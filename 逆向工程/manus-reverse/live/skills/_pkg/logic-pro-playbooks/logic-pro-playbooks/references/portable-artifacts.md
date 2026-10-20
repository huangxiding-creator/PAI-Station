# Portable audio and MIDI lane

Load this reference for LP1, LP2, LP4, or LP5 when the requested result can remain outside Logic.

## Input contract

Before processing, record:

- which files are user-owned, licensed, or synthetic;
- the authorized input and output locations visible to the current runtime;
- whether the user needs a finished portable artifact or editable Logic state;
- expected sample rate, channels, duration, tempo, meter, naming, order, and delivery format where known;
- listening decisions that cannot be reduced to file metadata.

Do not describe a Desktop-mounted file as host execution. If the active session exposes the file only through a mounted Sandbox path, all commands run in the Sandbox.

## Structural inspection

Run:

```text
python scripts/inspect_wav_midi.py INPUT... --output portable-qa.json
```

The inspector is read-only. It reports hashes and structural WAV/MIDI metadata. It does not prove musical quality, timing feel, clean edits, loudness compliance, absence of clipping, or Logic compatibility.

For an unseen route-pair check, compare a second fixture with different sample rate, tempo, meter, and notes. Never reuse the first fixture's expected values as defaults.

## Portable transform boundary

- Detect the actual Sandbox audio tools before proposing a transform. This package does not promise a particular codec or processing binary.
- Write a new output; preserve the source.
- Keep a change manifest with input hashes, requested edits, actual tool and command family, output hash, metadata, and listening status.
- If the required transform is unavailable, produce a precise processing or edit specification instead of claiming an output.
- For music generation, inspect the active runtime first. A code-defined capability that is absent from the session is unavailable.

## Listening gate

Metadata is never enough for an audio completion claim. Listen to the whole short fixture or, for longer material, all edit boundaries plus representative quiet, dense, opening, and ending sections. When the user's requested quality depends on taste, ask for or preserve an explicit acceptance decision.

## Portable completion report

Report:

- input and output filenames and hashes;
- actual runtime and tool lane;
- format, channels, sample rate, frames or duration, and MIDI structure where applicable;
- edits requested and edits actually performed;
- listening coverage and unresolved subjective decisions;
- whether any Logic-native state was created. The answer is `no` unless a separately verified L1 run occurred.

