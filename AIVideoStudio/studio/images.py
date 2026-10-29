from __future__ import annotations

import base64
import io
import os
import textwrap
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, ImageOps

from .config import Config, require_env, resolve
from .models import Episode


def _full_prompt(cfg: Config, scene_prompt: str, has_reference: bool) -> str:
    ref = (
        "Keep the main character exactly as he appears in the reference image (same proportions, "
        "colors and clothes). "
        if has_reference else ""
    )
    return (
        f"{scene_prompt}\n\n{ref}Main character: {cfg.channel.character}\n"
        f"Art style: {cfg.channel.style_prompt}\nWide 16:9 composition."
    )


def _gemini(cfg: Config, prompt: str, reference: Path | None) -> Image.Image:
    from google import genai
    from google.genai import types

    client = genai.Client(api_key=require_env("GEMINI_API_KEY"))
    contents: list = [prompt]
    if reference:
        contents.append(Image.open(reference))
    response = client.models.generate_content(
        model=cfg.images.gemini_model,
        contents=contents,
        config=types.GenerateContentConfig(
            response_modalities=["IMAGE"],
            image_config=types.ImageConfig(aspect_ratio="16:9"),
        ),
    )
    for part in response.parts or []:
        if part.inline_data and part.inline_data.data:
            return Image.open(io.BytesIO(part.inline_data.data))
    raise RuntimeError(f"Gemini không trả về ảnh: {response.text or response.prompt_feedback}")


def _openai(cfg: Config, prompt: str, reference: Path | None) -> Image.Image:
    from openai import OpenAI

    client = OpenAI(api_key=require_env("OPENAI_API_KEY"))
    model, size = cfg.images.openai_model, "1536x1024"
    if reference:
        with open(reference, "rb") as f:
            result = client.images.edit(model=model, image=f, prompt=prompt, size=size)
    else:
        result = client.images.generate(model=model, prompt=prompt, size=size)
    return Image.open(io.BytesIO(base64.b64decode(result.data[0].b64_json)))


_uploaded_refs: dict[Path, str] = {}


def _higgsfield(cfg: Config, prompt: str, reference: Path | None) -> Image.Image:
    import urllib.request

    import higgsfield_client

    hf = cfg.images
    if not (os.environ.get("HF_KEY") or (os.environ.get("HF_API_KEY") and os.environ.get("HF_API_SECRET"))):
        require_env("HF_KEY")
    arguments = {"prompt": prompt, "resolution": hf.higgsfield_resolution, "aspect_ratio": "16:9"}
    model = hf.higgsfield_model
    if reference and hf.higgsfield_reference_model:
        if reference not in _uploaded_refs:
            _uploaded_refs[reference] = higgsfield_client.upload_file(str(reference))
        model = hf.higgsfield_reference_model
        arguments[hf.higgsfield_reference_arg] = [_uploaded_refs[reference]]
    result = higgsfield_client.subscribe(model, arguments=arguments)
    images = (result or {}).get("images") or []
    if not images:
        raise RuntimeError(f"Higgsfield không trả về ảnh: {result}")
    with urllib.request.urlopen(images[0]["url"], timeout=120) as r:
        return Image.open(io.BytesIO(r.read()))


def _placeholder(cfg: Config, prompt: str, reference: Path | None, index: int = 0) -> Image.Image:
    """Free stand-in image so the whole pipeline can be tested without API keys."""
    img = Image.new("RGB", (cfg.video.width, cfg.video.height), (246, 241, 230))
    draw = ImageDraw.Draw(img)
    font = ImageFont.load_default(size=44)
    cx, cy = img.width // 2, img.height // 2 - 60
    draw.ellipse((cx - 60, cy - 220, cx + 60, cy - 100), outline="black", width=6)
    draw.line((cx, cy - 100, cx, cy + 60), fill="black", width=6)
    draw.polygon([(cx - 70, cy - 80), (cx + 70, cy - 80), (cx + 90, cy + 60), (cx - 90, cy + 60)], fill=(245, 200, 40))
    draw.text((60, 50), f"SCENE {index + 1}", fill="black", font=font)
    text = "\n".join(textwrap.wrap(prompt.split("\n")[0], 70)[:5])
    draw.multiline_text((60, img.height - 300), text, fill=(60, 60, 60), font=ImageFont.load_default(size=34))
    return img


PROVIDERS = {"higgsfield": _higgsfield, "gemini": _gemini, "openai": _openai, "placeholder": _placeholder}


def generate_images(cfg: Config, episode: Episode, out_dir: Path, provider: str, log=print) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    reference = resolve(cfg.images.character_reference) if cfg.images.character_reference else None
    paths = []
    for i, scene in enumerate(episode.scenes):
        path = out_dir / f"scene_{i:02d}.png"
        if not path.exists():
            log(f"  ảnh {i + 1}/{len(episode.scenes)}")
            prompt = _full_prompt(cfg, scene.image_prompt, reference is not None)
            if provider == "placeholder":
                img = _placeholder(cfg, scene.image_prompt, reference, i)
            else:
                img = PROVIDERS[provider](cfg, prompt, reference)
            img = ImageOps.fit(img.convert("RGB"), (cfg.video.width, cfg.video.height), Image.LANCZOS)
            img.save(path)
        # Without a configured reference, scene 1 anchors the character's look for the rest.
        if reference is None and i == 0:
            reference = path
        paths.append(path)
    return paths
