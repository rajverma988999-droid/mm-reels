#!/bin/zsh
# Start a new reel from the starter template (camera rig, title helper, drop & settle, split-flap counter,
# evidence card, draw-on strokes, spotlight, notebook overlay, Anton, grain, 4 world plates, SFX kit).
# Usage:  scripts/new_reel.sh TARGET_DIR [DURATION_SECONDS]
# Then:   put the voice-over at TARGET_DIR/assets/audio/voiceover.mp3 and follow SKILL.md "Workflow".
set -e; setopt null_glob
HERE="${0:A:h}/.."; T="$1"; D="${2:-10}"
[[ -n "$T" ]] || { sed -n 2,5p "$0"; exit 2; }
[[ -e "$T/index.html" ]] && { echo "$T/index.html exists: not overwriting. Pick a new folder (_vN)."; exit 1; }
mkdir -p "$T/assets/images_in"
cp -R "$HERE/templates/starter/." "$T/"
cp "$HERE/templates/BEAT_SHEET_TEMPLATE.md" "$T/BEAT_SHEET.md"
cp "$HERE/templates/IMAGES_NEEDED_TEMPLATE.md" "$T/IMAGES_NEEDED.md"
cp "$HERE/templates/SCRIPT_TEMPLATE.md" "$T/SCRIPT.md"
cp "$HERE/templates/PROGRESS_TEMPLATE.md" "$T/PROGRESS.md"
mkdir -p "$T/transcript"
sed -i '' -e "s/data-duration=\"10\" data-width/data-duration=\"$D\" data-width/" -e "s/^const END = 10;/const END = $D;/" "$T/index.html"
echo "new reel at $T ($D s). Next: voice-over -> scripts/transcribe.sh -> BEAT_SHEET.md -> IMAGES_NEEDED.md"
