from __future__ import annotations

import re
import time
from datetime import date
from pathlib import Path
from typing import Optional

import typer
from rich.console import Console

from .config import ROOT, load_config
from .models import Episode

app = typer.Typer(help="AI Video Studio: chủ đề -> kịch bản -> ảnh -> giọng đọc -> video -> YouTube", no_args_is_help=True)
console = Console()
OUTPUT = ROOT / "output"

ImagesOpt = typer.Option(None, "--images", help="gemini | openai | placeholder (ghi đè config.yaml)")
VoiceOpt = typer.Option(None, "--voice", help="edge | elevenlabs | silent (ghi đè config.yaml)")
RendererOpt = typer.Option(None, "--renderer", help="remotion | ffmpeg (ghi đè config.yaml)")


def _log(msg: str) -> None:
    console.print(f"[dim]{msg}[/dim]")


def _slug(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")[:50] or "episode"


def _new_script(topic: str) -> Path:
    from .script_writer import write_episode

    cfg = load_config()
    console.print(f"[bold]1/5 Viết kịch bản[/bold] ({cfg.script.model}): {topic}")
    episode = write_episode(cfg, topic)
    ep_dir = OUTPUT / f"{date.today():%Y%m%d}-{_slug(episode.title)}"
    ep_dir.mkdir(parents=True, exist_ok=True)
    episode.save(ep_dir / "script.json")
    words = sum(len(s.narration.split()) for s in episode.scenes)
    console.print(f"  [green]✓[/green] \"{episode.title}\" - {len(episode.scenes)} cảnh, {words} từ -> {ep_dir}")
    return ep_dir


def _prepare(ep_dir: Path, images: Optional[str], voice: Optional[str]):
    from .images import generate_images
    from .voice import generate_voice

    cfg = load_config()
    episode = Episode.load(ep_dir / "script.json")
    console.print(f"[bold]2/5 Tạo ảnh[/bold] ({images or cfg.images.provider})")
    image_paths = generate_images(cfg, episode, ep_dir / "images", images or cfg.images.provider, _log)
    console.print(f"[bold]3/5 Giọng đọc[/bold] ({voice or cfg.voice.provider})")
    voice_paths = generate_voice(cfg, episode, ep_dir / "audio", voice or cfg.voice.provider, _log)
    return cfg, episode, image_paths, voice_paths


def _render_ffmpeg(cfg, episode: Episode, ep_dir: Path, image_paths: list[Path], voice_paths: list[Path], final: Path) -> None:
    from .ffmpeg_utils import duration
    from .subtitles import write_ass
    from .video import assemble, render_scene

    clips_dir = ep_dir / "clips"
    clips_dir.mkdir(exist_ok=True)
    clips = []
    for i, (img, aud) in enumerate(zip(image_paths, voice_paths)):
        clip = clips_dir / f"scene_{i:02d}.mp4"
        # Re-render only when the clip is older than its inputs (e.g. after replacing one image).
        if not clip.exists() or clip.stat().st_mtime < max(img.stat().st_mtime, aud.stat().st_mtime):
            _log(f"  cảnh {i + 1}/{len(image_paths)}")
            render_scene(cfg, i, img, aud, clip)
        clips.append(clip)
    subs = ep_dir / "subtitles.ass"
    write_ass(cfg, episode, [duration(p) for p in voice_paths], subs)
    assemble(cfg, ep_dir, clips, subs, final)


def _build(ep_dir: Path, images: Optional[str], voice: Optional[str], renderer: Optional[str] = None) -> Path:
    from .ffmpeg_utils import duration
    from .thumbnail import make_thumbnail

    started = time.time()
    cfg, episode, image_paths, voice_paths = _prepare(ep_dir, images, voice)

    renderer = renderer or cfg.video.renderer
    console.print(f"[bold]4/5 Dựng video[/bold] ({renderer})")
    final = ep_dir / "video.mp4"
    if renderer == "remotion":
        from .renderer_remotion import render

        render(cfg, episode, ep_dir, image_paths, voice_paths, final)
    else:
        _render_ffmpeg(cfg, episode, ep_dir, image_paths, voice_paths, final)

    console.print("[bold]5/5 Thumbnail[/bold]")
    make_thumbnail(cfg, image_paths[cfg.thumbnail.scene], episode.thumbnail_text, ep_dir / "thumbnail.jpg")

    console.print(f"[green]✓ Xong[/green] {final} ({duration(final) / 60:.1f} phút, mất {time.time() - started:.0f}s)")
    return final


@app.command()
def ideas(count: int = typer.Option(20, help="Số ý tưởng")):
    """Gợi ý chủ đề cho các tập tiếp theo (lưu vào ideas.txt, mỗi dòng 1 chủ đề)."""
    from .script_writer import brainstorm

    items = brainstorm(load_config(), count)
    (ROOT / "ideas.txt").write_text("\n".join(items) + "\n", encoding="utf-8")
    for i, idea in enumerate(items, 1):
        console.print(f"{i:2d}. {idea}")
    console.print(f"[green]✓[/green] Đã lưu {ROOT / 'ideas.txt'}")


@app.command()
def script(topic: str):
    """Chỉ viết kịch bản (output/<tập>/script.json) để bạn đọc và sửa trước khi dựng."""
    _new_script(topic)


@app.command()
def build(episode_dir: Path, images: Optional[str] = ImagesOpt, voice: Optional[str] = VoiceOpt,
          renderer: Optional[str] = RendererOpt):
    """Dựng video từ script.json có sẵn. Chạy lại an toàn: chỉ làm lại phần còn thiếu."""
    _build(episode_dir.resolve(), images, voice, renderer)


@app.command()
def preview(episode_dir: Path, images: Optional[str] = ImagesOpt, voice: Optional[str] = VoiceOpt):
    """Mở Remotion Studio trên trình duyệt để xem trước và chỉnh hiệu ứng trước khi xuất video."""
    from .renderer_remotion import preview as remotion_preview

    ep_dir = episode_dir.resolve()
    cfg, episode, image_paths, voice_paths = _prepare(ep_dir, images, voice)
    remotion_preview(cfg, episode, ep_dir, image_paths, voice_paths)


@app.command()
def make(topic: str, images: Optional[str] = ImagesOpt, voice: Optional[str] = VoiceOpt,
         publish: bool = typer.Option(False, "--upload", help="Tải lên YouTube sau khi dựng xong")):
    """Toàn bộ quy trình: chủ đề -> video hoàn chỉnh (tuỳ chọn tải lên YouTube)."""
    ep_dir = _new_script(topic)
    _build(ep_dir, images, voice)
    if publish:
        upload(ep_dir, privacy=None)


@app.command()
def batch(topics_file: Path = typer.Argument(ROOT / "ideas.txt"), images: Optional[str] = ImagesOpt,
          voice: Optional[str] = VoiceOpt, publish: bool = typer.Option(False, "--upload")):
    """Làm nhiều video liên tiếp, mỗi dòng trong file là một chủ đề."""
    topics = [t.strip() for t in topics_file.read_text(encoding="utf-8").splitlines() if t.strip()]
    for n, topic in enumerate(topics, 1):
        console.rule(f"Video {n}/{len(topics)}")
        try:
            make(topic, images, voice, publish)
        except Exception as e:  # noqa: BLE001 - one failed episode shouldn't stop the batch
            console.print(f"[red]✗ Lỗi với '{topic}': {e}[/red]")


@app.command()
def upload(episode_dir: Path, privacy: Optional[str] = typer.Option(None, help="private | unlisted | public")):
    """Tải video lên YouTube (mặc định ở chế độ private để bạn duyệt trước)."""
    from .youtube import upload as yt_upload

    ep_dir = episode_dir.resolve()
    thumb = ep_dir / "thumbnail.jpg"
    url = yt_upload(load_config(), Episode.load(ep_dir / "script.json"), ep_dir / "video.mp4",
                    thumb if thumb.exists() else None, privacy)
    console.print(f"[green]✓ Đã tải lên:[/green] {url}")


if __name__ == "__main__":
    app()
