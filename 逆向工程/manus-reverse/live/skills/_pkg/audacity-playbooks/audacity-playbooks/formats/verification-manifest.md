# Audacity Verification Manifest

## Common fields

- source and working-copy identities and hashes;
- provenance and rights constraints;
- selected route and truth label;
- current file runtime, Audacity version, Macro/module/plug-in state, OS, and Computer Use state;
- expected source, project, and output identities;
- technical requirements and listening/A/B acceptance rule;
- completed, skipped, failed, and review counts;
- approvals, recovery events, and remaining human review.

## F0 portable result

- file signature, container, channels, sample rate, sample width or codec, duration, and names as supported by the probed verifier;
- exact expected versus actual file set;
- source hashes unchanged;
- explicit statement that no Audacity project state or listening approval was created.

## M1 reproduced automation

- exact Audacity build and Macro/script/module identity;
- command chain, parameters, input/output hashes, logs or receipts, and failure result;
- save/reopen proof for promised project state;
- output-manifest reconciliation before retry.

## P1 project, recording, or listening state

- working project path and source-preservation proof;
- required tracks, labels, selections, effects, plug-ins, devices, links, and output settings;
- representative A/B or listening decision and exception list;
- save, close, reopen, media-online, and export proof.

Never infer sound quality from a technical metric alone, and never infer editable Audacity state from a flat audio export.
