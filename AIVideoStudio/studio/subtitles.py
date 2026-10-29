from __future__ import annotations

import re
from pathlib import Path

from .config import Config
from .models import Episode

MAX_WORDS = 7


def _ts(seconds: float) -> str:
    cs = int(round(seconds * 100))
    h, cs = divmod(cs, 360000)
    m, cs = divmod(cs, 6000)
    s, cs = divmod(cs, 100)
    return f"{h}:{m:02d}:{s:02d}.{cs:02d}"


def _escape(text: str) -> str:
    return text.replace("\\", "\\\\").replace("{", "(").replace("}", ")").replace("\n", " ")


def _chunks(text: str) -> list[str]:
    """Split narration into short caption lines, breaking at sentence ends first."""
    chunks = []
    for sentence in re.split(r"(?<=[.!?])\s+", text.strip()):
        words = sentence.split()
        n = max(1, -(-len(words) // MAX_WORDS))
        size = -(-len(words) // n)
        chunks += [" ".join(words[i:i + size]) for i in range(0, len(words), size)]
    return [c for c in chunks if c]


def write_ass(cfg: Config, episode: Episode, voice_durations: list[float], path: Path) -> None:
    """Captions timed proportionally to text length within each scene's audio, plus a big overlay label."""
    v = cfg.video
    header = f"""[Script Info]
ScriptType: v4.00+
PlayResX: {v.width}
PlayResY: {v.height}
WrapStyle: 0

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Caption,{v.font},62,&H00FFFFFF,&H00FFFFFF,&H00000000,&H64000000,1,0,0,0,100,100,0,0,1,5,1,2,120,120,70,1
Style: Overlay,{v.font},120,&H0028C8F5,&H0028C8F5,&H00000000,&H64000000,1,0,0,0,100,100,2,0,1,7,2,8,80,80,60,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
"""
    events = []
    start = 0.0
    for scene, dur in zip(episode.scenes, voice_durations):
        if scene.on_screen_text.strip():
            events.append(f"Dialogue: 1,{_ts(start)},{_ts(start + dur)},Overlay,,0,0,0,,"
                          f"{{\\fad(200,200)}}{_escape(scene.on_screen_text)}")
        if v.subtitles:
            chunks = _chunks(scene.narration)
            total = sum(len(c) for c in chunks) or 1
            t = start
            for c in chunks:
                d = dur * len(c) / total
                events.append(f"Dialogue: 0,{_ts(t)},{_ts(t + d)},Caption,,0,0,0,,{_escape(c)}")
                t += d
        start += dur + cfg.voice.pause_after_scene
    path.write_text(header + "\n".join(events) + "\n", encoding="utf-8")
