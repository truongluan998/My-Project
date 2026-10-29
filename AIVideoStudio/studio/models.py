from __future__ import annotations

import json
from pathlib import Path

from pydantic import BaseModel, ConfigDict, Field


class Scene(BaseModel):
    model_config = ConfigDict(extra="forbid")

    narration: str = Field(description="Voice-over for this scene, 1-3 short sentences.")
    image_prompt: str = Field(
        description="Visual description of the illustration: who, doing what, where, mood. "
        "Do not describe the art style. Never ask for text in the image."
    )
    on_screen_text: str = Field(
        description="Short overlay such as a countdown ('45:00') or a key number ('12 L'). Empty string if none."
    )


class Episode(BaseModel):
    model_config = ConfigDict(extra="forbid")

    title: str = Field(description="YouTube title, under 70 characters, curiosity-driven.")
    description: str = Field(description="YouTube description, 2-4 short paragraphs, ends with the tips as a list.")
    tags: list[str] = Field(description="8-15 YouTube tags.")
    thumbnail_text: str = Field(description="2-4 punchy words for the thumbnail, e.g. '72 HOURS LEFT'.")
    sources: list[str] = Field(description="Official sources backing the safety facts used (organization + topic).")
    scenes: list[Scene]

    def save(self, path: Path) -> None:
        path.write_text(json.dumps(self.model_dump(), indent=2, ensure_ascii=False), encoding="utf-8")

    @classmethod
    def load(cls, path: Path) -> "Episode":
        return cls.model_validate_json(path.read_text(encoding="utf-8"))
