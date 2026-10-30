# -*- coding: utf-8 -*-
"""W0 源效度审计跑批（2026-10-30）——出口硬门：实测活源数基线。

用法：python audit_w0.py [关键词1 关键词2 关键词3]
默认关键词（任务书指定）：民法典 / 水电站 施工组织 / 机器学习
产出：analysis/source_audit_1030.jsonl（逐发台账）+ 终端汇总（SOURCE_AUDIT_1030.md 由人工+CLI 汇总合成）
"""
import json
import os
import sys
import time
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")

import core
from recipes import RECIPES

KEYWORDS = sys.argv[1:4] if len(sys.argv) >= 4 else ["民法典", "水电站 施工组织", "机器学习"]
JSONL = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                      "..", "..", "analysis", "source_audit_1030.jsonl"))
os.makedirs(os.path.dirname(JSONL), exist_ok=True)

t0 = time.time()
print(f"== W0 源效度审计 == 源数={len(RECIPES)} 关键词={KEYWORDS} 并发≤{core.MAX_GLOBAL_CONCURRENCY} 预算={core.BUDGET_TOTAL}")
rows = core.run_audit(RECIPES, KEYWORDS, JSONL)

# --- 汇总（数字零造假：全部来自实测行）---
by_verdict = Counter(r.verdict for r in rows)
src_verdicts: dict[str, list[str]] = {}
for r in rows:
    src_verdicts.setdefault(r.source, []).append(r.verdict)

live_sources, empty_sources, shell_sources, cf_sources, wall_sources, dead_sources = [], [], [], [], [], []
for src, vs in src_verdicts.items():
    if any(v.startswith("LIVE") for v in vs):
        live_sources.append(src)
    elif "WALL_PROXY" in vs or "CF_CHALLENGE" in vs:
        (cf_sources if "CF_CHALLENGE" in vs else wall_sources).append(src)
    elif "ALIVE_SHELL" in vs:
        shell_sources.append(src)
    elif "ALIVE_EMPTY" in vs:
        empty_sources.append(src)
    else:
        dead_sources.append(src)

total_hits = sum(r.hits for r in rows if r.verdict.startswith("LIVE"))
print("\n== 汇总 ==")
print(f"对外请求总数={core.spent()}（预算 {core.BUDGET_TOTAL}）耗时={time.time()-t0:.0f}s")
print(f"verdict 分布: {dict(by_verdict)}")
print(f"实测活源(LIVE*)={len(live_sources)}: {sorted(live_sources)}")
print(f"活而零命中={len(empty_sources)}: {sorted(empty_sources)}")
print(f"SPA壳={len(shell_sources)}: {sorted(shell_sources)}")
print(f"CF质询墙={len(cf_sources)}: {sorted(cf_sources)}")
print(f"直连被墙(代理通)={len(wall_sources)}: {sorted(wall_sources)}")
print(f"死源={len(dead_sources)}: {sorted(dead_sources)}")
print(f"LIVE 总命中条目={total_hits}")

summary = {"spent": core.spent(), "by_verdict": dict(by_verdict),
           "live": sorted(live_sources), "empty": sorted(empty_sources),
           "shell": sorted(shell_sources), "cf": sorted(cf_sources),
           "wall_proxy": sorted(wall_sources), "dead": sorted(dead_sources),
           "total_hits": total_hits}
with open(os.path.splitext(JSONL)[0] + "_summary.json", "w", encoding="utf-8") as f:
    json.dump(summary, f, ensure_ascii=False, indent=1)
print(f"台账: {JSONL}")
