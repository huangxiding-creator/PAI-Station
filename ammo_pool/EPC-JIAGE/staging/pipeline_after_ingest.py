# -*- coding: utf-8 -*-
"""EPC-JIAGE S1 基建收尾编排 — cross_ingest 完成后的全链一键跑 (1025).

顺序 (全部在役件, 本件只编排不重造):
  judge 循环 (待审清零, 如实计有效/废弃) → tree_backfill (存量判挂树,
  DIM_KEYWORDS 已增补 JIAGE 十维) → tree_spread (同维铺展) →
  rebuild (pool_state 全量重算) → tier_fulltext_reledger (fulltext_v2 分层
  落账, t1_chars 基线) → coverage (问题树饱和账) → status (终态基线).

用法: py -X utf8 E:/AI-Station/ammo_pool/EPC-JIAGE/staging/pipeline_after_ingest.py
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
CID = "EPC-JIAGE"
CAMP = REPO / "ammo_pool" / CID
RF = REPO / "reforge_factory"
sys.path.insert(0, str(RF))
import ammo_pool as ap                                    # noqa: E402


def sh(args: list[str], tag: str) -> int:
    print(f"\n=== {tag}: {' '.join(args)} ===", flush=True)
    r = subprocess.run([sys.executable, "-X", "utf8", *args],
                       cwd=str(REPO), timeout=7200)
    if r.returncode != 0:
        print(f"[pipeline] ⚠ {tag} 退出码 {r.returncode} (继续, 如实记录)",
              flush=True)
    return r.returncode


def judge_loop() -> None:
    """judge 循环直到待审清零 (file_missing 留审行除外 — 如实保留 pending)."""
    for rnd in range(1, 61):
        s = json.loads((CAMP / "pool_state.json").read_text(encoding="utf-8"))
        pend = s.get("pending_items", 0)
        if pend <= 0:
            print(f"[judge] 第{rnd}轮前待审=0, 清零收工", flush=True)
            return
        print(f"\n=== judge 第{rnd}轮 (待审 {pend} 件) ===", flush=True)
        before = pend
        ap.judge(CID, limit=4000)
        s2 = json.loads((CAMP / "pool_state.json").read_text(encoding="utf-8"))
        if s2.get("pending_items", 0) >= before:
            print(f"[judge] 待审未降 (留审 {s2.get('pending_items')} — "
                  f"file_missing 语义), 停轮如实保留", flush=True)
            return


def main() -> int:
    t0 = time.time()
    judge_loop()
    sh([str(RF / "tree_backfill.py"), "--campaign", CID], "tree_backfill")
    sh([str(RF / "tree_spread.py"), "--campaign", CID], "tree_spread")
    sh([str(RF / "ammo_pool.py"), "rebuild", CID], "rebuild")
    sh([str(RF / "tier_fulltext_reledger.py"), CID], "tier_fulltext_reledger")
    sh([str(RF / "ammo_pool.py"), "coverage", CID], "coverage")
    sh([str(RF / "ammo_pool.py"), "status", CID], "status")
    print(f"\n[pipeline] S1 基建全链完成, 耗时 "
          f"{(time.time() - t0) / 60:.1f} 分钟", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
