# Presentation Desktop Runtime

Read this file only after the route requires application-native presentation state.

Do not use this runtime for PowerPoint for web. Authenticated browser state routes through My Browser after its connector and online-client preflight.

In this package, **O1** means a live-observed operation on a named OS, PowerPoint edition/version, and fixture, with captured starting state, actions, result, and postcondition. Documentation or source code alone is not O1.

## Preflight

1. Confirm the exact target app: Microsoft PowerPoint, WPS Presentation, or LibreOffice Impress. File compatibility alone is insufficient.
2. Record OS, product/distribution/edition/version, foreground/background constraints, and the actual default application for `.pptx` or `.odp` when delivery depends on it.
3. Confirm that the target is a disposable fixture or a dated working copy. Never begin a CU procedure on the sole original.
4. Open the copy explicitly in the selected presentation app; do not rely on the default file association.
5. Inspect the current window and semantic controls before choosing a path. Ribbon names, dialogs, licensing, policy, add-ins, and protected-view state vary.
6. Confirm that the selected card already has a current O1 operation record for this OS, exact product/distribution/version, fixture, and postcondition. Otherwise stop at guidance or a blocked app-state branch.

If the selected app is absent, retain the Slides, inspection, file-edit, and conversion routes. Mark only that app-state branch blocked. Never transfer a PowerPoint record to WPS Presentation or Impress.

## CU execution contract

For each app operation, record:

- the exact fixture and starting state;
- the OS, exact product/distribution/version, and window title;
- semantic controls or labels used, not fixed coordinates;
- the expected app-native state after the operation;
- a visible or file-level postcondition;
- cancellation, save-copy, and recovery behavior.

Do not use a remembered menu path as an instruction. Detect the current UI or provide guidance until a live operation record exists.

## Validation

Reopen the saved copy in the selected app and inspect the representative slides that contain the changed feature. If cross-suite compatibility is the outcome, reopen it in the recipient app as well. For masters, verify inheritance on multiple layout types. For animation or media, play the slideshow. For merge or reorder, compare title/order manifests. For export, compare page count and visual samples. For repair, report losses item by item.

Do not treat “the file library opened it” or “the ZIP is valid” as proof that PowerPoint, WPS Presentation, or Impress will open and render it correctly.

## Cross-platform rule

A successful macOS record does not certify Windows, and a successful Windows record does not certify macOS. Keep the workflow card shared, but keep operation records and failure branches platform-specific.
