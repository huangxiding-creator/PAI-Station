# -*- coding: utf-8 -*-
"""Recover original Chinese docstrings from GBK/gb18030-mojibake constants.

Confirmed mechanism: original UTF-8 bytes were decoded with a GBK-family
codec that maps GBK user-defined zones to PUA (U+E000..). Python's gb18030
codec reproduces that mapping on decode and can ENCODE PUA back to the same
2 bytes. The dump summaries additionally show '?' for a few undecodable
bytes (1-2 lost bytes each) and '€' where the byte was 0x80 (cp936) or the
gb18030 2-byte euro (ambiguous -> also brute-forced).
"""

import itertools
import re
import sys

SUMMARY_FILES = [
    r"E:\AI-Station\逆向工程\IMA下载助手\dump\gui_search_mixin.summary.txt",
    r"E:\AI-Station\逆向工程\IMA下载助手\dump\gui_kb_tree_mixin.summary.txt",
]
OUT_FILE = r"E:\AI-Station\逆向工程\IMA下载助手\tools\docstring_recovery_report.txt"

CONST_RE = re.compile(r"CONST '(.*)'\s*$")
ESC_RE = re.compile(r"\\u([0-9a-fA-F]{4})")
PLACEHOLDER = 0x3F  # '?'


def mojibake_to_bytes(s: str):
    """Mojibake str -> (bytes with '?' placeholders, n_markers)."""
    out = bytearray()
    n = 0
    for ch in s:
        if ch in ("?", "\u20ac"):
            out.append(PLACEHOLDER)
            n += 1
            continue
        try:
            out += ch.encode("gb18030")
        except UnicodeEncodeError as e:
            return None, f"cannot map {ch!r}: {e}"
    return bytes(out), n


SUBS = [bytes([b]) for b in range(0x20, 0x100)] + [
    bytes([b1, b2])
    for b1 in range(0x80, 0x100)
    for b2 in list(range(0x40, 0x7F)) + list(range(0x80, 0x100))
]


def _window_ok(window: bytes) -> bool:
    """Window must decode as UTF-8, tolerating up to 3 leading continuation
    bytes (window may start mid-character) and up to 3 trailing bytes."""
    for lead in range(min(4, len(window))):
        if (window[lead] & 0xC0) == 0x80:
            continue  # continuation byte cannot start a character
        w = window[lead:]
        for cut in range(len(w), max(0, len(w) - 4), -1):
            try:
                w[:cut].decode("utf-8")
                return True
            except UnicodeDecodeError:
                continue
    return False


def recover(s: str):
    raw, n = mojibake_to_bytes(s)
    if raw is None:
        return [], n
    if n == 0:
        try:
            return [raw.decode("utf-8")], "clean round-trip"
        except UnicodeDecodeError as e:
            return [], f"utf-8 fail: {e}"
    if n > 3:
        return [], f"{n} lossy markers, too many"

    pos = [i for i, b in enumerate(raw) if b == PLACEHOLDER]
    locals_ = []
    for p in pos:
        lo = max(0, p - 4)
        hi = min(len(raw), p + 7)
        left = raw[lo:p]
        right = raw[p + 1:hi]
        cands = [sub for sub in SUBS if _window_ok(left + sub + right)]
        if not cands:
            return [], f"no local candidate at byte {p}"
        locals_.append(cands)

    total = 1
    for c in locals_:
        total *= len(c)
    if total > 5_000_000:
        return [], f"search space too big ({total})"

    results = set()
    for combo in itertools.product(*locals_):
        bs = bytearray()
        it = iter(combo)
        for b in raw:
            if b == PLACEHOLDER:
                bs += next(it)
            else:
                bs.append(b)
        try:
            results.add(bs.decode("utf-8"))
        except UnicodeDecodeError:
            continue
    good = [
        r for r in sorted(results)
        if r and sum("\u4e00" <= ch <= "\u9fff" for ch in r) >= 2
    ]
    return good[:60], f"{n} lossy marker(s), {len(good)} candidate(s)"


def unescape(s: str) -> str:
    return ESC_RE.sub(lambda m: chr(int(m.group(1), 16)), s)


def main() -> None:
    lines = []
    for path in SUMMARY_FILES:
        lines.append(f"===== {path} =====")
        with open(path, "r", encoding="utf-8", errors="strict") as f:
            for line in f:
                m = CONST_RE.search(line.rstrip("\n"))
                if not m:
                    continue
                s = unescape(m.group(1))
                if not any("一" <= ch <= "鿿" for ch in s):
                    continue  # pure ASCII/latin constants cannot be mojibake
                cands, note = recover(s)
                if not cands:
                    if any("\ue000" <= ch <= "\uf8ff" for ch in s) or (
                            "?" in s and any("\u4e00" <= ch <= "\u9fff" for ch in s)):
                        lines.append(f"  FAILED : {s!r}  ({note})")
                    continue
                lines.append(f"  mojibake : {s!r}")
                for c in cands:
                    lines.append(f"  RECOVERED: {c}")
                lines.append(f"  note     : {note}")
        lines.append("")
    with open(OUT_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"wrote {OUT_FILE}")


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    main()
