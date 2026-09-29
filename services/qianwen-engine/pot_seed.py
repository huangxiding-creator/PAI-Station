# -*- coding: utf-8 -*-
"""锅圈播种机：EPC 热点问题 → 工程大脑回答 → 公共锅圈条目。

用法（ECS 生产位）：
  PYTHONPATH=/opt/qianwen venv/bin/python pot_seed.py questions.json [积分预算]

- questions.json = [{"q": "...", "sort": 1}, ...]（sort 缺省按序号）
- 幂等：已入锅的同题自动跳过 → 跨日补种直接重跑
- 护栏：每问让路 pending（两进程经 DB 串行化）+ 20s 间隔 + 积分预算硬顶（默认 45）
  （KB_DAILY_POINT_CAP 是单进程计数；本脚本独立计数防两进程合计打穿共享池）
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import metaso_kb, store  # noqa: E402

POINT_PER_ASK = 3
ASK_GAP_SEC = 20


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: pot_seed.py questions.json [point_budget]")
        return 2
    qfile = Path(sys.argv[1])
    budget = int(sys.argv[2]) if len(sys.argv) > 2 else 45
    items = json.loads(qfile.read_text(encoding="utf-8"))
    print(f"[seed] {len(items)} questions, budget={budget} pts, gap={ASK_GAP_SEC}s")

    seeded = skipped = failed = 0
    used = 0
    for i, it in enumerate(items):
        q = (it.get("q") or "").strip()
        if not q:
            continue
        if used + POINT_PER_ASK > budget:
            print(f"[seed] budget hit at #{i + 1} (used {used}/{budget}) — 明日重跑续种")
            break
        if store.pot_exists(q):
            print(f"[seed] #{i + 1} skip (already in pot): {q[:30]}…")
            skipped += 1
            continue
        # 引擎在跑用户问题 → 让路（两进程经 DB pending 状态串行化）
        waited = 0
        while store.any_pending() and waited < 240:
            time.sleep(5)
            waited += 5
        try:
            t0 = time.time()
            res = metaso_kb.ask(q)
            sort = int(it.get("sort", i))
            aid = store.save_pot_answer(q, res.answer, res.citations, sort=sort,
                                        elapsed=round(time.time() - t0, 1))
            used += POINT_PER_ASK
            seeded += 1
            print(f"[seed] #{i + 1} OK {aid} {len(res.answer)}字 "
                  f"{res.elapsed_sec:.0f}s pts={used}/{budget}: {q[:30]}…")
        except Exception as exc:  # noqa: BLE001
            failed += 1
            print(f"[seed] #{i + 1} FAIL: {exc}")
        time.sleep(ASK_GAP_SEC)
    print(f"[seed] done seeded={seeded} skipped={skipped} failed={failed} pts={used}/{budget}")
    return 0 if seeded > 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
