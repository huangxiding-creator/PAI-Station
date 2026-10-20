#!/usr/bin/env python3
"""Deterministic preflight helpers for portable Illustrator-adjacent work.

This script does not read or mutate Illustrator document state. It validates
portable SVG, variable-data inputs, and file-package inventories so an agent can
decide whether a file route is sufficient or an app-native route is still needed.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
import re
import sys
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path
from typing import Any


HTTP_PREFIX = "http:" + "//"
HTTPS_PREFIX = "https:" + "//"
SVG_NS = HTTP_PREFIX + "www.w3.org/2000/svg"
XLINK_NS = HTTP_PREFIX + "www.w3.org/1999/xlink"
XML_NS = HTTP_PREFIX + "www.w3.org/XML/1998/namespace"
ALLOWED_NAMESPACES = {"", SVG_NS, XLINK_NS, XML_NS}
BLOCKED_SVG_ELEMENTS = {"script", "foreignObject"}
PRESENTATION_PROPERTIES = {
    "fill",
    "fill-opacity",
    "font-family",
    "font-size",
    "font-style",
    "font-weight",
    "opacity",
    "stroke",
    "stroke-dasharray",
    "stroke-linecap",
    "stroke-linejoin",
    "stroke-miterlimit",
    "stroke-opacity",
    "stroke-width",
    "text-anchor",
}
REMOTE_SCHEMES = (HTTP_PREFIX, HTTPS_PREFIX, "//")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def write_json(path: Path | None, payload: Any) -> None:
    text = json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if path is None:
        sys.stdout.write(text)
        return
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def require_new_output(path: Path | None, *protected_inputs: Path) -> None:
    if path is None:
        return
    resolved = path.resolve()
    if any(resolved == protected.resolve() for protected in protected_inputs):
        raise ValueError(f"output must not replace an input: {resolved}")
    if resolved.exists():
        raise ValueError(f"output already exists: {resolved}")


def split_tag(tag: str) -> tuple[str, str]:
    if tag.startswith("{"):
        namespace, local = tag[1:].split("}", 1)
        return namespace, local
    return "", tag


def parse_length(value: str, field: str) -> float:
    match = re.fullmatch(r"\s*([+-]?(?:\d+(?:\.\d*)?|\.\d+))(?:px)?\s*", value)
    if not match:
        raise ValueError(f"{field} must be a unitless or px numeric length, got {value!r}")
    return float(match.group(1))


def normalized_number(value: float) -> str:
    if value.is_integer():
        return str(int(value))
    return format(value, ".12g")


def inspect_svg(path: Path) -> tuple[ET.ElementTree, dict[str, Any]]:
    tree = ET.parse(path)
    root = tree.getroot()
    namespace, local = split_tag(root.tag)
    issues: list[str] = []
    warnings: list[str] = []
    if local != "svg" or namespace not in {"", SVG_NS}:
        issues.append("root element is not a standards SVG element")

    width_raw = root.get("width")
    height_raw = root.get("height")
    view_box_raw = root.get("viewBox")
    width = height = None
    view_box: list[float] | None = None
    try:
        if width_raw is None or height_raw is None:
            raise ValueError("width and height are required by this portable contract")
        width = parse_length(width_raw, "width")
        height = parse_length(height_raw, "height")
    except ValueError as exc:
        issues.append(str(exc))
    try:
        if view_box_raw is None:
            raise ValueError("viewBox is required by this portable contract")
        parts = [float(part) for part in view_box_raw.replace(",", " ").split()]
        if len(parts) != 4 or parts[2] <= 0 or parts[3] <= 0:
            raise ValueError("viewBox must contain x y width height with positive dimensions")
        view_box = parts
    except ValueError as exc:
        issues.append(str(exc))

    element_counts: Counter[str] = Counter()
    ids: list[str] = []
    text_values: list[str] = []
    remote_references: list[str] = []
    private_namespaces: set[str] = set()

    for element in root.iter():
        element_ns, element_name = split_tag(element.tag)
        element_counts[element_name] += 1
        if element_ns not in ALLOWED_NAMESPACES:
            private_namespaces.add(element_ns)
        if element_name in BLOCKED_SVG_ELEMENTS:
            issues.append(f"blocked SVG element: {element_name}")
        if element.get("id"):
            ids.append(element.get("id", ""))
        if element_name in {"text", "title", "desc"} and element.text:
            text_values.append(" ".join(element.text.split()))
        for attr_name, attr_value in element.attrib.items():
            attr_ns, attr_local = split_tag(attr_name)
            if attr_ns not in ALLOWED_NAMESPACES:
                private_namespaces.add(attr_ns)
            if attr_local == "href" and attr_value.strip().lower().startswith(REMOTE_SCHEMES):
                remote_references.append(attr_value.strip())
            lowered_value = attr_value.lower()
            if HTTP_PREFIX in lowered_value or HTTPS_PREFIX in lowered_value:
                remote_references.append(attr_value.strip())

    if private_namespaces:
        issues.append("private or unsupported namespaces present")
    if remote_references:
        issues.append("remote references present")
    if len(ids) != len(set(ids)):
        issues.append("duplicate element IDs present")
    if width is not None and height is not None and view_box is not None:
        if width <= 0 or height <= 0:
            issues.append("width and height must be positive")
        if abs((width / height) - (view_box[2] / view_box[3])) > 1e-9:
            warnings.append("viewport and viewBox aspect ratios differ")

    report = {
        "file": path.name,
        "sha256": sha256_file(path),
        "valid_portable_subset": not issues,
        "issues": sorted(set(issues)),
        "warnings": sorted(set(warnings)),
        "viewport": {"width": width, "height": height},
        "viewBox": view_box,
        "element_counts": dict(sorted(element_counts.items())),
        "ids": sorted(ids),
        "text": text_values,
        "remote_references": sorted(remote_references),
        "private_namespaces": sorted(private_namespaces),
    }
    return tree, report


def canonicalize_svg(tree: ET.ElementTree) -> ET.ElementTree:
    root = tree.getroot()
    ET.register_namespace("", SVG_NS)
    ET.register_namespace("xlink", XLINK_NS)

    for field in ("width", "height"):
        raw = root.get(field)
        if raw is not None:
            root.set(field, normalized_number(parse_length(raw, field)))

    for parent in list(root.iter()):
        for child in list(parent):
            _, child_name = split_tag(child.tag)
            if child_name == "metadata":
                parent.remove(child)

    for element in root.iter():
        style = element.attrib.pop("style", None)
        if style:
            for declaration in style.split(";"):
                if not declaration.strip():
                    continue
                if ":" not in declaration:
                    raise ValueError(f"invalid style declaration: {declaration!r}")
                key, value = (part.strip() for part in declaration.split(":", 1))
                if key not in PRESENTATION_PROPERTIES:
                    raise ValueError(f"unsupported style property for deterministic normalization: {key}")
                if key not in element.attrib:
                    element.set(key, value)
        ordered = sorted(element.attrib.items())
        element.attrib.clear()
        element.attrib.update(ordered)

    ET.indent(tree, space="  ")
    return tree


def command_svg(args: argparse.Namespace) -> int:
    source = Path(args.input).resolve()
    output = Path(args.output).resolve()
    report_output = Path(args.report).resolve() if args.report else None
    require_new_output(output, source)
    require_new_output(report_output, source, output)
    tree, before = inspect_svg(source)
    if not before["valid_portable_subset"]:
        write_json(report_output, {"before": before})
        return 2
    canonical = canonicalize_svg(tree)
    output.parent.mkdir(parents=True, exist_ok=True)
    canonical.write(output, encoding="utf-8", xml_declaration=True, short_empty_elements=True)
    with output.open("ab") as handle:
        handle.write(b"\n")
    after_tree, after = inspect_svg(output)
    del after_tree
    payload = {
        "operation": "standards-svg-normalize",
        "source": before,
        "output": after,
        "portable_state_only": True,
        "illustrator_state_claim": False,
    }
    write_json(report_output, payload)
    return 0 if after["valid_portable_subset"] else 2


def command_variables(args: argparse.Namespace) -> int:
    csv_path = Path(args.csv).resolve()
    asset_root = Path(args.asset_root).resolve()
    output = Path(args.output).resolve() if args.output else None
    require_new_output(output, csv_path)
    required = [value.strip() for value in args.required_columns.split(",") if value.strip()]
    with csv_path.open("r", encoding="utf-8-sig", newline="") as handle:
        reader = csv.DictReader(handle)
        headers = reader.fieldnames or []
        missing_headers = [name for name in required if name not in headers]
        rows = list(reader)

    id_counts = Counter(row.get(args.id_column, "").strip() for row in rows)
    seen: set[str] = set()
    records: list[dict[str, Any]] = []
    for line_number, row in enumerate(rows, start=2):
        errors: list[str] = []
        record_id = row.get(args.id_column, "").strip()
        if not record_id:
            errors.append("missing-id")
        elif record_id in seen:
            errors.append("duplicate-id")
        else:
            seen.add(record_id)
        for column in required:
            if not row.get(column, "").strip():
                errors.append(f"missing-required:{column}")
        asset_value = row.get(args.asset_column, "").strip()
        asset_path = (asset_root / asset_value).resolve() if asset_value else None
        if asset_value and (asset_root not in asset_path.parents and asset_path != asset_root):
            errors.append("asset-path-escapes-root")
        elif asset_value and not asset_path.is_file():
            errors.append("asset-missing")
        record = {
            "line": line_number,
            "record_id": record_id,
            "status": "reject" if errors else "ready-for-binding-pilot",
            "errors": sorted(set(errors)),
            "asset": asset_value,
            "asset_sha256": sha256_file(asset_path) if asset_path and asset_path.is_file() else None,
        }
        records.append(record)

    rejected = [record for record in records if record["status"] == "reject"]
    payload = {
        "operation": "variable-data-preflight",
        "source_csv": csv_path.name,
        "source_sha256": sha256_file(csv_path),
        "headers": headers,
        "missing_headers": missing_headers,
        "input_rows": len(rows),
        "unique_nonempty_ids": len([key for key in id_counts if key]),
        "duplicate_ids": sorted([key for key, count in id_counts.items() if key and count > 1]),
        "ready_rows": len(rows) - len(rejected),
        "rejected_rows": len(rejected),
        "records": records,
        "illustrator_binding_claim": False,
        "status": "preflight-failed" if missing_headers or rejected else "ready-for-binding-pilot",
    }
    write_json(output, payload)
    return 2 if missing_headers else 0


def command_inventory(args: argparse.Namespace) -> int:
    root = Path(args.root).resolve()
    candidate_input = Path(args.candidates).resolve() if args.candidates else None
    output = Path(args.output).resolve() if args.output else None
    require_new_output(output, root, *([candidate_input] if candidate_input else []))
    if not root.is_dir():
        raise ValueError(f"inventory root is not a directory: {root}")
    if output is not None and root in output.parents:
        raise ValueError("inventory output must be outside the inventoried root")
    files: list[dict[str, Any]] = []
    symlinks: list[dict[str, str]] = []
    for path in sorted(root.rglob("*")):
        if path.is_symlink():
            symlinks.append({"path": path.relative_to(root).as_posix(), "target": os.readlink(path)})
            continue
        if not path.is_file():
            continue
        relative = path.relative_to(root).as_posix()
        files.append({"path": relative, "bytes": path.stat().st_size, "sha256": sha256_file(path)})

    candidate_report: dict[str, Any] | None = None
    if candidate_input:
        specification = json.loads(candidate_input.read_text(encoding="utf-8"))
        candidates: list[dict[str, Any]] = []
        for candidate in specification.get("candidates", []):
            relative = candidate["path"]
            path = (root / relative).resolve()
            in_root = root in path.parents or path == root
            exists = in_root and path.is_file() and not path.is_symlink()
            candidates.append(
                {
                    "path": relative,
                    "declared_match": candidate.get("match"),
                    "expected_decision": candidate.get("expected_decision"),
                    "exists": exists,
                    "sha256": sha256_file(path) if exists else None,
                }
            )
        exact_hashes = {
            item["sha256"]
            for item in candidates
            if item["exists"] and str(item["declared_match"]).startswith("exact-name")
        }
        candidate_report = {
            "missing_link": specification.get("missing_link"),
            "candidates": candidates,
            "exact_name_candidates_have_distinct_content": len(exact_hashes) > 1,
            "automatic_relink_allowed": False,
        }

    payload = {
        "operation": "portable-package-inventory",
        "file_count": len(files),
        "files": files,
        "symlinks": symlinks,
        "candidate_report": candidate_report,
        "illustrator_package_claim": False,
        "status": "blocked-symlink-review" if symlinks else "inventory-only-requires-app-roundtrip-for-illustrator-package",
    }
    write_json(output, payload)
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)

    svg = subparsers.add_parser("svg", help="Validate and normalize a portable standards SVG")
    svg.add_argument("--input", required=True)
    svg.add_argument("--output", required=True)
    svg.add_argument("--report")
    svg.set_defaults(handler=command_svg)

    variables = subparsers.add_parser("variables", help="Build a variable-data preflight manifest")
    variables.add_argument("--csv", required=True)
    variables.add_argument("--asset-root", required=True)
    variables.add_argument("--required-columns", required=True)
    variables.add_argument("--id-column", default="record_id")
    variables.add_argument("--asset-column", default="photo_path")
    variables.add_argument("--output")
    variables.set_defaults(handler=command_variables)

    inventory = subparsers.add_parser("inventory", help="Build a deterministic portable package inventory")
    inventory.add_argument("--root", required=True)
    inventory.add_argument("--candidates")
    inventory.add_argument("--output")
    inventory.set_defaults(handler=command_inventory)
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    try:
        return int(args.handler(args))
    except (ET.ParseError, ValueError, OSError, json.JSONDecodeError) as exc:
        print(f"preflight error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
