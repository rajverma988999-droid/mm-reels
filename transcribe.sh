#!/bin/zsh
# Voice-over -> word times (words.tsv: start<TAB>end<TAB>word), free and local with whisper.cpp.
# Usage:  scripts/transcribe.sh VOICE.mp3 OUT_DIR [lang=hi]
# Needs:  ffmpeg, whisper-cli (brew install whisper-cpp), a ggml model.
#         Model path: $WHISPER_MODEL, default ~/.whisper-models/ggml-large-v3-turbo-q5_0.bin
# Long voice-overs are cut into 55 s chunks (whisper drifts on long files) and the times are joined.
set -e; setopt null_glob
IN="$1"; OUT="${2:-transcript}"; LANG_="${3:-hi}"
MODEL="${WHISPER_MODEL:-$HOME/.whisper-models/ggml-large-v3-turbo-q5_0.bin}"
[[ -f "$IN" ]] || { echo "no input: $IN"; exit 1; }
[[ -f "$MODEL" ]] || { echo "no whisper model at $MODEL (set WHISPER_MODEL)"; exit 1; }
mkdir -p "$OUT"
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$IN")
CH=55; i=0; t=0
rm -f "$OUT"/chunk_*.json
while (( $(echo "$t < $DUR" | bc -l) )); do
  ffmpeg -v error -y -ss $t -t $CH -i "$IN" -ac 1 -ar 16000 -c:a pcm_s16le "$OUT/chunk_$i.wav"
  whisper-cli -m "$MODEL" -f "$OUT/chunk_$i.wav" -l "$LANG_" -ml 1 -sow -oj -of "$OUT/chunk_${i}@${t}" >/dev/null 2>&1
  rm -f "$OUT/chunk_$i.wav"; i=$((i+1)); t=$((t+CH))
done
python3 - "$OUT" <<'PY'
import json, glob, os, sys
out = sys.argv[1]; rows = []
for f in sorted(glob.glob(os.path.join(out, "chunk_*@*.json")), key=lambda p: float(p.rsplit("@", 1)[1][:-5])):
    off = float(f.rsplit("@", 1)[1][:-5])
    for seg in json.load(open(f))["transcription"]:
        w = seg["text"].strip()
        if not w or w.startswith("["): continue
        a = seg["offsets"]["from"] / 1000 + off; b = seg["offsets"]["to"] / 1000 + off
        rows.append(f"{a:.2f}\t{b:.2f}\t{w}")
open(os.path.join(out, "words.tsv"), "w").write("\n".join(rows) + "\n")
print(f"{len(rows)} words -> {os.path.join(out, 'words.tsv')}")
bad = [r for r in rows if float(r.split("\t")[1]) - float(r.split("\t")[0]) > 1.5]
for r in bad:
    a, b, w = r.split("\t")
    print(f"WARNING: '{w}' lasts {float(b)-float(a):.1f} s ({a}-{b}): whisper lost sync there. Re-run that span alone:")
    print(f"  ffmpeg -ss {float(a)-1:.1f} -to {float(b)+1:.1f} -i VOICE out_span.mp3  -> transcribe it, add {float(a)-1:.1f} s to its times")
PY
