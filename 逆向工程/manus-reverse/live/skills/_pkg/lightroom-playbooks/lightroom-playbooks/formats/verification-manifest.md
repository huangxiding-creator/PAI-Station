# Verification Manifest

Report the fields that apply to the selected route.

```yaml
job: string
state_code: S1 | S2 | C1 | C2 | L1 | L2 | G1
route: string
status: string
environment:
  os: string | not-applicable
  client: string | not-applicable
  version: string | unobserved
  account_or_catalog: string | not-applicable
  authorized_root: string | not-applicable
scope:
  expected_items: integer | unknown
  processed_items: integer
protected_objects:
  - object: string
    before_proof: string
    after_proof: string
approvals: []
assertions:
  - name: string
    expected: string
    observed: string
    result: pass | fail | blocked
unresolved: []
recovery: string
o1_receipt: none | exact_receipt_identifier
```

## Channel-specific proof

- **Native output:** separate artifact, dimensions or duration, requested content, and no Lightroom-state claim.
- **Sandbox output:** complete inventory, names, signatures, dimensions or formats, isolated destination, and protected-source hashes where relevant.
- **My Browser:** browser route, authentication, exact library/album/photo, live feature preflight, semantic state after reload, and permission revocation when sharing was tested.
- **Desktop CU:** exact O1 receipt, observed start state, semantic re-observation after mutation, affected count, recovery, and one finish event.
- **Guidance:** decision record, inventories, unresolved gates, and explicit statement that no app state changed.

Never report `pass` for a retained app state that was inferred from files, documentation, or input dispatch alone.
