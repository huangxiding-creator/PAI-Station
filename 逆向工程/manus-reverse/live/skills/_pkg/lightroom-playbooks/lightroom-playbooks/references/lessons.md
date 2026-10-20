# Card 10: Standalone Outputs and Product Lessons

- **Primary channel:** Use native or Sandbox tools for standalone outputs, My Browser for a web-supported cloud lesson, and Desktop CU for a Classic or verified cloud-desktop lesson under exact O1.
- **Escalation trigger:** Escalate to an app surface only when the user asks to learn that client or the requested outcome must retain client-specific state.
- **Hybrid handoff:** Create or prepare a disposable fixture outside the app, demonstrate one client feature, then validate and clean up through the same route.
- **Verification:** Prove the artifact or semantic app state, client identity, affected fixture, recovery, and explicit separation between output completion and Lightroom-state completion.

These are separate jobs.

## Standalone output

Use native semantic editing for a new approved visual derivative and Sandbox for deterministic transforms. Verify the artifact itself and state explicitly that no Lightroom catalog, preset, history, album, rating, or cloud-library state was created unless a separate Lightroom route also ran and passed.

## Lightroom lesson

Resolve one product and one feature per lesson:

- Web-supported cloud lesson: My Browser, `CONDITIONAL-WEB`.
- Classic lesson: Desktop CU, `CONDITIONAL-O1`.
- Verified cloud desktop-only lesson: Desktop CU, `CONDITIONAL-O1`.

Each lesson requires:

- client, version, entitlement, and disposable fixture;
- current feature preflight;
- observable start state and semantic end state;
- exact recovery or cleanup;
- a repeatable step card derived from observed semantics, not frozen coordinates;
- one negative case.

Do not teach Assisted Culling on the web based on desktop documentation. A recording can preserve mechanics, runtime inputs, verification, and recovery; it cannot automatically learn the user's aesthetic rubric.
