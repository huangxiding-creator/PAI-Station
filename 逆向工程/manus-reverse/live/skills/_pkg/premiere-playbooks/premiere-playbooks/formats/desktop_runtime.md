# Premiere Runtime Preflight

## Speech-to-text

- Probe the active speech-to-text command or tool before promising output shape.
- Record exit status, created files, and whether the result includes timestamps or speakers.
- Plain transcript output must not be promoted to SRT, VTT, or an editable Premiere caption track.

## Deterministic media processing

- Confirm inputs are attached, retrieved, or inside the authorized Desktop shared folder.
- Probe `ffmpeg`, `ffprobe`, and every material codec/filter in the active Sandbox.
- Shared-file visibility, Sandbox shell execution, and host terminal authority are separate permissions. Do not run a host command merely because a file is visible.
- Validate every output technically and copy it back to the intended shared destination when required.

## Manus video surfaces

- Treat video generation and semantic variation as short flattened-output tools with runtime-specific model, duration, aspect, resolution, quota, and quality gates.
- Semantic variation is not deterministic trim, crop, captioning, keying, or grading.
- Manus Video Editor retains a Manus scene and exports MP4, but checked code does not establish an agent timeline-control interface or conversion to a Premiere project.

## Premiere through Computer Use

- Resolve the installed app/version and project owner from live state; do not hard-code an application path.
- Confirm the CU helper is ready and the lease is free.
- Preserve the project and recovery tree before opening; use a disposable or dated working copy.
- Observe current controls and state. First-party procedures are candidate maps until the exact app/OS/version path has passed a live fixture.
- Use typed timecodes and semantic controls when available, but never freeze coordinates or stale element handles.
- Re-observe after every meaningful mutation. Input dispatch is not proof of sequence state.
- Use state-based bounded waits for transcription, proxy, render, and export. Do not click a running job again.
- Finish the CU session exactly once after final verification.

## Integration boundary

Premiere has extension surfaces, but no Manus-accessible supported timeline integration was found in the checked code snapshot. Do not turn that scoped finding into a universal “Premiere has no API” claim.

## Parallelism

Independent transcript, file, route, and media-probe tests may run in parallel on separate assets. Premiere CU tests are serial.
