#!/usr/bin/env python3
"""Motion QC gate for the Meanwhile Mayank style (Claude update V2).

Measures how much the PICTURE moves (top 31% = title zone is ignored) in every
2-second window. A slideshow (one still image per scene with a slow zoom) fails.

Calibrated 2026-11-23 on the files in this project:
  generated V2 (chai demo) : median 1.75, still windows 37%  -> FAIL
  ref_01 / 03 / 07 / 10     : median 9.4-12.9, still windows 0-3% -> PASS

Usage:  python3 qc_motion.py VIDEO.mp4 [VIDEO2.mp4 ...]
Needs:  ffmpeg on PATH, numpy.
"""
import subprocess, sys
import numpy as np

W, H, FPS = 90, 160, 5          # tiny grey frames, 5 per second
MEDIAN_MIN = 6.0                # median motion per 2 s window must be at least this
STILL_LEVEL = 1.0               # a 2 s window below this counts as "still"
STILL_MAX = 0.05                # at most 5% of windows may be still


def motion(path):
    raw = subprocess.run(
        ["ffmpeg", "-v", "error", "-i", path, "-vf",
         f"fps={FPS},scale={W}:{H},format=gray", "-f", "rawvideo", "-"],
        check=True, capture_output=True).stdout
    a = np.frombuffer(raw, np.uint8).reshape(-1, H, W).astype(float)
    a = a[:, int(H * 0.31):, :]                       # skip the title zone
    d = np.abs(np.diff(a, axis=0)).mean((1, 2))      # per-frame change
    n = len(d) // (FPS * 2) * (FPS * 2)
    w = d[:n].reshape(-1, FPS * 2).mean(1)           # per 2 s window
    return w


def main(paths):
    ok_all = True
    for p in paths:
        w = motion(p)
        med, still = float(np.median(w)), float((w < STILL_LEVEL).mean())
        ok = med >= MEDIAN_MIN and still <= STILL_MAX
        ok_all &= ok
        print(f"{'PASS' if ok else 'FAIL'}  {p}\n      median/2s={med:.2f} (need >= {MEDIAN_MIN})"
              f"  still windows={still*100:.0f}% (need <= {STILL_MAX*100:.0f}%)")
        if not ok:
            bad = [f"{i*2}-{i*2+2}s" for i, v in enumerate(w) if v < STILL_LEVEL]
            if bad:
                print("      still at:", ", ".join(bad))
    sys.exit(0 if ok_all else 1)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    main(sys.argv[1:])
