# Scripter source preparation

Load this reference for LP7.

Logic Scripter uses JavaScript to process or generate MIDI events inside Logic. JavaScript source can be prepared outside the app, but Logic owns execution, audition, preset or patch state, project persistence, and final compatibility.

## Supported deterministic template

This package includes one bounded source generator: note transposition from -24 to +24 semitones with MIDI pitches clamped to 0 through 127. It passes non-note events through unchanged.

Run:

```text
python scripts/prepare_scripter_transpose.py --semitones 12 --notes 60,64,67,72 --output transpose.js --oracle transpose-oracle.json
```

The result is source preparation only. It does not prove that the script loads, runs, avoids stuck notes, sounds useful, or persists in Logic.

## Authoring contract

For any requested Scripter behavior:

1. define exact event types, parameter names and bounds, input vectors, expected output vectors, pass-through behavior, and failure limits;
2. keep source and oracle files together;
3. reject invented Logic APIs or unexplained global state;
4. use a protected synthetic test project for future execution;
5. stop on exceptions, runaway output, missing note-offs, unexpected controllers, or audible instability;
6. require save/reopen and a repeated vector before claiming persistence.

When a request exceeds the evidenced transpose template, provide a source specification or clearly provisional code for later O1 testing. Do not present provisional code as verified Logic behavior.

## Objective postconditions

The source-preparation lane is complete only when:

- the requested semitone value is within the declared bound;
- the generated source contains the chosen default;
- the oracle records exact input and clamped output notes;
- the files are valid UTF-8 and have recorded hashes;
- the completion report says Logic execution and persistence were not tested.

