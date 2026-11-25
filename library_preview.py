#!/usr/bin/env python3
"""Rebuild the labelled preview sheets of the image library (assets/library/_preview_*.jpg).
Run after adding images to assets/library/props, plates or baked_scenes.
Usage:  python3 scripts/library_preview.py        Needs: Pillow.
"""
import glob, os
from PIL import Image, ImageDraw, ImageFont

LIB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets", "library")


def font():
    for p in ("/System/Library/Fonts/Supplemental/Arial.ttf", "/Library/Fonts/Arial.ttf",
              "C:/Windows/Fonts/arial.ttf", "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"):
        if os.path.exists(p):
            return ImageFont.truetype(p, 15)
    return ImageFont.load_default()


def sheet(folder, out, T=230, cols=6, bg=(228, 190, 66)):
    files = sorted(glob.glob(os.path.join(LIB, folder, "*.png")) + glob.glob(os.path.join(LIB, folder, "*.jpg")))
    if not files:
        return
    F = font()
    rows = (len(files) + cols - 1) // cols
    S = Image.new("RGB", (cols * T, rows * (T + 26)), (30, 30, 30))
    d = ImageDraw.Draw(S)
    for i, f in enumerate(files):
        im = Image.open(f)
        if im.mode == "RGBA":                      # cut-outs shown on mustard so holes and halos show
            b = Image.new("RGBA", im.size, bg + (255,)); b.alpha_composite(im); im = b
        im = im.convert("RGB"); im.thumbnail((T - 8, T - 8))
        x, y = (i % cols) * T, (i // cols) * (T + 26)
        S.paste(im, (x + (T - im.width) // 2, y + 4))
        d.text((x + 4, y + T + 2), os.path.basename(f)[:30], fill=(240, 240, 240), font=F)
    S.save(os.path.join(LIB, out), quality=85)
    print(f"{out}: {len(files)} images")


if __name__ == "__main__":
    sheet("props", "_preview_props.jpg")
    sheet("plates", "_preview_plates.jpg", T=200, cols=5)
    sheet("baked_scenes", "_preview_baked_scenes.jpg", T=200, cols=7)
