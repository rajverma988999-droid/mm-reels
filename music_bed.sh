#!/bin/zsh
# Build the music bed as ONE file: dark epic under the problem, hard switch on the first "fix" line to a
# calm lo-fi bed (low-pass 5500 Hz, sidechain-ducked under the voice), faded out at the end.
# HyperFrames <audio> only has volume, so EQ and ducking happen here. Play the result as
#   <audio id="bgm" src="assets/audio/bgm_mix.wav" data-start="0" data-duration="<END>" data-volume="1.0">
#
# Usage:  scripts/music_bed.sh DARK.mp3 CALM.mp3 VOICE.mp3 SWITCH END OUT.wav [CALM_START=8.42] [DARK_VOL=0.12] [CALM_VOL=0.10]
#   SWITCH     = time (s) of the first "fix" word (V4: 29.0, "To chai chhodni nahi hai")
#   END        = video length (s)
#   CALM_START = where the calm track's beat starts (skip a quiet intro; Circle: 8.42). Check its first 10 s!
# Also writes OUT_preview.mp3 (voice + bed) so the user can judge the music: VideoHub's live preview
# plays only the voice-over.
# Defaults are the V4 values. Bundled: assets/music/bgm_dark_epic.mp3 and assets/music/circle_lofi.mp3.
set -e
DARK="$1"; CALM="$2"; VO="$3"; SW="$4"; END="$5"; OUT="$6"
CS="${7:-8.42}"; DV="${8:-0.12}"; CV="${9:-0.10}"
[[ -n "$OUT" ]] || { sed -n 2,14p "$0"; exit 2; }
FADE_ST=$(echo "$SW - 1.0" | bc -l)          # dark fades out over 1.4 s, overlapping the calm entry
DARK_END=$(echo "$SW + 0.4" | bc -l)
CALM_LEN=$(echo "$END - $SW" | bc -l)
OUT_ST=$(echo "$END - 1.5" | bc -l)
MS=$(printf "%.0f" $(echo "$SW * 1000" | bc -l))
ffmpeg -v error -y -i "$DARK" -i "$CALM" -i "$VO" -filter_complex "
[0:a]aformat=channel_layouts=stereo,aresample=48000,atrim=0:${DARK_END},asetpts=PTS-STARTPTS,afade=t=out:st=${FADE_ST}:d=1.4,volume=${DV}[a];
[1:a]aformat=channel_layouts=stereo,aresample=48000,atrim=start=${CS}:duration=${CALM_LEN},asetpts=PTS-STARTPTS,afade=t=in:st=0:d=0.12,lowpass=f=5500,volume=${CV},adelay=${MS}|${MS},apad=whole_dur=${END}[b0];
[2:a]aformat=channel_layouts=stereo,aresample=48000,apad=whole_dur=${END}[key];
[b0][key]sidechaincompress=threshold=0.03:ratio=4:attack=20:release=300:makeup=1[b1];
[b1]afade=t=out:st=${OUT_ST}:d=1.5[b];
[a][b]amix=inputs=2:normalize=0:duration=longest,atrim=0:${END}[out]" -map "[out]" -c:a pcm_s16le "$OUT"
ffmpeg -v error -y -i "$VO" -i "$OUT" -filter_complex "[0:a]aformat=channel_layouts=stereo,aresample=48000[v];[v][1:a]amix=inputs=2:normalize=0:duration=longest,alimiter=limit=0.95[o]" -map "[o]" -b:a 192k "${OUT%.*}_preview.mp3"
echo "bed: $OUT   preview (voice + bed): ${OUT%.*}_preview.mp3"
echo "Check levels: dark bed ~ -36 dB under the voice, calm bed -38..-42 dB under the voice, ~ -32 dB in pauses."
