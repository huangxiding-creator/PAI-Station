#!/usr/bin/env python3
"""Emit objective WAV headers and SHA-256 values without judging audio quality."""

from __future__ import annotations

import hashlib
import json
import sys
import wave
from pathlib import Path


def inspect(path: Path) -> dict[str, object]:
    data = path.read_bytes()
    with wave.open(str(path), "rb") as handle:
        frames = handle.getnframes()
        rate = handle.getframerate()
        return {
            "path": str(path),
            "sha256": hashlib.sha256(data).hexdigest(),
            "channels": handle.getnchannels(),
            "sample_width_bytes": handle.getsampwidth(),
            "sample_rate_hz": rate,
            "frames": frames,
            "duration_seconds": round(frames / rate, 6),
        }


def main() -> None:
    paths = [Path(arg) for arg in sys.argv[1:]]
    if not paths:
        raise SystemExit("usage: inspect_wav.py FILE.wav [FILE.wav ...]")
    try:
        result = [inspect(path) for path in paths]
    except (EOFError, OSError, wave.Error) as error:
        detail = str(error) or type(error).__name__
        raise SystemExit(f"invalid or unreadable WAV: {detail}") from None
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
