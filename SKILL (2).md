---
name: meanwhile-mayank-style-reels
description: >-
  Makes 9:16 science / myth-buster explainer Reels and Shorts in the tactile 3D-studio style of Meanwhile
  Mayank's new reels, the way the approved "Chai & Iron" demo was built: layered sets of cut-out props, a beat
  every 2 s, a camera that never stops, props that drop and stack, split-flap counters, pinned source cards,
  big two-line Anton titles, the notebook crease and holes, tactile SFX and a dark-to-calm music switch. Free
  and local (HyperFrames, rembg, whisper.cpp, ffmpeg), no paid credits. "/meanwhile-mayank-style-reels start"
  runs a guided start for beginners: setup check and install, then all questions at once (topic, script or
  voice-over, length, images, music); "continue" resumes a reel from its PROGRESS.md. Use it whenever the user
  says "Meanwhile Mayank style", "MM style", "like the chai video", "tactile 3D explainer reel", "science reel
  with props", or wants a Hindi/Hinglish voice-over or topic turned into a reel like this, or to fix a reel in
  this style that looks like a slideshow.
---

# Meanwhile Mayank style reels

Turn a voice-over into a reel that looks like a small physical science set filmed on a table: things land,
stack, light up and get pushed while the camera keeps moving and a two-line title names each phrase.

## 0. `start` and `continue`: the guided way in (assume a beginner)

The user may have never used a terminal. Explain each step in one or two plain sentences, say what happens next
and exactly what you need from them, and never leave them guessing which file or folder you mean (give full paths).

**`/meanwhile-mayank-style-reels start`** (or any first request for a reel in this style):
1. **Setup check.** Run `scripts/check_setup.sh` (from this skill's folder; `scripts/` paths below are relative to it).
   It prints a table and writes `~/.mm-reels/env.sh`.
   - **READY:** say so in one line and go on.
   - **Something missing:** show the user the missing items in plain words, what each is for, and the total
     download (about 1.5 GB if everything is missing), and **ask: "Can I install these now?"** Only after a clear
     yes, run `scripts/check_setup.sh --install` (in the background if it is slow), then run the check again.
   - **Homebrew missing** (macOS): it needs the user's Mac password, so you cannot install it. Give them the one
     command the script prints, ask them to paste it into Terminal and tell you when it's done, then re-run the check.
   - Not macOS: tell them the skill is tested on macOS; on Linux, give the apt equivalents (ffmpeg, nodejs 22,
     python3-venv) and re-run the check. Windows: say it's not supported yet.
   - Before running any script later in the session: `source ~/.mm-reels/env.sh`, and run Python scripts with
     `"$MMPY" scripts/<name>.py` (that Python has Pillow + numpy).
2. **Ask all the start questions in ONE message:** copy the message in `references/start_questions.md`. Wait
   for the answers. Don't ask again for what they answered; use the defaults for what they skipped and say so.
3. **Restate the plan** in 3–4 lines, create the reel folder with `scripts/new_reel.sh <folder> <length>`, and
   write the answers into its `PROGRESS.md`.
4. **Branch on what they have** (`references/start_questions.md`, "After the answers"):
   - topic only → write the script (`references/script_writing.md`), get an OK, ask them to record it;
   - a script → check it and suggest fixes, then ask them to record it;
   - a voice-over → convert it into the reel and continue with Workflow step 2 below.
5. From here follow **§4 Workflow**. After every step, tick it in `PROGRESS.md` and write what you are waiting for
   under "Waiting on the user". Stop and wait at each user step: script OK, recording, beat sheet OK, missing
   images, music preview, review notes, "render".

**`/meanwhile-mayank-style-reels continue`**: ask for the reel folder if it isn't clear, read its `PROGRESS.md`,
re-run the setup check quickly (silently if READY), say in two lines where it stands, and carry on from the
first unticked step.

**What is in this skill**

| Path | What it is | When to open it |
|---|---|---|
| `GUIDE.md` | The same workflow as a plain step-by-step guide for the user (what the user does, what Claude does) | When the user asks how the skill works |
| `examples/chai_v4/` | The approved V4 chai demo: full `index.html`, images, SFX, music bed, beat sheet, image prompts | Before building: copy moves from it |
| `templates/starter/` | A clean 10 s composition with every helper used once (via `scripts/new_reel.sh`) | Start of every new reel |
| `templates/*_TEMPLATE.md` | Script, beat sheet, image-prompt list and progress checklist (copied in by `new_reel.sh`) | Start, then workflow steps 3–4 |
| `references/start_questions.md` | The one message of start questions, and what to do with each answer | `start` |
| `references/script_writing.md` | How to write or check the script: length → words, the 6 steps, the ★ Fix line | When the user has no voice-over yet |
| `references/motion_vocabulary.md` | Every camera move, prop move and counter, with GSAP values | While writing the beat sheet and the timeline |
| `references/camera_to_explain.md` | Which camera move explains which kind of line (push = name it, travel = cause → effect, pull-back = how many…), rules, the `look`/`follow`/`shake`/`rack`/`depth` helpers | While filling the beat sheet's Camera column |
| `references/titles_overlay_worlds.md` | Title sizes, colours and entrance; notebook overlay; the background worlds | Titles and overlay |
| `references/sound_and_music.md` | SFX placement, levels, the dark → calm music switch | Sound |
| `references/mistakes_and_layout.md` | The user's 5 review notes, layout rules, every mistake already made once | **Before building and again before showing** |
| `references/reference_reels.md` | What each of the 12 reference reels teaches, and where to look | When you need an idea for a beat |
| `references/style_analysis.md`, `reference_gaps.md` | The first study of the style, and why the slideshow version failed | Background reading |
| `assets/library/` | **Every plate and prop already made** (10 plates, 21 cut-out props, 7 old baked scenes, 24 uncut originals) with `CATALOG.md` and preview sheets | Workflow step 4, before asking for any image |
| `scripts/` | `check_setup.sh` (check + install), `new_reel.sh`, `transcribe.sh`, `fit_titles.py`, `prep_plate.py`, `cutout.py`, `library_preview.py`, `music_bed.sh`, `qc_motion.py`, `contact_sheet.sh`, `loudnorm.sh` | At their workflow step |
| `assets/` | Anton font (OFL), grain, 4 world plates, 8 SFX, 2 music tracks (licences: `assets/LICENSES.md`) | Copied in by `new_reel.sh` |

---

## 1. The three rules (why the first attempt failed and V4 passed)

The first attempt was 7 still pictures with a slow zoom: it played like a slideshow. The reference reels are
**small sets where objects and the camera move on every phrase.** So:

1. **A scene is layers, never one image.** A *plate* (empty background, nothing in the top 30%, ideally bigger
   than the frame so the camera can travel), *props* (each object generated alone on flat grey, then cut out
   into a transparent PNG), and *states* (the same plate or prop with one thing changed: lit/dead coal,
   open/closed padlock, plain/red map). Moving separate layers is what makes it feel physical.
2. **Something in the picture changes every 2 seconds or less.** A prop lands, a state swaps, a hand acts, a
   fill spreads, a counter rolls, the camera reframes. A slow zoom alone is not a beat.
3. **The camera is alive.** Every scene sits in a `.cam` wrapper that always drifts (1.00 → 1.05) and makes at
   least one deliberate move (punch-in, reframe, whip, tilt, zoom-through). Shots join by a camera move or an
   object that carries across the cut, rarely by a plain cut, never by a crossfade.
   **And the camera explains:** each deliberate move goes to what the voice names, on that word (push in on
   "tannin", ride the arrow from cause to effect, pull back on "57% log", shake on "lock").
   Plan it per phrase as `move → target (on "word")` with `references/camera_to_explain.md`.

**Motion gate:** `"$MMPY" scripts/qc_motion.py out.mp4` must PASS (median picture motion per 2 s ≥ 6.0 with the
title zone ignored, ≤ 5% still windows). 11 of the 12 reference reels pass (9.2–12.8 / 0–3%; ref_06 has 6% still);
V4 scores 7.72 / 0%; the slideshow version 1.73 / 37%. The gate catches a slideshow; it does not prove the style, so rules 1–3 and the review
still apply.

## 2. Pacing

| | Reference (per 40 s) | Rule |
|---|---|---|
| New set or camera framing | 12–13 | one every ~3 s |
| Title pairs | 9–15 | one pair per spoken phrase |
| Longest time with no picture change | ~1.5 s | ≤ 2 s |
| Hook | 3 setups with an action in the first 4 s | 3 actions before the question title lands |

Clear the title (0.12 s fade) just before a transition; the next Line 1 comes 0.1–0.3 s after the new shot settles.

## 3. The look in one screen (details in `references/titles_overlay_worlds.md`)

- **Titles:** Anton, top-left at x = 97 px, cap top y ≈ 280 px. Line 1 = 92 px warm cream. Line 2 = 140 px,
  a vertical gradient with a glow of the same hue: pink (danger / big number), peach (story / time / place),
  gold (question / fact), cyan (science), violet (brain / calm), lime (the fix). Line 2 rises from a mask,
  blurred → sharp, on the stressed word. 2–4 words per line, Hinglish fine, never subtitles. Each line must fit
  in 80% of the width: `scripts/fit_titles.py`.
- **Notebook overlay on every frame:** a strong top vignette, soft fold crease at x = 62.5%, 7 punched holes at
  x = 4%, grain at 7%. Copy the `#vig` + `#overlay` block from the starter; don't redraw it.
- **Worlds:** mustard notebook paper (with faint ruled lines), walnut desk, jewel-tone biology (emerald,
  burgundy, indigo, teal), story sets (room, bed from above, window, street at dusk), real people only from
  behind, from above or hands only.
- **Numbers are objects:** a cream split-flap plate with a red double border and a red unit printed on it, or a
  brass date plate; a fact gets a pinned cream evidence card with real serif text and its real source.

---

## 4. Workflow

Everything is free and local. Run scripts from the skill folder (paths below are relative to it).

1. **Start the reel** (done by `start`, §0). `scripts/new_reel.sh <reel_folder> <seconds>` copies the starter
   composition, Anton, grain, the world plates, the SFX and the four templates. Default folder: `mm_reels/<topic>_v1`
   in the current working folder (in AST_BTS: `09_Videos/<ID>/06_Edit/<topic>_v1`). Bring the voice-over in with
   `ffmpeg -i <their file> -ar 48000 -b:a 192k <reel_folder>/assets/audio/voiceover.mp3` (any format works).
   Never reuse an old folder: each attempt is a new `_vN`.
2. **Voice first.** `scripts/transcribe.sh <reel_folder>/assets/audio/voiceover.mp3 <reel_folder>/transcript`
   writes `words.tsv` (start, end, word). Find the pauses between phrases; they are the beat boundaries.
   If it warns that a word lasts over 1.5 s, whisper lost sync there (it did on the chai voice at 17–30 s):
   re-run that span alone as it prints, and add the offset back.
3. **Beat sheet before any image** (`BEAT_SHEET.md`, one row per beat): time, spoken words, title L1 / L2 and
   colour, set, what moves (a move from `references/motion_vocabulary.md`), camera (`move → target (on "word")`,
   from `references/camera_to_explain.md`), SFX, and the rest box
   (x, y, width) of every object that comes to rest. Tick the checklist at its bottom (≤ 2 s gaps, a framing
   every ~3 s, a 3-action hook, titles fit, no rest boxes crossing, every number sourced) and **mark the
   music switch row** (the first "fix" line). **Show the beat sheet to the user and wait for an OK** before
   asking for images.
4. **Images: library first.** Look at `assets/library/_preview_props.jpg` and `_preview_plates.jpg`, read
   `assets/library/CATALOG.md`, and copy every plate or prop that fits into `<reel>/assets/img/` (a padlock,
   a stomach, a thali, tablets, a tray, a map, a molecule, a clock, a mustard / walnut / emerald world…). List them
   under "Reused from the library" in `IMAGES_NEEDED.md`. Then write one prompt per plate, prop, state and hand
   that is still missing (rules are at its top; `examples/chai_v4/IMAGES_NEEDED.md` has 23 prompts that worked). The user generates them with a free tool
   (ChatGPT or Gemini: paste one prompt, download the image, save it with the exact file name) into
   `<reel>/assets/images_in/`; tell a beginner exactly that. If they said they can't make images, build from the
   library and code-drawn things only. Never spend credits. Then:
   - plates: `"$MMPY" scripts/prep_plate.py --all <reel>/assets/images_in <reel>/assets/img` (1080x1920, or an
     overscan size for travel);
   - props: `"$MMPY" scripts/cutout.py IN.png <reel>/assets/img/P1_x.png --check`; for pale objects and paper
     sheets add `--mode color`. **Look at every `_check.png`** (dark + yellow) for halos and holes.
   - states: check that A and B line up; if not, make one from the other or shift it.
   - after the reel is approved, add its good new plates and props to `assets/library/` (descriptive names, a
     row in `CATALOG.md`, originals in `sources/`) and run `"$MMPY" scripts/library_preview.py`, so the next reel
     needs fewer new images.
5. **Build** `index.html` (1080x1920, 30 fps) from the beat sheet, using the starter's helpers (`show`,
   `drop`, `roll`, `draw`, `whipIn/Out`, `tiltIn/Out`, `title`) and moves copied from
   `examples/chai_v4/index.html`. Layer order inside a scene: plate → back props → contact shadows → front props
   → hands → particles. Above all scenes: a traveller layer, then `#vig`, titles, the overlay. All randomness
   seeded. Before writing the timeline, reread `references/mistakes_and_layout.md`.
6. **Music bed.** `scripts/music_bed.sh assets/music/bgm_dark_epic.mp3 assets/music/circle_lofi.mp3
   <reel>/assets/audio/voiceover.mp3 <switch_s> <length_s> <reel>/assets/audio/bgm_mix.wav` (any other dark /
   calm pair works; check the calm track's first 10 s for a quiet intro and pass its beat as CALM_START).
   If the skill has no music (a shared copy) and the user has none, skip the bed: the reel runs on voice + SFX.
   Add `<audio id="bgm" src="assets/audio/bgm_mix.wav" … data-volume="1.0">`. Send the user the `_preview.mp3`,
   because the live preview plays only the voice.
7. **Check without rendering.**
   - `npx hyperframes check --json > check.json` (never pipe it into `head`), fix every error.
   - `npx hyperframes snapshot --at <the end of every beat>` and look at each still for overlaps, peeking
     props, early dots, plate edges, unreadable titles.
   - Go through `references/mistakes_and_layout.md` item by item.
8. **Review, then render once.** Open the live preview for the user: VideoHub `hub_live` if its tools are
   available (AST_BTS, §6), otherwise `npx hyperframes preview` in the reel folder (it opens in the browser; tell
   the user to write notes as "at 0:12, …"). Wait for notes, fix them in code, mark them done. Render only when the user asks. Then:
   `"$MMPY" scripts/qc_motion.py <render>.mp4` (must PASS), `scripts/contact_sheet.sh <render>.mp4` (compare with
   `../reference_sheets/`), and `scripts/loudnorm.sh <render>.mp4 <final>.mp4` (−14 LUFS / −1 dBTP on a copy).

`source ~/.mm-reels/env.sh` puts Node 22 first for the HyperFrames CLI. Render locally only
(`npx hyperframes render --output <reel>/<topic>_v1.mp4 --fps 30` in the reel folder, or `hub_render` in AST_BTS), never in the cloud.

## 5. Facts and honesty

- Put a source card only on a number you can source, and quote the source exactly (V4: NFHS-5, "57.0% of women
  aged 15–49 in India are anaemic"). A number from the user's script with no study gets no card.
- Some reference hook shots are real footage (a foot splashing, water pouring). Without paid image-to-video,
  build them as layered cut-out actions or use a free stock clip, and tell the user it is not 1:1.
- The style is studied from another creator. Build original sets and words; never use their footage, images,
  titles or voice, and never present a reel as theirs.

## 6. In the AST_BTS project (Grow With AST)

- Reel folders go in the video's folder (`09_Videos/<ID_Name>/06_Edit/<reel>_vN/`), not inside the skill.
- Review: `hub_live({project: "<reel folder>"})`, then stop and ask the user to leave notes in VideoHub and
  press "Send to Claude". Notes: `hub_notes` → fix the code → `hub_note_update`. Render only on request with
  `hub_render({project, mode: "full"})`; HyperFrames projects need no render script. Copy the render into the
  delivery folder under a new `_vN` name.
- rembg is installed at `07_Scripts/rembg_venv/bin/rembg` (`export REMBG=…` for `cutout.py`). Whisper model:
  `~/.whisper-models/ggml-large-v3-turbo-q5_0.bin`. More SFX and music: `02_Audio/Edit sound/`.
- Scripts follow `08_Styles/00_SCRIPT_RULES.md` (Pain → Poke → Fix → Payoff → Recap → CTA). The music switch
  sits on the first Fix line.
- `.hyperframes/credit-limit.json` stays `{"credits": 0}`; `media-use` only with `--local-only`. No captions unless asked.
