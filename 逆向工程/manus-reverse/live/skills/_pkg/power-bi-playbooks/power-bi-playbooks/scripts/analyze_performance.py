#!/usr/bin/env python3
"""Validate and rank normalized visual timing records.

The accepted schema is deliberately normalized. This helper does not capture
Power BI data and does not claim compatibility with an unobserved export shape.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from decimal import Decimal, InvalidOperation
from pathlib import Path
from typing import Any


COMPONENT_FIELDS = ("dax_ms", "display_ms", "other_ms")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def number(value: Any, field: str) -> Decimal:
    try:
        result = Decimal(str(value))
    except InvalidOperation as exc:
        raise ValueError(f"{field} must be numeric") from exc
    if not result.is_finite() or result < 0:
        raise ValueError(f"{field} must be finite and non-negative")
    return result


def as_json_number(value: Decimal) -> int | float:
    if value == value.to_integral_value():
        return int(value)
    return float(value)


def normalize_record(record: dict[str, Any], index: int) -> dict[str, Any]:
    name = record.get("name")
    if not isinstance(name, str) or not name.strip():
        raise ValueError(f"visuals[{index}].name must be a non-empty string")
    total = number(record.get("total_ms"), f"visuals[{index}].total_ms")
    components: dict[str, Decimal] = {}
    for field in COMPONENT_FIELDS:
        if field in record and record[field] is not None:
            components[field] = number(record[field], f"visuals[{index}].{field}")
    reported = sum(components.values(), Decimal("0"))
    if reported > total:
        raise ValueError(f"visuals[{index}] component sum exceeds total_ms")
    unreported = total - reported
    ranked_components = {**components, "unreported_ms": unreported}
    dominant = max(ranked_components, key=ranked_components.get)
    return {
        "name": name.strip(),
        "total_ms": as_json_number(total),
        "components": {key: as_json_number(value) for key, value in ranked_components.items()},
        "dominant_component": dominant,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    if args.input.resolve() == args.output.resolve():
        raise SystemExit("output must not overwrite the input")

    payload = json.loads(args.input.read_text(encoding="utf-8"))
    visuals = payload.get("visuals") if isinstance(payload, dict) else None
    if not isinstance(visuals, list) or not visuals:
        raise SystemExit("normalized input must contain a non-empty visuals array")
    normalized = [normalize_record(record, index) for index, record in enumerate(visuals)]
    names = [record["name"] for record in normalized]
    if len(names) != len(set(names)):
        raise SystemExit("visual names must be unique in normalized input")
    ranked = sorted(normalized, key=lambda record: (-record["total_ms"], record["name"]))
    result = {
        "schema_version": 1,
        "scope": "normalized timing analysis only; not a Power BI capture receipt",
        "input_sha256": sha256(args.input),
        "protocol": payload.get("protocol"),
        "ranked_visuals": ranked,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
