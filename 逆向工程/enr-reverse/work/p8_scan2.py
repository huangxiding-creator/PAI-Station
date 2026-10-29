# -*- coding: utf-8 -*-
"""P8: notice/coc/research 栏找 ENR 年度榜文 (2026/2025版)"""
import sys, io, json, re, time
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
PAT = re.compile(r"ENR|国际承包商", re.I)
hits = {}
for col, maxp in [("notice", 25), ("coc", 25), ("research", 25)]:
    for p in range(1, maxp+1):
        try:
            items, _ = c.list_column(column=col, page=p)
        except Exception as e:
            print(f"{col} p{p} ERR {str(e)[:50]}"); time.sleep(2); continue
        for it in items:
            if PAT.search(it.get("title","")):
                k = it["title"][:60]
                if k not in hits:
                    hits[k] = dict(col=col, page=p, **it)
                    print("HIT:", json.dumps(hits[k], ensure_ascii=False))
        time.sleep(0.3)
json.dump(list(hits.values()), open("E:/AI-Station/逆向工程/enr-reverse/work/p8_hits.json","w",encoding="utf-8"), ensure_ascii=False, indent=1)
print("TOTAL", len(hits))
