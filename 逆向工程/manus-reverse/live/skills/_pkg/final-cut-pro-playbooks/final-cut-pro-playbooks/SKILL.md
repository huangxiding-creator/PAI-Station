---
name: final-cut-pro-playbooks
description: "Use when the user asks what Manus can do with Final Cut Pro or needs Final Cut workflows routed among portable media or captions, FCPXML interchange, and editable app-native state, using Manus-native or file routes when sufficient and Computer Use only after current-build verification."
---

# Final Cut Pro playbooks

Route the request by the state the user must retain. A portable media file, a timed-text sidecar, an FCPXML handoff, and an editable Final Cut library or timeline are different deliverables.

## Current qualification boundary

This package is source-valid but Final Cut behavior is live-blocked. It has no current-build observation of Final Cut Pro, no app-specific Computer Use proof, and no verified import, render, relink, caption, multicam, or recovery path.

- Do not present an exact Final Cut UI procedure.
- Do not operate Final Cut or claim app-native completion until a later package revision records current-build live evidence for that card.
- A successful FCPXML preflight does not prove that Final Cut accepts the file or preserves project state.
- My Browser is not a Final Cut editing route.
- An upstream app API, extension, or community tool is not a Manus runtime capability unless the current session exposes and qualifies it.

## Route by retained state

| User needs | Route now | Card family |
|---|---|---|
| Portable review or delivery media, with no Final Cut editability | Use a Manus-native video tool only when the current session exposes it; otherwise return a bounded edit plan or an authorized file-tool handoff | C01 |
| Portable timed text | Use sandbox file work and the included SRT preflight | C06 |
| FCPXML syntax or internal-reference validation | Use sandbox file work and the included FCPXML preflight; report Final Cut acceptance as untested | C10 |
| Candidate FCPXML or metadata handoff that must become editable in Final Cut | Prepare and preflight the artifact; stop before the live app tail | C03, C07 |
| Multicam, editable native captions, media relinking, or an authoritative Final Cut render | Preserve the native-state requirement and return a live-blocked handoff plan | C04, C05, C08, C09 |

First ask whether the user needs only a portable result or state that remains editable in Final Cut. Also detect the current session's actual tools, mounted-file reachability, authorized host-terminal scope, installed app identity, and requested destination. Do not infer availability from product documentation.

## Load only the relevant workflow family

- For portable media and timed text, read [references/portable-deliverables.md](references/portable-deliverables.md).
- For FCPXML, structured handoff, and metadata, read [references/interchange-and-metadata.md](references/interchange-and-metadata.md).
- For multicam, native captions, relinking, and authoritative exports, read [references/native-state-handoffs.md](references/native-state-handoffs.md).

Every admitted card states its primary route, escalation trigger, hybrid handoff, fallback, verification, and app-specific Computer Use reason.

## Verification gate

Keep artifact and app-state results separate. Report each as one of:

- verified portable artifact;
- preflight passed, Final Cut acceptance not tested;
- native-state handoff blocked pending current-build live qualification;
- failed, with the exact observable check that failed.

Never treat a dialog, file extension, parse result, or flattened render as proof of an editable Final Cut project.

## Safety boundary

Preserve source media and the authoritative library. Do not edit a library database directly. Import, relink, render submission, overwrite, install, permission, upload, and publication require the user's immediate task-specific approval when they become executable.
