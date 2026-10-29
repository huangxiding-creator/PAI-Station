# -*- coding: utf-8 -*-
import sys, io, json, time
sys.path.insert(0, "E:/AI-Station/逆向工程/enr-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from enr_api import ENRClient

c = ENRClient()
for year in [2026, 2025]:
    t0 = time.time()
    try:
        d = c.pull(year)
        g = c.verify(d)
        print(f"\n### {year}: {round(time.time()-t0,1)}s")
        print("coverage:", json.dumps(d["coverage"], ensure_ascii=False))
        print("facts:", json.dumps(d["facts"], ensure_ascii=False)[:200])
        print("g1:", g["g1_top_text_vs_ocr"]["matched"], "/", g["g1_top_text_vs_ocr"]["pairs"],
              json.dumps(g["g1_top_text_vs_ocr"]["detail"][:4], ensure_ascii=False))
        print("g2:", g["g2_monotonic_intl_rev"])
        print("g3:", g.get("g3_cn_count"))
        print("top5:", [(x["rank"], x["firm"][:24], x.get("rev_intl_musd")) for x in d["intl_table"][:5]])
        json.dump({"data": d, "gates": g}, open(f"E:/AI-Station/逆向工程/enr-reverse/work/p16_{year}_full.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    except Exception as e:
        print(f"### {year} ERR: {type(e).__name__} {str(e)[:150]}")
print("DONE")
