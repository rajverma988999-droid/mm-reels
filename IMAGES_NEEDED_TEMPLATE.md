# <Topic> — images to generate (<N> needed)

Put every file in **`assets/images_in/`** with the exact file name below (`.png` or `.jpg`).
Props don't need transparent backgrounds: they are cut out locally (`scripts/cutout.py`).
Use a free image tool only (never paid credits).

## Rules for every image
- **No text, no letters, no numbers, no logos, no watermark** anywhere.
- Photorealistic, soft studio light, rich colour, slight film grain, like a premium science-explainer still.

**Backgrounds (B):** portrait **9:16**, the biggest size the tool gives (at least 1080x1920). **Keep the top
30% calm and empty** (titles go there). No objects in the middle (props go there). For a camera travel, ask
for a wider or taller plate (overscan) than the frame.

**Props (P):** square **1:1**, at least 1024x1024. **ONE object only**, whole, not cropped, centred, filling about
70% of the frame, on a **plain flat light grey background (#D9D9D9)**, no shadow on the background, soft top
light, the camera angle written in the prompt (top-down for things lying on a table).

**States (P…b):** "the same <object> as P<n>, same framing and size, but <one change>". Easiest: edit the first
image in the tool and change only that one thing, so the two line up.

**Hands:** a separate prop, "an Indian <man's / woman's> hand <doing X>, the wrist entering from the <right>
edge of the frame".

## Backgrounds
| File name | Prompt |
|---|---|
| `B1_<name>.png` | <Overhead top-down photo of an empty …, soft warm light from the left, dark vignette at the edges, empty, nothing on it, 9:16, no text> |

## Reused from the library (no need to generate)
Copied from the skill's `assets/library/` (see its `CATALOG.md` and preview sheets):

| Used as | Library file |
|---|---|
| <plate for scene A> | `plates/mustard_paper.jpg` |
| <prop> | `props/<file>.png` |

Already there: 10 plates (mustard, walnut, teal cloth, emerald tiles, stomach cutaway, tea macro, kitchen, office,
chai tapri) and 21 props (thali, chai glasses, hand with chai, palak, chana, tablet, tray, steel coin, iron sphere,
molecule, red blood cell, stomach, padlock open / closed, 2 clocks, India map plain / red).

## Props
| File name | Prompt |
|---|---|
| `P1_<name>.png` | <Top-down view of …, isolated on a flat light grey background> |
| `P1b_<name>_<state>.png` | <The same … as P1, same framing and size, but …, isolated on a flat light grey background> |

## Drawn in code (no image needed)
Counter plates, date plates, evidence cards (real text), arrows, ticks, crosses, rings, dimension lines,
steam, bubbles, sparks, clock hands and time wedges, dividers and pills, titles, the notebook overlay.

Worked example with 8 plates and 15 props that worked: `examples/chai_v4/IMAGES_NEEDED.md`.
