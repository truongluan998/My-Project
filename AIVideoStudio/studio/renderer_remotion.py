from __future__ import annotations

import json
import math
import os
import shutil
import subprocess
from pathlib import Path

from .config import ROOT, Config
from .ffmpeg_utils import duration, run
from .models import Episode
from .video import pick_music
from .voice import load_words

REMOTION_DIR = ROOT / "remotion"


def _npx() -> str:
    npx = shutil.which("npx")
    if not npx:
        raise SystemExit("Không tìm thấy Node.js/npx. Cài Node.js 18+ (https://nodejs.org) hoặc đặt video.renderer: ffmpeg.")
    if not (REMOTION_DIR / "node_modules").exists():
        subprocess.run([shutil.which("npm") or "npm", "install"], cwd=REMOTION_DIR, check=True)
    return npx


def write_props(cfg: Config, episode: Episode, ep_dir: Path, images: list[Path], voices: list[Path]) -> Path:
    v = cfg.video
    pause = cfg.voice.pause_after_scene
    scenes = []
    for scene, img, aud in zip(episode.scenes, images, voices):
        scenes.append({
            "image": img.relative_to(ep_dir).as_posix(),
            "audio": aud.relative_to(ep_dir).as_posix(),
            "durationInFrames": math.ceil((duration(aud) + pause) * v.fps),
            "words": load_words(aud, scene.narration),
            "overlay": scene.on_screen_text,
        })
    music = pick_music(cfg)
    if music:
        # Remotion serves files only from the public dir, which is the episode folder.
        shutil.copy(music, ep_dir / f"music{music.suffix}")
    props = {
        "fps": v.fps, "width": v.width, "height": v.height, "zoom": v.zoom,
        "transitionFrames": min(v.transition_frames, int(pause * v.fps)),
        "showCaptions": v.subtitles,
        "music": f"music{music.suffix}" if music else None,
        "musicVolume": v.music_volume,
        "scenes": scenes,
    }
    path = ep_dir / "props.json"
    path.write_text(json.dumps(props, ensure_ascii=False, indent=1), encoding="utf-8")
    return path


def _remotion_args(ep_dir: Path, props: Path) -> list[str]:
    args = [f"--props={props}", f"--public-dir={ep_dir}"]
    if os.environ.get("REMOTION_BROWSER_EXECUTABLE"):
        args.append(f"--browser-executable={os.environ['REMOTION_BROWSER_EXECUTABLE']}")
    return args


def render(cfg: Config, episode: Episode, ep_dir: Path, images: list[Path], voices: list[Path], out: Path) -> None:
    props = write_props(cfg, episode, ep_dir, images, voices)
    raw = ep_dir / "render.mp4"
    subprocess.run(
        [_npx(), "remotion", "render", "src/index.ts", "Episode", str(raw), *_remotion_args(ep_dir, props)],
        cwd=REMOTION_DIR, check=True,
    )
    # Normalize loudness for YouTube (-14 LUFS); the picture is copied untouched.
    run(["-i", str(raw), "-c:v", "copy", "-af", "loudnorm=I=-14:TP=-1.5:LRA=11",
         "-c:a", "aac", "-b:a", "192k", "-ar", "48000", "-movflags", "+faststart", str(out)])
    raw.unlink()


def preview(cfg: Config, episode: Episode, ep_dir: Path, images: list[Path], voices: list[Path]) -> None:
    props = write_props(cfg, episode, ep_dir, images, voices)
    subprocess.run([_npx(), "remotion", "studio", "src/index.ts", *_remotion_args(ep_dir, props)], cwd=REMOTION_DIR)
