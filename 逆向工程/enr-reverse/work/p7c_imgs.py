# -*- coding: utf-8 -*-
import sys, io, re
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
imgs = [
 "/upload/image/20240914/6386190716584735821057666.png",
 "/upload/image/20240914/6386190720698796221956325.png",
 "/upload/image/20240914/6386190721989418155746270.png",
 "/upload/image/20240914/6386190723144108439752196.png",
 "/upload/image/20240914/6386190724411295792314429.png",
]
for i, p in enumerate(imgs):
    r = c.get(p)
    fn = f"E:/AI-Station/逆向工程/enr-reverse/captures/p7_chinca2024_tbl{i+1}.png"
    open(fn, "wb").write(r.content)
    # PNG 尺寸
    b = r.content
    if b[:8] == b"\x89PNG\r\n\x1a\n" and len(b) > 24:
        w = int.from_bytes(b[16:20], "big"); h = int.from_bytes(b[20:24], "big")
        print(fn.split("/")[-1], len(b), "bytes", f"{w}x{h}")
    else:
        print(fn.split("/")[-1], len(b), "bytes NOT-PNG", b[:16])
