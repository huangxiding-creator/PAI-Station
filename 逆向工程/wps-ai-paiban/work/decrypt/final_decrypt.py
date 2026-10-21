#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""品类模板终局解密器 —— 密钥来自 Ghidra 反编译（FUN_10013020 反混淆）。
容器 = 12B ASCII 魔数 + base64 正文；内层（Ghidra FUN_1001c260: fromBase64→AES-CBC）。
key=5FE71BD15A854390(ASCII 16B) iv=96D8FDE5E10A6321(ASCII 16B)；blob 头部或有短内层头（A1: len≡7 mod16 → 疑 7B 头）。
"""
import base64
import re
import sys
from pathlib import Path

from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

BASE = Path(r"C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN")
OUT = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\work\decrypt\out_final")
OUT.mkdir(parents=True, exist_ok=True)

KEY = b"5FE71BD15A854390"
IV = b"96D8FDE5E10A6321"
SAMPLES = {
    "official": BASE / "presettemplates" / "official",
    "nationalstandard": BASE / "presettemplates" / "thesis" / "standard" / "nationalstandard",
    "public_official": BASE / "publictemplates" / "public_official_template",
    "desc_base": BASE / "publictemplates" / "desc_base_template",
    "bid": BASE / "presettemplates" / "bid",
    "contract": BASE / "presettemplates" / "contract",
    "general": BASE / "presettemplates" / "general",
    "thesis": BASE / "presettemplates" / "thesis",
}
MAGICS = {b"PK\x03\x04": "zip/docx", b"\xd0\xcf\x11\xe0": "OLE(wps/doc)", b"{": "json", b"<": "xml/html"}


def try_decrypt(blob: bytes, key: bytes, iv: bytes):
    dec = Cipher(algorithms.AES(key), modes.CBC(iv)).decryptor()
    return dec.update(blob) + dec.finalize()


def score(data: bytes):
    for magic, name in MAGICS.items():
        if data[:4] == magic or data[:1] == magic:
            return 100, name
    printable = sum(1 for b in data[:512] if 32 <= b < 127 or b in (9, 10, 13))
    ratio = printable / min(len(data), 512)
    cjk = len(re.findall(b"[\xe4-\xe9][\x80-\xbf][\x80-\xbf]", data[:2048]))
    return int(ratio * 50) + min(cjk, 50), f"printable={ratio:.2f} cjk={cjk}"


def main():
    for name, path in SAMPLES.items():
        raw = path.read_bytes()
        magic, body = raw[:12], raw[12:]
        try:
            blob = base64.b64decode("".join(body.decode("ascii", "ignore").split()), validate=True)
        except Exception as e:
            print(f"[{name}] base64 失败: {e}")
            continue
        hits = []
        for off in (0, 3, 7, 11, 15, 16):
            ct = blob[off:]
            if len(ct) == 0 or len(ct) % 16:
                continue
            for k, i, tag in ((KEY, IV, "k1i2"), (IV, KEY, "k2i1")):
                try:
                    pt = try_decrypt(ct, k, i)
                except Exception:
                    continue
                s, why = score(pt)
                if s >= 60:
                    hits.append((s, off, tag, why, pt))
        if not hits:
            print(f"[{name}] magic={magic!r} blob={len(blob)}B 无有效解（全部偏移/键序组合失败）")
            continue
        hits.sort(reverse=True)
        s, off, tag, why, pt = hits[0]
        out = OUT / f"{name}.bin"
        out.write_bytes(pt)
        print(f"[{name}] ✔ offset={off} {tag} score={s} ({why}) -> {out} ({len(pt)}B) 头16B={pt[:16].hex()}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
