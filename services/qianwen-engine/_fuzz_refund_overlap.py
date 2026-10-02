# -*- coding: utf-8 -*-
"""穷举验证：任意 consume/grant/refund 交错序列下，真实 refund_one（先退bonus）
与「理想逆退」（按记录退本次扣的桶）的 total_left / 可问次数 是否可能不同。
单库多用户（每 trial 一个 openid），一次 init。"""
from __future__ import annotations

import random
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, store  # noqa: E402


def main() -> int:
    tmp = Path(tempfile.mkdtemp())
    config.DATA_DIR = tmp
    config.DB_PATH = tmp / "t.sqlite"
    store._init_done = False

    random.seed(42)
    trials = 500
    diff_total = 0
    diff_askable = 0
    diffs = []

    for t in range(trials):
        u = f"u{t}"
        shadow = {"F": 0, "E": 0, "U": 0}
        stack = []  # 每次成功 consume 扣的桶（理想退法的依据）
        for step in range(40):
            r = random.random()
            if r < 0.45:  # consume
                real = store.consume_one(u)
                if shadow["F"] < 6:
                    shadow["F"] += 1
                    sh = True
                    stack.append("F")
                elif shadow["U"] < shadow["E"]:
                    shadow["U"] += 1
                    sh = True
                    stack.append("U")
                else:
                    sh = False
                assert real == sh, f"consume 分歧 trial={t} step={step}"
            elif r < 0.72:  # grant
                store.grant_reward(u, f"a{t}-{step}", "like")
                shadow["E"] += 1
            else:  # refund
                if stack:
                    store.refund_one(u)          # 真实路径：先退 bonus
                    b = stack.pop()              # 理想路径：退本次扣的桶
                    if b == "F":
                        shadow["F"] = max(0, shadow["F"] - 1)
                    else:
                        shadow["U"] = max(0, shadow["U"] - 1)
        q = store.quota_left(u)
        sh_total = max(0, 6 - shadow["F"]) + max(0, shadow["E"] - shadow["U"])
        if q["total_left"] != sh_total:
            diff_total += 1
            diffs.append((t, dict(q), dict(shadow)))
        # 真实可问次数（问到底）
        extra = 0
        while store.consume_one(u):
            extra += 1
        if extra != sh_total:
            diff_askable += 1

    print(f"trials={trials}")
    print(f"total_left 与理想逆退不一致: {diff_total}")
    print(f"可问次数 与理想逆退不一致: {diff_askable}")
    for d in diffs[:5]:
        print("  样本:", d)
    verdict = diff_total == 0 and diff_askable == 0
    print("VERDICT:", "REFUTED" if verdict else "CLAIM HOLDS")
    return 0 if verdict else 1


if __name__ == "__main__":
    sys.exit(main())
