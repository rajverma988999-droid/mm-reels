# The start questions (sent once, in one message, after the setup check passes)

Send this message as it is: fill in nothing, keep the defaults visible. The user may be a complete beginner, so the
wording stays plain and every question has a default they can accept by writing "default" or skipping it.
Answer anything they ask back before moving on.

---

> Setup is ready. Now a few questions, all at once, so I can plan your reel. Reply in one message.
> Skip any question to keep its **default**.
>
> 1. **Topic:** what is the reel about, in one line? (e.g. "Is it bad to drink chai right after food?")
> 2. **What do you have right now?**
>    a) just the topic (I'll write the script for you)
>    b) a written script (paste it)
>    c) a recorded voice-over (send the file path, e.g. `/Users/you/Desktop/voice.m4a`)
> 3. **Length:** 30 s, **45 s** (default), 60 s or 90 s. If you already recorded the voice, the reel takes its length.
> 4. **Language:** **Hinglish** (default), Hindi or English.
> 5. **Facts and numbers:** any number you want on screen, with where it comes from (a survey, study or news link).
>    Default: I suggest facts and show you the source before using them. A number with no real source gets no source card.
> 6. **Images:** can you make images in a free tool like ChatGPT or Gemini and save them to a folder?
>    **yes** (default) / no (then I use only the images we already have and drawings made in code, and some scenes get simpler)
> 7. **Music:** **use the music in the skill** (default, if it has some), use your own two tracks (one dark, one calm: send the paths),
>    or no music (sound effects only)
> 8. **Ending line:** your channel or page name for the last line (e.g. "Follow @yourpage" or "Subscribe to <channel>"). Default: no ending line.
> 9. **Where to save:** default is a new folder `mm_reels/<topic>_v1` next to where we are working (in the AST_BTS project:
>    `09_Videos/<video ID>/06_Edit/<topic>_v1`).

---

## After the answers

1. **Restate in 3–4 lines** what you understood (topic, what they have, length, language, images yes/no, music, folder).
   Don't ask again for anything they already answered; for anything unclear, use its default and say so.
2. **Create the reel folder:** `scripts/new_reel.sh <folder> <length>`, then fill `PROGRESS.md` with the answers.
3. **Branch on question 2:**

| They have | Next |
|---|---|
| **a) topic only** | Write the script (`references/script_writing.md`, `templates/SCRIPT_TEMPLATE.md`), sized to the length, in their language. Mark the first "Fix" line (the music switches there). Show it, take changes, then ask them to record it (how-to below). |
| **b) a script** | Check it against `references/script_writing.md` (opening pain, length in words, a clear Fix line). Suggest fixes; don't rewrite their voice. Then ask them to record it. |
| **c) a voice-over** | Convert it into the reel: `ffmpeg -i <file> -ar 48000 -b:a 192k <reel>/assets/audio/voiceover.mp3`. Go to SKILL.md Workflow step 2. |

### How to record (send this to a beginner who has no recording yet)
> Record it on your phone in a quiet room (a closet or under a blanket is great), phone about 15 cm from your mouth,
> one line at a time with a small pause between lines. If you stumble, just say the line again: send me the file and
> I'll use it as is. Any format is fine (m4a, mp3, wav). Send me the file path when it's on this computer.

The skill never makes the voice with AI or clones a voice. A real voice is the point of the style. (Polishing the
recording, e.g. noise removal, is a separate step: ask first.)

### If they answered "no" to images (question 6)
Use only `assets/library/` and code-drawn things. In the beat sheet, mark which beats changed because an image was
missing, so they can add images later if they want.
