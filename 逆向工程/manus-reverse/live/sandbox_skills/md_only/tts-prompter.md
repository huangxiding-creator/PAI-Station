---
name: tts-prompter
description: MUST read this skill BEFORE calling `generate_speech` or entering generate mode for any text-to-speech (TTS) task, including narration, voice-over and dialogue audio requested by other skills such as video production. Covers how to split a script into verbatim `turns[].text` and short `turns[].style`, inline vocal tags, two-speaker dialogue, voice selection (30 studio voices, plus 2,000+ locale-native library voices with regional accents and personas found through a bundled search script), language and accent, and length and duration planning.
---

# TTS Prompter

`generate_speech` reads `turns[].text` as a **verbatim transcript**: every character you put in `text` can be spoken aloud. Delivery direction goes in `turns[].style` (never spoken), and speaker identity comes from the voice you choose. The rules below follow the official prompting guide and migration guide of the speech model behind `generate_speech`.

## 1. The core model: four channels

| Question | Channel | Spoken? |
| :--- | :--- | :--- |
| Who is speaking (timbre, gender, identity) | `voice_name`, or `speaker_voice_configs` for two speakers | No |
| What is said | `turns[].text` | Yes, verbatim |
| How this turn is delivered, sustained across the turn | `turns[].style` (optional, short English) | Never |
| A momentary vocal event at a specific word | Inline angle-bracket tag inside `text`, e.g. `<sigh>` | Rendered as a sound, not as words |

**Alignment rule:** voice, transcript, style and tags should all point in the same direction. A frightened style works best with words that actually sound frightened, spoken by a voice whose timbre fits the character.

## 2. Workflow

Follow these steps in order:

1. **Count speakers.** One speaker: use `voice_name`. Exactly two: use `speaker_voice_configs`. Three or more: split into separate calls (§6.3).
2. **Choose voices** (§5): a studio voice from `references/voice_catalog.md` by default, or a library voice found with `scripts/find_voice.py` when a regional accent or a specific persona is needed.
3. **Write the transcript** in the target language as natural speech (§3).
4. **Split it into turns.** Start a new turn at every speaker change, and whenever the sustained delivery must change (§4.3).
5. **Leave `style` empty first.** Add a short English style only to the turns that need a specific delivery (§4).
6. **Set `language_code`** to the main spoken language (§7).
7. **Check length and duration** (§8), then run the pre-flight checklist (§10).

## 3. Writing `turns[].text`: the verbatim transcript

### 3.1 Hard rules

- **Only the words to be spoken.** Never put any of the following in `text`, because the model may read them aloud:
  - delivery directions, e.g. `Say cheerfully:` or `Speak in Brazilian Portuguese:`
  - speaker labels, e.g. `Joe:`
  - stage directions such as `(laughs)` or `*door creaks*`
  - square-bracket tags, e.g. `[sigh]` or `[whispering]`
  - Markdown, emoji, or notes to yourself
- **Write in the exact language(s) to be spoken.** For Japanese, write Japanese; for Japanese with English terms, write exactly that mix. The model does not translate.
- **Write it as speech, not as an essay.** Use contractions and natural rhythm. In conversational content, natural disfluencies help, e.g. `Oh uh yeah I think... hm, so that's interesting.` Formal narration can stay clean.
- **Use punctuation for breathing and hesitation.** Commas, periods, dashes (`--`) and ellipses (`...`) create natural pauses.
- **Use capitals for emphasis.** Capitalize the stressed word: `This is a VERY important point!` Use it sparingly. In scripts without letter case, such as Chinese or Japanese, use word order and punctuation instead.
- **Spell out readings that matter.** For phone numbers, codes, unit symbols, rare names or anything ambiguous, write it the way it should be read.

### 3.2 Inline vocal tags (point-in-time events)

Place a tag exactly where the sound should occur. Use **angle brackets only**, and write the tag in English even inside non-English text. These are the tags recommended by the official guide:

| Group | Tags |
| :--- | :--- |
| Laughter | `<laugh>` / `<laughter>`, `<chuckle>` / `<chuckles>`, `<giggle>`, `<snicker>`, `<cackle>` |
| Breath and sighs | `<sigh>` / `<sighs>`, `<breath>`, `<heavy breath>`, `<exhales>`, `<pant>`, `<phew>` / `<pff>` |
| Body sounds | `<cough>`, `<sneeze>`, `<throat-clearing>`, `<yawn>`, `<snort>`, `<tsk>` |
| Distress | `<gasp>`, `<sob>`, `<cry>`, `<whimper>`, `<groan>`, `<moan>` |
| Force | `<grunt>`, `<growl>`, `<grr>`, `<argh>`, `<hiss>`, `<cheer>`, `<shout>`, `<scream>`, `<shriek>` |
| Voice mode | `<whispers>` / `<whispering>` |
| Pauses | `<short pause>`, `<long pause>` |

Examples:

- `<cough> Thank you all for coming tonight! <throat-clearing> As I was saying...`
- `It was a VERY long day <sigh> ... nobody listens anymore.`
- `今天真的太累了 <sigh> …… 明天再说吧。`

Rules for tags:

- **Human vocalizations only.** Never write sound-effect tags such as `<applause>`, `<door slam>` or `<music>`. Produce sound effects separately and mix them in with `ffmpeg`.
- **No emotion-word tags.** Do not write `<scared>`, `<happy>`, `[excited]` and the like. Emotion belongs in `style`.
- **Disfluencies are words, not tags.** Write `uhm` or `hm` directly in the text.
- **No `[square brackets]`.** That is an older tag syntax (§4.4).
- **Tags mark moments.** If a whole turn should be whispered or shouted, put that in `style` rather than in a tag.

### 3.3 Pacing and pauses

There are three levels of control, from finest to coarsest:

1. **Punctuation:** commas, dashes (`--`) and ellipses (`...`) for natural hesitation.
2. **Pause tags:** `<short pause>` or `<long pause>`. There is no medium pause tag; use `...` for a medium pause. Example: `Hold on, let me think... <short pause> Alright, I've got it.`
3. **Turn-level pace:** `style: "speaking rapidly"` or `style: "speaking slowly"`.

### 3.4 Backchannels and overlapping speech (two-speaker dialogue only)

- Wrap the **listener's** brief reaction in pipes **inside the active speaker's turn**. Do not create a separate turn for a one-word reaction.
  - Turn (Maya): `So the launch is Thursday |oh hmm| Are we actually ready?`
  - Turn (Leo): `Ready enough |oh really?| The last blocker cleared this morning.`
- Interleave several pipe segments for simultaneous or choral speech, e.g. `one. two. three. |happy| happy |birthday| birthday!`
- Never use pipes in single-speaker audio, and remove any `|` characters that are not intended as backchannels, such as those from tables.

## 4. Writing `turns[].style`: optional direction (never spoken)

### 4.1 Default: leave it empty

Most turns need no style at all. Synthesize a plain transcript first, and add style only where the delivery has to differ from a natural read.

### 4.2 Keep it short, in English, and about delivery only

- Write a short English phrase, typically 1 to 6 words.
- Use style only for **sustained delivery**: emotion, tone, prosody and pitch, overall pace, volume, and delivery mode.
- Good examples: `warm and calm`, `whispered, nervous`, `speaking rapidly`, `speaking slowly`, `out of breath`, `sarcastic`, `angry tone`, `muttering, then reassuring`, `monotone and flat`, `casual, friendly`, `high pitch, cheerful and excited inflection`.
- For a consistent baseline across many turns, **reuse the exact same style string**. Do not paraphrase it from turn to turn.

**Never put these in `style`:**

| Do not write | Why | Do this instead |
| :--- | :--- | :--- |
| Age, gender, names, permanent accent, e.g. `a 60-year-old British man named Arthur` | These are immutable speaker traits and cannot be changed through style | Pick a fitting voice (§5) and set the regional `language_code` (§7) |
| Language instructions, e.g. `Speak in Japanese` | Language comes from the transcript and `language_code` | Write the text in that language |
| Long persona paragraphs, scene descriptions, "Audio Profile" or "Director's Notes" blocks | The most common cause of voice drift | Keep only the delivery words, e.g. `terrified, trembling whisper` |
| Meta-instructions, e.g. `keep the same voice`, `do not switch speaker identity`, `maintain identical timbre` | Extra prompt text increases drift; the voice already anchors identity | Omit them |
| The words to be spoken | Style is never spoken | Put them in `text` |

### 4.3 When to start a new turn

- **Speaker change:** always a new turn.
- **Delivery change** that lasts, such as calm turning to panic, or narration followed by a shouted quote: a new turn with its own style.
- **Long monologue:** split it into paragraph-sized turns instead of strengthening the style.
- **Otherwise,** keep a sentence within one turn.

### 4.4 Converting old-style prompts

Users, or other skills, may supply prompts written in an older format. **Convert them; never pass them through as `text`.**

| Old pattern | New form |
| :--- | :--- |
| `Say cheerfully: Have a wonderful day!` | text `Have a wonderful day!`, style `cheerful` |
| `You are hiding in a dark closet. Speak in English with a terrified, trembling whisper as if you are afraid of being caught: I think someone is in the house.` | text `I think someone is in the house.`, style `terrified, trembling whisper`, `language_code` `en-US` |
| `TTS the following conversation between Joe and Jane:` followed by `Joe: ...` and `Jane: ...` lines | One turn per line with `speaker` set to `Joe` or `Jane`; remove the intro line and the name prefixes |
| `[sigh]`, `[laughing]`, `[cough]`, `[gasp]` | `<sigh>`, `<laugh>`, `<cough>`, `<gasp>` |
| `[uhm]` | the word `uhm` |
| `[short pause]` / `[medium pause]` / `[long pause]` | `<short pause>` / `...` / `<long pause>` |
| `[whispering]`, `[shouting]`, `[extremely fast]`, `[sarcasm]` | style `whispering`, `shouting`, `speaking rapidly`, `sarcastic`; start a new turn if the change happens mid-script |

## 5. Voice selection

There are two kinds of voices. Both go into `voice_name` or `speaker_voice_configs[].voice_name`, and both must be copied exactly.

| Kind | What it is | When to use it |
| :--- | :--- | :--- |
| Studio voices (30) | Named voices such as `Kore` and `Charon`, listed in `references/voice_catalog.md`. They speak every supported language. | The default for every task, and the only choice for languages without library voices, such as Chinese. |
| Library voices (2,059) | Locale-native voices with IDs such as `en-gb-storyteller-3`, each with a regional accent and a persona, in 30 locales. | When the user asks for a regional accent or a native speaker of a library locale, or when a specific persona (documentary narrator, tutor, support agent, podcaster, commercial voice-over, coach, character) clearly fits better than a studio voice. |

### 5.1 Studio voices (default)

- **Match timbre to role** using the catalog's timbre words:
  - Documentary or explainer narration: `Informative`, `Knowledgeable`, `Even`, `Clear` (e.g. Charon, Rasalgethi, Sadaltager, Schedar, Iapetus, Erinome)
  - Warm storytelling or wellness content: `Warm`, `Gentle`, `Soft`, `Smooth` (e.g. Sulafat, Vindemiatrix, Achernar, Algieba, Despina)
  - Energetic ads or announcements: `Upbeat`, `Excitable`, `Lively`, `Bright` (e.g. Puck, Laomedeia, Fenrir, Sadachbia, Zephyr, Autonoe)
  - Authority or instruction: `Firm`, `Mature`, `Forward` (e.g. Kore, Orus, Alnilam, Gacrux, Pulcherrima)
  - Casual conversation: `Easy-going`, `Casual`, `Friendly`, `Breezy`, `Youthful` (e.g. Callirrhoe, Umbriel, Zubenelgenubi, Achird, Aoede, Leda)
  - Grit or texture: `Gravelly`, `Breathy` (e.g. Algenib, Enceladus)

### 5.2 Library voices: query them, never read the table

`references/voice_library.tsv` lists every voice, but it is about 110,000 tokens. **Never open or print it.** Query it with the bundled script, which prints only a few matching lines:

```bash
python3 "<skill-dir>/scripts/find_voice.py" --language en-GB --gender female --use-case storyteller --search calm warm
python3 "<skill-dir>/scripts/find_voice.py" --facets --language ja
python3 "<skill-dir>/scripts/find_voice.py" --check en-gb-storyteller-3 Kore
```

- Replace `<skill-dir>` with this skill's directory and keep the quotes, because the path may contain spaces. On Windows, use `py` or `python` if `python3` is unavailable.
- **Filters:** `--language` (a locale such as `en-GB`, or a language such as `en`), `--gender` (`female`, `male`, `neutral`), `--pitch` (`low`, `medium`, `high`), `--accent` (part of an accent name, e.g. `Glasgow`), `--use-case` (persona or context words, e.g. `narrator`, `tutor`, `podcast`, `commercial`, `gaming`) and `--search` (tone words that rank the results, e.g. `calm warm`). Five results are shown by default; `--limit` allows up to 15. Add `--include-studio` to compare studio voices in the same list.
- **Unfamiliar locale:** run `--facets` first to see which accents, contexts, use cases and genders exist. When no combination matches, the script relaxes the narrowest filter and says which one it relaxed. When a locale has no library voices, it names the closest locales or tells you to use a studio voice.
- **Pick one line and copy its `id` verbatim.** Run `--check` on any ID you did not copy from the current output, such as one reused from earlier in the project or supplied by the user.
- **Set `language_code` to the voice's locale exactly**, as shown in its row (e.g. `en-CA` for `en-ca-advisor-1`), even when `references/language_catalog.md` does not list that code. Any other code fails with `No matching speaker voice found`.
- **Without Python,** filter the table with `grep` and print only a few lines; never `cat` the file. Columns are tab-separated: `id`, `kind`, `language`, `gender`, `pitch`, `accent`, `context`, `persona`, `display_name`, `description`.

```bash
grep -i $'\tlibrary\ten-GB\tfemale\t' "<skill-dir>/references/voice_library.tsv" | grep -i storyteller | head -5
```

### 5.3 Rules for every voice

- **Gender comes from the voice.** Choose a voice of the required gender; never try to change gender or age through style.
- **Two speakers** need clearly distinguishable voices: different genders, or contrasting timbres such as Firm with Breezy. Studio and library voices can be mixed, but two library voices must come from the same locale, because one request has a single `language_code`.
- **Keep identity stable.** Reuse the same voice ID for the same character in every call of a project.
- **Designed and replicated (cloned) voices are not supported.** If the user asks for a celebrity, a cloned voice or a custom design, explain the limitation and choose the closest studio or library voice. Never imitate a real person.

## 6. Dialogue

### 6.1 Two speakers

- `speaker_voice_configs` must contain **exactly two** entries with two different voices (studio or library).
- **Every turn must set `speaker`**, spelled exactly as in `speaker_voice_configs`.
- Speaker names are labels and are never spoken. Do not repeat them as prefixes in `text`.
- Use backchannels (§3.4) for short reactions.

### 6.2 Single speaker with several turns

This is allowed and useful when the delivery changes. Leave `speaker` empty on every turn.

### 6.3 Three or more speakers

1. Split the script into consecutive segments that each contain at most two speakers.
2. Generate each segment with its own call, keeping every character on the same voice in every call.
3. Concatenate the WAV files in script order:

```bash
printf "file '%s'\n" seg01.wav seg02.wav seg03.wav > list.txt
ffmpeg -f concat -safe 0 -i list.txt -c:a pcm_s16le -ar 24000 -ac 1 dialogue.wav
```

## 7. Language and accent

- **Language comes from the transcript itself.** The model detects it automatically.
- Set `language_code` to the BCP-47 code of the main spoken language, e.g. `en-US`, `en-GB`, `cmn-CN`, `ja-JP`, `pt-BR` or `es-MX`. It helps the model choose the locale; it does not translate. When a library voice is used, `language_code` must be that voice's locale (§5.2).
- **Mixed language:** write the mix exactly as spoken and set `language_code` to the dominant language. Do not add a "mixed language" instruction.
- **Accent comes from the voice.** For a specific regional accent, such as Glasgow English, Mexico Spanish or Osaka Japanese, use a library voice with that accent (§5.2) and set `language_code` as described there. Studio voices are catalogued as General American English; for them, the regional `language_code` and natural regional wording or spelling are the only accent controls. Never write accents into `style`.
- Check `references/language_catalog.md` before promising a language. Languages marked "not listed" may fail or sound poor, so tell the user before you rely on them.

## 8. Length, splitting and duration

- **Per call:** the total `text` across all turns must not exceed 6000 characters. Split longer scripts into several calls at paragraph or turn boundaries, keep the same voice(s) and style strings, then concatenate with `ffmpeg` (§6.3).
- **Duration is not deterministic.** The model chooses its own speaking rate.
  - **Standalone tasks with no time limit:** ignore duration and optimize for reading the text fully and accurately.
  - **Time-constrained tasks** (video narration, dubbing to a fixed clip, ad spots): size the first draft with the calling skill's rules, then generate, measure the real duration (for example with `ffprobe`) and adjust. Change the script length first and regenerate; `speaking rapidly` or `speaking slowly` in `style` gives only a modest adjustment. Use a light `ffmpeg` `atempo` change only to close a gap of a few percent.

## 9. Safety and policy

- **No real brands or real people as style references.** Phrases like "Chanel-style" or "like a famous YouTuber" are common triggers for policy blocks, so describe the delivery generically instead.
- **Soften sensitive content.** Violence, sexual content, hate, self-harm or illegal activity can be blocked silently ([provider use policy](https://policies.google.com/terms/generative-ai/use-policy)), so soften descriptors and remove explicit cues.
- **Never impersonate a real, identifiable person's voice.**

## 10. Pre-flight checklist

- [ ] `text` contains only spoken words, plus angle-bracket human-sound tags and, in dialogue only, `|backchannels|`.
- [ ] There are no directions, speaker prefixes, square brackets, parentheses-as-directions, Markdown or emoji.
- [ ] Every `style` is empty or a short English phrase about delivery: no age, gender, name, accent, language or meta-instructions.
- [ ] Dialogue has exactly two speakers, every turn has `speaker`, and the names match `speaker_voice_configs`.
- [ ] Every voice is a studio voice from the catalog or an ID copied from `find_voice.py` output (or confirmed with `--check`), and fits its role; two speakers are clearly distinguishable.
- [ ] `language_code` matches the main spoken language; with a library voice, it is exactly that voice's locale, and two library voices share one locale.
- [ ] The total text is at most 6000 characters per call, and longer scripts are split.

## 11. Examples

**A. Neutral narration (no style needed)**

```json
{"voice_name": "Charon", "language_code": "en-US",
 "turns": [{"text": "In 1969, three astronauts left Earth on a journey no one had made before."}]}
```

**B. Emotion with point-in-time tags**

```json
{"voice_name": "Achernar", "language_code": "en-US",
 "turns": [{"text": "Wait... <short pause> did you hear that? <gasp> Someone's at the door.",
            "style": "whispered, nervous"}]}
```

**C. Mid-script emotion shift: split the turns**

```json
{"voice_name": "Kore", "language_code": "en-US",
 "turns": [
   {"text": "Okay. Everything is under control. We just follow the plan.", "style": "calm and reassuring"},
   {"text": "No, no, NO -- the door is open! Run!", "style": "panicked, speaking rapidly"}]}
```

**D. Chinese narration**

```json
{"voice_name": "Sulafat", "language_code": "cmn-CN",
 "turns": [{"text": "欢迎回来。今天我们聊一聊……嗯，怎么在忙碌的一周里，好好休息。", "style": "warm and calm"}]}
```

**E. Mixed Japanese and English**

```json
{"voice_name": "Kore", "language_code": "ja-JP",
 "turns": [{"text": "私たちの新しい製品は強力な AI capabilities を備えており、既存の workflow にシームレスに統合できます。",
            "style": "professional, confident"}]}
```

**F. Two-speaker podcast with backchannels**

```json
{"language_code": "en-US",
 "speaker_voice_configs": [{"speaker": "Maya", "voice_name": "Aoede"}, {"speaker": "Leo", "voice_name": "Puck"}],
 "turns": [
   {"speaker": "Maya", "text": "So the launch is Thursday |oh hmm| Are we actually ready?"},
   {"speaker": "Leo",  "text": "Ready enough |oh really?| The last blocker cleared this morning.", "style": "confident, casual"},
   {"speaker": "Maya", "text": "Then let's ship it |absolutely| and watch the dashboards. <laugh>"}]}
```

**G. Regional accent with a library voice** (ID copied from `find_voice.py --language en-GB --gender female --use-case storyteller --search calm warm`)

```json
{"voice_name": "en-gb-storyteller-3", "language_code": "en-GB",
 "turns": [{"text": "Out on the moor, the wind never really stops. It just changes its mind.", "style": "warm and unhurried"}]}
```

## References

Paths are relative to this skill's directory:

- `references/voice_catalog.md`: the 30 studio voices with gender, pitch and timbre. Read it before choosing a studio voice.
- `scripts/find_voice.py`: searches the library voices, lists the available filter values and checks voice IDs (§5.2).
- `references/voice_library.tsv`: a snapshot of every studio and library voice with its official metadata. Never read it directly; query it with `scripts/find_voice.py`.
- `references/language_catalog.md`: supported languages and BCP-47 codes. Read it before promising a language or setting `language_code`.
