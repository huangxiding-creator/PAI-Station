#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""IV 十六进制变体终测：AES key 已确证（块2+全对），只差块1 的真 IV。"""
import base64
import hashlib
import string
from pathlib import Path

from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

BASE = Path(r"C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN")
K1 = b"5FE71BD15A854390"
K2 = b"96D8FDE5E10A6321"
PRINTABLE = set(string.printable.encode())


def readable(b):
    return sum(1 for x in b if x in PRINTABLE) / len(b)


def main():
    raw = (BASE / "presettemplates" / "official").read_bytes()
    blob = base64.b64decode("".join(raw[12:].decode("ascii", "ignore").split()), validate=True)
    ct = blob[7:]
    d = Cipher(algorithms.AES(K1), modes.CBC(K2)).decryptor()
    wrong = d.update(ct) + d.finalize()
    d_ct1 = bytes(a ^ b for a, b in zip(wrong[:16], K2))
    h2 = bytes.fromhex(K2.decode())          # 8B
    h1 = bytes.fromhex(K1.decode())          # 8B
    cands = {
        "hex(K2)+零8": h2 + b"\x00" * 8, "hex(K2)×2": h2 * 2, "hex(K2)+hex(K1)": h2 + h1,
        "hex(K1)+hex(K2)": h1 + h2, "hex(K1)×2": h1 * 2, "hex(K2)rev+零": h2[::-1] + b"\x00" * 8,
        "md5(K1)": hashlib.md5(K1).digest(), "md5(K2)": hashlib.md5(K2).digest(),
        "md5(K1+K2)": hashlib.md5(K1 + K2).digest(), "md5(hexK2)": hashlib.md5(h2).digest(),
        "sha256(K2)[:16]": hashlib.sha256(K2).digest()[:16],
        "utf16le(K2)": K2.decode().encode("utf-16-le")[:16],
        "尾块IV(ct[-16:])": ct[-16:],
        "头块自IV(ct[:16])": ct[:16],
        "头7B+零9": blob[:7] + b"\x00" * 9,
        "头7B重复+4B": (blob[:7] * 3)[:16],
    }
    for name, iv in cands.items():
        pt = bytes(a ^ b for a, b in zip(d_ct1, iv))
        r = readable(pt)
        mark = "✔" if r > 0.85 else " "
        print(f"{mark} {name:<18} r={r:.2f} {pt!r}")
    print(f"\n[锚] 真明文[16:23]={'cProps/'.encode()!r}（CBC 块2 与 IV 无关，已确证）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
