# Card 2 — Localization and Variants

**Use when:** an existing After Effects project must produce many language, regional, campaign, product, or personalized versions while preserving traceability and editable sources. Typical cases include localized SaaS launches, regional price/legal variants, event-name videos, certificates, and repeated annual updates.

**Primary channel:** F0 validates and freezes the source-data table, assets, locale rules, and unique output matrix. Prefer A1 for data-driven sources, scripts, and rendering only after each route is reproduced. Use P1 for visual exception review and corrections involving text fit, right-to-left behavior, glyphs, timing, imagery, or app-native state.

**Escalation trigger:** move to P1 when the project is not structurally data-driven, a locale fails objective checks, or visual review is required to preserve meaning and layout.

**Hybrid handoff:** F0 validates every row and identifies high-risk cases. A1 creates project variants or renders repeatably. P1 reviews a sample from every locale and fixes only named exceptions. File tooling reconciles one row to one project/output and validates files.

**Inputs:** base project, approved translations or personalization table, locale and reading-direction rules, fonts, asset variants, naming convention, output matrix, and qualified reviewers.

**Workflow:**

1. Freeze the base project and source-data snapshot; define stable row and output IDs.
2. Validate required columns, encoding, locale, duplicates, unsafe names, asset paths, and missing values.
3. Classify fields as direct data replacements, computed values, visual exceptions, or human-language review.
4. Reproduce the selected A1 route on normal, long-text, right-to-left, missing-glyph, and collision cases before scale.
5. Generate a small sample and verify row-to-output mapping plus project reopen where retained state is promised.
6. Review at least one output per locale and every flagged exception for line breaks, glyphs, direction, timing, crop, and legal text.
7. Obtain approval before completing the matrix; preserve completed IDs for restart.
8. Reconcile source rows, project variants, renders, failures, and review status one to one.

**Failure and recovery:** block duplicate destinations and unknown language correctness. Do not infer translation quality from visual fit. Keep data, project, script, render, and review checkpoints separate, and query existing outputs before retrying.

**Record as Skill:** record only the P1 exception-review branch after O1. Data validation, structured generation, and unattended rendering keep their own reproducible receipts rather than being recorded as GUI actions.

**CU display:** highlight after O1 only for visual localization exceptions and retained After Effects state. Bulk row mapping and rendering should remain structured.
