#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""定点解剖：head=7 切片 + k1/k2 的解密产物直接目检 + base64 二层假设检验。"""
import base64
import sys
from pathlib import Path

from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

BASE = Path(r"C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN")
K1 = b"5FE71BD15A854390"
K2 = b"96D8FDE5E10A6321"
OUT = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\work\decrypt\out_final")
OUT.mkdir(parents=True, exist_ok=True)


def dec(ct, key, iv):
    d = Cipher(algorithms.AES(key), modes.CBC(iv)).decryptor()
    return d.update(ct) + d.finalize()


def show(tag, data):
    printable = sum(1 for b in data if 32 <= b < 127 or b in (9, 10, 13)) / max(len(data), 1)
    print(f"  [{tag}] len={len(data)} printable={printable:.3f} 头64B={data[:64]!r}")


for name in ("official", "nationalstandard", "bid", "public_official"):
    p = {
        "official": BASE / "presettemplates" / "official",
        "nationalstandard": BASE / "presettemplates" / "thesis" / "standard" / "nationalstandard",
        "bid": BASE / "presettemplates" / "bid",
        "public_official": BASE / "publictemplates" / "public_official_template",
    }[name]
    raw = p.read_bytes()
    blob = base64.b64decode("".join(raw[12:].decode("ascii", "ignore").split()), validate=True)
    print(f"== {name} blob={len(blob)} 前8B={blob[:8].hex()} ==")
    for head, tail in ((7, 0), (0, 0), (3, 0)):
        L = len(blob) - head - tail
        if L % 16:
            print(f"  head={head} 不对齐(mod16={L%16})")
            continue
        ct = blob[head:]
        for key, iv, tag in ((K1, K2, "k1/k2"), (K2, K1, "k2/k1")):
            try:
                pt = dec(ct, key, iv)
            except Exception as e:
                print(f"  head={head} {tag} 异常 {e}")
                continue
            show(f"head={head} {tag}", pt)
            # base64 二层假设：解密产物若是 base64 文本 → 再解一层
            try:
                txt = pt.decode("ascii")
                stripped = "".join(txt.split())
                if stripped and all(c in "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=" for c in stripped):
                    inner = base64.b64decode(stripped)
                    print(f"      -> 二层base64成立! len={len(inner)} 头8B={inner[:8].hex()}")
                    if inner[:4] in (b"PK\x03\x04", b"\xd0\xcf\x11\xe0"):
                        out = OUT / f"{name}.final"
                        out.write_bytes(inner)
                        print(f"      -> 🎯 容器命中! 已写出 {out}")
            except Exception:
                pass
