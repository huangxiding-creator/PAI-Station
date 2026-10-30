# -*- coding: utf-8 -*-
"""W2 终验轮：xunlei（timestamp 字符串修复）/139（caLst 解析+下钻）/quark（pdir_fid 子层）。
预算口径：本轮 ≤20 发；与一轮 42+二轮 63+调试 14 合计 ≤150 铁门。"""
from __future__ import annotations

import json
import sys
import time
import random
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from discovery import DiscoveryLedger, discover_url   # noqa: E402

PLAN = [
    ("xunlei", ["https://pan.xunlei.com/s/VP1hRejZmkpJcRrBpjHraHZ5A1?pwd=4gcx",
                "https://pan.xunlei.com/s/VP2WcZD_P5LYvfTXWNeWF7MOA1",
                "https://pan.xunlei.com/s/VP2Ae5hVGJLvfDXWNeWF7MOA1"]),
    ("139", ["https://yun.139.com/shareweb/#/w/i/2wFGVXneonin0",
             "https://yun.139.com/shareweb/#/w/i/2v3EzZfWKgRkw"]),
    ("quark", ["https://pan.quark.cn/s/4d4f7daa67d3",
               "https://pan.quark.cn/s/0a78c60ed400"]),
]

ledger = DiscoveryLedger(20, str(ROOT / "analysis" / "w2_verify_ledger.jsonl"))
out = []
for disk, urls in PLAN:
    for u in urls:
        try:
            r = discover_url(u, ledger=ledger)
            row = {"disk": disk, "url": u[:80], "ok": r.ok, "alive": r.alive,
                   "state": r.state, "message": r.message[:130],
                   "title": r.title[:60], "n": len(r.entries), "fc": r.file_count,
                   "shots": r.shots,
                   "sample": [f"{'D' if e.is_dir else 'F'}:{e.name[:36]}:{e.size}"
                              for e in r.entries[:4]]}
        except Exception as e:
            row = {"disk": disk, "url": u[:80], "ok": False, "state": f"err:{type(e).__name__}",
                   "message": str(e)[:100]}
        out.append(row)
        print(json.dumps(row, ensure_ascii=False))
        time.sleep(random.uniform(2.0, 3.2))
print(f"\n== 终验 {ledger.shots} 发（本轮预算 20）")
with open(ROOT / "analysis" / "w2_verify_results.jsonl", "w", encoding="utf-8") as f:
    for row in out:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")
