# -*- coding: utf-8 -*-
"""Read-only signature scan of the ThiFlow installer (no execution of target)."""
import sys, re

path = r"e:\AI-Station\逆向工程\逆向标的\识流AI助手 Setup 2.0.3.exe"
data = open(path, "rb").read()
print("size:", len(data))

# NSIS marker
for marker in (b"Nullsoft", b"NSIS", b"electron-builder", b"nsis"):
    idxs = [m.start() for m in re.finditer(re.escape(marker), data)][:5]
    print(marker, "->", idxs)

# 7z signature
sig7z = bytes.fromhex("377abcaf271c")
idxs = [m.start() for m in re.finditer(re.escape(sig7z), data)]
print("7z signature ->", idxs[:10], "count:", len(idxs))

# zip local header / central dir markers (electron-builder may embed web assets)
zipidx = [m.start() for m in re.finditer(re.escape(b"PK\x03\x04"), data)]
print("zip local headers count:", len(zipidx), zipidx[:10])

# asar header possibility
ai = [m.start() for m in re.finditer(re.escape(b'"main"'), data)][:5]
print('"main" json hits ->', ai)

# Look for readable URLs (API endpoints) in the clear
urls = set(re.findall(rb"https?://[\x21-\x7e]{6,80}", data))
interesting = [u for u in urls if any(k in u.lower() for k in (b"thiflow", b"shiliu", b"api", b"wechat", b"weixin", b"wx", b"s3", b"oss", b"cdn"))]
print("interesting urls:", len(interesting))
for u in sorted(interesting)[:60]:
    print("  ", u.decode("utf-8", "replace"))
