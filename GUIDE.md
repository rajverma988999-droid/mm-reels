# How this skill works: step by step

A plain guide to making one reel like the Chai & Iron video with this skill: what **you** do, what **Claude**
does, and what you get at each step. (`SKILL.md` is the same workflow written for Claude.)

**What you get at the end:** a 9:16 reel (1080×1920, 30 fps) where props drop, stack and get locked, the
camera keeps moving, a big two-line title names each phrase, the notebook crease and holes sit on every frame,
and the music turns from dark to calm when the fix starts. Everything is free and runs on your Mac.

**Time for a 40 s reel:** about 1–2 hours of Claude's work, plus the time you spend on your voice-over, images
and review.

---

## The whole flow in short

Type **`/meanwhile-mayank-style-reels start`**. Then:

1. **Setup check** (`scripts/check_setup.sh`): looks for ffmpeg, Node 22 + HyperFrames (with Chrome, disk and
   memory), Python + Pillow + numpy, rembg, and whisper.cpp + its model.
   - Missing something? Claude says what each item is for and how big the download is (about 1.5 GB if nothing is
     installed), then asks **"Can I install these now?"**. It installs only after your yes, then checks again.
   - Homebrew needs your Mac password, so Claude gives you one line to paste into Terminal instead.
2. **All the questions in one message:** topic, what you have (topic / script / voice-over), length, language,
   facts with sources, whether you can make images, music, ending line, where to save. Skip any to keep its default.
3. **Claude restates the plan,** makes the reel folder with a `PROGRESS.md` checklist, then goes by what you have:
   - **just a topic:** writes the script for your length (about 2 words per second, the Fix line marked for the
     music switch); you approve it and record it with the tips it gives you;
   - **a script:** checks it and suggests fixes; you record it;
   - **a voice-over:** converts it and goes straight to building.
4. **The steps below,** stopping each time you're needed: beat sheet OK, missing images, music preview, review
   notes, "render".
5. **`/meanwhile-mayank-style-reels continue`** picks up any reel later from its `PROGRESS.md`.

Works on macOS. On Linux Claude gives install commands instead of installing; Windows isn't supported yet.

---

## How to start (even if you've never done this before)

Open Claude Code in the folder where you want your reels, and type:

```
/meanwhile-mayank-style-reels start
```

That's all. Claude then does two things:

**1. Checks your computer.** It looks for the free tools the skill needs:

| Tool | What it's for |
|---|---|
| ffmpeg | cuts and mixes video and sound |
| Node.js 22 + HyperFrames | turns the reel's code into a video |
| Python + Pillow + numpy | prepares images |
| rembg | cuts props out of their background |
| whisper.cpp + its model | finds the time of every word you say |

If something is missing, Claude tells you what and how big the download is (about 1.5 GB if nothing is there yet)
and **asks before installing**. Say yes and it installs everything itself. The one exception is **Homebrew**, the Mac
installer: it needs your Mac password, so Claude gives you one line to paste into the Terminal app.
(macOS only for now.)

**2. Asks all its questions in one message.** Reply once; skip any question to keep its default:
1. the topic, in one line;
2. what you have: just the topic (Claude writes the script), a written script, or a recorded voice-over;
3. the length: 30, 45 (default), 60 or 90 s;
4. the language: Hinglish (default), Hindi or English;
5. any numbers you want on screen, with their source;
6. whether you can make images in a free tool like ChatGPT or Gemini;
7. the music: the skill's own, your two tracks (one dark, one calm), or none;
8. an ending line (your page or channel name), or none;
9. where to save the reel.

After that, Claude makes a folder for the reel with a `PROGRESS.md` checklist inside. It ticks off each step and
writes what it's waiting for from you. Stop any time. To pick up later, type:

```
/meanwhile-mayank-style-reels continue
```

**If you have no script yet:** Claude writes it for your length (about 2 words per second: a 45 s reel is about
90 words). It opens with the habit or problem, then the reason, then the fix (the music turns calm there), then
a calm ending. You approve it and record it.

**Recording tips:** record on your phone in a quiet room, phone about 15 cm away, one line at a time. If you
stumble, just say the line again. Any file type works. Put the file on this computer and send Claude its path.

---

## At a glance

| # | Step | You | Claude | You get |
|---|---|---|---|---|
| 0 | Start | Type `/meanwhile-mayank-style-reels start`, answer the questions | Checks and installs tools (asks first), asks everything at once | A ready computer, a plan |
| 0b | Script | Approve the script, record it | Writes or checks the script (if you have no voice-over yet) | `SCRIPT.md`, your recording |
| 1 | Folder | — | Makes the reel folder and its checklist | `<topic>_v1/` + `PROGRESS.md` |
| 2 | Listen | — | Writes down every word with its time | `transcript/words.tsv` |
| 3 | Plan | Read the beat sheet, say OK or change it | Plans every 2 s of the reel | `BEAT_SHEET.md` |
| 4 | Images | Make only the missing images (free tool) | Reuses the library, writes prompts for the rest, cuts out props | `assets/img/` ready |
| 5 | Build | — | Writes the reel as code | `index.html` |
| 6 | Music | Listen to the preview MP3 | Builds the dark → calm music bed | `bgm_mix.wav` + `_preview.mp3` |
| 7 | Check | — | Runs the checks, looks at stills | No errors, no overlaps |
| 8 | Review | Leave notes in VideoHub (or in the chat with the time) | Fixes every note in code | Approved preview |
| 9 | Render | Say "render" | Renders once, checks motion, sets loudness | Final MP4 |

---

## Step 1: The reel folder

**You:** nothing new. This happens right after the start questions (or say it directly, e.g.
"MM style reel on *Doodh ke saath namak*, voice-over `/Users/you/Desktop/vo.m4a`").

**Claude:** runs `scripts/new_reel.sh <folder>/<topic>_v1 <seconds>` (default folder `mm_reels/` where you're
working; in the AST_BTS project, the video's `06_Edit/`). That copies in the starter
reel (camera, titles, counters, overlay already set up), the Anton font, grain, the 4 world backgrounds and the
sound effects. Your voice-over goes in as `assets/audio/voiceover.mp3`.

Every new try gets a new folder (`_v2`, `_v3`…). Nothing old is ever overwritten.

## Step 2: Listen (word times)

**Claude:** runs `scripts/transcribe.sh` (whisper.cpp, on your Mac). It writes `words.tsv`: every word with
its start and end time. The pauses between phrases become the beat points.

If whisper loses sync (one "word" lasting many seconds, which happened on the chai voice at 17–30 s), the script
warns, and Claude re-runs only that part.

## Step 3: Plan (the beat sheet), *your OK needed*

**Claude:** writes `BEAT_SHEET.md`, one row per beat:

| Time | Spoken | Title | Set | What moves | Camera | Sound |
|---|---|---|---|---|---|---|
| 0.0–1.3 | "Khane ke turant baad" | KHANE KE BAAD | teal cloth | thali slides in | slow push | whoosh |
| 1.3–2.4 | "ek garam chai" | **GARAM CHAI?** (gold) | teal cloth | chai glass drops | punch-in | clink |

It checks the rules before showing you:
- something moves at least every 2 seconds;
- a new set or camera angle about every 3 seconds, and every camera move pointing at what the words name;
- the hook has 3 actions in the first 4 seconds;
- every title fits on screen (`scripts/fit_titles.py`);
- nothing will rest on top of anything else;
- every number on screen has a real source, or gets no source card;
- the row where the music switches is marked (your first "fix" line).

**You:** read it and say OK, or change it ("make the hook a hand crushing a puri", "title 3 in Hinglish").
Nothing else starts until you say OK.

## Step 4: Images, *you make only what's missing*

**Claude, library first:** opens `assets/library/` (the previews and `CATALOG.md`) and reuses everything that
fits: 10 backgrounds (mustard, walnut, teal cloth, emerald tiles, stomach cutaway, chai macro, kitchen, office,
tapri) and 21 cut-out props (thali, chai glasses, hand with chai, tablets, tray, padlock open/closed, clocks,
India map plain/red, stomach, molecule, blood cell…).

Code draws these, so they never need an image: counters, date plates, source cards, arrows, ticks, crosses,
rings, steam, bubbles, clock hands, titles, the crease and holes.

**Claude, then:** writes `IMAGES_NEEDED.md` with:
- a "Reused from the library" list;
- one ready prompt for each missing image, with its exact file name.

**You:** make those images in a free tool (ChatGPT / Gemini) and save them in `assets/images_in/` with the given
names. Rules the prompts already include:
- no text in any image;
- backgrounds are 9:16 with the top 30% empty;
- props are one object on flat light grey, whole and not cropped;
- two "states" of a thing (open/closed, plain/red) come from the same image, edited.

**Claude:** prepares them:
- backgrounds resized to 1080×1920 (`scripts/prep_plate.py`);
- props cut out locally (`scripts/cutout.py`, with a colour mode for pale things like trays and maps);
- every cut-out checked on a dark and a yellow background for halos and holes.

## Step 5: Build the reel

**Claude:** writes `index.html` from the beat sheet, using the starter's ready moves:

| Move | What you see |
|---|---|
| `drop` | A prop falls from above, squashes a little and settles with a shadow |
| `roll` | Split-flap counter digits roll and click into place |
| `draw` | An arrow, ring or tick draws itself |
| `whipIn` / `whipOut` | Fast sideways swipe with blur to the next shot |
| `tiltIn` / `tiltOut` | The camera tilts down into the next shot |
| `look` | The camera pushes in, pulls back or reframes onto one point (the thing being said) |
| `follow` | The camera travels along a path, e.g. riding an arrow from cause to effect |
| `drift` | The slow always-on push that keeps a shot alive |
| `shake` | A short shake on an impact ("lock!", a stamp, a slam) |
| `rack` | Focus pull: the set blurs so one thing stands out |
| `depth` | Parallax: near layers move more than far ones, so the set feels 3D |

**The camera explains.** It goes where the words point, on the word: push in when something is named, travel
from cause to effect, pull back for "how many", shake on a hit, focus-pull on a source card. Claude plans this in
the beat sheet's Camera column (`push → tannin (on "tannin")`) using `references/camera_to_explain.md`.
| `title` | Line 1 fades in, Line 2 rises on the stressed word |

Bigger moves are copied from the chai example: background swaps behind the same hand, red fill spreading on a map,
zoom into the glass, the padlock snapping shut, tablets raining into the tray, clock hands painting a time wedge.

Before building, Claude reads `references/mistakes_and_layout.md`, which includes your 5 review notes from the chai
video, so the same mistakes don't come back.

## Step 6: Music, *you listen*

**Claude:** runs `scripts/music_bed.sh`, which builds one music file:
- **problem part:** a dark epic track, quiet under your voice;
- **from your first "fix" line:** a hard switch to calm lo-fi, softened, dipping under your voice, fading out at the end.

**You:** listen to the `_preview.mp3` (your voice + the music). VideoHub's live preview plays only the voice, so
this file is the way to judge the music before the render.

## Step 7: Check (before you see anything)

**Claude:**
- runs `npx hyperframes check` and fixes every error;
- takes still frames at the end of every beat and looks at them for overlaps, props peeking in early, stray dots,
  background edges and unreadable titles;
- goes through the mistakes list item by item.

## Step 8: Review the preview, *your notes*

**Claude:** opens the reel in a live preview: VideoHub (`hub_live`) if you have it, otherwise the HyperFrames
preview in your browser (`npx hyperframes preview`). Nothing is rendered yet; it plays from the code.
(Without VideoHub, write notes in the chat like "at 0:12, the padlock covers the title".)

**You:** watch it, click on a frame, write a note ("use a red arrow here", "this overlaps", "add a tick under the
chai") and press **Send to Claude**.

**Claude:** fixes each note in the code (the preview reloads by itself) and marks it done. Repeat until you're happy.

## Step 9: Render, *only when you say so*

**You:** say "render".

**Claude:**
1. renders once, locally (`hub_render`, no cloud, no credits);
2. runs the motion check (`scripts/qc_motion.py`): it must PASS. The chai V4 scored 7.72; a slideshow scores about 1.7.
3. makes a contact sheet to compare with the reference reels;
4. sets the loudness to −14 LUFS on a copy (`scripts/loudnorm.sh`; the raw render comes out too quiet);
5. saves the final as a new `_vN` file.

**After it's approved:** the good new images go into `assets/library/`, so the next reel needs fewer new images.

---

## What you can say at any point

| You say | What happens |
|---|---|
| `/meanwhile-mayank-style-reels start` | Setup check, then the start questions |
| `/meanwhile-mayank-style-reels continue` | Picks up a reel from its `PROGRESS.md` |
| "MM style reel on <topic>, voice-over <path>" | Starts from step 1 |
| "Show me the beat sheet again" / "change beat 5 to …" | Back to step 3 |
| "Which images do you need?" | The missing list from step 4 |
| "Use the padlock / map / clock from the library" | Reuses that prop |
| "Is the music right?" | A new voice + music preview MP3 |
| "This looks like a slideshow" | Adds beats and camera moves until the motion check passes |
| "Render" | Step 9 |

## If something goes wrong

| Problem | Fix |
|---|---|
| "command not found" or a tool is missing | Run `/meanwhile-mayank-style-reels start` again: the setup check finds it and offers to install it |
| Homebrew is missing | Paste the one line Claude gives you into the Terminal app (it asks for your Mac password), then tell Claude it's done |
| Render fails with low memory | Close other apps (browsers especially) and render again |
| A cut-out has a grey halo or holes | Re-cut it with `--mode color`, or make the prop again on plain grey |
| A title doesn't fit | `fit_titles.py` shrinks Line 2; if Line 1 is too long, it gets reworded |
| The music switch can't be heard | The calm track started on its quiet intro; start it on its beat (Circle: 8.42 s) |
| The render is too quiet | `scripts/loudnorm.sh` (step 9) |
| The motion check fails | Add a beat wherever 2 s pass with nothing moving: a punch-in, a pulse, a drop |
| Two "state" images don't line up | Make one from the other, or shift it by a few pixels |

## What it never does

- Spend credits (HeyGen, cloud render, paid image or video tools).
- Copy Mayank's footage, images, titles or voice. His reels are only for studying, and they stay outside this folder.
- Put a source card on a number with no real source.
- Overwrite an old version.
- Add captions, unless you ask.

## Where things are

| Path | What |
|---|---|
| `SKILL.md` | The same workflow, written for Claude |
| `GUIDE.md` | This guide |
| `examples/chai_v4/` | The approved chai reel, ready to open |
| `assets/library/` | Every image we already have, with `CATALOG.md` and previews |
| `templates/` | The starter reel, the beat sheet and the image-prompt list |
| `references/` | Detailed rules: motion, titles, sound, mistakes, the 12 reference reels |
| `scripts/` | The 11 tools used in the steps above (`check_setup.sh` checks and installs the rest) |
| `../reference_videos/`, `../reference_sheets/` | Mayank's reels and their frame sheets (study only, never shared) |
