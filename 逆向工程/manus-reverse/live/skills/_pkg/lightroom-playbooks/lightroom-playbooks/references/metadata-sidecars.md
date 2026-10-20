# Card 6: Metadata, Keywords, and Sidecars

- **Primary channel:** Use Sandbox for proven standalone metadata round trips and observed-sidecar inspection; use My Browser for observed web-supported cloud fields; use Desktop CU for Classic catalog or sidecar lifecycle writes and verified cloud-desktop-only fields under exact O1.
- **Escalation trigger:** Escalate when the requested field must persist in a Lightroom catalog, cloud library, keyword hierarchy, or Classic-managed sidecar lifecycle rather than only in a standalone file.
- **Hybrid handoff:** Prepare and validate controlled values outside Lightroom, apply them through the authoritative product surface, then inspect only the resulting supported file artifacts.
- **Verification:** Reconcile every requested field and item, persistence target, hierarchy, sidecar inventory, reload persistence, and protected-source hashes where promised.

Metadata is not one state. Resolve the exact field and persistence target first.

| Target | State | Route | Status |
|---|---|---|---|
| Standalone file metadata outside Lightroom | `S2` | Sandbox metadata tooling | `READY` only after format and field round-trip tests |
| Classic catalog-only fields or keyword hierarchy | `C1` | Lightroom Classic through Desktop CU | `CONDITIONAL-O1` |
| Classic-supported write-to-file or sidecar creation/synchronization | `C2` | Classic for writes; Sandbox for inspection and validation | Classic mutation is `CONDITIONAL-O1` |
| Web-supported cloud ratings, flags, albums, or other observed fields | `L1` | My Browser | `CONDITIONAL-WEB`, field by field |
| Cloud desktop-only metadata field or local client behavior | `L2` | Cloud Lightroom desktop through Desktop CU | `CONDITIONAL-O1` |

## Input contract

- exact fields and values;
- hierarchy or controlled vocabulary;
- selected photo scope and expected count;
- catalog-only, cloud-library, standalone-file, or Classic-managed sidecar persistence;
- file format and round-trip requirements;
- whether source files or sidecars may change.

## Safety and verification

- Never write directly to `.lrcat`.
- Do not synthesize a Lightroom-emitted sidecar schema from an authored sample.
- Use supported Classic behavior for sidecar creation and lifecycle until a schema-safe writer has separate evidence.
- File tools may parse, hash, copy, and compare observed sidecars.
- Verify every field, affected count, hierarchy, catalog/file distinction, sidecar inventory, original hashes where promised, and persistence after reload.

Metadata-to-file and sidecar lifecycle are explicit per-batch approval boundaries.
