# Lightroom Runtime Boundary

## Product and client identities

Treat these as different retained-state systems:

- **Lightroom Classic** owns local catalog state such as catalog membership, collections, flags, ratings, color labels, edit history, presets, missing-file links, and catalog-aware export configuration.
- **Classic-managed sidecars** are file-adjacent state whose creation, synchronization, rename, move, and delete lifecycle is controlled by supported Classic behavior. File tools may inspect, copy, hash, and validate observed sidecars; they do not imitate an unproven Lightroom writer.
- **Cloud Lightroom library** owns synchronized cloud photos, albums, ratings, flags, supported edits, masks, shares, and downloads across clients.
- **Cloud Lightroom desktop state** covers a feature or client-local condition that is not satisfied by the web surface, such as a currently verified desktop-only feature or local desktop sync/cache state. Do not classify ordinary cloud ratings or edits as `L2` merely because the desktop client is open.
- **Standalone derivatives** are ordinary files. They do not prove membership, history, presets, albums, ratings, or any other Lightroom state.

If the user says only “Lightroom,” inspect available clients and ask one question only when the retained state or consequence changes. Do not infer installation, subscription, authentication, catalog identity, or feature presence from product availability.

## Route preflight

### Native or Sandbox

1. Confirm whether the operation is semantic or deterministic.
2. Confirm the source files are available to the active runtime. Desktop-local files must be within the authorized shared root.
3. Probe required codecs or media capability.
4. Write to an isolated output root unless the user explicitly approves an overwrite contract.
5. Define file-level assertions before execution.

### My Browser for `L1`

1. Confirm My Browser is ready and the result is tagged to the user's browser route.
2. Confirm Lightroom Web is authenticated.
3. Identify the exact target library, album, photo, or share.
4. Confirm the requested feature is present in that live web surface and the account is entitled to use it.
5. Use a disposable target for validation. Reload or revisit to prove persistence.

My Browser is never labeled as CU. Web support for ratings, flags, organization, supported edits and masks, sharing, or downloads does not prove every field, batch behavior, or named desktop feature.

### Desktop CU for `C1`, Classic writes in `C2`, or `L2`

Desktop execution requires an exact current O1 receipt containing:

- OS, product identity, app version, account or catalog fixture, and CU helper readiness;
- start state and protected objects;
- observed controls or semantic element identities for the exact build;
- action sequence, semantic postcondition, and recovery evidence;
- negative case and finish status.

Without that receipt, return `CONDITIONAL-O1`: prepare fixtures, explain the route, or guide the user, but do not operate the desktop app or claim completion. Run every CU session serially. Do not generalize shortcuts, menu names, coordinates, or accessibility indices across Classic, cloud desktop, operating systems, versions, or keyboard layouts.

## API and plugin boundary

Current file-oriented Lightroom transformation APIs do not expose the user's Classic catalog or cloud-library organization. Classic has a plugin substrate, but this package has no verified Manus-to-Lightroom plugin bridge. A plugin can become a route only after explicit installation, compatibility, invocation, secret, verification, and recovery contracts are proven.

## Protected objects

- Never write directly to a `.lrcat` file.
- Do not fabricate a catalog, cloud album, or Lightroom-emitted sidecar for testing.
- Preserve source files unless an explicit, itemized overwrite or deletion approval exists.
- Treat metadata-to-file, sidecar lifecycle, share permissions, migration, and deletion as separate approval boundaries.
