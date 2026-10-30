# -*- coding: utf-8 -*-
"""_tmp_dup_mark_1028 — 1028 r4 收口一次性件: warehouse 重跑重复行标记.

事故: 1153 warehouse_leg 8 查询 (八大央企营收序列) 与 1007 已判 valid 批
同内容 (文件头时间戳不同 → dedup_key 不同 → 入池未拦)。零造假纪律:
重复行不得入门槛账 — 本件把 115325 批 8 行 pending → rejected
(judge_reason=dup_rerun_of_20261028_100736_batch, 如实留痕), 行为照
judge_reland 同机械 (池锁 + 备份 + rebuild)。行不删, 只改判态。

用法: py -X utf8 _tmp_dup_mark_1028.py [--dry]
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import ammo_pool as ap                                   # noqa: E402

DUP_BATCH = "20261028_115325"
ORIG_BATCH = "20261028_100736"


def run(dry: bool) -> int:
    d = ap._camp_dir("EPC-TOP50")
    mp = d / "manifest.jsonl"
    with ap._pool_lock(d):
        rows = [json.loads(x) for x in
                mp.read_text(encoding="utf-8").splitlines() if x.strip()]
        n = 0
        for row in rows:
            if (row.get("judge") == "pending"
                    and row.get("engine") == "warehouse"
                    and DUP_BATCH in str(row.get("source_path", ""))):
                if dry:
                    n += 1
                    continue
                row.update(judge="rejected",
                           judge_reason=f"dup_rerun_of_{ORIG_BATCH}_batch",
                           judge_engine="manual-dedup-1028")
                n += 1
        if dry:
            print(f"[dup-mark] DRY: 可标记 {n} 行 (batch {DUP_BATCH})")
            return 0
        bak = d / "manifest.pre-dupmark-1028.bak.jsonl"
        if not bak.is_file():
            mp.replace(bak)
        mp.write_text(
            "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows),
            encoding="utf-8")
    ap.rebuild("EPC-TOP50")
    print(f"[dup-mark] 标记 rejected {n} 行 (batch {DUP_BATCH}) | 备份 {bak.name}")
    return 0


if __name__ == "__main__":
    ap_ = argparse.ArgumentParser()
    ap_.add_argument("--dry", action="store_true")
    sys.exit(run(ap_.parse_args().dry))
