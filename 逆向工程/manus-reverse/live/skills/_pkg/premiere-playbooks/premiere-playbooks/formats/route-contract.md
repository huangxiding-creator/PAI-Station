# Premiere Route Contract

## Route precedence

1. Preserve an explicit Premiere or project-state request.
2. Name the durable-state class: T0, F1, G1, M1, or P1.
3. Probe the required runtime, file path, app, account, and version.
4. Choose the least fragile route that preserves the accepted product.
5. State the route and completion truth label before mutation.
6. Escalate only for required retained Premiere state, observed file-route failure, or explicit in-app teaching.

## Truth labels

| State | Completion label | Must not be called |
|---|---|---|
| T0 | Standalone transcript with named timing/speaker properties | SRT or Premiere captions unless those objects exist |
| F1 | Standalone media/subtitle file set | Premiere sequence, attached proxy, or editable effect state |
| G1 | New or semantically varied short MP4 | Deterministic edit or Premiere project |
| M1 | Manus Video Editor scene available for user editing | Agent-edited Premiere project or CapCut draft |
| P1 | Premiere project state with named retained objects | Complete merely because an export succeeded |

## Material questions

- Does the user need text, subtitle files, a burned-in video, or an editable Premiere caption track?
- Is an approved master already available, or must the authoritative sequence render?
- Does the user need a Premiere project, or only an output file?
- Which project state must survive: edits, captions, proxies, media links, effects, Lumetri, recovery version, or plugins?
- Is the goal completion, recovery, reusable project state, or learning?

Ask only when the answer changes the route or acceptance oracle.

## Route-change record

Record the original route, observed limitation, new durable-state requirement, added risk/setup, and revised verification oracle whenever a workflow escalates.
