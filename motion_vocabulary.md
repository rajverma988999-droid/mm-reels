# Motion vocabulary: camera moves, prop moves, counters

What the reference reels do and how to build each move in GSAP (all on the one paused timeline). Values marked *(m)* were measured, *(s)* read off contact sheets; the rest are starting values to tune by eye. Every helper named here (`drop`, `roll`, `draw`, `whipIn`, `tiltIn`, `title`) is in `templates/starter/index.html` and `examples/chai_v4/index.html`.

All moves live on the one paused master timeline `window.__timelines["main"]`. Seed any randomness
(`let s=7; const rnd=()=>(s=(s*16807)%2147483647)/2147483647;`) so every render is identical.

**Render-proven (V4, 2026-11-23).** These all rendered correctly in HyperFrames in the V4 chai demo: GSAP
transforms and opacity, `keyframes`, SVG `stroke-dashoffset` draw-ons, CSS `clip-path` circle reveals,
`background-clip: text` gradient titles, tweened CSS `filter: blur()` / `grayscale()` / `brightness()`, and
`svgOrigin` rotation for clock hands. Whips used CSS `blur(16px)` on the whole scene, which looks fine.
A tweened SVG `feGaussianBlur` (directional blur) is **still untested**: try it in a 3-second test before
relying on it. Starting point for any new reel: `examples/chai_v4/index.html`.

### 3a. Camera moves (on `.cam`)
Which move to use for which line, and the `look` / `follow` / `shake` / `rack` / `depth` helpers: `references/camera_to_explain.md`.

| Move | Seen in | Build (starting values) |
|---|---|---|
| Drift | every shot | `scale 1.00→1.05`, ease `none`, whole scene |
| Reframe on a word | map: Americas → India; bed: family → slippers | tween `x/y/scale` of `.cam` to a new region of the plate, 0.6–0.9 s, `power3.inOut` |
| Punch-in | bed wide → man's face; molecule → blood cell | `scale ×1.3–1.6` in 0.35 s `expo.out` toward the subject |
| Tilt transition | pink wall + tap → sunset sky (hook) | two plates stacked in one tall `.cam`; tween `y` by one screen height, 0.7 s `power2.inOut`; props on the lower plate leave with it |
| Whip-pan | man → wife on the same bed; bowl entering | `x ±1080` in 0.28 s (`power3.in` out, `power3.out` in) with CSS `filter: blur(16px)` on both scenes (proven in V4); horizontal-only SVG blur is untested |
| Zoom-through | dark hole in a pot → next scene; into a molecule | `scale 1→8` into a dark/central point in 0.45 s `power3.in`; next scene starts at `scale 1.25→1` `expo.out` |
| Pull-back out of a frame | face inside a phone/mirror frame → full face | start `scale 0.55` with the frame PNG on top, tween to 1.0 and fade the frame |

### 3b. Prop moves
| Move | Seen in | Build (starting values) |
|---|---|---|
| **Drop & settle** | coins raining and stacking into bar columns; pots raining into a grid; products piling into a heap; coal falling into the stove; element tiles slamming down | from `y:-1300, rotation:±25, blur(6px)` to rest in 0.45–0.6 s, `power4.in`, then a 0.12 s squash (`scaleY .9→1`); contact shadow (blurred dark ellipse) grows from 0 as it lands; stagger 0.06–0.12 s; a tick SFX per landing (or every 3rd for big piles) |
| **Stack into a chart** | coin columns on US/Brazil vs a short one on India | same drop, each coin lands `-14px` higher than the last; the column height is the data |
| **Traveller across cuts** | virus ball falls out of the night sky, lands on the map, rolls across countries, rolls off | put the prop in a layer **above** the scenes, so it keeps moving while the scene under it changes; `x/y/rotation` keyframes |
| **Fill spreads from a contact point** | each country turns red as the virus touches it; brain turns gold; stomach glows | a pre-coloured state layer revealed by `clip-path: circle(0% at X Y) → circle(150% at X Y)` in 0.4–0.6 s |
| **State swap on the same plate** | window night → morning; coal lit → dead; lungs pink → grey; hair full → thin; heads → bald heads one by one | stack state B over A; reveal with a soft radial mask or 0.35 s opacity; for "one by one", reveal small masked spots in stagger |
| **Constant foreground, changing background** | the same hand + glass while festival → street → party swap behind it on each word | foreground PNG stays; background plates hard-swap on the words (0.08 s), a small push on each swap |
| **Hand action** | hand pushes the door bolt, breaks the glass, crushes a puri, lifts the stove, holds the phone | cut-out hand enters from the frame edge (`y +500 → 0`, 0.45 s `power3.out`), state swap for the action (whole → crushed + splash bits), exits down |
| **Light travelling along a path** | liquid going through the stomach; signal along a nerve | SVG path, `stroke-dashoffset` tween with a glow filter; a masked gradient rising for "filling" |
| **Pinned evidence card** | Tribune headline with tape; research paper with a red pushpin | cream card slides up rotated −3°→−1.5°, 0.5 s `expo.out`; tape or pin pops (`scale 1.4→1`); headline typed as real HTML text (serif), not baked into the image |
| **Tags and labels** | luggage tags with country names under each pot group; "30 CM" dimension line | tag PNG + HTML text drops and swings (`rotation 12→-4→0`); dimension arrows draw outward from the centre |
| **Stamp** | rubber stamp hits and leaves red "DHT" | stamp drops, squashes, lifts away; ink mark `scale 1.3→1, rotation -8, opacity 0→0.9` at the hit frame |
| **Draw-on marks** | red X over sour food, green tick on the coated pan, ring around a region | SVG strokes drawn with `stroke-dashoffset`, 0.3 s each |
| **Spotlight reveal** | dark brown stage, a yellow spot fades up, then the molecule appears in it | radial-gradient spot `scale 0.3→1, opacity 0→1`, prop pops 0.2 s later |
| **Ambient life** | dust in light beams, bubbles rising, sparks, confetti | 10–25 small elements on slow seeded drifts; keeps frames alive between beats |

### 3c. Counters (physical, not a UI widget)
- **Split-flap plate:** cream plate (`#F3E6CC`) with a thin red double border, dark tiles (`#2B2118`) with
  cream digits, and a **bold red unit label printed on the plate** (`OILS`, `/100`, `%`). Slight
  rotation (−2°) and a soft drop shadow, so it reads as an object on the table.
- **Date plate:** brass/wood frame, tiles `14 | JANUARY | 2024`, the month tile in red.
- Digits roll as vertical strips, blurred while moving and sharp at the end; one `metal_click` per digit
  settle.
- Avoid the chai demo's red frame with a grey caption under it (`ANEMIA IN INDIA`): it reads as UI.
