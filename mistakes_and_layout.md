# Layout rules and mistakes already made once

Read this before building and again before showing the video. Every line happened in the V4 chai build or its VideoHub review and is fixed in `examples/chai_v4/`.

**The user's 5 review notes on V4 (his words, all fixed):**
1. "instead of this color drop and line use food image and chai image drop from top to stomach": show the real cut-outs moving, not abstract dots and lines.
2. "for this use red color to direct to stomach": a pointing line is red (`#E3243B`) with an arrowhead into the target.
3. "here add green check below chai and food": one tick under each item, below it, never on it.
4. "why this green dot before even use": hidden strokes stay at `opacity: 0` until they draw.
5. "overlap remove, add in skill also": nothing rests on anything else (Layout rules below).

## Layout: nothing overlaps (from the V4 review, 2026-11-23)

- **No prop, label, pill, tick or counter may rest on top of another one, or on a title.** Each gets its own
  clear space; keep at least 24 px between resting objects. Plan a layout box per object in the beat sheet
  (x, y, width) and check the boxes don't intersect. A falling or whipping object may cross something for a
  few frames, but where it comes to rest must be clear.
- **Side-by-side comparisons** (food | gap | chai): left item, divider + pill in the gap, right item, and the
  pill must fit inside the gap. Ticks, crosses and labels go **below** the thing they mark, never across it.
- **Titles own the top 30%.** Time a title's Line 2 so it appears after a prop has passed through that zone,
  not while the prop is crossing it.
- **Hide what hasn't started yet.** A draw-on stroke with round caps shows a dot before it draws: keep it at
  `opacity: 0` until its draw starts. A hidden Line 2 inside its mask can peek out as a thin coloured line:
  hide it with `opacity: 0` as well as `yPercent: 140`.
- **QC:** take stills at the end of every beat (`npx hyperframes snapshot --at …`) and look for collisions,
  peeking elements and early dots before showing the video.

---

## What cannot be matched 1:1 for free (say so, don't fake it)

Some reference hook shots are real moving footage (a foot splashing in a puddle, water pouring from a tap).
Without paid image-to-video, build them as layered actions (foot cut-out stepping down + splash pieces bursting
out; a water-stream cut-out stretching `scaleY` under a moving mask), or use a free stock clip (Pexels /
Pixabay, downloaded locally, played as a HyperFrames video clip; check the `hyperframes` skill for clip
attributes). Never spend credits.

## Don't do this — mistakes already made once (V4 chai demo, 2026-11-23)

Every line here happened in the V4 build or its review and was fixed. Read this list before building, and
check each item again before showing the video.

### Story pictures
- **Don't show a story object as an abstract shape.** Coloured dots for "food" and a yellow line for "chai"
  were rejected: use the real cut-out (thali, chai glass) and move *it* (fall from the top, through the food
  pipe, into the stomach).
- **Don't draw a "goes to" line without a direction.** A line from A to B is red (`#E3243B`) and ends in an
  arrowhead pointing into B. Pop the arrowhead when the line finishes; an SVG `marker` shows before the line
  has drawn.
- **Don't put a tick or cross on top of the thing it marks.** It goes below it (one per item: a tick under the
  food *and* one under the chai).

### Things showing up before their moment
- **Don't let a prop sit just above the frame before it drops.** A drop that starts at `y: -1500` left bowls
  and a padlock peeking in at the top. Start drops at least `-(top + height + 200)` above (V4 uses `-2300`),
  or hide them with `opacity: 0` until they fall.
- **Don't leave a slide-in card parked at the frame edge.** The evidence card showed at the bottom before its
  entrance: start it at `opacity: 0` and far enough away.
- **Don't let a draw-on stroke or a hidden title show early.** A round-cap stroke shows a dot before it draws,
  and a masked Line 2 shows a thin coloured line. Both stay at `opacity: 0` until their entrance (Layout rules above).

### Camera
- **Don't zoom the camera out below `scale: 1`.** It showed black edges around the plate. To show more, place
  the props so they fit at scale 1, or make the plate bigger.
- **Don't change a `.cam`'s `transformOrigin` in the middle of a scene.** While scaled, a new origin makes the
  picture jump. Set one origin per scene (on the main subject) and do every move from it.
- **Don't leave a dead gap after something settles.** After the counter and tablets settled, nothing moved
  for 2 s and the motion gate failed. Put the next beat (a punch-in on the key word, a pulse on the items
  that matter) within 2 s.

### Titles and text
- **Don't put pink, gold or lime titles on mustard without help.** They were unreadable. Keep the strong top
  vignette (`rgba(20,10,0,.78)` → `.55` at 18% → 0 at 34%) and a dark under-shadow on every Line 2
  (`drop-shadow(0 3px 5px rgba(0,0,0,.55))` before the coloured glow).
- **Don't guess title widths.** Measure each line in Anton with `scripts/fit_titles.py` and shrink only
  Line 2 so it stays within 80% of the width (V4: `ROZ KYA KARTI?` at 128 px, `1 GHANTE KA GAP` at 130 px).
- **Don't show a Line 2 while a prop is falling through the title zone.** Time it for after the prop has
  passed, ideally on the spoken word (V4: `SAATH MILTE HI` on "milte").
- **Don't use reading text under 28 px** (the card's source line), and keep cards inside the 168–1330 px band.
- **Don't put a source card on a number you can't source.** V4 shows NFHS-5 (57.0% of women 15–49 anaemic);
  the "60%" figure got no card because no study was given.

### Images and cut-outs
- **Don't trust rembg on pale objects or flat sheets.** It made a light wooden tray half see-through and threw
  away a map's paper and sea. For those, cut by colour distance from the grey background, fill the holes, and
  feather the edge: `scripts/cutout.py IN OUT --mode color --check`.
- **Don't assume two generated "states" line up.** The red map was drawn on a different sheet from the plain
  one. Make one state from the other (recolour the red land back to beige), or measure the offset and shift
  one before stacking (the closed padlock needed 6×12 px).
- **Don't forget the plates' real size.** Generated plates came at 941×1672. Resize them to 1080×1920 once and
  keep camera pushes modest (≤ 1.4, except the zoom-through) so they stay sharp.

### Sound
- **Don't run one music track under the whole video.** Dark epic under the problem, then switch on the first
  "fix" line to a soft lo-fi bed (low-pass 5500 Hz, ducked under the voice, faded out at the end): sound_and_music.md.
- **Don't start the calm track from its intro.** Circle's quiet 8-second intro made the switch inaudible
  (−48 dB); start on the beat (8.42 s) and check any new track's first 10 s first.
- **Don't try EQ or ducking with HyperFrames `<audio>`.** It only does volume: build the bed with ffmpeg
  (`lowpass`, `sidechaincompress` keyed by the voice-over, `afade`) and play it as one file.
- **Don't ask the user to judge the music in VideoHub's live preview.** It plays only the voice-over: send a
  voice + bed MP3 instead.
- **Don't drop an SFX in without checking its first second.** `riser_clean.mp3` is silent for 1.3 s; trim it
  with `data-media-start="1.3"`. HyperFrames `check` flags this as `audio_clip_silent`.
- **Don't deliver the render's loudness as is.** It came out at −18.8 LUFS. Run a two-pass `loudnorm` (`scripts/loudnorm.sh`) to −14
  LUFS / −1 dBTP on a copy, re-encoding only the audio (`-c:v copy`). In zsh, write `${VAR}:linear=true`, not
  `$VAR:linear`: zsh reads `:l` as a modifier and breaks the filter.

### Workflow
- **Don't pipe `hyperframes check` into `head`.** That cuts it off before it saves its report. Send its output
  to a file and read the JSON. Mark rolling counter digits `data-layout-ignore` (they are hidden on purpose).
- **Don't render to check a fix.** Check fixes with `npx hyperframes snapshot --at <times>`. Draft renders only
  go to a scratch folder for the motion gate; the real render happens once, when the user asks.
- **Don't overwrite an earlier version.** Each attempt gets a new name (`…_v4.mp4`), copied from VideoHub's
  output into the delivery folder.
