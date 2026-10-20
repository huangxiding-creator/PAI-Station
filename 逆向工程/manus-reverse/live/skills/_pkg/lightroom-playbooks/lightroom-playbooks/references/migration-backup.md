# Cards 7 and 9: Backup, Move, and Migration

## Card 7: Backup or move Lightroom

- **Primary channel:** Use guidance plus Sandbox inventory/copy/checksum for authorized Classic assets, My Browser for web-visible cloud continuity checks, and Desktop CU only for client-open, relink, sync, or desktop-only validation under exact O1.
- **Escalation trigger:** Escalate after product identity, authoritative asset inventory, destination, backup policy, and representative retained-state assertions are explicit.
- **Hybrid handoff:** Copy and checksum authorized files outside Lightroom, then open or reconcile the moved state in the exact client without retiring the source.
- **Verification:** Prove copied inventory and hashes, successful client access, representative edits/ratings/links/presets or cloud state, unresolved assets, and source retention.

### Lightroom Classic

Inventory catalog, originals, Classic-managed sidecars, presets, plugins, and preview policy. Copy only authorized paths, checksum the copy, retain the source, and treat successful catalog open, representative edits, ratings, links, presets, and plugin compatibility as separate future O1 assertions. A copied file set is not proof that the catalog is usable.

### Cloud Lightroom

Do not apply the Classic local-catalog model. Verify account identity, cloud storage, synchronization state, expected library count, representative edits and ratings, local-original policy, and client readiness. Use My Browser for web-visible `L1` checks; use cloud desktop only for an exact desktop-only or explicit-client step under O1.

## Card 9: Classic-to-cloud migration

- **Primary channel:** Use guidance and a loss manifest first; use Desktop CU only for an approved disposable migration on exact clients and versions under O1.
- **Escalation trigger:** Escalate only after backup-open proof, storage headroom, direction, upload scope, documented losses, and source-retention acceptance all pass.
- **Hybrid handoff:** Build and approve inventories outside the app, run the one-way migration in the supported client, then reconcile cloud items and retained source state.
- **Verification:** Reconcile item, edit, metadata, organization, error, and storage outcomes; keep the source intact and never infer a symmetric reverse migration.

Treat migration as one-way, high-consequence, and guidance-first. Do not imply a symmetric automatic cloud-to-Classic migration.

Before execution, produce and obtain acceptance for a loss and transformation manifest covering applicable items such as snapshots, custom metadata, books or slideshows, print or web creations, shares, map locations, folder hierarchy, Smart Collections, edit history, color labels, and full-resolution upload/storage consequences.

Required gates:

1. Source catalog and product direction are explicit.
2. A supported backup opens and representative state is verified.
3. Cloud storage headroom and expected upload scope are known.
4. Losses and transformations are accepted.
5. A disposable migration O1 exists for the exact clients and versions.
6. Source remains intact until item, edit, metadata, organization, and error reconciliation passes.

Without all gates, provide the plan and inventory only. Do not start migration or claim completion.
