# Revisions and Comparison (Cards E1, E2)

## Card E1: Revision and comment report

**Primary channel**: Documents runtime.

**Escalation trigger**: residual Word-specific revision/comment constructs remain after native reporting, or the user explicitly requires a Word app count cross-check.

**Hybrid handoff**: extract and classify native revision/comment state; use Word only for a separately qualified residual check; create accept/reject output only as a distinct confirmed mode.

**Workflow**
1. Inventory insertions, deletions, moves/property changes when available, comments, authors, timestamps, story parts, and unsupported constructs.
2. Produce a substantive summary, item table, author breakdown, or scoped report with source locators.
3. Group trivial changes separately from substantive ones.
4. If requested, create a separate accept-all or reject-all copy and rerun the report; disclose pragmatic revision-engine limits.
5. Treat metadata stripping and comment resolution as separate approved operations.

**Verification**: item counts, authors, locations, XML inventory, residual report, original hash, and full render of any cleaned copy.

## Card E2: Compare outcomes

**Primary channel**: Documents runtime for text/render difference analysis.

**Escalation trigger**: the durable output must be Word's semantic Compare/Combine document with revision markup and reviewer semantics.

**Hybrid handoff**: native analysis explains differences; an O1-qualified Word route may create semantic comparison state; E1 then summarizes that output.

**Official O2 boundary**: Microsoft documents Compare as producing a separate result with revision marks and Combine as merging reviewer revisions, while source documents remain unchanged in the documented default flow. Treat these as semantic-state test oracles, not proof that the controls are present or automatable on the selected build.

**Workflow**
1. Clarify whether the user needs an explanation/report or a Word semantic comparison document.
2. For analysis, preserve both inputs and generate text plus page-render diffs with source locators.
3. Label the result as analysis, never Word Compare semantics.
4. For semantic output, require an O1-qualified Word procedure and separate saved result; otherwise guide or hold.
5. Never accept/reject combined changes without separate approval.

**Verification**: both inputs unchanged; text/page diffs reconcile; reviewer labels and revision state verified for any Word-generated result.
