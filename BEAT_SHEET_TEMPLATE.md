# <Topic> — beat sheet (skill: meanwhile-mayank-style-reels)

Voice: `assets/audio/voiceover.mp3` (<length> s). Word times: `transcript/words.tsv` (scripts/transcribe.sh).
1080x1920, 30 fps. Image IDs: B = background plate, P = cut-out prop, see `IMAGES_NEEDED.md`.
"code" = drawn in HTML/SVG (counters, cards, arrows, ticks, rings, steam, bubbles), no image needed.

| # | Time (s) | Spoken | Title L1 / **L2** (colour) | Set | What moves (beat) | Camera | SFX | Rest box (x, y, w) |
|---|---|---|---|---|---|---|---|---|
| A1 | 0.00–1.30 | <first words> | <L1> | B1 | <prop enters / lands> | drift on the set | whoosh_soft | P1: 110, 980, 620 |
| A2 | 1.30–2.40 | <...> | **<L2>** (gold) | B1 | <hand / drop / state swap> | push → P1 (on "<word>") | metal_click | |
| B1 | 2.40–3.10 | <...> | <L1> | B2 | whip-pan in | whip | whoosh | |
| … | | | | | | | | |
| **MUSIC SWITCH** | <t> | <first "fix" words> | | | dark bed → calm lo-fi (scripts/music_bed.sh) | | | |

**Title colours:** pink = danger / big number, peach = story / time / place, gold = question / fact,
cyan = science / mechanism, violet = brain / calm, lime = the fix / good news.

**Check before making any image:**
- [ ] No gap over 2 s without a beat (the lower 70% of the frame changes).
- [ ] A new set or camera framing about every 3 s.
- [ ] Every camera move points at what the words name, landing on that word (`references/camera_to_explain.md`);
      cause → effect = travel, how many = pull-back, a hit = shake; at least 5 kinds of move across the reel.
- [ ] Hook: 3 actions in the first 4 s before the question title lands.
- [ ] One title pair per spoken phrase; every line fits (`scripts/fit_titles.py`).
- [ ] Every resting object has its own box; no box crosses another or the top 30% (titles).
- [ ] Every number on screen has a source, or no source card.
- [ ] The music switch row is marked.

**Facts on screen:** <each number, and the source the card will quote word for word>
