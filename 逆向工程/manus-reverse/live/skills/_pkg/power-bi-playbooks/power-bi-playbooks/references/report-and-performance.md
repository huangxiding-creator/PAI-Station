# Report design, interaction, and performance workflows

Read for W04, W05, and W06.

## W04: design and accessibility review

### Contract

- **Primary route now:** P0 read-only audit and a structured change specification; prepare portable theme or image assets as D0 when requested.
- **Escalation:** C0 through My Browser for a signed-in Service render; a qualified L0 Desktop Bridge may capture local pixels, while UI mutation and interaction still need their own current O1.
- **Fallback:** design audit, target tokens, alt-text plan, tab-order plan, and unresolved rendered checklist.
- **Verification:** protected regions, clipping, contrast target, meaningful alt text, keyboard order, and unchanged KPI totals.
- **CU display:** no. A Bridge screenshot is host-local evidence, not CU and not complete rendered acceptance by itself.

JSON or text inspection can detect some structural defects but cannot prove rendered hierarchy, clipping, keyboard behavior, or visual judgment. Keep structural and rendered findings separate.

## W05: navigation and report interaction

### Contract

- **Primary route now:** define the interaction graph, targets, carried filter context, defaults, reset behavior, and keyboard order.
- **Escalation:** execute behavior only in the authoritative rendered Service or Desktop surface.
- **Fallback:** provide the interaction specification and independent behavior test matrix.
- **Verification:** every control reaches its target, drillthrough carries the intended key, reset restores defaults, and no hidden page becomes unreachable.
- **CU display:** no until the local behavior replay has current O1.

A structurally valid bookmark, button, or page definition does not prove behavior. Do not report an interaction complete from a source diff or static Bridge screenshot alone.

## W06: performance diagnosis

### Contract

- **Primary route now:** analyze user-supplied evidence in the sandbox.
- **Escalation:** capture belongs to the available rendered authoring surface; model/report remediation belongs to a separately verified P0, L0, or C0 route.
- **Fallback:** return the ranking, normalization map, capture protocol, and blocked remediation handoff.
- **Verification:** compare like-for-like filter, page, source, and cache conditions; make one change at a time; reconcile business totals.
- **CU display:** no in this source revision. A future Desktop capture could qualify only after its own O1.

Preserve the original JSON. If its observed shape differs from the normalized contract, copy only explicitly mapped fields into a new normalized file and save the field map. Use `scripts/analyze_performance.py` on that normalized copy. The script validates and ranks timing records; it does not capture Power BI data or prove compatibility with an unobserved export format.

Do not classify a slow visual as a refresh failure. Do not claim improvement from one uncontrolled timing sample.
