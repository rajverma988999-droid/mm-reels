# Phone se MM Style Skill kaise chalaye (Android + iPhone)

**Seedhi baat:** ye skill video *render* karti hai (HyperFrames + Chrome + ffmpeg + Python + rembg).
Ye sab phone ke andar nahi chal sakta. Kaam ek **computer** ya **cloud computer** pe hota hai.
Jinke paas computer hai wo Tarika 1, **jinke paas sirf phone hai wo Tarika 2** follow karein.

| | Tarika 1: Computer wale | Tarika 2: Sirf Phone wale (computer nahi hai) |
|---|---|---|
| Kya chahiye | Mac (best) ya Linux computer, Claude Pro/Max plan | Sirf phone (Android ya iPhone), GitHub account, Claude Pro/Max plan |
| Kaam kahan hota hai | Aapke computer pe | Anthropic ke cloud computer pe |
| Video kahan milega | Computer ke folder mein (phone pe share kar lo) | GitHub repo mein, wahan se phone pe download |
| Mushkil | Easy | Medium (pehli baar setup lamba hai) |

> Windows computer abhi supported nahi hai. Windows wale Tarika 2 (sirf phone wala) use karein.

---

## Tarika 1: Computer wale

### Ek baar computer pe (15–30 min, ek hi baar)
1. Computer pe **Claude desktop app** install karo: https://claude.com/download (Mac / Windows), apne account se login karo.
2. Ye poora folder `MM_Style_Skill` computer pe rakho, jaise `Documents/MM_Style_Skill`.
3. Claude app kholo → upar **Code** tab pe jao → **naya session** → folder chuno:
   `Documents/MM_Style_Skill/meanwhile-mayank-style-reels` (folder picker se select karo, kuch type nahi karna).
4. Session ke message box mein likho: `/meanwhile-mayank-style-reels start`
   Claude khud check karega kya install nahi hai (ffmpeg, Node 22, Python, rembg, whisper model ~1.5 GB),
   aur poochega **"Can I install these now?"** → **yes** bolo, baaki wo khud install kar dega.
   Sirf ek case: Mac pe Homebrew na ho to Claude ek command dega jo Mac password maangti hai; use Claude app ke
   **Terminal** panel (ya Mac ki Terminal app) mein paste karke Enter dabao, password daalo. Bas itna hi aapko khud karna hai.
5. Phir likho, jaise: "chai aur iron pe 40 sec ki reel banao, voice-over maine folder mein daala hai".
   Claude sab sawaal ek saath poochega (topic, script, length, images, music), aap jawab do.
6. Reel ban jaane ke baad Claude bataega file kahan bani (`.../renders/…mp4`).

---

## Tarika 2: Sirf Phone wale (computer nahi hai) — Android aur iPhone dono

Isme skill ek **GitHub repo** mein rakhni padti hai, aur Claude ka cloud computer usse chalata hai.

### Ek baar setup
1. Phone pe **Claude app** install karo aur login karo:
   - Android: Play Store → "Claude by Anthropic"
   - iPhone: App Store → "Claude by Anthropic"
2. Phone ke browser mein **github.com** pe free account banao.
3. Naya **private repo** banao, jaise `mm-reels`.
4. Repo mein ye folder upload karo: `meanwhile-mayank-style-reels/` → repo ke andar
   `.claude/skills/meanwhile-mayank-style-reels/` naam se. (Phone se bahut saari files upload karna mushkil hai.
   Kisi dost ke computer se ek baar upload karwa lo, ya GitHub ki "Upload files" mein zip ki jagah folder ki files daalo.)
5. Claude app kholo → **Code** section →
   GitHub connect karo → apna `mm-reels` repo chuno.

### Reel banana
6. Naya session kholo aur likho: `/meanwhile-mayank-style-reels start`
7. Cloud computer **Linux** hota hai. Skill ka setup check Linux pe apt wale commands batata hai
   (ffmpeg, nodejs 22, python3-venv); Claude ko bolo **"ye sab install kar do"**. Pehli baar thoda time lagega.
8. Voice-over: apni `voiceover.mp3` repo mein upload karo (GitHub app/website se), phir Claude ko batao kahan hai.
9. Reel banne ke baad Claude ko bolo: **"final mp4 repo mein commit aur push kar do"**.
   Phir GitHub app/website se `mp4` phone pe download karo.

**Dhyan do:** cloud wala tarika naya hai aur bhaari downloads karta hai (Chrome, models). Har nayi cloud session
mein setup dobara ho sakta hai. Agar baar baar atke, kisi computer wale dost se Tarika 1 se banwa lo.

**Phone sleep ho jaye to bhi kaam chalta rehta hai**, kyunki render cloud computer pe ho raha hai.

---

## Android pe Termux? (sirf advanced log)
Termux mein ffmpeg / Node / Python install ho jaate hain, par HyperFrames ke liye headless Chrome
aur rembg (cut-outs) phone ke ARM processor pe theek se nahi chalte. **Recommend nahi karte.**
iPhone pe ye bhi possible nahi.
