# CapCut Verification Manifest

## Common fields

- source/draft-copy hashes and media inventory;
- selected route and durable-state code;
- client, version, account, region, and feature visibility when applicable;
- output destination and collision policy;
- completed, skipped, failed, and review counts;
- recovery events and user approvals.

## T0 transcript

- source duration/language;
- real output file/type;
- sampled accuracy;
- timing/speaker support present or absent.

## F1 standalone output

- signatures, streams, dimensions, duration, frame rate, codec, audio, subtitle cues, names, and count;
- protected content and source hashes unchanged where applicable.

## G1 generated or varied clip

- model/runtime parameters;
- MP4 integrity and technical properties;
- user semantic-quality review;
- explicit non-equivalence to deterministic edit or matte.

## M1 Manus scene

- scene identifier/export and user reopen handoff;
- explicit statement that it is not CapCut project state.

## W1 CapCut Web project

- client/account/region/build and visible feature;
- save/reopen proof;
- exact editable caption/timeline/template/effect state promised;
- unsupported or substituted state.

## C1 CapCut Desktop draft

- OS/app/account/region/version;
- copied draft and exact retained timeline objects;
- save/reopen and media-online proof;
- export validation, rollback point, and source unchanged check.

Never infer CapCut state from an exported MP4 alone.
