from __future__ import annotations

import random
from pathlib import Path

from .config import Config, resolve
from .ffmpeg_utils import duration, run

# Ken Burns moves, cycled per scene so consecutive shots don't feel identical.
# Z = target zoom, N = frame count, on = current output frame.
MOVES = [
    ("1+(Z-1)*on/N", "iw/2-(iw/zoom/2)", "ih/2-(ih/zoom/2)"),  # slow zoom in
    ("Z-(Z-1)*on/N", "iw/2-(iw/zoom/2)", "ih/2-(ih/zoom/2)"),  # slow zoom out
    ("Z", "(iw-iw/zoom)*on/N", "ih/2-(ih/zoom/2)"),            # pan left -> right
    ("Z", "(iw-iw/zoom)*(1-on/N)", "ih/2-(ih/zoom/2)"),        # pan right -> left
]


def render_scene(cfg: Config, index: int, image: Path, voice: Path, out: Path) -> None:
    v = cfg.video
    pause = cfg.voice.pause_after_scene
    dur = duration(voice) + pause
    frames = round(dur * v.fps)
    z, x, y = (e.replace("Z", str(v.zoom)).replace("N", str(frames)) for e in MOVES[index % len(MOVES)])
    # Upscaling before zoompan avoids the shaky sub-pixel motion zoompan has at native size.
    vf = (f"scale={v.width * 2}:{v.height * 2},"
          f"zoompan=z='{z}':x='{x}':y='{y}':d={frames}:s={v.width}x{v.height}:fps={v.fps},"
          "format=yuv420p")
    run([
        "-i", str(image), "-i", str(voice),
        "-vf", vf, "-af", f"apad=pad_dur={pause}",
        "-t", f"{dur:.3f}", "-r", str(v.fps),
        "-c:v", "libx264", "-preset", "medium", "-crf", "18",
        "-c:a", "aac", "-b:a", "192k", "-ar", "44100", "-ac", "2",
        str(out),
    ])


def pick_music(cfg: Config) -> Path | None:
    folder = resolve(cfg.video.music_dir)
    tracks = [p for p in folder.glob("*") if p.suffix.lower() in {".mp3", ".wav", ".m4a", ".ogg"}] if folder.exists() else []
    return random.choice(tracks) if tracks else None


def assemble(cfg: Config, ep_dir: Path, clips: list[Path], subtitles: Path | None, out: Path) -> None:
    concat_list = ep_dir / "clips.txt"
    concat_list.write_text("".join(f"file '{c.relative_to(ep_dir).as_posix()}'\n" for c in clips), encoding="utf-8")
    body = ep_dir / "body.mp4"
    run(["-f", "concat", "-safe", "0", "-i", concat_list.name, "-c", "copy", body.name], cwd=ep_dir)

    args = ["-i", body.name]
    music = pick_music(cfg)
    if music:
        args += ["-stream_loop", "-1", "-i", str(music.resolve())]
        # Music ducks under the narration (sidechain), then everything is normalized for YouTube (-14 LUFS).
        af = (f"[0:a]asplit=2[voice][key];[1:a]volume={cfg.video.music_volume}[m];"
              "[m][key]sidechaincompress=threshold=0.03:ratio=8:attack=20:release=400[duck];"
              "[voice][duck]amix=inputs=2:duration=first:normalize=0,loudnorm=I=-14:TP=-1.5:LRA=11[a]")
    else:
        af = "[0:a]loudnorm=I=-14:TP=-1.5:LRA=11[a]"
    vf = f"[0:v]ass={subtitles.name}[v]" if subtitles else "[0:v]null[v]"
    run([
        *args, "-filter_complex", f"{vf};{af}", "-map", "[v]", "-map", "[a]",
        "-c:v", "libx264", "-preset", "medium", "-crf", "20", "-pix_fmt", "yuv420p",
        "-c:a", "aac", "-b:a", "192k", "-ar", "48000", "-movflags", "+faststart",
        out.name,
    ], cwd=ep_dir)
    body.unlink()
