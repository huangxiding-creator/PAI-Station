#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""密文切片爆破：密钥已确证（Ghidra FUN_10013020 手工复验），穷举 (head, tail) 切片 × 键型 × 键序。"""
import base64
import re
import sys
from pathlib import Path

from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

BASE = Path(r"C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN")
OUT = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\work\decrypt\out_final")
OUT.mkdir(parents=True, exist_ok=True)

K1 = b"5FE71BD15A854390"
K2 = b"96D8FDE5E10A6321"
SAMPLES = {
    "official": BASE / "presettemplates" / "official",
    "nationalstandard": BASE / "presettemplates" / "thesis" / "standard" / "nationalstandard",
    "public_official": BASE / "publictemplates" / "public_official_template",
    "bid": BASE / "presettemplates" / "bid",
}
MAGICS = {b"PK\x03\x04": 100, b"\xd0\xcf\x11\xe0": 100, b"{": 70, b"<": 70}


def score(d: bytes):
    for m, s in MAGICS.items():
        if d.startswith(m):
            return s, "magic:" + repr(m)
    printable = sum(1 for b in d[:1024] if 32 <= b < 127 or b in (9, 10, 13)) / min(len(d), 1024)
    cjk = len(re.findall(b"[\xe4-\xe9][\x80-\xbf][\x80-\xbf]", d[:4096]))
    s = int(printable * 40) + min(cjk, 60)
    return s, f"printable={printable:.2f} cjk={cjk}"


def decrypt(ct, key, iv):
    d = Cipher(algorithms.AES(key), modes.CBC(iv)).decryptor()
    return d.update(ct) + d.finalize()


def main():
    keysets = [
        (K1, K2, "128 k1/k2"), (K2, K1, "128 k2/k1"),
        (K1 + K2, K2, "256 k1k2/k2"), (K2 + K1, K1, "256 k2k1/k1"),
        (K1 + K2, K1, "256 k1k2/k1"), (K2 + K1, K2, "256 k2k1/k2"),
    ]
    any_hit = False
    for name, path in SAMPLES.items():
        raw = path.read_bytes()
        blob = base64.b64decode("".join(raw[12:].decode("ascii", "ignore").split()), validate=True)
        n = len(blob)
        best = (0, None)
        for head in range(0, 16):
            for tail in range(0, 16):
                L = n - head - tail
                if L <= 0 or L % 16:
                    continue
                ct = blob[head: n - tail if tail else n]
                for key, iv, tag in keysets:
                    if len(key) not in (16, 24, 32) or len(iv) != 16:
                        continue
                    try:
                        pt = decrypt(ct, key, iv)
                    except Exception:
                        continue
                    s, why = score(pt)
                    if s > best[0]:
                        best = (s, (head, tail, tag, why, pt))
        s, hit = best
        if hit and s >= 60:
            head, tail, tag, why, pt = hit
            out = OUT / f"{name}.dec"
            out.write_bytes(pt)
            print(f"[{name}] ✔ score={s} head={head} tail={tail} {tag} ({why}) 头32B={pt[:32].hex()} -> {out}")
            any_hit = True
        else:
            print(f"[{name}] ✗ 最高分 {s}（无有效切片）")
    return 0 if any_hit else 1


if __name__ == "__main__":
    sys.exit(main())
