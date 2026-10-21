#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""首块 IV 取证：CBC 下 true_plain[0:16] = D(ct1) XOR TRUE_IV。
已知 D(ct1) = wrong_plain[0:16] XOR K2(误用IV)。候选 IV 逐一试，找可读前导。"""
import base64
import string
from pathlib import Path

from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

BASE = Path(r"C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN")
K1 = b"5FE71BD15A854390"
K2 = b"96D8FDE5E10A6321"
PRINTABLE = set(string.printable.encode())


def readable(b: bytes):
    return sum(1 for x in b if x in PRINTABLE) / len(b)


def main():
    raw = (BASE / "presettemplates" / "official").read_bytes()
    blob = base64.b64decode("".join(raw[12:].decode("ascii", "ignore").split()), validate=True)
    ct = blob[7:]
    d = Cipher(algorithms.AES(K1), modes.CBC(K2)).decryptor()
    wrong = d.update(ct) + d.finalize()
    d_of_ct1 = bytes(a ^ b for a, b in zip(wrong[:16], K2))   # 消去误用 IV → 纯 D(ct1)
    print(f"wrong[0:16] = {wrong[:16].hex()}")
    print(f"wrong[16:23] = {wrong[16:23]!r}  (PK@23 前的 7B)")
    cands = {
        "零IV": b"\x00" * 16, "K1": K1, "K1rev": K1[::-1], "K2rev": K2[::-1],
        "全空格": b" " * 16, "全F": b"\xff" * 16, "K2hex解码再补": bytes.fromhex(K2.decode()) * 2,
        "blob前16B": blob[:16], "blob[7:23]": blob[7:23], "魔数补零": (b"225f8didjBaA" + b"\x00" * 4),
        "魔数+头7B": raw[:12] + blob[:4],
    }
    for name, iv in cands.items():
        pt = bytes(a ^ b for a, b in zip(d_of_ct1, iv))
        r = readable(pt)
        if r > 0.7:
            print(f"✔ [候选 {name}] readable={r:.2f} -> {pt!r}")
        else:
            print(f"  [候选 {name}] readable={r:.2f} {pt[:8].hex()}")
    # 反向：假设真前导是已知 WPS 容器串 → 推 IV 再互检其他文件
    for crib in (b"PK\x03\x04", b"WPS", b"wps", b"<?xml", b"\x89PNG"):
        pad = crib + b"\x00" * (16 - len(crib))
        iv = bytes(a ^ b for a, b in zip(d_of_ct1, pad))
        print(f"crib={crib!r:12} → 推定IV={iv.hex()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
