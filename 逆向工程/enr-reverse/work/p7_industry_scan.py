# -*- coding: utf-8 -*-
"""P7: chinca industry 栏目深扫 ENR 年度榜文章(2025/2026版)"""
import sys, io, json, re, time
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
PAT = re.compile(r"ENR|国际承包商|250", re.I)
hits = {}
for p in range(1, 61):
    try:
        items, _ = c.list_column(column="industry", page=p)
    except Exception as e:
        print(f"p{p} ERR {str(e)[:60]}"); time.sleep(2); continue
    n = 0
    for it in items:
        if PAT.search(it.get("title", "")):
            k = it["title"][:60]
            if k not in hits:
                hits[k] = dict(page=p, **it); n += 1
    if n: print(f"p{p}: +{n}")
    time.sleep(0.35)
print("\n=== 命中 ===")
for k, v in sorted(hits.items(), key=lambda kv: kv[1].get("date") or "", reverse=True):
    print(json.dumps(v, ensure_ascii=False))
json.dump(list(hits.values()), open("E:/AI-Station/逆向工程/enr-reverse/work/p7_hits.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("TOTAL", len(hits))
