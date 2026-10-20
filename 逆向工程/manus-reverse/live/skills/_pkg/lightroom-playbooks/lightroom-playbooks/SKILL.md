---
name: lightroom-playbooks
description: "Use when the user asks what Manus can do with Lightroom or needs to cull, edit, export, organize metadata, repair, migrate, or learn a Lightroom workflow. Routes each request by retained state among native image tools, file processing, Lightroom Web in My Browser, and O1-gated Lightroom desktop workflows."
---

# Lightroom Playbooks

Decide what state must survive before choosing a product or control surface. A finished image is not the same deliverable as Lightroom catalog or cloud-library state.

## 1. Classify retained state

| Code | State that must survive | Default route |
|---|---|---|
| `S1` | Standalone semantic derivative | Native image generation or refinement, after runtime preflight |
| `S2` | Deterministic standalone file set | Sandbox or authorized Desktop-shared file processing |
| `C1` | Lightroom Classic catalog state | Desktop CU only under an exact current O1 receipt; otherwise `CONDITIONAL-O1` |
| `C2` | Classic-managed sidecars or file metadata | Sandbox for read/copy/validation; Classic writes or lifecycle changes are `CONDITIONAL-O1` |
| `L1` | Cloud Lightroom library state supported on web | Lightroom Web in My Browser after extension, authentication, target-library, and feature preflight |
| `L2` | Cloud Lightroom desktop-only or client-local state | Desktop CU only under an exact current O1 receipt; otherwise `CONDITIONAL-O1` |
| `G1` | Plan, report, decision record, or staged recovery | Guidance plus safe file operations |

Read `formats/route-contract.md` before choosing a route. Read `formats/desktop_runtime.md` before any Lightroom client operation. This package contains no Lightroom O1 receipt, so it cannot by itself authorize or claim completion of a Desktop CU workflow.

## 2. Apply the execution status

- `READY`: the required native or file capability passes a live runtime probe and the output has a deterministic oracle.
- `CONDITIONAL-WEB`: first-party capability evidence exists, but My Browser, login, target library, entitlement, and the exact feature must pass live preflight.
- `CONDITIONAL-O1`: the job needs a real Lightroom desktop state, but the exact OS, app build, fixture, procedure, postcondition, and recovery have not all been observed.
- `GUIDANCE`: Manus can plan, inventory, compare, or prepare, but must not claim the retained app state changed.
- `REFUSE`: the request requires direct catalog writes, fabricated app/cloud state, unreviewed deletion, or another unsafe shortcut.

My Browser is browser control, not Computer Use. Desktop CU is serial. Documentation or an installed app does not count as O1.

## 3. Route the user job

| Job | Card | Possible states | Default route |
|---|---|---|---|
| Select keepers and rejects | 1 | `S2`, `C1`, `L1`, `L2` | File list uses analysis; cloud ratings/flags use My Browser; Classic or desktop-only culling remains `CONDITIONAL-O1` |
| Apply a look or reusable preset | 2 | `S1`, `S2`, `C1`, `L1`, `L2` | Standalone output uses native/file tools; web-supported cloud edits use My Browser; retained desktop preset/history work remains `CONDITIONAL-O1` |
| Export, download, or share | 3 | `S2`, `C1`, `L1`, `L2` | Existing files use Sandbox; web-supported download/share uses My Browser; catalog-aware or desktop-only export remains conditional |
| Find duplicates | 4 | `S2`, `C1` | Byte-identical files use hashes; Classic catalog duplicate state remains `CONDITIONAL-O1` |
| Diagnose slowness or instability | 5 | `G1`, `S2`, `C1`, `L1`, `L2` | Diagnose product and baseline first; change no app setting without an exact reversible O1 procedure |
| Apply metadata or keywords | 6 | `S2`, `C1`, `C2`, `L1`, `L2` | Resolve the exact fields and persistence target before routing |
| Back up or move Lightroom | 7 | `G1`, `S2`, `C1`, `C2`, `L1`, `L2` | Classic local assets and cloud continuity are separate workflows |
| Relink missing originals | 8 | `S2`, `C1`, `C2` | Find identity-checked candidates with file tools; Classic relink remains `CONDITIONAL-O1` |
| Move between Classic and cloud | 9 | `G1`, `S2`, `C1`, `L1`, `L2` | Produce and approve a loss manifest before any one-way migration action |
| Create a derivative or teach a feature | 10 | `S1`, `S2`, `C1`, `L1`, `L2` | Output work and product lessons are separate; choose one client, fixture, postcondition, and recovery |

Read only the reference needed for the selected card:

- Card 1: `references/culling.md`
- Cards 2 and 3: `references/editing-export.md`
- Card 6: `references/metadata-sidecars.md`
- Cards 4, 5, and 8: `references/catalog-care.md`
- Cards 7 and 9: `references/migration-backup.md`
- Card 10: `references/lessons.md`

## 4. Close the workflow

Before execution, state the retained-state code, product/client, route, status, protected objects, approval boundaries, verification assertions, and recovery path. After execution, use `formats/verification-manifest.md`. Never infer Lightroom completion from a generated derivative, copied files, an input event, or first-party documentation.
