#!/usr/bin/env python3
"""Stage a CSV through an explicit, deterministic validation contract.

This helper creates new clean, quarantine, and JSON report files. It never edits
the input and does not create Power Query or Power BI state.
"""

from __future__ import annotations

import argparse
import csv
import datetime as dt
import hashlib
import json
import re
from decimal import Decimal, InvalidOperation
from pathlib import Path
from typing import Any


INTEGER_RE = re.compile(r"^[+-]?\d+$")


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def load_contract(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as handle:
        contract = json.load(handle)
    if contract.get("schema_version") != 1:
        raise ValueError("contract schema_version must be 1")
    required = contract.get("required_columns")
    if not isinstance(required, list) or not required or not all(isinstance(x, str) for x in required):
        raise ValueError("required_columns must be a non-empty string list")
    trim_columns = contract.get("trim_columns", [])
    if not isinstance(trim_columns, list) or not all(isinstance(x, str) for x in trim_columns):
        raise ValueError("trim_columns must be a string list")
    if not set(trim_columns).issubset(required):
        raise ValueError("trim_columns must be a subset of required_columns")
    return contract


def decimal_value(value: str) -> Decimal:
    try:
        result = Decimal(value)
    except InvalidOperation as exc:
        raise ValueError("not a decimal") from exc
    if not result.is_finite():
        raise ValueError("decimal must be finite")
    return result


def validate_row(row: dict[str, str], contract: dict[str, Any]) -> list[str]:
    errors: list[str] = []
    for column in contract["required_columns"]:
        if not row.get(column, "").strip():
            errors.append(f"{column}: required value missing")

    for column, date_format in contract.get("date_columns", {}).items():
        value = row.get(column, "")
        if value:
            try:
                parsed = dt.datetime.strptime(value, date_format)
                if parsed.strftime(date_format) != value:
                    raise ValueError
            except ValueError:
                errors.append(f"{column}: expected date format {date_format}")

    for column, number_type in contract.get("number_columns", {}).items():
        value = row.get(column, "")
        if not value:
            continue
        try:
            if number_type == "integer":
                if not INTEGER_RE.fullmatch(value):
                    raise ValueError("not an integer")
            elif number_type == "decimal":
                decimal_value(value)
            else:
                errors.append(f"{column}: unsupported number type {number_type}")
        except ValueError:
            errors.append(f"{column}: expected {number_type}")

    for column, allowed in contract.get("allowed_values", {}).items():
        value = row.get(column, "")
        if value and value not in allowed:
            errors.append(f"{column}: value is not in the allowed set")
    return errors


def build_report_totals(rows: list[dict[str, str]], contract: dict[str, Any]) -> dict[str, str]:
    totals: dict[str, str] = {}
    for name, spec in contract.get("computed_totals", {}).items():
        multiply = spec.get("multiply") if isinstance(spec, dict) else None
        if not isinstance(multiply, list) or len(multiply) != 2:
            raise ValueError(f"computed total {name} must declare multiply with two columns")
        total = Decimal("0")
        for row in rows:
            total += decimal_value(row[multiply[0]]) * decimal_value(row[multiply[1]])
        totals[name] = format(total, "f")
    return totals


def write_csv(path: Path, fieldnames: list[str], rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--contract", required=True, type=Path)
    parser.add_argument("--clean-output", required=True, type=Path)
    parser.add_argument("--quarantine-output", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    args = parser.parse_args()

    protected_inputs = {args.input.resolve(), args.contract.resolve()}
    outputs = {args.clean_output.resolve(), args.quarantine_output.resolve(), args.report.resolve()}
    if protected_inputs & outputs:
        raise SystemExit("output paths must not overwrite the input or contract")
    if len(outputs) != 3:
        raise SystemExit("clean, quarantine, and report outputs must be distinct")

    contract = load_contract(args.contract)
    with args.input.open(newline="", encoding="utf-8-sig") as handle:
        reader = csv.DictReader(handle)
        header = reader.fieldnames or []
        missing_columns = [column for column in contract["required_columns"] if column not in header]
        if missing_columns:
            raise SystemExit("missing required columns: " + ", ".join(missing_columns))
        trim_columns = set(contract.get("trim_columns", []))
        source_rows = []
        for row in reader:
            normalized: dict[str, str] = {}
            for key, value in row.items():
                if key is None:
                    continue
                text = value or ""
                normalized[key] = text.strip() if key in trim_columns else text
            source_rows.append(normalized)

    clean_rows: list[dict[str, str]] = []
    quarantine_rows: list[dict[str, str]] = []
    seen_keys: set[tuple[str, ...]] = set()
    key_columns = contract.get("unique_key", [])

    for row in source_rows:
        errors = validate_row(row, contract)
        if key_columns and not errors:
            key = tuple(row.get(column, "") for column in key_columns)
            if key in seen_keys:
                errors.append("business key: duplicate")
            else:
                seen_keys.add(key)
        if errors:
            quarantine_rows.append({**row, "_errors": " | ".join(errors)})
        else:
            clean_rows.append(row)

    write_csv(args.clean_output, header, clean_rows)
    write_csv(args.quarantine_output, header + ["_errors"], quarantine_rows)
    report = {
        "schema_version": 1,
        "input_name": args.input.name,
        "input_sha256": sha256(args.input),
        "contract_sha256": sha256(args.contract),
        "input_rows": len(source_rows),
        "accepted_rows": len(clean_rows),
        "quarantined_rows": len(quarantine_rows),
        "computed_totals": build_report_totals(clean_rows, contract),
        "clean_output_sha256": sha256(args.clean_output),
        "quarantine_output_sha256": sha256(args.quarantine_output),
    }
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
