# -*- coding: utf-8 -*-
"""P4: chinca intl/industry 栏目扫 ENR Top250 榜文章"""
import sys, io, json, re
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from chinca_api import ChincaClient

c = ChincaClient()
PAT = re.compile(r"ENR|250强|国际承包商|最大250", re.I)
hits = {}
for col in ["intl", "industry"]:
    for p in range(1, 6):
        items, maxp = c.list_column(column=col, page=p)
        for it in items:
            if PAT.search(it.get("title", "")):
                key = it["title"][:60]
                if key not in hits:
                    hits[key] = dict(col=col, page=p, **it)
        print(f"{col} p{p}: {len(items)} items (maxp={maxp})")
print("\n=== ENR榜命中 ===")
for k, v in sorted(hits.items(), key=lambda kv: kv[1].get("date") or "", reverse=True):
    print(json.dumps(v, ensure_ascii=False))
json.dump(list(hits.values()), open("E:/AI-Station/逆向工程/enr-reverse/work/p4_chinca_hits.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("TOTAL", len(hits))
