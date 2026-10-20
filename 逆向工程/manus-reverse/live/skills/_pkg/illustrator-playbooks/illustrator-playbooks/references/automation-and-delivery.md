# Automation and delivery workflows

## Card 3: Export matrix

Before execution, define source document, selected artboards or assets, order, formats, scales, naming pattern, destination, collision policy, and whether PDF should be separate, multipage, or imposed. Produce an expected-output manifest first.

Use an already configured and reproduced Adobe Action or script for recurring deterministic exports. A one-time Desktop export remains live-blocked until current-build O1. File tooling may verify count, unique names, dimensions, hashes, and openability; it cannot perform or prove Illustrator export by itself.

## Card 9: Missing-link and handoff inventory

Use the inventory command for portable candidate and package inspection:

```bash
python3 scripts/preflight.py inventory \
  --root PACKAGE_ROOT \
  --candidates link-candidates.json \
  --output package-inventory.json
```

The optional candidate file contains a logical missing link and relative candidate paths. Same-name files with different hashes stay ambiguous and require user review. The report is an inventory only; it does not relink Illustrator, copy fonts, run Package, or prove save-reopen.

## Card 10: Reusable automation choice

Choose the smallest durable mechanism that fits the repeated work:

- Variables for structured substitutions when a real binding workflow is available;
- Actions for stable recordable commands;
- a reviewed supported script or plug-in for logic, loops, and parameterization;
- a Manus playbook for route selection, judgment, safety, and cross-tool handoff;
- Record a Skill only for a short stable mainline after current-build O1.

Do not use row-by-row Computer Use for deterministic scale. A recording never supplies missing branch logic, permission handling, recovery, or cross-OS proof. Validate the durable asset on an unseen fixture, isolate failures, prevent hardcoded paths, and reconcile resumed outputs by ID or manifest.

### Data Merge and script boundaries

An official cloud Data Merge route still depends on an Illustrator-authored template whose Variables and bindings already match the dataset. Treat template authoring, data preflight, cloud execution, and returned-file inspection as four separate stages. Never claim that a cloud merge endpoint created or validated the Illustrator template.

For a supported Illustrator script, record the script source, owner, version, expected document scope, allowed changes, and rollback before execution. Illustrator may warn when an external script is opened. Do not suppress, bypass, or auto-accept that warning: the user must review the source and approve execution in the trusted app context. A public sample or script-compatible file extension is not sufficient trust evidence.
