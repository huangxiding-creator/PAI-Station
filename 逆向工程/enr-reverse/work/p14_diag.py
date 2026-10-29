# -*- coding: utf-8 -*-
import sys, io, json, time
sys.path.insert(0, "E:/AI-Station/逆向工程/enr-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from enr_api import ENRClient

t0 = time.time()
c = ENRClient()
data = c.pull(2024)
gates = c.verify(data)
print("elapsed", round(time.time()-t0, 1), "s | solves:", c.cc.solve_count)
print("coverage:", json.dumps(data["coverage"], ensure_ascii=False))
print("facts:", json.dumps(data["facts"], ensure_ascii=False)[:300])
print("images:", json.dumps(data["images"], ensure_ascii=False))
print("gates:", json.dumps(gates, ensure_ascii=False)[:800])
print("\nintl_table 样例:")
for x in data["intl_table"][:12]:
    print("  ", x["rank"], x.get("rank_prev"), round(x["rev_intl_musd"],1) if x.get("rev_intl_musd") else None, x["firm"][:40], "inferred" if x.get("inferred") else "")
print("  ...")
for x in data["intl_table"][-4:]:
    print("  ", x["rank"], x.get("rank_prev"), x.get("rev_intl_musd"), x["firm"][:40], "inferred" if x.get("inferred") else "")
print("\ncn_list 样例:", json.dumps(data["cn_list"][:5], ensure_ascii=False))
# 完整落盘
json.dump({"data": data, "gates": gates}, open("E:/AI-Station/逆向工程/enr-reverse/work/p14_2024_full.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("saved p14_2024_full.json")
