#!/usr/bin/env python3
"""Check the bounded FCPXML document contract and refs without claiming app acceptance."""

from __future__ import annotations

import argparse
import json
import re
import sys
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


FCPXML_VERSION = re.compile(r"^1\.\d+$")


def inspect(path: Path) -> tuple[dict, int]:
    try:
        root = ET.parse(path).getroot()
    except (ET.ParseError, OSError) as exc:
        return {
            "path": str(path),
            "well_formed": False,
            "error": str(exc),
            "final_cut_acceptance": "not_tested",
        }, 1

    declared_version = root.attrib.get("version")
    root_valid = root.tag == "fcpxml"
    declared_version_valid = bool(declared_version and FCPXML_VERSION.fullmatch(declared_version))
    document_issues: list[str] = []
    if not root_valid:
        document_issues.append("root tag must be 'fcpxml'")
    if declared_version is None:
        document_issues.append("missing required fcpxml version")
    elif not declared_version_valid:
        document_issues.append("declared version must match 1.<non-negative integer>")

    ids = [value for element in root.iter() if (value := element.attrib.get("id"))]
    refs = [value for element in root.iter() if (value := element.attrib.get("ref"))]
    counts = Counter(ids)
    duplicate_ids = sorted(value for value, count in counts.items() if count > 1)
    missing_refs = sorted(set(refs) - set(ids))
    events = [element.attrib.get("name") for element in root.findall(".//event") if element.attrib.get("name")]
    projects = [element.attrib.get("name") for element in root.findall(".//project") if element.attrib.get("name")]

    result = {
        "path": str(path),
        "root_tag": root.tag,
        "declared_version": declared_version,
        "root_valid": root_valid,
        "declared_version_valid": declared_version_valid,
        "well_formed": True,
        "id_count": len(ids),
        "ref_count": len(refs),
        "duplicate_ids": duplicate_ids,
        "missing_refs": missing_refs,
        "events": events,
        "projects": projects,
        "document_issues": document_issues,
        "preflight_passed": not document_issues and not duplicate_ids and not missing_refs,
        "final_cut_acceptance": "not_tested",
        "limitations": [
            "No DTD or schema-validity claim",
            "No claim that the declared version is supported by a target Final Cut build",
            "No media-reachability claim",
            "No Final Cut import or semantic-fidelity claim",
        ],
    }
    return result, 0 if result["preflight_passed"] else 1


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("fcpxml", type=Path)
    args = parser.parse_args()
    result, code = inspect(args.fcpxml)
    print(json.dumps(result, indent=2, sort_keys=True))
    return code


if __name__ == "__main__":
    sys.exit(main())
