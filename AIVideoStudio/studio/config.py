from __future__ import annotations

import os
from pathlib import Path
from typing import Any

import yaml
from dotenv import load_dotenv

ROOT = Path(__file__).resolve().parent.parent


class Config(dict):
    """Nested dict with attribute access: cfg.video.width."""

    def __getattr__(self, name: str) -> Any:
        try:
            value = self[name]
        except KeyError as e:
            raise AttributeError(name) from e
        return Config(value) if isinstance(value, dict) else value


def load_config(path: str | Path | None = None) -> Config:
    load_dotenv(ROOT / ".env")
    path = Path(path) if path else ROOT / "config.yaml"
    with open(path, encoding="utf-8") as f:
        return Config(yaml.safe_load(f))


def require_env(name: str) -> str:
    value = os.environ.get(name)
    if not value:
        raise SystemExit(f"Thiếu biến môi trường {name}. Hãy điền vào file .env (xem .env.example).")
    return value


def resolve(path: str) -> Path:
    p = Path(path)
    return p if p.is_absolute() else ROOT / p
