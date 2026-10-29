from __future__ import annotations

import asyncio
from pathlib import Path

from .config import Config, require_env
from .ffmpeg_utils import run
from .models import Episode


def _edge(cfg: Config, text: str, path: Path, **_) -> None:
    import edge_tts

    communicate = edge_tts.Communicate(text, cfg.voice.edge_voice, rate=cfg.voice.edge_rate)
    asyncio.run(communicate.save(str(path)))


def _elevenlabs(cfg: Config, text: str, path: Path, previous_text: str = "", next_text: str = "") -> None:
    from elevenlabs.client import ElevenLabs

    client = ElevenLabs(api_key=require_env("ELEVENLABS_API_KEY"))
    audio = client.text_to_speech.convert(
        cfg.voice.elevenlabs_voice_id,
        text=text,
        model_id=cfg.voice.elevenlabs_model,
        output_format="mp3_44100_128",
        # Neighbouring scenes keep intonation continuous across the separate requests.
        previous_text=previous_text or None,
        next_text=next_text or None,
    )
    with open(path, "wb") as f:
        for chunk in audio:
            f.write(chunk)


def _silent(cfg: Config, text: str, path: Path, **_) -> None:
    """Silence lasting roughly as long as the text would take to read (for free test runs)."""
    seconds = max(2.0, len(text.split()) / 2.5)
    run(["-f", "lavfi", "-i", "anullsrc=r=44100:cl=stereo", "-t", f"{seconds:.2f}", "-c:a", "libmp3lame", str(path)])


PROVIDERS = {"edge": _edge, "elevenlabs": _elevenlabs, "silent": _silent}


def generate_voice(cfg: Config, episode: Episode, out_dir: Path, provider: str, log=print) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    scenes = episode.scenes
    paths = []
    for i, scene in enumerate(scenes):
        path = out_dir / f"scene_{i:02d}.mp3"
        if not path.exists():
            log(f"  giọng đọc {i + 1}/{len(scenes)}")
            PROVIDERS[provider](
                cfg, scene.narration, path,
                previous_text=scenes[i - 1].narration if i > 0 else "",
                next_text=scenes[i + 1].narration if i + 1 < len(scenes) else "",
            )
        paths.append(path)
    return paths
