#!/usr/bin/env python3
"""Measure every title line in Anton and say what size fits (SKILL.md "Titles").

Line 1 = 92 px, letter-spacing 0.015em.  Line 2 = 140 px, letter-spacing 0.03em.
Both start at x = 97 px; a line may be at most 862 px wide (about 80% of the 1080 frame;
calibrated on the approved V4 titles: 'PAKAD LETA HAI' 860 px kept at 140, '1 GHANTE KA GAP' set to 130 = 862 px).
Only Line 2 is shrunk (never below 110 px); a Line 1 that is too long must be reworded.

Usage:
  python3 fit_titles.py "KHANE KE BAAD|GARAM CHAI?" "AAPKE PET MEIN|ROZ KYA KARTI?"
  python3 fit_titles.py --file titles.txt        (one "line1|line2" per line)
Needs: Pillow.
"""
import os, sys
from PIL import ImageFont

FONT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets", "fonts", "Anton-Regular.ttf")
MAX_W = 862                  # text width allowed (V4-calibrated)
L1 = (92, 0.015)
L2 = (140, 0.03)
L2_MIN = 110


def width(text, size, ls):
    f = ImageFont.truetype(FONT, size)
    return f.getlength(text) + ls * size * max(len(text) - 1, 0)


def fit(l1, l2):
    w1 = width(l1, *L1)
    s = L2[0]
    while s > L2_MIN and width(l2, s, L2[1]) > MAX_W:
        s -= 2
    w2 = width(l2, s, L2[1])
    note = []
    if w1 > MAX_W: note.append("LINE 1 TOO LONG: reword (2-4 words)")
    if w2 > MAX_W: note.append(f"LINE 2 TOO LONG even at {L2_MIN}px: reword")
    size = "" if s == L2[0] else f'  -> style="font-size:{s}px" on .l2'
    print(f"{l1!r:28} {w1:5.0f}px | {l2!r:22} {w2:5.0f}px @ {s}px{size}  {' / '.join(note)}")
    return not note


def main(a):
    if not a:
        print(__doc__); return 2
    pairs = open(a[1]).read().splitlines() if a[0] == "--file" else a
    ok = all(fit(*(p.split("|") + [""])[:2]) for p in pairs if p.strip())
    print("ALL FIT" if ok else "SOME TITLES NEED REWORDING")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
