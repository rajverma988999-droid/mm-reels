#!/bin/zsh
# Two-pass loudness match of the finished render to -14 LUFS / -1 dBTP, on a COPY (never overwrites).
# The HyperFrames render comes out quieter (V4: -18.8 LUFS). Video is copied, only audio is re-encoded.
# Usage:  scripts/loudnorm.sh RENDER.mp4 OUT.mp4 [I=-14] [TP=-1]
# zsh note: variables before ":" are written ${VAR}:..., because zsh reads "$VAR:l" as a modifier.
set -e
IN="$1"; OUT="$2"; I="${3:--14}"; TP="${4:--1}"
[[ -n "$OUT" && "$IN" != "$OUT" ]] || { echo "usage: loudnorm.sh IN.mp4 OUT.mp4 (OUT must differ)"; exit 2; }
J=$(ffmpeg -hide_banner -i "$IN" -af loudnorm=I=${I}:TP=${TP}:LRA=11:print_format=json -f null - 2>&1 | sed -n '/^{/,/^}/p')
g() { echo "$J" | python3 -c "import json,sys; print(json.load(sys.stdin)['$1'])"; }
MI=$(g input_i); MTP=$(g input_tp); MLRA=$(g input_lra); MTH=$(g input_thresh); OFF=$(g target_offset)
echo "measured: ${MI} LUFS, peak ${MTP} dBTP"
ffmpeg -v error -y -i "$IN" -c:v copy -af "loudnorm=I=${I}:TP=${TP}:LRA=11:measured_I=${MI}:measured_TP=${MTP}:measured_LRA=${MLRA}:measured_thresh=${MTH}:offset=${OFF}:linear=true,aresample=48000" -c:a aac -b:a 256k "$OUT"
ffmpeg -hide_banner -i "$OUT" -af ebur128=peak=true -f null - 2>&1 | grep -E "^\s+(I:|Peak:)" | tail -2
echo "wrote $OUT"
