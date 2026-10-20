#!/usr/bin/env python3
"""Prepare bounded Logic Scripter transpose source and a portable MIDI oracle."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


SCRIPT = """/* Source preparation only. Logic execution and persistence require live verification. */
var PluginParameters = [
  {{ name: "Semitones", type: "lin", minValue: -24, maxValue: 24, numberOfSteps: 48, defaultValue: {semitones}, unit: "st" }}
];

function HandleMIDI(event) {{
  if (event instanceof Note) {{
    event.pitch = Math.max(0, Math.min(127, event.pitch + GetParameter("Semitones")));
  }}
  event.send();
}}
"""


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_notes(value: str) -> list[int]:
    try:
        notes = [int(item.strip()) for item in value.split(",") if item.strip()]
    except ValueError as error:
        raise argparse.ArgumentTypeError("notes must be comma-separated integers") from error
    if not notes:
        raise argparse.ArgumentTypeError("at least one note is required")
    if any(note < 0 or note > 127 for note in notes):
        raise argparse.ArgumentTypeError("notes must be in the MIDI range 0 through 127")
    return notes


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--semitones", type=int, required=True, choices=range(-24, 25), metavar="-24..24")
    parser.add_argument("--notes", type=parse_notes, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--oracle", type=Path, required=True)
    args = parser.parse_args()

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.oracle.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(SCRIPT.format(semitones=args.semitones), encoding="utf-8")

    output_notes = [max(0, min(127, note + args.semitones)) for note in args.notes]
    oracle = {
        "schema_version": 1,
        "scope": "portable source and vector preparation only",
        "logic_execution_tested": False,
        "semitones": args.semitones,
        "input_notes": args.notes,
        "expected_output_notes": output_notes,
        "source_file": args.output.name,
        "source_sha256": digest(args.output),
        "required_live_checks": [
            "load in current Logic Scripter",
            "compare observed MIDI events with this oracle",
            "verify matching note-offs and no runaway events",
            "save, close, reopen, and repeat the vector",
        ],
    }
    args.oracle.write_text(json.dumps(oracle, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({"source": str(args.output), "oracle": str(args.oracle), "source_sha256": oracle["source_sha256"]}, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

