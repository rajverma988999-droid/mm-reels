#!/usr/bin/env python3
"""Cut a prop out of its flat background -> transparent PNG (free, local).

Two modes:
  rembg  (default) good for most objects. Needs the rembg CLI
         (pip install "rembg[cli]" in a venv; set $REMBG to its path if it is not on PATH).
  color  for pale objects and flat sheets (light trays, maps, paper) where rembg eats holes into the
         object. Cuts by colour distance from the background colour (read from the 4 corners),
         fills holes inside the object and feathers the edge.

Usage:
  python3 cutout.py IN.png OUT.png                    # rembg
  python3 cutout.py IN.png OUT.png --mode color [--tol 38] [--feather 2]
  python3 cutout.py IN.png OUT.png --check            # also writes OUT_check.png (cut-out on dark + yellow)
Always look at the _check image before using a cut-out (halo, missing parts).
Needs: Pillow, numpy.
"""
import argparse, os, shutil, subprocess, sys
import numpy as np
from PIL import Image, ImageFilter, ImageDraw


def rembg_cut(src, dst):
    exe = os.environ.get("REMBG") or shutil.which("rembg")
    if not exe:
        sys.exit("rembg not found: install it (pip install 'rembg[cli]') or set $REMBG, or use --mode color")
    subprocess.run([exe, "i", src, dst], check=True)


def color_cut(src, dst, tol, feather):
    im = Image.open(src).convert("RGB")
    a = np.asarray(im).astype(float)
    h, w, _ = a.shape
    k = max(4, min(h, w) // 40)
    corners = np.concatenate([a[:k, :k].reshape(-1, 3), a[:k, -k:].reshape(-1, 3),
                              a[-k:, :k].reshape(-1, 3), a[-k:, -k:].reshape(-1, 3)])
    bg = np.median(corners, axis=0)
    dist = np.sqrt(((a - bg) ** 2).sum(-1))
    obj = dist > tol                                   # True = object
    # background = only the part connected to the border (so pale areas inside the object stay)
    m = Image.fromarray(np.where(obj, 0, 255).astype(np.uint8))
    m = m.filter(ImageFilter.MinFilter(3)).filter(ImageFilter.MaxFilter(3))
    seed = Image.new("L", (w + 2, h + 2), 255)
    seed.paste(m, (1, 1))
    ImageDraw.floodfill(seed, (0, 0), 128)
    outside = np.asarray(seed)[1:-1, 1:-1] == 128
    alpha = Image.fromarray(np.where(outside, 0, 255).astype(np.uint8))
    if feather:
        alpha = alpha.filter(ImageFilter.MinFilter(3)).filter(ImageFilter.GaussianBlur(feather))
    out = im.convert("RGBA"); out.putalpha(alpha)
    bbox = alpha.getbbox()
    out.crop(bbox).save(dst) if bbox else out.save(dst)


def check(dst):
    im = Image.open(dst).convert("RGBA")
    w, h = im.size
    sheet = Image.new("RGBA", (w * 2 + 30, h + 20), (255, 255, 255, 255))
    for i, col in enumerate([(25, 18, 12, 255), (228, 190, 66, 255)]):
        tile = Image.new("RGBA", (w, h), col); tile.alpha_composite(im)
        sheet.paste(tile, (10 + i * (w + 10), 10))
    p = os.path.splitext(dst)[0] + "_check.png"
    sheet.convert("RGB").save(p); print("check sheet:", p)


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("src"); ap.add_argument("dst")
    ap.add_argument("--mode", choices=["rembg", "color"], default="rembg")
    ap.add_argument("--tol", type=float, default=38)
    ap.add_argument("--feather", type=float, default=1.5)
    ap.add_argument("--check", action="store_true")
    a = ap.parse_args()
    rembg_cut(a.src, a.dst) if a.mode == "rembg" else color_cut(a.src, a.dst, a.tol, a.feather)
    print("wrote", a.dst)
    if a.check: check(a.dst)
