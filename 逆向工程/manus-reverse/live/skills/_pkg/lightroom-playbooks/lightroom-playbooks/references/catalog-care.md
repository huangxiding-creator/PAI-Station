# Cards 4, 5, and 8: Catalog Care and Recovery

## Card 4: Duplicate management

- **Primary channel:** Use Sandbox hashes for standalone exact duplicates and Lightroom Classic through Desktop CU for catalog duplicate state under exact O1.
- **Escalation trigger:** Escalate from a file report only when catalog membership, stacks, edits, or a Classic review state must be preserved.
- **Hybrid handoff:** Generate an identity-backed candidate report with file tools, then review or apply only the catalog-specific decision in Classic.
- **Verification:** Record the detection basis, candidate groups, keeper policy, review state, and zero deletions before itemized approval.

| Job | State | Route | Status |
|---|---|---|---|
| Find byte-identical standalone files | `S2` | Sandbox hashes | `READY` with exact-hash oracle |
| Find exact duplicate image data in a Classic catalog | `C1` | Current Classic duplicate feature through Desktop CU | `CONDITIONAL-O1` |
| Find perceptually similar but non-identical photos | `G1` or `S2` | Candidate analysis and review report | Do not call these exact duplicates |

Keep detection basis, candidate groups, keeper policy, and deletion approval separate. Build a review collection or report first. Stop before deletion until the user approves the itemized set.

## Card 5: Performance rescue

- **Primary channel:** Begin with guidance and authorized file inventory; use Desktop CU only for one exact reversible in-app change under current O1.
- **Escalation trigger:** Escalate after the product, version, reproducible symptom, baseline, backup, and one evidence-backed causal hypothesis are established.
- **Hybrid handoff:** Measure and inventory outside the app, apply one supported client change, then repeat the identical benchmark and preserve rollback evidence.
- **Verification:** Report the old value, new value, before/after measurement, outcome, unchanged protected objects, and rollback result.

Diagnose before changing settings:

1. Identify Classic, cloud desktop, or web and capture version and account/catalog context.
2. Define one reproducible slow or failing action and measure a baseline.
3. Verify a usable backup for Classic catalog actions.
4. Form one evidence-backed hypothesis.
5. Change one reversible variable only under an exact O1 procedure.
6. Repeat the same measurement and record old value, new value, outcome, and rollback.

File tools may inventory authorized files, sizes, manifests, and checksums. They do not provide arbitrary full-disk inspection. Do not run a generic cache, preview, GPU, sync, and catalog checklist or promise an improvement.

## Card 8: Missing Classic originals

- **Primary channel:** Use Sandbox to locate and identity-check candidate originals; use Lightroom Classic through Desktop CU for the relink itself under exact O1.
- **Escalation trigger:** Escalate only after a candidate matches available identity evidence and the required original or drive is accessible.
- **Hybrid handoff:** Produce a read-only candidate mapping first, then relink approved rows in Classic while leaving ambiguous rows blocked.
- **Verification:** Re-observe the missing count, representative thumbnails or editing access, preserved edits, unresolved rows, and the wrong-file negative case.

This is a Classic catalog-link workflow, not a generic cloud-sync workflow.

1. Build a read-only candidate report from authorized local files.
2. Compare path, filename, dimensions, signatures, capture metadata, and other available identity evidence.
3. Treat same-name but different-content files as a negative case.
4. Relink only through supported Classic behavior under an exact O1 receipt.
5. Re-observe thumbnails or editing access, preserved edits, and the remaining missing count.

Do not broad-remap uncertain candidates. Leave absent drives and unresolved identities explicitly blocked.
