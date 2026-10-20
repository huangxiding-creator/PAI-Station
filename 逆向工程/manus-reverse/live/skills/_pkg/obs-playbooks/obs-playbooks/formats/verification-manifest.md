# OBS Verification Manifest

## Common fields

- requested product and durable-state code;
- OBS OS/version/architecture/Profile/Scene Collection when applicable;
- source asset/log/config hashes and inventory;
- selected fixture, recovery point, destination, and collision rule;
- completed, skipped, failed, and review-list items;
- confirmations for secrets, installation, recording, streaming, or publication.

## A1 standalone asset

- signature, dimensions, duration, streams, transparency, loop, audio, and naming as applicable;
- source/provenance and user quality review;
- explicit statement that no OBS state was created.

## H1 hosted overlay

- local deterministic simulation and public deployment checks;
- event-source authorization and secret boundary;
- URL loads without exposing credentials;
- explicit statement that downstream OBS installation remains separate.

## F1 report or blueprint

- exact files/log range and hashes;
- observations separated from hypotheses;
- planned objects/settings and rollback;
- no claim that the plan was applied.

## P1 protocol state

- client/version/source policy and terminal permission;
- secret-input/redaction gate result;
- live version/available-request receipt;
- allowlisted request/response receipts and query-before-retry record;
- semantic read-back, render/screenshot where relevant, and rollback result.

## D1 Desktop state

- current app/OS/version and disposable fixture;
- observed control and before/after value;
- save/reopen or restart persistence where relevant;
- visible render and recovery proof.

## R1 consequential output

- immediate confirmation and exact target;
- selected scene/destination/privacy scope;
- start state, independent read-back, stop state, and output artifact if any;
- no duplicate start and no secret in report.

Never infer installed, rendered, retained, or live state from an upstream artifact or input-dispatch success.
