#!/usr/bin/env python3
"""Check SRT-style cue structure and timing without claiming media alignment."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


STAMP = re.compile(r"^(\d{2}):(\d{2}):(\d{2}),(\d{3}) --> (\d{2}):(\d{2}):(\d{2}),(\d{3})$")


def milliseconds(parts: tuple[str, ...]) -> int:
    hours, minutes, seconds, millis = map(int, parts)
    return ((hours * 60 + minutes) * 60 + seconds) * 1000 + millis


def clock_issues(parts: tuple[str, ...], cue: int, endpoint: str) -> list[str]:
    _, minutes, seconds, _ = map(int, parts)
    issues = []
    if not 0 <= minutes <= 59:
        issues.append(f"cue {cue}: {endpoint} minute field is outside 00-59")
    if not 0 <= seconds <= 59:
        issues.append(f"cue {cue}: {endpoint} second field is outside 00-59")
    return issues


def inspect(path: Path) -> tuple[dict, int]:
    try:
        text = path.read_text(encoding="utf-8-sig")
    except OSError as exc:
        return {"path": str(path), "parse": False, "issues": [str(exc)]}, 1

    blocks = [block for block in re.split(r"\r?\n\s*\r?\n", text.strip()) if block.strip()]
    ranges: list[tuple[int, int, int]] = []
    issues: list[str] = []

    for position, block in enumerate(blocks, start=1):
        lines = block.splitlines()
        if len(lines) < 3:
            issues.append(f"cue {position}: expected index, timestamp, and text")
            continue
        if not lines[0].isdigit():
            issues.append(f"cue {position}: index is not numeric")
            continue
        cue_index = int(lines[0])
        if cue_index != position:
            issues.append(f"cue {position}: index is {cue_index}")
        match = STAMP.match(lines[1])
        if not match:
            issues.append(f"cue {position}: invalid timestamp line")
            continue
        start_parts = match.groups()[:4]
        end_parts = match.groups()[4:]
        field_issues = clock_issues(start_parts, position, "start") + clock_issues(end_parts, position, "end")
        if field_issues:
            issues.extend(field_issues)
            continue
        start = milliseconds(start_parts)
        end = milliseconds(end_parts)
        if start >= end:
            issues.append(f"cue {position}: start is not before end")
            continue
        ranges.append((position, start, end))

    overlaps = []
    for left, right in zip(ranges, ranges[1:]):
        if right[1] < left[2]:
            overlaps.append({"left_cue": left[0], "right_cue": right[0], "overlap_ms": left[2] - right[1]})

    result = {
        "path": str(path),
        "parse": not issues,
        "cue_count": len(blocks),
        "structural_issues": issues,
        "overlaps": overlaps,
        "media_alignment": "not_tested",
    }
    return result, 1 if issues or overlaps else 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("srt", type=Path)
    args = parser.parse_args()
    result, code = inspect(args.srt)
    print(json.dumps(result, indent=2, sort_keys=True))
    return code


if __name__ == "__main__":
    sys.exit(main())
