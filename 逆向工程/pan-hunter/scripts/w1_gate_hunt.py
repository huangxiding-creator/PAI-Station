# -*- coding: utf-8 -*-
"""W1 门链狩猎：9 活源搜索 → 按盘型分桶候选分享链（analysis/w1_gate_links.json）

预算：34 发主射（6 关键词×5 泛盘源 + 2 关键词×2 影视源）；重试另计入台账。
"""
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from searchagg import SearchSession, SearchLedger   # noqa: E402

KWS_GENERAL = ["Python 教程", "考研数学 真题", "纪录片 4K 合集", "PS2024 绿色版",
               "有声书 MP3", "CAD 图库"]
SRC_GENERAL = ["melost", "hunhepan", "naspt", "panhunt", "pansearch"]
KWS_MEDIA = ["电影 4K", "短剧 合集"]
SRC_MEDIA = ["mikuclub", "tg_tgsearchers7"]

ledger = SearchLedger(str(ROOT / "analysis" / "w1_gatehunt_ledger.jsonl"))
buckets: dict[str, list[dict]] = {}
t0 = time.time()
jobs = [(kw, s) for kw in KWS_GENERAL for s in SRC_GENERAL] + \
       [(kw, s) for kw in KWS_MEDIA for s in SRC_MEDIA]
for i, (kw, src) in enumerate(jobs, 1):
    s = SearchSession(src, ledger)
    hits = s.search(kw)
    for h in hits:
        buckets.setdefault(h.disk, []).append({"url": h.url, "kw": kw, "source": src})
    print(f"[{i:02d}/{len(jobs)}] {src:16s} {kw[:14]:14s} -> {len(hits):3d} hits "
          f"(total {ledger.shots})", flush=True)

out = ROOT / "analysis" / "w1_gate_links.json"
out.write_text(json.dumps(buckets, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n== 分桶（盘型: 链数）==")
for d in sorted(buckets, key=lambda x: -len(buckets[x])):
    print(f"  {d:10s} {len(buckets[d])}")
print(f"台账 {ledger.shots} 发 / {round(time.time()-t0)}s -> {out}")
