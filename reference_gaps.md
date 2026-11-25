# What the Antigravity skill's chai demo missed vs the reference — checked 2026-11-23

Compared: `09_Videos/Copy MeanWhileMayank/Skill_And_Test/generated_videos/chai_iron_myth_demo_v2_voiced.mp4` (contact sheet: `MM_Style_Skill/reference_sheets/chai_iron_myth_demo_v2_voiced_0-40s.jpg`) (39.5 s) against
`MM_Style_Skill/reference_videos/ref_01, 03, 04, 05, 07, 10, 12` (1 fps contact sheets of 0–40 s,
60–100 s of ref_03, 6–30 fps strips of transitions, pixel measurements over 64–81 frames per reel).

## The one-line answer
The chai demo is **7 still pictures with a slow zoom**. The reference is **small sets where objects
and the camera move on every phrase**. Picture motion per 2 s: chai demo **1.73** vs reference **9.4–12.9**;
the chai demo is still in 37% of 2-s windows, the reference in 0–3%.

## Gaps, biggest first

| # | Reference does | Chai demo did | Fix in Claude update V2 (SKILL.md) |
|---|---|---|---|
| 1 | Scenes built from **layers**: empty plate + cut-out props + before/after states | One baked image per scene (768x1376, upscaled) | SKILL.md rule 1 + Workflow step 3 (rembg cut-outs, overscan plates, state images) |
| 2 | **Something changes every ≤ 2 s** (prop lands, fill spreads, hand acts, state swaps) | 4–7 s holds: map 6 s, stomach 7 s, blood cells 7 s, clock 5 s | SKILL.md rule 2 + the beat sheet |
| 3 | **Camera always moving**: reframe across the map, punch-in to a face, tilt wall→sky, whip-pan across the bed, zoom-through into a hole/molecule, pull-back out of a phone frame | Slow 1.00→1.07 zoom on each image; 2 slide transitions | motion_vocabulary.md (camera) |
| 4 | **Drop & pile physics**: coins rain and stack into bar columns, pots rain into a grid, products fall into a heap, coal drops into the stove, element tiles slam down | Coin stack is baked into the map image, does not move | motion_vocabulary.md (drop & settle, stack into a chart )|
| 5 | **Traveller across cuts**: virus falls out of the sky scene onto the map, rolls, each country turns red as it touches it | No object ever crosses a cut | motion_vocabulary.md (traveller + fill spreads )|
| 6 | **State swaps on the same set**: night→morning window, lit→dead coal, pink→grey lungs, red→gold brain, heads turning bald one by one | None | motion_vocabulary.md (state swap )|
| 7 | **Hands do things**: push the bolt, break glass, crush a puri, lift the stove, hold the phone | No hands | motion_vocabulary.md (hand action )|
| 8 | **Constant foreground, background swaps on each word** (glass in hand: festival → street → party) | — | motion_vocabulary.md |
| 9 | **Evidence props**: Tribune clipping with tape, research paper with red pushpin, luggage tags with country names, "30 CM" dimension line, DHT rubber stamp, red X / green tick | None | motion_vocabulary.md (evidence, tags, stamp, marks )|
| 10 | **Titles big**: Anton, Line 1 ≈ 92 px, Line 2 ≈ 140 px, Line 1 up to 80% of width, Line 2 a light→saturated **gradient** with glow, rises from a mask blurred→sharp | Oswald 56 / 90 px (about half the area), flat colour, Line 1 greyish | titles_overlay_worlds.md |
| 11 | **About 9–15 title pairs per 40 s**, one per phrase, cleared at transitions | 7 pairs, held 5–7 s | SKILL.md Pacing, titles_overlay_worlds.md |
| 12 | **Fold crease at 62.5%**, soft dark+light band | Hard thin line at 52% | titles_overlay_worlds.md |
| 13 | **7 clearly visible punched holes** at x 4%, every 11.46% from y 15.6% | 11 dots, practically invisible | titles_overlay_worlds.md |
| 14 | Mustard background reads as **notebook paper** (grain + faint ruled lines) | Flat yellow gradient | titles_overlay_worlds.md (paper texture) |
| 15 | **Counters are physical plates**: cream plate, red double border, red unit label printed on it (`500 OILS`, `100/100`), brass date plate `14 JANUARY 2024`, digits blur while rolling | Red frame + grey caption under it (reads like UI) | motion_vocabulary.md (counters) |
| 16 | **Hook = 3 actions in 4 s** (foot splashes, tap pours into hands, hand crushes puri) before the question lands | One still thali for 4.7 s | SKILL.md Pacing, mistakes_and_layout.md (free-only limits) |
| 17 | Story sets and people from above/behind, hands only, calm portraits | Only food/organ/object stills | titles_overlay_worlds.md (worlds) |
| 18 | Audio peaks −0.5 to −0.7 dBFS | −2.1 dBFS | sound_and_music.md |

## Stale numbers in the original style analysis (`../history/STYLE_ANALYSIS_original.md`; corrected copy: `references/style_analysis.md`)
That file (and the Antigravity SKILL.md) say the crease is at ≈ 52% and there are 8–11 binder dots. Measured on 4 reels:
the crease is at **62.5%** and there are **7** holes. Claude update V2 uses the measured values; the
analysis file was left as it was.

## What still can't be copied for free
A few hook shots in the reference are real moving footage (splashing foot, pouring water). Without paid
image-to-video these become layered cut-out actions or a free stock clip (see mistakes_and_layout.md).
