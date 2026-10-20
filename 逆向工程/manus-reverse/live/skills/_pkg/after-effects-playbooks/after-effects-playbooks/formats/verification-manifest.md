# After Effects Verification Manifest

## Common fields

- source and working-copy hashes;
- app/version, OS, account, fonts, plug-ins, codecs, and companion-app inventory;
- selected route and retained-state code;
- composition, placeholder, locale, asset, and output manifests;
- collision policy, completed, skipped, failed, and review counts;
- approvals, recovery events, and remaining human review.

## F0 files or flat output

- file signatures, dimensions, duration, frame rate, codec, color/alpha, audio, and names;
- exact expected versus actual file set;
- source hashes unchanged;
- explicit statement that no editable After Effects state was created.

## A1 reproduced automation

- exact app and executable/control version;
- script or data hash, parameters, logs, exit status, and per-item receipts;
- save/reopen proof for any promised project state;
- query-before-retry or output-manifest reconciliation.

## P1 project state

- working project path and source-preservation proof;
- required compositions, layers, expressions, placeholders, footage, fonts, effects, plug-ins, and data bindings;
- representative visual checks and exception list;
- save, close, reopen, media-online, and render proof.

Never infer editable state from a rendered MP4 or image sequence alone.
