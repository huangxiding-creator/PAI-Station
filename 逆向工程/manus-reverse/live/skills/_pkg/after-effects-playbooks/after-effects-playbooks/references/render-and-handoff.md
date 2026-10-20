# Render and Handoff Operations

Use these operations only as support for an accepted template or variant workflow. They are not proof of demand by themselves.

## Rendering

- Build a composition-to-output manifest before submitting work.
- Prefer a reproduced app-native or command-line render route for repeatable items.
- Use P1 only when queue templates, companion encoder state, plug-ins, project warnings, or UI-only diagnosis must be inspected.
- Use unique destinations and preserve logs. Observe current job state before retrying.
- Validate every output independently for file signature, dimensions, duration, frame rate, codec, color/alpha, audio, expected count, and representative playback.

## Project collection and handoff

- First inventory project, footage, data, fonts, effects, plug-ins, proxies, codecs, and licenses.
- A project collection procedure may copy the project and linked footage, but it does not guarantee that fonts, plug-ins, licenses, external data, or the recipient environment are complete.
- Preserve a collected-project report and source hashes.
- The acceptance test is a reopen and representative render from the collected location in a recipient-like environment, not the presence of a folder.

## Failure handling

- Do not clear caches, replace missing effects, change render settings, or relink assets without a named hypothesis and rollback point.
- Keep partial renders and reconcile their identities before retrying.
- Report unresolved fonts, effects, plug-ins, codecs, links, data sources, and language review as explicit handoff blockers.
