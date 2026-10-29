# -*- coding: utf-8 -*-
"""P10: 2026版文章 + 表格图"""
import sys, io, re
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
for label, url in [("2026", "/CICA/info/26082609115911"), ("2025", "/CICA/info/25082215040911")]:
    art = c.get_article(url)
    print(f"\n##### {label} {url}")
    print("title:", art["title"], "| date:", art["date"], "| len:", art["content_len"])
    print("head:", art["content"][:400].replace("\n", " / "))
    # 图片
    r = c.get(url)
    imgs = re.findall(r'<img[^>]+src="(/upload/image/[^"]+|/files/[^"]+)"', r.text)
    print("content imgs:", len(imgs))
    for p in imgs:
        rr = c.get(p)
        fn = f"E:/AI-Station/逆向工程/enr-reverse/captures/p10_{label}_" + p.split("/")[-1][:24]
        open(fn, "wb").write(rr.content)
        b = rr.content
        dim = (int.from_bytes(b[16:20],"big"), int.from_bytes(b[20:24],"big")) if b[:8]==b"\x89PNG\r\n\x1a\n" else "-"
        print("  saved", fn.split("/")[-1], len(rr.content), dim)
    open(f"E:/AI-Station/逆向工程/enr-reverse/captures/p10_{label}_article.txt", "w", encoding="utf-8").write(art["content"])
