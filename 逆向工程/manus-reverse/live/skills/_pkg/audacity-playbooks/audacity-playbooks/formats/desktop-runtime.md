# Audacity Runtime Preflight

## Portable files

- Confirm each source is attached, generated, or visible inside the authorized shared path.
- Record source identities and create a distinct working copy before processing.
- Probe the current environment for the exact audio executable, codec, filter, and permission required by the proposed operation.
- Treat a sandbox shell, authorized host terminal, shared-file bridge, and app-local automation as separate surfaces.
- Use `scripts/inspect_wav.py` only for uncompressed WAV headers and checksums.

## Audacity automation

- Treat Macros, scripting commands, plug-ins, and experimental modules as app-native candidates, not Manus connectors.
- Detect the installed Audacity build and the exact available Macro/module state.
- Reproduce the smallest disposable case and capture command or Macro identity, parameters, source/output hashes, failure behavior, recovery boundary, and save/reopen result.
- Promote only observed atoms. Do not infer that one fixed chain is safe for heterogeneous files.
- Never assume an experimental external scripting module ships with the app.

## Audacity through Computer Use

- Resolve the app identity, version, window, project, and current task from fresh live state.
- Confirm helper readiness and the exclusive Computer Use lease.
- Observe current tracks, selection, project state, warnings, devices, and output destination before acting.
- A first-party guide is a candidate map until the exact product, OS, version, fixture, and retained state pass live replay.
- Re-observe after meaningful changes. An input event, visual movement, or export dialog is not proof of saved project state or acceptable sound.
- Use bounded state-based waits; never submit an already-running export or effect again.
- Save under a distinct name, close, reopen, and inspect promised track, label, effect, and project state.
- Finish the Computer Use session exactly once after final verification.

## Parallelism

Independent source inventory, checksum work, manifest preparation, and output inspection may run in parallel on separate copies. All Audacity Computer Use steps are serial.
