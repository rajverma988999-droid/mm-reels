# Camera that explains (read while writing the beat sheet's Camera column)

The camera in this style isn't decoration. It is **the narrator's finger**: it goes to the thing the voice
names, at the moment the voice names it. A move that doesn't point at anything is noise. A move that follows
the story makes the idea easier to follow than any title.

Ask for every phrase: **"While these words play, where should the viewer look, and why?"** The answer is
the camera move.

## 1. What the line says → the camera move

| The words do this | Camera move | How (helpers in `templates/starter/index.html`) | Example |
|---|---|---|---|
| **Name one thing** ("tannin", "ye ek coin") | **Push in** on it | `look(cam, t, x, y, 1.25–1.4, 0.4, "expo.out")` on the stressed word | "Chai mein hota hai **tannin**" → push to the tannin molecule |
| **Cause → effect** ("A hota hai, to B…") | **Travel** from A to B along the path | `follow(cam, t, [[xA,yA],[xB,yB]], s, dur)` in time with the arrow or the moving prop | camera rides the arrow from the cup to the stomach |
| **Something moves inside** ("khoon mein", "pet ke andar") | **Zoom-through** into it | scale `1→8` into a dark point (motion_vocabulary 3a), next scene starts big and settles | into the stomach → inside, iron balls floating |
| **How big / how many** ("57% log", "har ghar mein") | **Pull back** to reveal the whole | start pushed in on one item (`look(..., 1.4, 0)`), then `look(cam, t, x, y, 1.0, 0.9, "power2.inOut")` | one anaemic face → pull back to a crowd / a full map |
| **Compare A and B** ("ye… aur ye…") | **Reframe** A, then B (same set) or **whip** A → B | `look()` on A, hold, `look()` on B on B's word; separate sets = `whipOut` / `whipIn` | food plate (left) → chai cup (right) |
| **Steps of a process** ("pehle… phir… phir…") | **Track** along the steps, one stop per step | `follow()` with one point per step, or one `look()` per step word | mouth → stomach → gut, a stop on each |
| **Before → after / problem → fix** | **Tilt** to the next state, or hold still while the state swaps | `tiltOut` / `tiltIn`, or `look()` hold + state swap | sour stomach → calm stomach on "1 ghante ka gap" |
| **A hit, a shock, a lock** ("lock kar deta hai!", "bam") | **Short shake** on the impact frame | `shake(cam, t, 10, 0.25)` (6–14 px, ≤ 0.3 s) | padlock closes → shake + metal click |
| **Look at this detail, ignore the rest** | **Focus pull**: the set blurs, the subject stays sharp | `rack(bgSelector, t, 6)` then `rack(bgSelector, t2, 0)` | everything soft except the source card |
| **Depth / a real world** (a room, a table) | **Parallax**: near layers move more than far ones | `depth(scene, t, dx, dy, dur)` with `data-depth` on layers (0.6 far … 1.3 near) | slow pan across a kitchen counter, cup in front moves faster |
| **Calm ending / recap** | **Slow pull back**, settling to the wide shot | `look(cam, t, 540, 1240, 1.0, 1.5, "power2.inOut")` | last line: the whole thali + the chai, side by side |

The always-on **drift** (`drift(cam, t0, t1, x, y)`, 1.00 → 1.05 at one point, ease `none`) runs under all of these.
It keeps the frame alive; it never counts as the scene's deliberate move.

## 2. Rules

1. **One deliberate move per phrase, aimed at what the words name.** Write it in the beat sheet as
   `move → target (on "word")`, e.g. `push → tannin (on "tannin")`. "punch-in" alone isn't a plan.
2. **Land on the word.** Start the move 0.1–0.2 s before the stressed word so it settles *on* it.
   Fast moves (push, whip, shake) 0.25–0.45 s; travels and pull-backs 0.6–1.2 s.
3. **Hold after the move.** Give the eye 0.5–1 s on the target (with drift) before the next move.
   Two big moves back to back make people lose the thread.
4. **The camera and the prop agree.** If a prop or an arrow travels, the camera follows it (same direction,
   same speed or a little behind), never the other way.
5. **Keep the target in the action zone.** `look()` puts the point at (540, 1240): under the titles
   (top 30%) and inside the notebook margins. Never frame a subject under the titles.
6. **Never below `scale: 1`, never past 1.4** (blurry plates), except the zoom-through. `look()` clamps so no
   black edge shows; if it can't reach a corner, the plate is too small: ask for a bigger plate.
7. **One way of moving per `.cam`.** A scene uses either `look()`/`follow()` (origin `0 0`) or the old
   origin-based `scale` tweens, never both on the same `.cam` (the picture jumps).
8. **Variety.** Don't use the same move three times in a row. Across a 45 s reel use at least 5 kinds
   (push, travel, pull-back, whip/tilt, shake or focus pull).

## 3. Plates for a travelling camera

`look()` and `follow()` work on any plate, but travel needs room. For a scene where the camera travels
(cause → effect, a process, a parallax pan), ask for a **bigger plate** in `IMAGES_NEEDED.md` (e.g. 2160×1920
for a sideways travel, 1080×3840 for a tilt) and give the `.cam` that size:

```html
<div class="cam" id="camD" style="width:2160px; height:1920px;"> <img class="bg" style="width:2160px; height:1920px;" …>
```

`look()` reads the `.cam`'s size, so the clamp still keeps the frame filled.

## 4. A worked plan (chai, first 12 s)

| Time | Words | Camera |
|---|---|---|
| 0.0 | "Khane ke turant baad…" | drift on the thali |
| 1.3 | "…ek garam **chai**" | push → chai cup (on "chai") |
| 2.4 | "har ghar ki aadat" | pull back → whole table, more cups drop in |
| 4.0 | "aapke **pet** mein…" | zoom-through into the stomach |
| 5.8 | "**tannin** hota hai" | push → tannin molecule, shake as it lands |
| 7.5 | "iron ko pakad ke **lock**" | travel: molecule → iron ball, following the arrow; shake on "lock" |
| 9.6 | "57% logon mein…" | whip → counter plate, focus pull to the source card |

Check it against the words: each row's camera points at the word in bold.
