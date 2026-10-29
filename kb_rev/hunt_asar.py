# -*- coding: utf-8 -*-
"""在解包块中猎杀 app.asar（\x04 + {"files" 头签名）并读文件名表。"""
import os

OUT = r"E:\AI-Station\kb_rev\nsis_out"
for fn in sorted(os.listdir(OUT)):
    if not fn.startswith("blk"):
        continue
    p = os.path.join(OUT, fn)
    sz = os.path.getsize(p)
    with open(p, "rb") as f:
        head = f.read(64)
    if head[:4] == b"\x04\x00\x00\x00" or b'{"files' in head[:32]:
        print("ASAR?", fn, sz, head[:24].hex())
    if head[:1] == b"{" and b"files" in head[:20]:
        print("JSON-FILES?", fn, sz, head[:48])
print("---- names_all.txt ----")
print(open(os.path.join(OUT, "names_all.txt"), encoding="utf-8").read())
