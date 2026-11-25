# Sound and music

## Sound

- Voice 1.00, low ambient bed 0.12–0.14 ducked under the voice, SFX 0.40–0.50.
- An SFX on **every physical event**: whoosh on whips and tilts, tick/clink on each landing coin or pot, paper
  slide on cards, thud on stamps and tiles, glass crack, door creak, low boom on pink/danger titles, clock ticks.
- Master to about −14 LUFS with true peak around −0.7 dBTP (reference peaks −0.5 to −0.7 *(m)*; chai demo −2.1).
  The HyperFrames render comes out quieter (V4: −18.8 LUFS), so loudness-match after rendering with `scripts/loudnorm.sh` (mistakes_and_layout.md, Sound).

### Music follows the story: dark under the problem, calm under the fix (user's rule, V4, 2026-11-23)
- **Problem part** (Pain → Poke, up to the line where the fix starts): a dark epic bed. V4 used
  `assets/music/bgm_dark_epic.mp3` ("50 Invictus - Dark Epic", Epidemic Sound) at 0.12, from its start.
- **Switch on the first "fix" line** (V4: 0:29, "To chai chhodni nahi hai"): fade the epic out over ~1.4 s
  (V4: 28.0 → 29.4 s) and bring the calm track in hard at the switch, overlapping the tail of the fade.
- **Fix / payoff part:** a soft, cozy lo-fi bed. V4 used
  `assets/music/circle_lofi.mp3` ("Circle", Epidemic Sound) with a warm low-pass at
  5500 Hz, **sidechain-ducked under the voice**, and a fade-out over the last 1.5 s.
- **Start the calm track on its beat, not its intro.** Circle's first 8 s are a quiet intro (about −22 dB), so
  starting there made the switch inaudible (−48 dB). V4 starts it at 8.42 s, in the silent dip just before
  the beat at 8.5 s, with a 0.12 s fade-in. Check any new track's first 10 s for an intro before choosing
  where to start it.
- **Build the bed as one file with ffmpeg: `scripts/music_bed.sh` does all of this** (it also writes the voice + bed preview MP3) (HyperFrames `<audio>` has volume only: no EQ, no ducking), then
  play it as one `<audio id="bgm" data-volume="1.0">`. V4's filter, with the voice-over as the duck key:
  ```
  [0:a]atrim=0:29.4,asetpts=PTS-STARTPTS,afade=t=out:st=28.0:d=1.4,volume=0.12[a];
  [1:a]atrim=start=8.42:duration=10.6,asetpts=PTS-STARTPTS,afade=t=in:st=0:d=0.12,lowpass=f=5500,volume=0.10,
       adelay=29000|29000,apad=whole_dur=39.5[b0];
  [2:a]aformat=channel_layouts=stereo,aresample=48000,apad=whole_dur=39.5[key];
  [b0][key]sidechaincompress=threshold=0.03:ratio=4:attack=20:release=300:makeup=1[b1];
  [b1]afade=t=out:st=38.0:d=1.5[b];
  [a][b]amix=inputs=2:normalize=0:duration=longest,atrim=0:39.5[out]
  ```
- **Check the levels per section:**
  - Dark bed about −36 dB under the voice.
  - Calm bed −38 to −42 dB under the voice, rising to about −32 dB in pauses (the duck is working).
  - Voice about −21 to −23 dB.
- **VideoHub's live preview plays only the voice-over.** To let the user hear the bed before a render, give
  them a voice + bed MP3 made with ffmpeg.
