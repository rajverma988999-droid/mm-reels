# Worked example: the V4 chai demo ("Chai & Iron", approved 2026-11-23)

The approved reel built with this style: 39.5 s, 14 sets, 24 beats, 17 title pairs. It passed the VideoHub
review after 5 notes (all fixed in this `index.html`) and the motion gate (median 7.72, 0% still).
The rendered result is outside the skill: `MM_Style_Skill/example_output/chai_iron_myth_demo_v4_music.mp4` (`../../../example_output/` from here),
The slideshow version that failed is at `09_Videos/Copy MeanWhileMayank/Skill_And_Test/generated_videos/chai_iron_myth_demo_v2_voiced.mp4` (its contact sheet is in `MM_Style_Skill/reference_sheets/`).

**This folder plays as is:** `index.html` + `hyperframes.json` + `assets/` (cut-out images in `assets/img/`, Anton,
SFX, the voice-over and the finished music bed `bgm_v4_mix.mp3`). Open it in a HyperFrames preview or VideoHub.

What to copy from `index.html`:
| Want | Look at |
|---|---|
| Hook: thali slides in, chai glass drops, punch-in, steam | scene A |
| Same hand + glass while the background swaps on each word | scene B |
| Red 3D `?` drawn stroke by stroke, red arrow with a popping head | scene C |
| Printed map, red fill spreading from a point, split-flap `57%` plate, pinned NFHS-5 card | scene D |
| Zoom-through into the glass, floating molecules, bubbles | scenes after D |
| Padlock drops and snaps shut (state swap) | the "LOCK" scene |
| Tablets raining into a tray, turning grey | the "60% TAK KAM" scene |
| Brass clock with code hands and a gold time wedge | the "1 GHANTE KA GAP" scene |
| Side-by-side with divider + pill, ticks below both items | scene N |
| Every helper (`drop`, `roll`, `draw`, `whipIn`, `tiltIn`, `title`) | the top of `<script>` |

- `BEAT_SHEET.md`: how the voice-over became 24 beats. It was written **before** the review; the final
  `index.html` has the fixes (real thali + chai falling into the stomach, red arrow, two ticks under food and
  chai, no overlaps). Its paths (and those in `IMAGES_NEEDED.md`) point at the original project folders in `09_Videos/Copy MeanWhileMayank/`; the final render is `chai_iron_myth_demo_v4_music.mp4`.
- `IMAGES_NEEDED.md`: the 8 plate and 15 prop prompts that worked.
- Music bed: dark epic 0–29.4 s, switch to "Circle" lo-fi at 29.0 s (its beat at 8.42 s), low-pass 5500 Hz,
  ducked, faded out at 38–39.5 s. Rebuild it with `scripts/music_bed.sh` (switch 29.0, end 39.5).
- Changed from the approved file: only `data-layout-allow-occlusion` on `#vig` and `#overlay` (so `hyperframes check`
  stops reading the see-through vignette as a cover) and the header comment. Nothing visible changed.
- Not for sharing: `assets/audio/` (see `../../assets/LICENSES.md`).
