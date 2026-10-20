# Conversion, Replacement, and Extraction (Cards F1, F2, F3)

## Card F1: Convert to editable DOCX

**Primary channel**: PDF/OCR tooling plus Documents runtime.

**Escalation trigger**: scan quality is unreliable, legal/financial text has unresolved uncertainty, or exact Microsoft Word layout is the acceptance target.

**Hybrid handoff**: extract/OCR first, reconstruct real DOCX structure, render every page, and use Word only for a qualified exact-layout comparison or explicit lesson.

**Workflow**
1. Classify text-layer PDF, scan, or loose images and agree reflowable versus visual-fidelity priority.
2. Preserve OCR confidence and source-page provenance.
3. Rebuild real headings, lists, tables, notes, images, and sections rather than visual approximations.
4. Surface low-confidence text instead of silently correcting it.
5. Compare all pages and deliver a specific fidelity/loss report.

**Verification**: source coverage, sampled text accuracy, table/footnote/column checks, full render, and uncertainty log.

## Card F2: Batch find and replace

**Primary channel**: HOLD for arbitrary retained DOCX; deterministic native replacement only for a tested simple/Manus-generated structure.

**Escalation trigger**: the token crosses runs or appears in fields, revisions, controls, headers/footers, footnotes, comments, hyperlinks, text boxes, or protected state.

**Hybrid handoff**: build a story-aware dry-run and fixture-backed engine before execution. Word CU is not automatically safer and needs its own recorded procedure.

**Workflow contract**
1. Define pattern, case/word rules, story parts, exclusions, and preservation requirements.
2. Inventory occurrences by story/object type and show contexts.
3. If the current engine and fixture do not cover every in-scope type, stop rather than partially replace.
4. Run one sample copy, verify semantic and rendered diffs, then batch.

**Verification**: exact per-story counts, zero unintended field/URL/metadata changes, surrounding formatting, full render, source hashes, and skipped files.

## Card F3: Extract details into a table

**Primary channel**: file reading/Documents runtime; spreadsheet output follows `excel-playbooks`.

**Escalation trigger**: content is image-only and needs OCR, or required information is unavailable through readable file state.

**Hybrid handoff**: read text/page images and structured tables; extract to an explicit schema with locators; spreadsheet tooling formats and validates the output.

**Workflow**
1. Define columns, normalization, missing/conflict behavior, and scope.
2. Extract prose, tables, comments, or metadata with source page/section/heading locators.
3. Preserve conflicting values instead of choosing silently.
4. Validate a sample before scaling.

**Verification**: coverage count, every row's source locator, duplicate/conflict report, and sampled reconciliation to source.
