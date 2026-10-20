---
name: finance-pro-playbooks
description: >-
  Use for finance and investment analysis: stock/company research, earnings and
  filings review, financial/market data retrieval, industry research, fund/ETF
  comparison, options, crypto/DeFi, portfolio allocation/rebalancing, strategy
  backtesting, and manual trade planning. Also use for IB/PE/VC workflows:
  DCF/LBO/comps/SOTP, financial models, financing/deal structures, due diligence,
  M&A/IPO materials, teasers/CIMs, and IC memos. Guides source selection,
  fiscal-period and metric discipline, professional defaults, calculations,
  and delivery checks. For finance Excel outputs, apply
  references/corporate-finance/formats/excel_standards.md.
  Do not use for pure formatting, translation, or syntax repair; production
  trading-system development; legal advice/dispute calculations; personal
  tax filing, bookkeeping, insurance, or real-estate underwriting.
---

# Finance Pro Playbooks

Guide finance research, models, diligence, portfolio analysis, backtests and professional materials. The written rules and task checklists are the acceptance authority. The LLM or analyst applies them to routing, calculations and delivery; no validation program, machine receipt or serialized result is required. Available authorized tools support retrieval, actual calculations, file creation, viewing and recalculation as needed.

## Essential Principles

1. Preserve the user's explicit data source, input snapshot, metric definition, calculation parameters, scope and output requirements before using defaults. Preserve factual accuracy, reproducible arithmetic, confidentiality, capability boundaries and higher-priority instructions; a requested basis is not automatically a verified fact.
2. Identify the final deliverable and responsible module. Order supporting work by its actual data dependencies; do not silently replace upstream facts, assumptions or versions.
3. For entity-specific retrieval, resolve the company, security or fund and fix the reference date, fiscal period, currency and units. A narrow concept explanation needs no invented entity or market-data pull.
4. Use deterministic tools for material calculations, models and backtests, and actual file tools for artifact checks. Choose tools that fit the task; this Skill does not require a particular programming language or package installation.
5. Ask only when an unresolved answer would materially change the analysis, confidentiality, authority or deliverable. Preserve choices and authorization the user has already supplied.

## Data Rules

Read [data-source-policy.md](references/data-source-policy.md) whenever external or user-provided data are used. It is the detailed authority for source selection, evidence quality, freshness, normalization, conflicts and failure handling.

- **DR-01 — Entity and time anchor:** Resolve entity, venue, listing status, fiscal year end, currency/unit, industry, reference time, and reporting period before retrieval.
- **DR-02 — Capability inventory and source preference:** Use the user's requested source or supplied data as the requested analytical basis when available; inspect professional, connected, built-in and public capabilities before declaring it unavailable. Never silently replace it because another source ranks higher or is easier to query. If the user specified an exclusive source, do not substitute one without authorization.
- **DR-03 — Capability and authority are different:** Select retrieval tools by data type, grain, and time axis; judge evidence by source authority. Search snippets are discovery only. Upgrade decision-relevant claims to original disclosures when available.
- **DR-04 — Lineage and states:** Record source identity, locator, retrieval/observation/publication times, period, currency, unit, frequency, adjustment basis, query basis, and reliability status. Every material fact and hard-coded input must trace to its actual source record.
- **DR-05 — Point-in-time integrity:** Separate filing date from fiscal period, actuals from guidance/estimates, LTM from NTM, and consensus samples from one another. Backtests must use information and constituents available at the decision time.
- **DR-06 — Normalize and verify:** Reconcile identifiers, share classes, currencies, units, calendars, time zones, corporate actions, and adjustment bases before calculation. Mark a key fact verified only under the policy's evidence test; preserve unresolved conflicting candidates.
- **DR-07 — Freshness and fail-closed behavior:** Apply use-case freshness limits. Never convert missing, stale, failed, blocked, or unverified data into remembered values or false precision. Withhold or label affected conclusions.
- **DR-08 — Reproducibility and protection:** Keep derived figures reconstructable without intermediate rounding; minimize personal data, keep credentials in authorized stores, and never place secrets in results, manifests, files, or logs.

## Understand the Request

Record the requested task, subject, source and input version, calculation basis, time window, benchmark, parameters, deliverable, audience, exclusions, preserved content and latest corrections in working notes appropriate to the task. Use only supplied or safely inferable values. A simple answer does not require an extra input file or complete input form.

Interpret clauses in context. An uploaded CSV or Excel workbook is an input unless the user also asks for that output. Scope a prohibition to its actual action: “Build a DCF, but do not create Excel” requests a DCF analysis without an Excel deliverable. A negated task does not trigger that task; a separate positive task remains active. Resolve genuine ambiguity from the full request, not isolated keywords.

## Route and Load

Use [module-catalog.json](references/module-catalog.json) for module responsibilities, reference paths, priority and dependencies; use [task-catalog.json](references/corporate-finance/task-catalog.json) for the 54 corporate-finance tasks. Patterns are discovery hints, not a substitute for understanding the user's requested action. Read [routing-catalog.md](references/routing-catalog.md) for ambiguity rules and multi-module examples.

| Responsible module | Final responsibility | Read when selected |
|---|---|---|
| equity-research | Single-company research and investment view | [equity-research.md](references/equity-research.md) |
| fund-etf | Fund/ETF comparison and product structure | [fund-etf.md](references/fund-etf.md) |
| options-strategy | Option structures, payoff, volatility and Greeks | [options-strategy.md](references/options-strategy.md) |
| crypto-analysis | Crypto, on-chain, derivatives and DeFi analysis | [crypto-analysis.md](references/crypto-analysis.md) |
| portfolio-management | Portfolio diagnosis, allocation and rebalancing analysis | [portfolio-management.md](references/portfolio-management.md) |
| quant-backtesting | Historical strategy testing and robustness | [quant-backtesting.md](references/quant-backtesting.md) |
| trade-planning | Proposed manual plans; no transaction execution | [trade-planning.md](references/trade-planning.md) |
| corporate-finance | Valuation, models, diligence and deal/IC materials | [corporate-finance.md](references/corporate-finance.md) |

Narrow lookups and concept explanations follow [direct-answer.md](references/direct-answer.md). Pure translation, reformatting and syntax repair use an appropriate general workflow. For a mixed request, retain the valid finance work without expanding it. FX, futures and commodities have limited support; route backtesting, portfolio allocation and manual planning by the requested action and disclose analysis limits.

Load only the selected domain guide and triggered shared references. Corporate-finance work loads each selected task's group overview, Playbook and applicable [task checks](references/corporate-finance/task-checks.md). Deduplicate shared references. Load file-format standards only for the actual deliverable. A task dependency may be supplied by a usable, reviewed existing model or external input; assess missing prerequisites without automatically building additional unrequested work.

## Retrieve and Analyze

Apply the Data Rules before calculations. User-specified formulas, windows, benchmarks, adjustments, annualization and assumptions precede [metric-dictionary.md](references/metric-dictionary.md) defaults. Calculate with an appropriate deterministic tool using those inputs; record enough source and calculation detail to reproduce material figures. A nonstandard requested formula retains its label with a user-defined qualifier and its actual definition. If arithmetic or applicability cannot be verified, explain the affected limitation rather than replacing the formula or claiming that it passed.

Use [scoring-standard.md](references/scoring-standard.md) when scoring or weighting. Use [privacy-security.md](references/privacy-security.md) for protected inputs. Apply selected domain and Playbook checks. Keep facts, estimates, assumptions and analytical conclusions distinguishable, and refresh dependent results when inputs change.

## Deliver and Check

User requirements govern source basis, content, format, structure, section order, length and template before task defaults. Task layout and page-count guidance are defaults unless necessary for model integrity, compliance or usable output. Create only requested or task-essential files. An unlisted output format is not automatically unsupported; select available creation and verification tools and disclose genuine capability limits.

Follow [output-contracts.md](references/output-contracts.md) for delivery standards and [completion-evidence.md](references/completion-evidence.md) for verification responsibilities. The LLM or analyst reviews results against the written checklist, with actual source, calculation and file outputs as evidence; a genuine reviewer handles complex financial semantics or approval when required. No program's pass/fail result is a required delivery gate. Describe only checks actually performed and identify unresolved items without forcing a separate JSON, Markdown report or evidence attachment.

For Excel output, [excel_standards.md](references/corporate-finance/formats/excel_standards.md) is the finance workbook standard. For Word/PPT and institutional documents, use [document_standards.md](references/corporate-finance/formats/document_standards.md). Preserve the user's existing template and layout unless a necessary change is explained.

## Financial Transactions and External Actions

Never operate a broker, exchange, custody system or wallet to place, route, transmit, submit, sign, modify, cancel, approve or settle a financial transaction, or transfer assets. This boundary applies to the Skill and its tools, not the user's independent activity. A transaction request routes to trade-planning and produces a proposed, unsubmitted manual plan. User confirmation does not authorize the Skill to transact.

Read [execution-safety.md](references/execution-safety.md) for manual plans, simulations, monitoring, sending or publication. Creating a file does not authorize sending it externally. Preserve existing authorization and obtain any missing approval for the concrete external action.

Before delivery, check that the response addresses the original request and latest correction, uses the requested source and metric basis, discloses material dates/units/assumptions/gaps, passes the applicable analytical and file checks, protects confidential data, respects transaction boundaries, and opens in the requested format. Communicate relevant limitations and notices using the user's requested structure; [notices.md](references/notices.md) provides wording guidance.
