# Conditional Power BI Desktop Bridge

Use this reference only for a Windows-local status, open, reload, or screenshot handoff. The bridge is an official upstream preview surface. This package does not establish that its client is installed, exposed to Manus, or reproduced on the target host.

## Admission gate

Proceed only when the current session proves:

- an authorized host-local execution route;
- the exact running Power BI Desktop process and intended file;
- the official bridge client or CLI identity and version;
- a live manifest containing the required method;
- current path and unsaved-change state;
- a copied disposable project and rollback;
- serial execution with a machine-readable result.

If any item is absent, mark the branch `not run` and return the file-level artifact, verification specification, or user handoff.

## Bounded uses

- inspect application state before choosing a file or process;
- open an intended copied project when the client and method are qualified;
- reload supported project changes from disk;
- capture one or all report-page screenshots for a separate visual review.

The bridge does not author project source, define DAX or model semantics, edit the report canvas, perform Power Query work, replay interactions, publish, or govern Service state. A Microsoft authoring plug-in or skill is a separate installed product and must be detected independently.

## Verification

Keep these receipts separate:

1. source diff and source-level validation;
2. live bridge manifest and application-state read;
3. reload or open response;
4. screenshot file and page identity;
5. model-aware calculation checks, if a qualified model route exists;
6. human or accessible rendered review;
7. unresolved interaction, refresh, save, or reopen checks.

Never turn a screenshot into a claim about accessibility, interaction, calculation, refresh, or persistence. Never reload over unsaved or ambiguous user work.
