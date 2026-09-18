# -*- coding: utf-8 -*-
"""融合画像夜间刷新链——卷宗语料保鲜。

金标准卷宗通道（src/paistation/cx/dossier.py）的检索域=SELF_PROFILE
精炼卷宗；画像工具产出即记忆本体。本驱动把全部融合画像生成器串成
一条链，随日采（23:47 信号流 / 23:59 聊天面）之后重算，保证卷宗
永远反映最新数据。全部本地读+md 写，幂等。

用法：python tools/cx_fusion_refresh.py
排程：schtask PAIStation-fusion-refresh 每日 00:10
"""
from __future__ import annotations

import subprocess
import sys
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]

# （生成器， 预计秒）——顺序跑，前一个失败不挡后一个
GENERATORS = [
    "cx_dimensions.py",
    "cx_facts_card.py",
    "cx_signal_profile.py",
    "cx_relations_profile.py",
    "cx_rhythm_evolution.py",
    "cx_idea_evolution.py",
]


def main() -> int:
    ok = fail = 0
    for gen in GENERATORS:
        t0 = datetime.now()
        try:
            proc = subprocess.run(
                [sys.executable, str(REPO / "tools" / gen)],
                capture_output=True, text=True, encoding="utf-8",
                errors="replace", timeout=600, cwd=str(REPO),
            )
            cost = (datetime.now() - t0).total_seconds()
            if proc.returncode == 0:
                ok += 1
                print(f"[ok] {gen} {cost:.0f}s")
            else:
                fail += 1
                print(f"[FAIL] {gen} rc={proc.returncode}: "
                      f"{(proc.stderr or '')[-200:]}")
        except subprocess.TimeoutExpired:
            fail += 1
            print(f"[TIMEOUT] {gen} >600s")
    print(f"融合刷新完成：{ok} ok / {fail} fail")
    return 1 if fail else 0


if __name__ == "__main__":
    raise SystemExit(main())
