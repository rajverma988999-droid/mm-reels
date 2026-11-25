# MM Style Skill: make reels like Meanwhile Mayank's (the chai video way)

> **Lite copy (2026-11-25):** only the skill, made smaller so it is easy to share. Nothing the skill needs was removed:
> the `reference_videos/`, `reference_sheets/`, `example_output/` and `history/` folders mentioned below are NOT in this copy
> (they are not used to make a reel), the original images in `assets/library/sources/` are high-quality JPG instead of PNG,
> the chai example's music bed is MP3 instead of WAV, and the HyperFrames cache was cleared (it rebuilds itself).
> Phone / computer steps: `steps.md`.


Everything needed to make a 9:16 tactile science / myth-buster reel like the approved **Chai & Iron V4** demo,
in one place. Made 2026-11-24 from the V2 skill, the V4 build, its 5 review notes and the 12 reference reels.

## What is here

| Folder | What | Ship it to others? |
|---|---|---|
| **`meanwhile-mayank-style-reels/`** | **The skill.** `SKILL.md` (workflow + rules), `references/` (motion, titles, sound, mistakes, the reels), `scripts/` (10 tools), `templates/` (starter composition + beat sheet + image prompts), `assets/` (font, grain, SFX, music, and **`library/`: 10 plates + 21 cut-out props from the chai videos, ready to reuse**), `examples/chai_v4/` (the approved reel, plays as is) | The skill yes, but read `assets/LICENSES.md` first: SFX, music and the voice-over must be removed |
| `reference_videos/` | Mayank's 12 new-style reels (`ref_01`–`ref_12`). His old paper-style reel stays at `09_Videos/Copy MeanWhileMayank/referance/my_older_paper_style/oldPaperStyle.mp4` | **Never** (another creator's work; study only) |
| `reference_sheets/` | `ALL_12_REELS_overview.png` (one row per reel) and a 1-fps contact sheet of the first 40 s of every reel and of the V4 and failed V2 chai versions | No (frames of his reels) |
| `example_output/` | `chai_iron_myth_demo_v4_music.mp4` (approved) and `chai_voice_over.mp3`. The slideshow version that failed stays at `09_Videos/Copy MeanWhileMayank/Skill_And_Test/generated_videos/chai_iron_myth_demo_v2_voiced.mp4` | Your own work, your call |
| `history/` | Untouched copies: `1_antigravity_original/` (first skill), `2_claude_update_v2/` (the V2 skill this grew from), `STYLE_ANALYSIS_original.md` | No (old numbers) |

The videos here are APFS clones of the originals, so they take no extra disk space.

## Make a new reel (short version; the step-by-step guide is [`meanwhile-mayank-style-reels/GUIDE.md`](meanwhile-mayank-style-reels/GUIDE.md))

```bash
cd "MM_Style_Skill/meanwhile-mayank-style-reels"
scripts/new_reel.sh "../../06_Edit/<topic>_v1" 40
```
1. Put the voice-over at `<reel>/assets/audio/voiceover.mp3`, then `scripts/transcribe.sh` it.
2. Fill `BEAT_SHEET.md` (a beat every ≤ 2 s, a 3-action hook, the music switch on the first "fix" line) and agree it.
3. Fill `IMAGES_NEEDED.md`; generate the images free; `prep_plate.py` the plates, `cutout.py` the props.
4. Build `index.html` from the starter helpers and moves copied from `examples/chai_v4/`.
5. `music_bed.sh` → check → snapshots → VideoHub review → render once when asked → `qc_motion.py` →
   `loudnorm.sh`.

## Checked on 2026-11-24
- `qc_motion.py`: V4 PASS (median 7.72, 0% still), V2 slideshow FAIL (1.73, 37% still); reference reels: 11 of 12 PASS (median 9.2–12.8), ref_06 just misses on still windows (6%).
- The starter and the chai example pass `npx hyperframes check`.
- Paths inside the skill point inside it, except: AST_BTS-only paths (gathered in SKILL.md §6), and the example's `BEAT_SHEET.md` / `IMAGES_NEEDED.md`, which keep their original project paths as a record.
- All scripts were run on the chai files: `transcribe.sh` (single and multi-chunk), `fit_titles.py`, `prep_plate.py`, `cutout.py` (rembg and colour mode), `music_bed.sh` (matches the V4 bed to 0.1 dB), `loudnorm.sh`, `contact_sheet.sh`, `new_reel.sh`.

## Installed as a Claude skill (2026-11-24)
Linked into the project skills: `.claude/skills/meanwhile-mayank-style-reels` → this folder (a symlink, so edits here
are live). Claude picks it up on "MM style", "Meanwhile Mayank style", "like the chai video" and similar.
