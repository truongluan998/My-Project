from __future__ import annotations

import asyncio
import base64
import json
from pathlib import Path

from .config import Config, require_env
from .ffmpeg_utils import duration, run
from .models import Episode

# Each provider writes the mp3 and returns word timings [{"text", "start", "end"}] in seconds,
# or None when it can't (timings are then estimated from text length).
Words = list[dict] | None


def _edge(cfg: Config, text: str, path: Path, **_) -> Words:
    import edge_tts

    async def go() -> list[dict]:
        communicate = edge_tts.Communicate(text, cfg.voice.edge_voice, rate=cfg.voice.edge_rate, boundary="WordBoundary")
        words = []
        with open(path, "wb") as f:
            async for chunk in communicate.stream():
                if chunk["type"] == "audio":
                    f.write(chunk["data"])
                elif chunk["type"] == "WordBoundary":
                    start = chunk["offset"] / 1e7  # edge-tts reports 100-nanosecond ticks
                    words.append({"text": chunk["text"], "start": start, "end": start + chunk["duration"] / 1e7})
        return words

    return asyncio.run(go())


def _elevenlabs(cfg: Config, text: str, path: Path, previous_text: str = "", next_text: str = "") -> Words:
    from elevenlabs.client import ElevenLabs

    client = ElevenLabs(api_key=require_env("ELEVENLABS_API_KEY"))
    result = client.text_to_speech.convert_with_timestamps(
        cfg.voice.elevenlabs_voice_id,
        text=text,
        model_id=cfg.voice.elevenlabs_model,
        output_format="mp3_44100_128",
        # Neighbouring scenes keep intonation continuous across the separate requests.
        previous_text=previous_text or None,
        next_text=next_text or None,
    )
    path.write_bytes(base64.b64decode(result.audio_base_64))
    a = result.alignment
    if not a:
        return None
    words, current = [], None
    for ch, start, end in zip(a.characters, a.character_start_times_seconds, a.character_end_times_seconds):
        if ch.isspace():
            current = None
        elif current is None:
            current = {"text": ch, "start": start, "end": end}
            words.append(current)
        else:
            current["text"] += ch
            current["end"] = end
    return words


def _festival(cfg: Config, text: str, path: Path, **_) -> Words:
    """Offline English voice (apt install festival festvox-us-slt-hts). Robotic, but free and needs no network."""
    import subprocess
    import tempfile

    with tempfile.TemporaryDirectory() as tmp:
        txt, wav = Path(tmp) / "t.txt", Path(tmp) / "t.wav"
        txt.write_text(text, encoding="utf-8")
        subprocess.run(["text2wave", "-eval", f"({cfg.voice.get('festival_voice', 'voice_cmu_us_slt_arctic_hts')})",
                        str(txt), "-o", str(wav)], check=True, capture_output=True)
        run(["-i", str(wav), "-ar", "44100", "-ac", "2", "-c:a", "libmp3lame", "-q:a", "2", str(path)])
    return None


def _silent(cfg: Config, text: str, path: Path, **_) -> Words:
    """Silence lasting roughly as long as the text would take to read (for free test runs)."""
    seconds = max(2.0, len(text.split()) / 2.5)
    run(["-f", "lavfi", "-i", "anullsrc=r=44100:cl=stereo", "-t", f"{seconds:.2f}", "-c:a", "libmp3lame", str(path)])
    return None


def estimate_words(text: str, seconds: float) -> list[dict]:
    """Spread words over the clip proportionally to their length."""
    tokens = text.split()
    total = sum(len(t) + 1 for t in tokens) or 1
    words, t = [], 0.0
    for tok in tokens:
        d = seconds * (len(tok) + 1) / total
        words.append({"text": tok, "start": t, "end": t + d})
        t += d
    return words


PROVIDERS = {"edge": _edge, "elevenlabs": _elevenlabs, "festival": _festival, "silent": _silent}


def generate_voice(cfg: Config, episode: Episode, out_dir: Path, provider: str, log=print) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    scenes = episode.scenes
    paths = []
    for i, scene in enumerate(scenes):
        path = out_dir / f"scene_{i:02d}.mp3"
        words_path = path.with_suffix(".words.json")
        if not path.exists():
            log(f"  giọng đọc {i + 1}/{len(scenes)}")
            words = PROVIDERS[provider](
                cfg, scene.narration, path,
                previous_text=scenes[i - 1].narration if i > 0 else "",
                next_text=scenes[i + 1].narration if i + 1 < len(scenes) else "",
            )
            words = words or estimate_words(scene.narration, duration(path))
            words_path.write_text(json.dumps(words, ensure_ascii=False), encoding="utf-8")
        paths.append(path)
    return paths


def load_words(audio: Path, text: str) -> list[dict]:
    words_path = audio.with_suffix(".words.json")
    if words_path.exists():
        return json.loads(words_path.read_text(encoding="utf-8"))
    return estimate_words(text, duration(audio))
