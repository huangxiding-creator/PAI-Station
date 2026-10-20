# Verification contracts

## Portable standards SVG

- XML parses and the root is SVG.
- Width, height, viewBox, namespace, ID, reference, and blocked-element checks pass.
- The output render matches the source under the declared renderer and target size.
- The report says `illustrator_state_claim: false`.

## Variable-data preflight

- Required headers are present.
- Input count, unique-ID count, ready rows, and rejected rows reconcile.
- Duplicate IDs, missing required values, escaped paths, and missing assets are isolated by row.
- Long, Unicode, bidirectional, and optional-empty cases remain in the later visual pilot.
- The report says `illustrator_binding_claim: false` until a real binding and pilot pass.

## Export plan

- Requested artboards or assets, formats, scales, names, and destination are explicit.
- Expected count is derived before execution.
- Collisions stop or follow the separately approved policy.
- Every produced file opens and matches expected dimensions.
- An export specification is not an executed export.

## File and package inventory

- Every listed file has a relative path, byte count, and content hash.
- Same-name candidates with different hashes remain ambiguous.
- Font license status and unresolved assets are reported, not guessed.
- The report says `illustrator_package_claim: false` until Illustrator Package and save-reopen pass.

## App-native state

- Name the observed OS, app edition/version, document copy, and exact live-tested subflow.
- Verify the saved object state after reopen, not merely input dispatch or a derivative preview.
- Web and Desktop require separate evidence.
- If live evidence is absent, report the app tail as blocked and do not imply completion.
