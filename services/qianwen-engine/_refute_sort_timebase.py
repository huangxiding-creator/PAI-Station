# -*- coding: utf-8 -*-
"""反驳复现：声称「用户共享的旧答案按提问时间排序，入锅即沉底」。

方法（全走真实代码路径，仅拨时钟）：
  1) 播种条目 A：save_pot_answer —— 3 天前播种（拨 created_at 回 3 天）
  2) 用户 3 天前问的答案 B：save_answer 后拨 created_at 回 3 天
  3) 播种条目 C：save_pot_answer —— 刚刚播种（今天）
  4) 用户现在点共享：share_on(B) —— pot_items.created_at=当下（真实入锅时刻）
  5) pot_list() 看排序：B 应排在哪里？
     - 若缺陷真：B 的 ts 取 answers.created_at(3天前) → 排在 C(今天播种) 之下
     - 若缺陷假：B 应以入锅时刻参与排序 → 排在 C 之上（此刻最新入锅）
"""
from __future__ import annotations

import sqlite3
import sys
import tempfile
import time
from datetime import datetime, timedelta
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, store  # noqa: E402

DAYS = 3


def _fmt(dt: datetime) -> str:
    return dt.strftime("%Y-%m-%d %H:%M:%S")


def main() -> int:
    tmp = Path(tempfile.mkdtemp(prefix="qw_sort_refute_"))
    config.DB_PATH = tmp / "t.sqlite"
    config.DATA_DIR = tmp
    store._init_done = False
    store.init()

    now = datetime.now()
    old = now - timedelta(days=DAYS)
    user = "user-old-share"

    # ── 1) 3 天前播种的条目 A ──
    aid_a = store.save_pot_answer("3天前播种的问题A", "A 的答案" * 60, [])
    # ── 2) 用户 3 天前的提问 B（问题即入锅？不——用户问题此刻只是自己的答案）──
    aid_b = store.save_answer(user, "用户3天前的问题B", "B 的答案" * 60, [])
    # ── 3) 今天播种的条目 C ──
    aid_c = store.save_pot_answer("今天播种的问题C", "C 的答案" * 60, [])

    # 拨时钟：A、B 的 answers.created_at 回到 3 天前（SQLite 默认写入即当下，
    # 此处模拟「3 天过去了」——created_at 无任何代码路径会再更新，见下述 grep 证明）
    with sqlite3.connect(config.DB_PATH) as conn:
        conn.execute("UPDATE answers SET created_at=? WHERE id=?",
                     (_fmt(old), aid_a))
        conn.execute("UPDATE answers SET created_at=? WHERE id=?",
                     (_fmt(old), aid_b))

    # ── 4) 用户此刻共享 3 天前的旧答案 B ──
    ok = store.share_on(aid_b, user)
    assert ok, "share_on 应成功（本人 ready 有正文的答案）"

    # pot_items.created_at 是什么时刻？（真实入锅时刻）
    with sqlite3.connect(config.DB_PATH) as conn:
        conn.row_factory = sqlite3.Row
        rows = conn.execute(
            "SELECT p.aid, p.created_at AS pot_at, a.created_at AS ans_at, a.shared"
            " FROM pot_items p JOIN answers a ON a.id=p.aid").fetchall()
        print("=== pot_items 真实状态（入锅时刻 vs 提问时刻）===")
        for r in rows:
            print(f"  aid={r['aid']}  pot_at(入锅)={r['pot_at']}"
                  f"  ans_at(提问)={r['ans_at']}  shared={r['shared']}")

    # ── 5) pot_list 排序 ──
    items = store.pot_list()
    print("\n=== pot_list() 实际返回顺序（v0.7.0 公共墙）===")
    for i, it in enumerate(items, 1):
        print(f"  #{i}  {it['id']}  q={it['question']}  created_at={it['created_at']}")

    ids = [it["id"] for it in items]
    pos_b = ids.index(aid_b) + 1 if aid_b in ids else None
    pos_c = ids.index(aid_c) + 1 if aid_c in ids else None
    print(f"\n用户刚共享的旧答案 B 排名: #{pos_b}/{len(ids)}")
    print(f"今天播种的条目    C 排名: #{pos_c}/{len(ids)}")

    # ── 判定 ──
    sunk = pos_b is not None and pos_c is not None and pos_b > pos_c
    print("\n===== 判定 =====")
    if sunk:
        print(f"缺陷成立：B 在此刻共享（入锅），却排在 {DAYS} 天内播种的 C 之下"
              f"（#{pos_b} > #{pos_c}）——排序时间基=提问时间而非入锅时间")
    else:
        print("缺陷不成立：B 排在 C 之上或并列——入锅时刻参与了排序")
    return 0 if sunk else 1


if __name__ == "__main__":
    sys.exit(main())
