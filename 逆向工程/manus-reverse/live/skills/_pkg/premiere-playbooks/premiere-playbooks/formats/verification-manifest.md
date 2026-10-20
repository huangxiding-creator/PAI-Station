# Premiere Verification Manifest

## Common fields

- source/project-copy hashes;
- media and dependency inventory;
- selected sequence or standalone inputs;
- route and durable-state code;
- output destinations and collision policy;
- completed, skipped, failed, and review counts;
- recovery events and user approvals.

## T0 transcript

- source duration and language;
- output file/type;
- sampled text accuracy;
- explicit timing/speaker capability present or absent.

## F1 standalone output

- file signatures, streams, dimensions, duration, frame rate, codec, audio, and subtitle-cue assertions;
- expected versus actual count and names;
- source hashes unchanged.

## G1 generated or varied clip

- model parameters and runtime result;
- MP4 integrity and technical properties;
- user semantic-quality review;
- no claim of deterministic edit equivalence.

## M1 Manus scene

- scene identifier and export;
- user reopen/edit handoff proof;
- explicit statement that it is not Premiere project state.

## P1 Premiere state

- OS/app version and project-copy path;
- exact sequence/caption/proxy/effect/recovery state promised;
- save/reopen proof and media-online checks;
- authoritative export validation when requested;
- rollback point and original-project unchanged check.

Never infer retained Premiere state from an exported MP4 alone.
