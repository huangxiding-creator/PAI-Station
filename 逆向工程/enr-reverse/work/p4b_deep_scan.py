# -*- coding: utf-8 -*-
"""P4b: chinca intl 栏目深扫 ENR 榜文章 (页1..48)"""
import sys, io, json, re, time
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
PAT = re.compile(r"ENR|250", re.I)
hits = {}
for p in range(1, 49):
    try:
        items, maxp = c.list_column(column="intl", page=p)
    except Exception as e:
        print(f"p{p} ERR {e}"); time.sleep(2); continue
    n = 0
    for it in items:
        if PAT.search(it.get("title", "")):
            key = it["title"][:60]
            if key not in hits:
                hits[key] = dict(col="intl", page=p, **it); n += 1
    if n:
        print(f"p{p}: +{n}")
    time.sleep(0.4)
print("\n=== ENR/250 命中 ===")
for k, v in sorted(hits.items(), key=lambda kv: kv[1].get("date") or "", reverse=True):
    print(json.dumps(v, ensure_ascii=False))
json.dump(list(hits.values()), open("E:/AI-Station/逆向工程/enr-reverse/work/p4b_hits.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("TOTAL", len(hits))
