# -*- coding: utf-8 -*-
"""复现检验：pre 快照跨午夜后 from_bonus 旗标过期 → 503 退款静默落空，新的一天少 1 次免费问。

声称序列（审查者原话要点）：
  日 D 状态 free_used=6/bonus_earned=2/bonus_used=0；
  app.py:1102 pre=quota_left（日 D，free_left=0 → from_bonus 旗标=True）；
  午夜翻转落在 pre 与 consume_one（两笔独立事务）之间；
  consume_one 内部 _row_user 触发跨日重置 → 扣的是新日免费桶（free_used 0→1，返回 True）；
  随后 503 退款 refund_one(from_bonus=True)（过期旗标）→ store.py:758 守卫 bonus_used>0
  不成立（=0）→ 静默 no-op；
  结果新日 free_left=5 —— 用户为一次 503 的问答被扣掉 1 次免费问，违背「503 不扣次」。

验证法：真实 store 模块逐字重放，用受控 _today() 模拟午夜翻转；另跑两组对照：
  A. 无午夜（同日完整流）——退款正常还原；
  B. 有午夜但退款桶按行内重算（修复后语义）——免费位还原。
"""
from __future__ import annotations

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, store  # noqa: E402

DAY_D = "2026-10-18"
DAY_D1 = "2026-10-19"


def setup(tmpdir: Path) -> None:
    config.DATA_DIR = tmpdir
    config.DB_PATH = tmpdir / "t.sqlite"
    store._init_done = False
    store.init()                   # 建表（公共函数各自会 init，这里先建以便内部 seed）
    store._today = lambda: DAY_D   # 受控时钟：起始日 D


def seed(u: str) -> None:
    """日 D 前置：免费桶用满（free_used=6=FREE_PER_DAY），bonus 可用 2，bonus_used=0。"""
    with store._LOCK, store._db() as c:
        store._row_user(c, u)
        c.execute(
            "UPDATE users SET free_used=6, bonus_earned=2, bonus_used=0 WHERE openid=?",
            (u,))


def row_state(u: str) -> dict:
    with store._db() as c:
        r = c.execute(
            "SELECT quota_day, free_used, bonus_earned, bonus_used FROM users WHERE openid=?",
            (u,)).fetchone()
    return dict(r)


def replay(midnight: bool, fixed_refund: bool, verbose: bool = True) -> dict:
    """midnight=False/True：pre 与 consume_one 之间是否翻转日；
    fixed_refund=True：退款桶按 refund 事务内行值重算（修复语义）而非过期旗标。"""
    with tempfile.TemporaryDirectory() as td:
        setup(Path(td))
        u = "u-claim"
        seed(u)

        # ── app.py:1095 门（统一额度池余量检查，>0 才放行，否则 429 早退）──
        gate = store.quota_left(u)
        assert gate["total_left"] > 0, gate   # 0 免费 + 2 赠次 = 2 > 0，放行

        # ── app.py:1102 pre 快照（日 D 事务）──
        pre = store.quota_left(u)
        assert pre["free_left"] == 0 and pre["bonus_left"] == 2, dict(pre)

        # ── 午夜翻转：pre 事务已提交、consume_one 事务尚未开启 ──
        if midnight:
            store._today = lambda: DAY_D1

        # ── app.py:1103 consume_one（独立事务；内部 _row_user 跨日重置）──
        consumed = store.consume_one(u)
        after_consume = row_state(u)

        # ── app.py:1118-1129 zhipu 异常/空解析 → 503 退款（from_bonus=pre 快照旗标）──
        if fixed_refund:
            # 修复语义：在同一退款事务里按行重算桶（扣后哪个桶被用过退哪个的对称近似）
            with store._LOCK, store._db() as c:
                r = store._row_user(c, u)
                fb = r["free_used"] <= 0 and r["bonus_used"] > 0
            store.refund_one(u, from_bonus=fb)
        else:
            store.refund_one(u, from_bonus=pre["free_left"] <= 0)   # 真实代码路径

        final_q = store.quota_left(u)
        final_row = row_state(u)
        # 数新日还能问几次（问到底）
        extra = 0
        while store.consume_one(u):
            extra += 1

        if verbose:
            print(f"  [路径 midnight={midnight} fixed_refund={fixed_refund}]")
            print(f"    放行门 total_left : {gate['total_left']}（>0，非 429）")
            print(f"    pre 快照(日D)     : {dict(pre)}  → from_bonus={pre['free_left'] <= 0}")
            print(f"    consume_one 返回  : {consumed}")
            print(f"    扣后行            : {after_consume}")
            print(f"    退款后行          : {final_row}")
            print(f"    退款后 quota      : {dict(final_q)}")
            print(f"    之后还能问        : {extra} 次")
        return {"q": dict(final_q), "row": final_row, "extra": extra}


def main() -> int:
    print("== 对照 A：无午夜（同日完整流，退款应正常还原）==")
    a = replay(midnight=False, fixed_refund=False)
    print()
    print("== 被指缺陷路径：午夜落在 pre 与 consume_one 之间，退款用过期旗标 ==")
    bug = replay(midnight=True, fixed_refund=False)
    print()
    print("== 对照 B：同午夜但退款桶按行重算（修复语义）==")
    b = replay(midnight=True, fixed_refund=True)
    print()

    ok_a = a["q"]["total_left"] == 2 and a["extra"] == 2          # 同日：还原后 2 赠次可问
    bug_fired = (bug["row"]["free_used"] == 1                     # 退款没还原免费位
                 and bug["q"]["free_left"] == config.FREE_PER_DAY - 1
                 and bug["extra"] == config.FREE_PER_DAY - 1 + 0)  # 新日只剩 5+0 次可问
    ok_b = b["row"]["free_used"] == 0 and b["q"]["free_left"] == config.FREE_PER_DAY

    print(f"对照A 同日退款正常还原（total_left 回 2）?          → {ok_a}")
    print(f"缺陷路径 新日 free_left=5（被扣 1 次免费问）?        → {bug_fired}")
    print(f"对照B 修复语义 免费位还原（free_left=6）?            → {ok_b}")
    print()
    if ok_a and bug_fired and ok_b:
        print("结论：缺陷成立——跨午夜 straddle 下 503 退款静默落空，新的一天永久少 1 次免费问；")
        print("      同日路径与修复语义均正常，差异仅出现在 pre/consume 跨日竞态窗。")
        return 1   # 缺陷复现成功（反驳失败）
    print("结论：未能复现声称行为。")
    return 0


if __name__ == "__main__":
    sys.exit(main())
