from __future__ import annotations

import shutil
import subprocess
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, ImageOps

from .config import Config, resolve

SIZE = (1280, 720)


def _font(cfg: Config, size: int) -> ImageFont.FreeTypeFont:
    path = cfg.thumbnail.font_file
    if not path and shutil.which("fc-match"):
        path = subprocess.run(["fc-match", "-f", "%{file}", f"{cfg.video.font}:bold"],
                              capture_output=True, text=True).stdout.strip()
    try:
        return ImageFont.truetype(str(resolve(path)) if path else "arialbd.ttf", size)
    except OSError:
        return ImageFont.load_default(size=size)


def make_thumbnail(cfg: Config, background: Path, text: str, out: Path) -> None:
    img = ImageOps.fit(Image.open(background).convert("RGB"), SIZE, Image.LANCZOS)
    # Darken the left half so the headline stays readable over any illustration.
    shade = Image.linear_gradient("L").rotate(-90).resize(SIZE).point(lambda p: int(p * 0.75))
    img = Image.composite(Image.new("RGB", SIZE, "black"), img, shade)

    draw = ImageDraw.Draw(img)
    words = text.upper().split()
    lines = [" ".join(words[i:i + 2]) for i in range(0, len(words), 2)]
    size = 150
    font = _font(cfg, size)
    while size > 60 and max(draw.textlength(line, font=font) for line in lines) > SIZE[0] * 0.55:
        size -= 8
        font = _font(cfg, size)
    y = (SIZE[1] - len(lines) * size * 1.1) / 2
    for i, line in enumerate(lines):
        fill = (255, 214, 0) if i == len(lines) - 1 else "white"
        draw.text((50, y), line, font=font, fill=fill, stroke_width=10, stroke_fill="black")
        y += size * 1.1
    img.save(out, quality=92)
