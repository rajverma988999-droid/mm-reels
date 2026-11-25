#!/bin/zsh
# Contact sheet: 1 frame per second, 10 x 4 tiles per sheet (40 s each). Compare it with the reference
# sheets: titles as big, crease at ~62% and 7 holes on every frame, no cut-out halos, no plate edges.
# Usage:  scripts/contact_sheet.sh VIDEO.mp4 [OUT_PREFIX]
set -e
IN="$1"; P="${2:-${IN%.*}_sheet}"
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$IN"); s=0; n=1
while (( $(echo "$s < $DUR" | bc -l) )); do
  ffmpeg -v error -y -ss $s -t 40 -i "$IN" -vf "fps=1,scale=216:384,tile=10x4" -frames:v 1 -q:v 4 "${P}_${n}.jpg"
  echo "${P}_${n}.jpg  (${s}-$((s+40)) s)"; s=$((s+40)); n=$((n+1))
done
