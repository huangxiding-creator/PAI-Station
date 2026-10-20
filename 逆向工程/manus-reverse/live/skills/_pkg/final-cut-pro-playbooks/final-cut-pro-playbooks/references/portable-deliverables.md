# Portable deliverables

Use this reference only when the user does not require editable Final Cut state.

## C01 — Portable review or delivery media

- **Outcome:** Produce a portable review or delivery file without claiming a Final Cut project.
- **Primary:** A Manus-native video editor only when the exact current-session tool is exposed and accepts the inputs.
- **Escalation:** The user requires Final Cut editability, an unsupported codec or effect, or rendering from an existing Final Cut timeline.
- **Hybrid:** Complete the portable edit in an exposed native tool, then hand the approved result or cut plan to C03 only if Final Cut state becomes necessary.
- **Fallback:** Deliver a cut decision list, media inventory, and verification plan. Use an authorized file tool only after detecting it; do not promise a render from code presence alone.
- **Verification:** Confirm the output exists and decodes, matches the declared dimensions, duration, and audio expectations, and leaves source hashes unchanged. Keep creative review separate from technical checks.
- **Computer Use reason:** None. A portable media artifact does not require Final Cut.
- **Current status:** Routing is fixture-tested; native media behavior and target-session tool exposure are not.

### Execution contract

1. Ask whether a portable file is sufficient and capture the output specification and creative reference.
2. Detect a real current-session editor or authorized media tool before selecting it.
3. Work on copies and write to a new output path.
4. Verify the file technically and ask for human review of pacing, shot choice, titles, and audio treatment.
5. If no execution tool is exposed, return the decision list and mark the render blocked.

## C06 — Portable timed text

- **Outcome:** Create or validate a portable timed-text file without claiming Final Cut-native captions.
- **Primary:** Sandbox file work.
- **Escalation:** Captions must remain editable in Final Cut, the only source is inaccessible inside a library, or a requested burn-in lacks an authorized render tool.
- **Hybrid:** Prepare and verify the sidecar in the sandbox; treat any later Final Cut import as a separate live-blocked handoff.
- **Fallback:** Return a reviewed timestamped transcript and state that no sidecar or render was completed.
- **Verification:** Check cue structure, numbering, timestamp shape, minute/second fields within `00–59`, ordering, overlaps, and expected text. Media alignment requires a separate media-aware run.
- **Computer Use reason:** None for the portable sidecar. Computer Use would matter only for later Final Cut-native caption state.
- **Current status:** SRT-style syntax, clock-field-range, and overlap preflight are locally reproduced; burn-in and Final Cut import are not.

### Execution contract

1. Confirm sidecar, burn-in, or editable-app state before work.
2. Create or revise the timed text as a new file.
3. Run `scripts/preflight_srt.py` on the candidate file; a matching timestamp line still fails if either minute or second field is outside `00–59`.
4. Resolve reported structural or timing issues; keep language, line-break, and reading-speed judgment explicit.
5. Report the artifact scope and never imply that Final Cut imported it.
