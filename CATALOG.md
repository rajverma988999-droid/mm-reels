# Image library: plates and props we already have

Everything made for the chai demos (V1, V3, V4), ready to reuse. **Check here before asking the user for any
image.** List what you can reuse in `IMAGES_NEEDED.md` under "Reused from the library", and ask only for the rest.

Look first (one image per folder, names under each picture):
- `_preview_props.jpg` (21 cut-outs on mustard)
- `_preview_plates.jpg` (10 backgrounds)
- `_preview_baked_scenes.jpg` (7 old all-in-one scenes)

**To use one:** copy it into the reel and keep the library name, e.g.
`cp assets/library/props/padlock_open.png assets/library/props/padlock_closed.png <reel>/assets/img/`.
Never edit files in the library; edit the copy in the reel.

**When you make new images for a reel,** add the good ones here after the reel is approved. Put the cut-out in
`props/` and the 1080x1920 plate in `plates/` with a plain descriptive name, keep the original in `sources/`, add
a row below, and re-run the preview step (at the bottom).

---

## Props (`props/`, transparent PNG cut-outs)

| File | Size | View | What it is | Good for |
|---|---|---|---|---|
| `thali_top.png` | 754×754 | top-down | Steel thali: 2 rotis, dal, aloo sabzi | "Khana", any Indian meal; drop or slide in |
| `thali_top_v3.png` | 755×754 | top-down | Same thali, V3 cut (slightly different crop) | Spare / second plate |
| `chai_glass_top.png` | 818×979 | top-down | Cutting-chai glass with foam | Chai on a table, falling into a stomach |
| `chai_glass_side.png` | 440×653 | side | Tall glass of milky chai | Chai standing beside things, side-by-side comparisons |
| `hand_holding_chai.png` | 1000×588 | side, wrist from the right | Man's hand holding a chai glass | Constant foreground while backgrounds swap; "you" moments |
| `bowl_palak_top.png` | 923×953 | top-down | Bowl of palak sabzi | Iron-rich food, greens, healthy food |
| `bowl_chana_top.png` | 924×957 | top-down | Bowl of kala chana | Protein / iron food, healthy food |
| `red_tablet_top.png` | 800×824 | top-down | Glossy round dark-red tablet | Pills, supplements, counters in a tray, a red token |
| `wood_tray_10_slots.png` | 1000×440 | top-down | Light wooden tray, 10 round slots (2×5) | Fill-the-tray counts ("6 out of 10"), percentages |
| `steel_coin_disc.png` | 695×732 | angled | Plain brushed-steel disc | Coins, tokens, stacking into a bar chart, a steel lid |
| `iron_sphere_glow.png` | 889×892 | front | Glossy dark-red sphere with an orange glowing core | Atoms, minerals, iron, "energy" balls |
| `molecule_amber.png` | 1000×795 | front | Ball-and-stick molecule, amber + dark brown | Any chemical: tannin, caffeine, a toxin; float in on seeded drifts |
| `red_blood_cell.png` | 634×598 | angled | 3D red blood cell | Blood, anaemia, oxygen, circulation |
| `stomach_3d.png` | 659×819 | front | Glossy 3D stomach with a dark open window | Digestion, "pet mein", where food goes |
| `stomach_3d_v3.png` | 660×821 | front | Same stomach, V3 cut | Spare |
| `padlock_open.png` | 591×954 | front | Brass padlock, shackle open | State A of "lock": blocking, trapping, security |
| `padlock_closed.png` | 591×954 | front | Same padlock, shut | State B (V4 needed a 6×12 px shift to line it up with the open one) |
| `brass_clock_no_hands.png` | 903×944 | front | Brass wall clock, cream face, **no hands** | Any time; draw the hands + a time wedge in code (V4 "1 GHANTE KA GAP") |
| `wall_clock_with_hands.png` | 798×800 | front | Brass wall clock with fixed hands at ~10:10 | A clock that doesn't need to move |
| `india_map_paper.png` | 821×1000 | top-down | Printed India map on aged paper, beige land, blue sea | Any India statistic on the walnut desk |
| `india_map_paper_red.png` | 821×1000 | top-down | Same map, land in crimson, lined up with the plain one | Red fill spreading from a point (clip-path circle reveal) |

## Plates (`plates/`, 1080×1920 backgrounds, top 30% kept calm for titles)

| File | World | What it is | Good for |
|---|---|---|---|
| `mustard_paper.jpg` | Mustard notebook | Warm mustard paper with a soft spotlight (add `.ruled` lines in code) | The default studio for props and comparisons |
| `walnut_desk_top.jpg` | Walnut desk | Empty dark walnut desk from above, spotlight in the centre | Maps, evidence cards, counter plates |
| `teal_cloth_top.jpg` | Teal cloth | Teal cotton tablecloth from above, window light | Food flat-lays, hook shots |
| `emerald_tiles.jpg` | Jewel tone | Wall of small glossy emerald tiles | Clocks, rules, "the fix", calm science |
| `stomach_cutaway_burgundy.jpg` | Jewel tone | 3D stomach cross-section on deep burgundy | Inside-the-body scenes; punch in and add molecules / spheres |
| `tea_liquid_macro.jpg` | Macro | Inside milky chai: amber liquid, bubbles, light rays | Zoom-through target, "inside the drink" |
| `kitchen_blur.jpg` | Real world (blurred) | Indian home kitchen, morning, empty foreground | Background swaps behind a hand / prop |
| `office_desk_blur.jpg` | Real world (blurred) | Office desk at evening, city lights | Background swaps, "at work" |
| `chai_tapri_dusk_blur.jpg` | Real world (blurred) | Roadside chai stall at dusk, string lights | Background swaps, street / outside |
| `walnut_desk_india_map_baked.jpg` | Walnut desk (768×1376) | V3 plate with an India map and tablets **baked in** | Only a quick static beat; for motion use `walnut_desk_top.jpg` + `india_map_paper.png`. Run `scripts/prep_plate.py` before use. |

## Baked scenes (`baked_scenes/`, 768×1376, the V1 slideshow images)

Everything is painted into one picture, so nothing in them can move on its own. That is why V1 failed the motion gate.
Use one only as a background for a single short beat with props moving on top, or as a mood reference when
writing a prompt. Run `scripts/prep_plate.py` first (they are small and need upscaling).

| File | Shows |
|---|---|
| `thali_chai_on_teal_cloth.jpg` | Thali + chai glass on teal cloth, steam |
| `thali_chai_on_mustard.jpg` | Small thali + chai glass on mustard |
| `red_question_mark_chai_mustard.jpg` | Glossy red 3D "?" next to a clay chai cup on mustard |
| `india_map_on_walnut.jpg` | India map card with tablets on a walnut desk |
| `stomach_glow_burgundy.jpg` | Stomach with glowing particles on burgundy |
| `blood_cells_navy.jpg` | Red blood cells in a dark navy swirl |
| `wall_clock_emerald_tiles.jpg` | Wall clock on emerald tiles |

## Sources (`sources/`)

The original uncut V4 images as generated (24 files, `B*` plates and `P*` props, flat grey backgrounds; saved as high-quality JPG to keep the skill small). Use them
to re-cut a prop with other settings (`scripts/cutout.py … --mode color` for pale objects) or to re-crop a plate
to an overscan size (`scripts/prep_plate.py IN OUT 1404 2496`).

All images here were generated by the user for the chai demos, so they are his to reuse and share.

---

Rebuild the previews after adding images:
`python3 scripts/library_preview.py` (from the skill folder).
