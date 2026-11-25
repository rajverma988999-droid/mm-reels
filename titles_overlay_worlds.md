# Titles, notebook overlay and worlds

## Titles

- **Font:** Anton (bundled: `assets/fonts/Anton-Regular.ttf`, SIL Open Font License; copy it into the
  composition's `assets/fonts` and load it with `@font-face`). Not Oswald: thinner and smaller at the same size.
- **Position *(m)*:** left edge at **x = 9% (97 px)**. Line 1 cap top at **y ≈ 14.6% (280 px)**; Line 2 right
  under it (`line-height: 0.95`). Left-aligned, never centred, never at the bottom.
- **Size *(m)*:** Line 1 **92 px, letter-spacing 0.015em** (cap height ≈ 4.1% of the frame). Line 2 **140 px,
  letter-spacing 0.03em** (1.5× Line 1). Checked by overlaying these sizes on a reference frame: cap heights
  match. A long Line 1 may reach **80% of the width**; shrink only if it would go past that.
  (The chai demo used Oswald 56 / 90 px, about half the area.)
- **Line 1 colour *(m)*:** warm cream, top `#FCF1DD` → bottom `#FCE7C8`, warm glow
  `text-shadow: 0 0 18px rgba(255,214,160,.55), 0 2px 6px rgba(0,0,0,.45)`.
- **Line 2 colour:** a **vertical gradient**, light top → saturated bottom, plus a glow of the same hue:
  - danger / big number *(m)*: `#FE949F → #FD6272` (coral pink)
  - story / time / place *(m)*: `#FEAC70 → #FD7B2F` (peach-orange)
  - question / fact *(m)*: `#FDDE99 → #FCBE51` (gold)
  - science / mechanism *(m)*: `#D4F9F9 → #71FAFD` (cyan)
  - brain / calm (starting value): `#D9C8FF → #8E6BFF` (violet)
- **Line 2 structure (so the glow survives the entrance):**
  ```html
  <div class="l2-glow">            <!-- filter: drop-shadow(0 0 16px <glow>)  — never tweened -->
    <div class="l2-mask">          <!-- overflow: hidden; padding: 20px 30px 10px 0 (room for the glow) -->
      <div class="l2">500 OILS</div> <!-- gradient text; entrance tweens y and filter:blur here only -->
    </div>
  </div>
  ```
  Entrance on the stressed word, 0.12–0.18 s: `.l2` from `y: 110%` and `filter: blur(8px)` to `y: 0`,
  `filter: blur(0px)`, then `clearProps: "filter"`. The mask is the wrapper's `overflow: hidden`, so no
  `clip-path` sits on the glowing element.
- **Line 1 entrance:** fade in with a 6 px rise, 0.2 s.
- **Words:** 2–4 words per line, story words, not subtitles. Numbering for lists: `1. SOUR` / `+ SALT`,
  `2. THE BIGGER ONE` / `LEAD`. Hinglish is fine (`FESTIVAL HO YA` / `CELEBRATION`).

---

## Notebook overlay (always on top) *(m, 4 reels)*

- **Fold crease at x = 62.5%, not 52%.** A dark band at 61.5–62.1% (664–671 px, black 16% multiply) and a
  light band right after it at 62.9–63.5% (679–686 px, white 14% screen). Soft-edged, not a hard 2 px line.
  (Chai demo: hard line at 52%.)
- **7 punched holes**, x = 4.0% (43 px), y = 15.6%, 27.1%, 38.6%, 50.0%, 61.5%, 72.9%, 84.4%
  (300, 520, 740, 960, 1180, 1400, 1620 px), diameter ≈ 24 px, colour `rgba(20,12,6,.75)` with a 1 px light
  rim at the bottom. Visible on every background. (Chai demo: 11 dots, practically invisible.)
- **Top vignette** `linear-gradient(180deg, rgba(0,0,0,.55) 0%, rgba(0,0,0,0) 30%)` and a soft corner falloff.
- **Paper texture** over everything at 6–10%: fine grain; on the mustard studio also faint horizontal ruled
  lines (every ~41 px, 3–4% dark; measured period 27.5 px on the 720-wide reels), so the yellow reads as a
  notebook page, not a flat colour.

---

## Worlds and backgrounds

Keep the Antigravity skill's worlds (mustard studio `#E4BE42→#5C410C`, walnut desk, jewel-tone biology,
cinematic real-world) and add what the reference uses that the chai demo never did:
- **Story sets** (room at night, bed seen from above, door, window, street at dawn) built from layers so the
  light can change (night → morning) and the camera can travel across them.
- **Real people shown from above, from behind, or hands only**, plus calm portraits for "you" moments
  (mirror / phone frame). No smiling stock faces.
- **Full-bleed macro worlds** to fly into: liquid with bubbles, skin cross-section, metal surface.
- Plates have **no text and nothing in the top 30%**, so titles stay clean.
