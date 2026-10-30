# -*- coding: utf-8 -*-
"""W1 稀有盘定向狩猎（第二轮）：TG 按盘名 + melost 软件词 + naspt/panhunt 诊断
输出并入 analysis/w1_gate_links.json 分桶（追加）。
"""
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from searchagg import SearchSession, SearchLedger   # noqa: E402
from recipes import RECIPES, build_request          # noqa: E402

JOBS = [
    ("115", "tg_tgsearchers7"), ("123", "tg_tgsearchers7"),
    ("蓝奏", "tg_tgsearchers7"), ("小飞机", "tg_tgsearchers7"),
    ("奶牛快传", "tg_tgsearchers7"), ("文叔叔", "tg_tgsearchers7"),
    ("蓝奏", "melost"), ("字体 打包", "melost"), ("Pr 插件", "pansearch"),
    ("考研 英语", "hunhepan"),
]

p = ROOT / "analysis" / "w1_gate_links.json"
buckets = json.loads(p.read_text(encoding="utf-8"))
ledger = SearchLedger(str(ROOT / "analysis" / "w1_gatehunt_ledger.jsonl"))

for kw, src in JOBS:
    s = SearchSession(src, ledger)
    hits = s.search(kw)
    n_new = 0
    for h in hits:
        b = buckets.setdefault(h.disk, [])
        if not any(x["url"] == h.url for x in b):
            b.append({"url": h.url, "kw": kw, "source": src})
            n_new += 1
    print(f"[{src:16s}] {kw[:12]:12s} -> {len(hits):3d} hits (+{n_new} 新) 总{ledger.shots}",
          flush=True)

# naspt/panhunt 诊断（各 1 发，看原始响应摘要）
from searchagg import extract_hits
for src in ("naspt", "panhunt"):
    recipe = next(r for r in RECIPES if r["name"] == src)
    s = SearchSession(src, ledger)
    s._kw = "Python"
    try:
        method, url, headers, jb, fb = build_request(recipe, "Python")
        from curl_cffi import requests as creq
        kw2 = dict(headers={"User-Agent": "Mozilla/5.0"}, timeout=15, impersonate="chrome124")
        if method == "POST":
            kw2["json"] = jb if jb else None
            if fb:
                kw2.pop("json", None); kw2["data"] = fb
            r = creq.post(url, **kw2)
        else:
            r = creq.get(url, **kw2)
        body = (r.text or "")[:400].replace("\n", " ")
        norm = (r.text or "").replace("\\/", "/")
        print(f"DIAG {src}: status={r.status_code} len={len(r.text or '')} "
              f"hits={len(extract_hits(r.text or '', src))} :: {body[:200]}", flush=True)
    except Exception as e:
        print(f"DIAG {src}: {type(e).__name__} {e}", flush=True)

p.write_text(json.dumps(buckets, ensure_ascii=False, indent=1), encoding="utf-8")
print("\n分桶更新：")
for d in sorted(buckets, key=lambda x: -len(buckets[x])):
    print(f"  {d:10s} {len(buckets[d])}")
