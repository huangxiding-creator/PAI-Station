#!/usr/bin/env python3
"""Read-only structural inspection for PCM WAV and Standard MIDI files."""

from __future__ import annotations

import argparse
import hashlib
import json
import struct
import wave
from pathlib import Path


class InspectionError(Exception):
    pass


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def inspect_wav(path: Path) -> dict[str, object]:
    try:
        with wave.open(str(path), "rb") as source:
            channels = source.getnchannels()
            sample_width = source.getsampwidth()
            sample_rate = source.getframerate()
            frames = source.getnframes()
            compression = source.getcomptype()
    except (wave.Error, EOFError) as error:
        raise InspectionError(f"invalid WAV: {error}") from error
    duration = frames / sample_rate if sample_rate else None
    return {
        "kind": "wav",
        "channels": channels,
        "sample_width_bits": sample_width * 8,
        "sample_rate_hz": sample_rate,
        "frames": frames,
        "duration_seconds": round(duration, 9) if duration is not None else None,
        "compression": compression,
    }


def read_vlq(data: bytes, offset: int) -> tuple[int, int]:
    value = 0
    for _ in range(4):
        if offset >= len(data):
            raise InspectionError("truncated variable-length quantity")
        byte = data[offset]
        offset += 1
        value = (value << 7) | (byte & 0x7F)
        if not byte & 0x80:
            return value, offset
    raise InspectionError("variable-length quantity exceeds four bytes")


def parse_midi_track(track: bytes) -> dict[str, object]:
    offset = 0
    absolute_tick = 0
    running_status: int | None = None
    tempo_us_per_quarter: list[int] = []
    time_signatures: list[dict[str, int]] = []
    note_on_count = 0
    note_off_count = 0
    note_off_without_on = 0
    note_pitches: list[int] = []
    active_notes: dict[tuple[int, int], int] = {}

    while offset < len(track):
        delta, offset = read_vlq(track, offset)
        absolute_tick += delta
        if offset >= len(track):
            raise InspectionError("track ends before event status")

        byte = track[offset]
        if byte & 0x80:
            status = byte
            offset += 1
            if status < 0xF0:
                running_status = status
        elif running_status is not None:
            status = running_status
        else:
            raise InspectionError("data byte without running status")

        if status == 0xFF:
            running_status = None
            if offset >= len(track):
                raise InspectionError("truncated meta event")
            meta_type = track[offset]
            offset += 1
            length, offset = read_vlq(track, offset)
            payload = track[offset : offset + length]
            if len(payload) != length:
                raise InspectionError("truncated meta-event payload")
            offset += length
            if meta_type == 0x51 and length == 3:
                tempo_us_per_quarter.append(int.from_bytes(payload, "big"))
            elif meta_type == 0x58 and length >= 2:
                time_signatures.append({"numerator": payload[0], "denominator": 2 ** payload[1]})
            elif meta_type == 0x2F:
                break
            continue

        if status in (0xF0, 0xF7):
            running_status = None
            length, offset = read_vlq(track, offset)
            offset += length
            if offset > len(track):
                raise InspectionError("truncated system-exclusive payload")
            continue

        if status >= 0xF0:
            raise InspectionError(f"unsupported system event {status:#x}")

        event_type = status & 0xF0
        channel = status & 0x0F
        data_length = 1 if event_type in (0xC0, 0xD0) else 2
        payload = track[offset : offset + data_length]
        if len(payload) != data_length:
            raise InspectionError("truncated channel event")
        offset += data_length

        if event_type == 0x90 and payload[1] != 0:
            pitch = payload[0]
            note_on_count += 1
            note_pitches.append(pitch)
            active_notes[(channel, pitch)] = active_notes.get((channel, pitch), 0) + 1
        elif event_type == 0x80 or (event_type == 0x90 and payload[1] == 0):
            pitch = payload[0]
            note_off_count += 1
            key = (channel, pitch)
            if active_notes.get(key, 0) > 1:
                active_notes[key] -= 1
            elif active_notes.get(key, 0) == 1:
                active_notes.pop(key, None)
            else:
                note_off_without_on += 1

    unmatched = [
        {"channel": channel + 1, "pitch": pitch, "count": count}
        for (channel, pitch), count in sorted(active_notes.items())
    ]
    return {
        "last_tick": absolute_tick,
        "tempo_us_per_quarter": tempo_us_per_quarter,
        "tempo_bpm": [round(60_000_000 / tempo, 6) for tempo in tempo_us_per_quarter if tempo],
        "time_signatures": time_signatures,
        "note_on_count": note_on_count,
        "note_off_count": note_off_count,
        "note_off_without_on": note_off_without_on,
        "note_pitches": note_pitches,
        "unmatched_note_ons": unmatched,
    }


def inspect_midi(path: Path) -> dict[str, object]:
    data = path.read_bytes()
    if len(data) < 14 or data[:4] != b"MThd":
        raise InspectionError("missing MIDI header")
    header_length = int.from_bytes(data[4:8], "big")
    if header_length < 6 or len(data) < 8 + header_length:
        raise InspectionError("invalid MIDI header length")
    midi_format, declared_tracks, division = struct.unpack(">HHH", data[8:14])
    if midi_format not in (0, 1, 2):
        raise InspectionError(f"unsupported Standard MIDI format {midi_format}")
    if division & 0x8000:
        timebase: dict[str, object] = {"type": "smpte", "raw_division": division}
    else:
        timebase = {"type": "ppq", "ticks_per_quarter": division}

    offset = 8 + header_length
    tracks: list[dict[str, object]] = []
    while offset < len(data):
        if data[offset : offset + 4] != b"MTrk" or offset + 8 > len(data):
            raise InspectionError(f"invalid track header at byte {offset}")
        length = int.from_bytes(data[offset + 4 : offset + 8], "big")
        start = offset + 8
        end = start + length
        if end > len(data):
            raise InspectionError("truncated MIDI track")
        tracks.append(parse_midi_track(data[start:end]))
        offset = end

    if len(tracks) != declared_tracks:
        raise InspectionError(f"declared {declared_tracks} tracks but parsed {len(tracks)}")

    return {
        "kind": "midi",
        "smf_format": midi_format,
        "declared_tracks": declared_tracks,
        "parsed_tracks": len(tracks),
        "timebase": timebase,
        "tracks": tracks,
    }


def inspect(path: Path) -> dict[str, object]:
    base: dict[str, object] = {
        "path": str(path),
        "size_bytes": path.stat().st_size,
        "sha256": sha256(path),
    }
    suffix = path.suffix.lower()
    if suffix in {".wav", ".wave"}:
        base.update(inspect_wav(path))
    elif suffix in {".mid", ".midi"}:
        base.update(inspect_midi(path))
    else:
        raise InspectionError("supported extensions are .wav, .wave, .mid, and .midi")
    return base


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("inputs", nargs="+", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()

    results: list[dict[str, object]] = []
    failed = False
    for path in args.inputs:
        try:
            if not path.is_file():
                raise InspectionError("file does not exist")
            results.append({"status": "ok", **inspect(path)})
        except (InspectionError, OSError) as error:
            failed = True
            results.append({"status": "error", "path": str(path), "error": str(error)})

    report = {"schema_version": 1, "read_only": True, "files": results}
    payload = json.dumps(report, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.write_text(payload, encoding="utf-8")
    else:
        print(payload, end="")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
