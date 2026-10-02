# -*- coding: utf-8 -*-
"""反驳复现：refund_one 交叠场景是否真让用户多得 1 次咨询。

声称序列（审查者原话）：
  问A 扣最后 1 个免费（free 5→6）→ 用户点赞获得 bonus → 问B 免费已满改扣 bonus（0→1）
  → 问A 失败退款退的是 bonus（1→0）——A 消耗的明明是免费位。
  净效果用户多得 1 次咨询。

验证法：用真实 store 模块逐字重放该序列，对比「实际退 bonus」与「理想退 free」两种账的
total_left / free_left / bonus_left，并数用户当天最终还能问几次（consume 直到 False）。
"""
from __future__ import annotations

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, store  # noqa: E402


def setup(tmpdir: Path) -> None:
    config.DATA_DIR = tmpdir
    config.DB_PATH = tmpdir / "t.sqlite"
    store._init_done = False


def replay(refund_to_bonus: bool, verbose: bool = True):
    """重放声称序列。refund_to_bonus=True 走真实 refund_one（先退 bonus）；
    False 模拟「理想账」（退 free_used）以对照。返回结算 dict。"""
    with tempfile.TemporaryDirectory() as td:
        setup(Path(td))
        u = "u-claim"

        # 前置：当天已用 5 次免费（free_used=5，FREE_PER_DAY=6）
        for _ in range(5):
            assert store.consume_one(u) is True
        q0 = store.quota_left(u)
        assert q0["free_left"] == 1 and q0["bonus_left"] == 0, q0

        # 问A：consume_one → 扣最后 1 个免费（free 5→6）
        a_consumed_free = store.consume_one(u)
        assert a_consumed_free is True
        qA = store.quota_left(u)

        # 用户点赞获得 bonus（grant_reward 真实路径）
        granted = store.grant_reward(u, "aid-old", "like")
        assert granted is True
        qLike = store.quota_left(u)

        # 问B：免费已满 → 改扣 bonus（bonus_used 0→1）
        b_consumed = store.consume_one(u)
        assert b_consumed is True
        qB = store.quota_left(u)

        # 问A 失败退款：真实路径=refund_one（先退 bonus）；对照路径=直接退 free_used
        if refund_to_bonus:
            store.refund_one(u)
        else:
            # 理想账：A 消耗的是免费位，退款应还原 free_used（手写逆操作，不经 refund_one）
            import sqlite3
            conn = sqlite3.connect(config.DB_PATH)
            conn.execute("UPDATE users SET free_used=free_used-1 WHERE openid=?", (u,))
            conn.commit()
            conn.close()
        qEnd = store.quota_left(u)

        # 数用户当天还能问几次（真实 consume_one，问到底）
        extra = 0
        while store.consume_one(u):
            extra += 1

        if verbose:
            print(f"  [路径 refund_to_bonus={refund_to_bonus}]")
            print(f"    问A后      : {dict(qA)}")
            print(f"    点赞获赠后 : {dict(qLike)}")
            print(f"    问B后      : {dict(qB)}")
            print(f"    A退款结算  : {dict(qEnd)}")
            print(f"    之后还能问 : {extra} 次")
        return {"qEnd": dict(qEnd), "extra": extra}


def main() -> int:
    print("== 真实代码路径（refund_one 先退 bonus，即被指缺陷行为）==")
    real = replay(refund_to_bonus=True)
    print()
    print("== 理想账对照（退款还原 free_used，审查者主张的『正确』逆退）==")
    ideal = replay(refund_to_bonus=False)
    print()

    ok_total = real["qEnd"]["total_left"] == ideal["qEnd"]["total_left"]
    ok_extra = real["extra"] == ideal["extra"]
    print(f"结算 total_left 相等?  实际={real['qEnd']['total_left']} vs 理想={ideal['qEnd']['total_left']}  → {ok_total}")
    print(f"当天还能问次数相等?  实际={real['extra']} vs 理想={ideal['extra']}  → {ok_extra}")
    print(f"实际路径退还总数=1（失败退次承诺精确兑现）? → {real['qEnd']['total_left'] == 1}")

    verdict = ok_total and ok_extra and real["qEnd"]["total_left"] == 1
    print()
    print("结论：", "账面总额与可问次数与理想账完全一致 → 『多得 1 次咨询』不成立"
          if verdict else "存在总额差异 → 声称成立")
    return 0 if verdict else 1


if __name__ == "__main__":
    sys.exit(main())
