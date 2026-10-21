#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""终局：解密全部品类模板 → 雕出 zip 容器 → 落盘 .docx → 清点内容。
CBC 特性：IV 误读只毁第一块；从首个 PK\\x03\\x04 雕到 EOCD。"""
import base64
import sys
import zipfile
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
    "desc_base": BASE / "publictemplates" / "desc_base_template",
    "bid": BASE / "presettemplates" / "bid",
    "contract": BASE / "presettemplates" / "contract",
    "general": BASE / "presettemplates" / "general",
    "custom_bid": BASE / "customtemplates" / "bid",
    "custom_contract": BASE / "customtemplates" / "contract",
    "custom_general": BASE / "customtemplates" / "general",
    "custom_official": BASE / "customtemplates" / "official",
    "custom_thesis": BASE / "customtemplates" / "thesis",
}


def decrypt_blob(blob):
    ct = blob[7:]
    d = Cipher(algorithms.AES(K1), modes.CBC(K2)).decryptor()
    return d.update(ct) + d.finalize()


def carve_zip(data: bytes):
    start = data.find(b"PK\x03\x04")
    if start < 0:
        return None, "无 PK 本地头"
    eocd = data.rfind(b"PK\x05\x06")
    if eocd < 0:
        return None, "无 EOCD"
    end = eocd + 22
    comment_len = int.from_bytes(data[eocd + 20:eocd + 22], "little")
    end += comment_len
    return data[start:end], f"PK@{start} EOCD@{eocd} 前导{start}B"


def main():
    wins = 0
    for name, path in SAMPLES.items():
        if not path.is_file():
            print(f"[{name}] 跳过（路径非文件）")
            continue
        raw = path.read_bytes()
        blob = base64.b64decode("".join(raw[12:].decode("ascii", "ignore").split()), validate=True)
        if (len(blob) - 7) % 16:
            print(f"[{name}] blob 长度不合 (mod16={(len(blob)-7)%16})")
            continue
        pt = decrypt_blob(blob)
        zbytes, why = carve_zip(pt)
        if zbytes is None:
            print(f"[{name}] ✗ {why}；解密头64B={pt[:64]!r}")
            continue
        out = OUT / f"{name}.docx"
        out.write_bytes(zbytes)
        try:
            names = zipfile.ZipFile(out).namelist()
            print(f"[{name}] ✔ {why} → {out.name} ({len(zbytes)}B, {len(names)} 条目) 首三: {names[:3]}")
            wins += 1
        except Exception as e:
            print(f"[{name}] ⚠ zip 解析失败: {e}")
    print(f"\n战果: {wins}/{len(SAMPLES)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
