#!/bin/zsh
# Checks everything this skill needs, and (with --install) installs what is missing.
#
#   scripts/check_setup.sh            check only: prints a table, what is missing and how to install it
#   scripts/check_setup.sh --install  install the missing things that need no password (asks nothing itself;
#                                      Claude runs it only after the user said yes)
#
# Always writes ~/.mm-reels/env.sh. Every later step starts with:  source ~/.mm-reels/env.sh
# It sets: PATH (Node 22 first), MMPY (a Python with Pillow + numpy), REMBG, WHISPER_MODEL.
#
# Exit code: 0 = ready, 1 = something required is missing.
# macOS (Apple Silicon or Intel) with Homebrew. Linux works with apt equivalents; Windows is not supported yet.
setopt null_glob
INSTALL=0; [[ "$1" == "--install" ]] && INSTALL=1
SKILL="${0:A:h:h}"
HOME_DIR="$HOME/.mm-reels"; VENV="$HOME_DIR/venv"; ENVF="$HOME_DIR/env.sh"
MODEL_DIR="$HOME/.whisper-models"; MODEL_NAME="ggml-large-v3-turbo-q5_0.bin"
MODEL_URL="https://huggingface.co/ggerganov/whisper.cpp/resolve/main/$MODEL_NAME"
mkdir -p "$HOME_DIR"

typeset -a ROWS MISSING_REQ MISSING_OPT USER_ONLY
row() { ROWS+=("$1|$2|$3"); }            # name | OK / MISSING / WARN | detail
have() { command -v "$1" >/dev/null 2>&1; }
inst() { echo "  -> installing: $*"; "$@"; }

# ---- 0. Homebrew (installs everything else on macOS) ----
OS=$(uname -s)
for b in /opt/homebrew/bin /usr/local/bin; do [[ -d $b ]] && PATH="$b:$PATH"; done
if [[ $OS == Darwin ]]; then
  if have brew; then row "Homebrew" OK "$(brew --version | head -1)"
  else
    row "Homebrew" MISSING "needed to install the other tools"
    USER_ONLY+=('Homebrew: paste this in Terminal (it asks for your Mac password, so you run it yourself):
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
  fi
else
  row "System" WARN "$OS: install the tools below with your package manager (apt), then re-run"
fi

# ---- 1. ffmpeg ----
if have ffmpeg && have ffprobe; then row "ffmpeg" OK "$(ffmpeg -version | head -1 | cut -d' ' -f1-3)"
else row "ffmpeg" MISSING "video/audio tool"; MISSING_REQ+=(ffmpeg)
  (( INSTALL )) && have brew && inst brew install ffmpeg; fi

# ---- 2. Node 22+ ----
NODE22=""
for n in /opt/homebrew/opt/node@22/bin /usr/local/opt/node@22/bin $(dirname "$(command -v node 2>/dev/null)" 2>/dev/null); do
  [[ -x "$n/node" ]] || continue
  v=$("$n/node" -v | tr -d v | cut -d. -f1); (( v >= 22 )) && { NODE22="$n"; break; }
done
if [[ -z $NODE22 ]] && (( INSTALL )) && have brew; then inst brew install node@22
  for n in /opt/homebrew/opt/node@22/bin /usr/local/opt/node@22/bin; do [[ -x "$n/node" ]] && NODE22="$n"; done; fi
if [[ -n $NODE22 ]]; then row "Node.js 22+" OK "$("$NODE22/node" -v) ($NODE22)"; PATH="$NODE22:$PATH"
else row "Node.js 22+" MISSING "runs HyperFrames"; MISSING_REQ+=(node@22); fi

# ---- 3. Python with Pillow + numpy ----
MMPY=""
for p in "$VENV/bin/python3" "$(command -v python3)"; do
  [[ -x "$p" ]] && "$p" -c "import PIL, numpy" 2>/dev/null && { MMPY="$p"; break; }
done
if [[ -z $MMPY ]] && (( INSTALL )); then
  have python3 || { have brew && inst brew install python; }
  [[ -x "$VENV/bin/python3" ]] || inst python3 -m venv "$VENV"
  inst "$VENV/bin/pip" install -q --upgrade pip pillow numpy && MMPY="$VENV/bin/python3"
fi
if [[ -n $MMPY ]]; then row "Python + Pillow + numpy" OK "$MMPY"
else row "Python + Pillow + numpy" MISSING "image tools"; MISSING_REQ+=(python-pillow-numpy); fi

# ---- 4. rembg (cuts props out of their background) ----
REMBG="${REMBG:-}"
for r in "$REMBG" "$(command -v rembg 2>/dev/null)" "$VENV/bin/rembg" "$SKILL/../../../../07_Scripts/rembg_venv/bin/rembg" "$PWD/07_Scripts/rembg_venv/bin/rembg"; do
  [[ -n "$r" && -x "$r" ]] && { REMBG="${r:A}"; break; } || REMBG=""
done
if [[ -z $REMBG ]] && (( INSTALL )); then
  [[ -x "$VENV/bin/python3" ]] || inst python3 -m venv "$VENV"
  inst "$VENV/bin/pip" install -q "rembg[cli]" && REMBG="$VENV/bin/rembg"
  echo "  (rembg downloads its cut-out model, about 170 MB, the first time it runs)"
fi
if [[ -n $REMBG ]]; then row "rembg" OK "$REMBG"
else row "rembg" MISSING "cuts props out (needs ~1 GB with its model)"; MISSING_REQ+=(rembg); fi

# ---- 5. whisper.cpp + model (word times from the voice-over) ----
if have whisper-cli; then row "whisper.cpp" OK "$(command -v whisper-cli)"
else
  (( INSTALL )) && have brew && inst brew install whisper-cpp
  if have whisper-cli; then row "whisper.cpp" OK "$(command -v whisper-cli)"
  else row "whisper.cpp" MISSING "turns the voice-over into word times"; MISSING_REQ+=(whisper-cpp); fi
fi
WHISPER_MODEL="${WHISPER_MODEL:-$MODEL_DIR/$MODEL_NAME}"
if [[ ! -s $WHISPER_MODEL ]] && (( INSTALL )); then
  mkdir -p "$MODEL_DIR"; echo "  -> downloading the whisper model (about 550 MB)…"
  curl -L --fail -o "$WHISPER_MODEL.part" "$MODEL_URL" && mv "$WHISPER_MODEL.part" "$WHISPER_MODEL"
fi
if [[ -s $WHISPER_MODEL ]]; then row "whisper model" OK "$WHISPER_MODEL"
else row "whisper model" MISSING "~550 MB download (Hindi + English)"; MISSING_REQ+=(whisper-model); fi

# ---- 6. HyperFrames (renders the reel) via its own doctor ----
if [[ -n $NODE22 ]]; then
  DOC=$(cd /tmp && npx -y hyperframes doctor --json 2>/dev/null)
  if [[ -n $DOC ]]; then
    while IFS='|' read -r name ok detail hint; do
      case $name in
        Version|Chrome|Disk) [[ $ok == True ]] && row "HyperFrames $name" OK "$detail" || { row "HyperFrames $name" MISSING "$hint"; MISSING_REQ+=("hyperframes-$name"); } ;;
        Memory) [[ $ok == True ]] && row "Free memory" OK "$detail" || row "Free memory" WARN "$detail: close other apps before rendering" ;;
      esac
    done < <(print -r -- "$DOC" | python3 -c "
import json,sys
for c in json.load(sys.stdin)['checks']: print('|'.join([c['name'], str(c['ok']), c.get('detail','')[:80].replace('|','/'), c.get('hint','').replace('|','/')]))")
  else row "HyperFrames" MISSING "npx could not run it (check the internet connection)"; MISSING_REQ+=(hyperframes); fi
else row "HyperFrames" MISSING "needs Node 22 first"; fi

# ---- 7. Optional extras ----
have bc && row "bc" OK "" || { row "bc" MISSING "used by the music script"; MISSING_REQ+=(bc); }
if [[ -s "$SKILL/assets/music/bgm_dark_epic.mp3" && -s "$SKILL/assets/music/circle_lofi.mp3" ]]; then row "Music tracks" OK "bundled (personal licence)"
else row "Music tracks" WARN "none bundled: the user brings a dark track + a calm track, or the reel has SFX only"; fi

# ---- write env.sh ----
cat > "$ENVF" <<EOF
# written by meanwhile-mayank-style-reels/scripts/check_setup.sh — source it before running the skill's scripts
export PATH="${NODE22:+$NODE22:}/opt/homebrew/bin:/usr/local/bin:\$PATH"
export MMPY="${MMPY:-python3}"
export REMBG="${REMBG}"
export WHISPER_MODEL="${WHISPER_MODEL}"
export MM_SKILL="${SKILL}"
EOF

# ---- report ----
echo; echo "Meanwhile Mayank style reels: setup check"; echo "-----------------------------------------"
for r in $ROWS; do IFS='|' read -r a b c <<< "$r"; printf "%-26s %-8s %s\n" "$a" "$b" "$c"; done
echo; echo "Settings written to $ENVF  (use: source $ENVF)"
if (( ${#USER_ONLY} )); then echo; echo "YOU need to do this yourself first:"; for u in $USER_ONLY; do echo "  - $u"; done; fi
if (( ${#MISSING_REQ} )); then
  echo; echo "MISSING: ${MISSING_REQ[*]}"
  (( INSTALL )) || echo "To install them (no password needed, about 1.5 GB of downloads): scripts/check_setup.sh --install"
  exit 1
fi
echo; echo "READY: everything the skill needs is installed."; exit 0
