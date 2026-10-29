# -*- coding: utf-8 -*-
"""Carve the embedded 7z payload from the NSIS installer and extract it (static only)."""
import io, os, struct, sys

SRC = r"e:\AI-Station\逆向工程\逆向标的\识流AI助手 Setup 2.0.3.exe"
OFF = 202062
OUT = r"e:\AI-Station\逆向工程\extracted\app64"

data = open(SRC, "rb").read()
blob = data[OFF:]
print("carved bytes:", len(blob))

# sanity: 7z signature header = 32 bytes; parse NextHeaderOffset/Size to know logical end
sig = blob[:6]
assert sig == bytes.fromhex("377abcaf271c"), sig
version = blob[6:8]
next_hdr_off, next_hdr_size = struct.unpack("<QQ", blob[12:28])
logical_end = 32 + next_hdr_off + next_hdr_size
print("7z logical size:", logical_end)

payload = blob[:logical_end]

import py7zr
os.makedirs(OUT, exist_ok=True)
with py7zr.SevenZipFile(io.BytesIO(payload)) as z:
    names = z.getnames()
    print("entries:", len(names))
    for n in names[:20]:
        print("  ", n)
    z.extractall(path=OUT)
print("extracted to", OUT)
