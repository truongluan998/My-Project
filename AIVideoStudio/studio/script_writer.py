from __future__ import annotations

import anthropic
from pydantic import BaseModel, ConfigDict

from .config import Config
from .models import Episode


def _system_prompt(cfg: Config) -> str:
    ch = cfg.channel
    return (
        f"You write scripts for the YouTube channel \"{ch.name}\": short animated stories "
        f"narrated in {ch.language}.\n\n"
        f"Main character:\n{ch.character}\n\n"
        f"Episode format:\n{ch.format}\n\n"
        "Write for the ear: the narration is read by a text-to-speech voice, so avoid "
        "abbreviations, emojis and symbols the voice would read oddly. Each scene becomes one "
        "illustration shown while its narration plays, so every scene needs a clear, drawable moment. "
        "Keep the character's look exactly as described in every image_prompt and refer to him by name."
    )


def write_episode(cfg: Config, topic: str) -> Episode:
    sc = cfg.script
    words = int(sc.target_minutes * 150)
    client = anthropic.Anthropic()
    response = client.beta.messages.parse(
        model=sc.model,
        max_tokens=16000,
        system=_system_prompt(cfg),
        thinking={"type": "adaptive"},
        output_config={"effort": sc.effort},
        betas=["server-side-fallback-2026-07-01"],
        fallbacks="default",
        output_format=Episode,
        messages=[{
            "role": "user",
            "content": (
                f"Write a new episode about: {topic}\n\n"
                f"Length: about {words} words of narration in total, split into {sc.scenes} scenes."
            ),
        }],
    )
    if response.stop_reason == "refusal":
        raise SystemExit("Claude từ chối chủ đề này. Hãy thử một chủ đề khác.")
    if response.stop_reason == "max_tokens" or response.parsed_output is None:
        raise SystemExit(f"Không nhận được kịch bản hoàn chỉnh (stop_reason={response.stop_reason}).")
    return response.parsed_output


class _Ideas(BaseModel):
    model_config = ConfigDict(extra="forbid")
    ideas: list[str]


def brainstorm(cfg: Config, count: int) -> list[str]:
    client = anthropic.Anthropic()
    response = client.beta.messages.parse(
        model=cfg.script.model,
        max_tokens=8000,
        system=_system_prompt(cfg),
        thinking={"type": "adaptive"},
        output_config={"effort": "medium"},
        betas=["server-side-fallback-2026-07-01"],
        fallbacks="default",
        output_format=_Ideas,
        messages=[{
            "role": "user",
            "content": f"Suggest {count} distinct episode topics, one line each, as a specific situation "
                       "with a time limit (e.g. 'Hurricane in 48 hours, no car').",
        }],
    )
    if response.parsed_output is None:
        raise SystemExit(f"Không nhận được danh sách ý tưởng (stop_reason={response.stop_reason}).")
    return response.parsed_output.ideas
