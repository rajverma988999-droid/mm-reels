#!/usr/bin/env python3
"""Resize a generated background plate to the frame once (cover + centre crop), saved as JPG.

Generated plates come in odd sizes (V4: 941x1672). Resize once to 1080x1920 (or an overscan size for
camera travel, e.g. 1404x2496, or a tall 1080x3840 strip for a tilt) and keep camera pushes <= 1.4 so they
stay sharp.

Usage:  python3 prep_plate.py IN.png OUT.jpg [WIDTH HEIGHT]     (default 1080 1920)
        python3 prep_plate.py --all IN_DIR OUT_DIR [WIDTH HEIGHT]   (every B*.png / B*.jpg -> .jpg)
Needs: Pillow.
"""
import glob, os, sys
from PIL import Image


def prep(src, dst, W=1080, H=1920):
    im = Image.open(src).convert("RGB")
    s = max(W / im.width, H / im.height)
    im = im.resize((round(im.width * s), round(im.height * s)), Image.LANCZOS)
    l, t = (im.width - W) // 2, (im.height - H) // 2
    im.crop((l, t, l + W, t + H)).save(dst, quality=92)
    note = "  (upscaled: keep pushes modest)" if s > 1.05 else ""
    print(f"{os.path.basename(src)} -> {dst} {W}x{H}{note}")


if __name__ == "__main__":
    a = sys.argv[1:]
    if not a: print(__doc__); sys.exit(2)
    if a[0] == "--all":
        W, H = (int(a[3]), int(a[4])) if len(a) > 4 else (1080, 1920)
        os.makedirs(a[2], exist_ok=True)
        for f in sorted(glob.glob(os.path.join(a[1], "B*.png")) + glob.glob(os.path.join(a[1], "B*.jp*g"))):
            prep(f, os.path.join(a[2], os.path.splitext(os.path.basename(f))[0] + ".jpg"), W, H)
    else:
        W, H = (int(a[2]), int(a[3])) if len(a) > 3 else (1080, 1920)
        prep(a[0], a[1], W, H)
