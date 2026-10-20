# Structure and Formatting (Cards A1, A2, B1, B2)

## Card A1: Document structure

**Primary channel**: bundled Documents runtime.

**Escalation trigger**: the user requires current Microsoft Word-evaluated TOC/PAGE/NUMPAGES results and no accepted compatible evaluator satisfies the layout requirement.

**Hybrid handoff**: native inventory and structure edits produce a separate DOCX; an O1-qualified Word route evaluates only the layout-dependent fields; structural checks and rendering verify the result.

**Official O2 boundary**: Microsoft currently documents manual field updates for TOC, page-number, cross-reference, bookmark, and table-formula fields, including whole-document refresh. Treat that documentation as a candidate test contract only. It does not prove the selected Word build, keyboard behavior, nested-table coverage, pagination result, or Manus control path.

**Workflow**
1. Inventory real headings versus visual lookalikes, numbering definitions, sections, headers/footers, bookmarks, field codes/results, captions, and references.
2. Agree heading levels, numbering, section/page-number behavior, TOC type/depth, captions, and cross-reference targets.
3. Create headings, numbering, sections, SEQ captions, bookmarks, and REF fields natively.
4. Choose either static clickable navigation or insert a true TOC field. Do not call an inserted field evaluated.
5. Materialize only supported SEQ/REF display values. Use Word only for a separately proved layout-field evaluation tail.

**Verification**: heading/bookmark/link graph, numbering/section state, field inventory, full-page render, and Word-evaluated page results when required.

## Card A2: Multi-source merge

**Primary channel**: Documents runtime for rebuilds or compatible body-only append.

**Escalation trigger**: append sources contain drawings, media relationships, headers/footers, footnotes, comments, revisions, sections, custom numbering, or other retained package state that must survive.

**Hybrid handoff**: inventory all sources, choose clean rebuild versus compatible append, and hold complex retained merge until a tested package merger or Word operation exists.

**Workflow**
1. Inventory source order, styles, sections, media/relationships, headers/footers, fields, revisions, and geometry.
2. Select a winning design system and decide whether each source can be reconstructed or safely appended.
3. Refuse body-only append when unsupported state is present; do not silently drop it.
4. Merge/rebuild into a separate file and reconcile source content.
5. Apply A1 field handling only after the merge state is stable.

**Verification**: source manifest, content counts, declared media/header/footer/section preservation, relationship integrity, field report, and every rendered page.

## Card B1: Formatting rescue

**Primary channel**: Documents runtime.

**Escalation trigger**: the document uses load-bearing legal/regulatory formatting or the requested cleanup would remove intentional emphasis or change pagination beyond the approved scope.

**Hybrid handoff**: style lint identifies drift; the user approves a bounded scope; native edits apply only that scope; render/style/text diffs verify it.

**Workflow**
1. Capture baseline render and style/direct-formatting report.
2. Separate intentional emphasis, code styles, numbering, and template constraints from accidental drift.
3. Offer a scoped change set; never normalize everything by default.
4. Apply to a copy and produce a measured change report.

**Verification**: approved-scope style/text diff, intentional exceptions preserved, full render, page-count delta, and no unexplained changes outside scope.

## Card B2: Brand restyle

**Primary channel**: Documents runtime.

**Escalation trigger**: the retained document contains colliding custom styles, layout-sensitive state, or rich controls whose authoring is not covered by the bundled helper.

**Hybrid handoff**: distill the brand authority, approve a style mapping, apply scoped native changes, and escalate only a specifically unsupported rich-control tail.

**Workflow**
1. Identify the authority: brand guide, retained DOCX/DOTX, or approved reference.
2. Inventory target styles, theme, numbering, controls, headers/footers, and pagination.
3. Present mappings and collision/pagination risks before applying them.
4. Apply approved mappings to a copy and create a compliance report.
5. Route reusable template behavior to C1.

**Verification**: compliance matrix, style collisions, control inventory, pagination delta, package integrity, and every rendered page.
