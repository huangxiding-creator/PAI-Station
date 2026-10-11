# -*- coding: utf-8 -*-
"""front_gate — 总序+卷导语前置门（排版弧线）。

检查 bluebook/front/ 六件：
  1. 纯汉字数在带内（总序 [2800,3600]; 卷导语 [1400,1850], 不含 # 标题行）
  2. 除章号（形如 3-5 / 2-29）外不得出现阿拉伯数字
  3. 禁词九个（同 m2_gate）
usage: PYTHONIOENCODING=utf-8 python front_gate.py
exit: 0 全 PASS / 1 有 FAIL / 缺文件按 FAIL 计
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
FRONT = Path(__file__).resolve().parents[2] / "bluebook" / "front"

SPECS = [("0-zongxu.md", 2800, 3600)] + [
    (f"vol{n}-daoyu.md", 1400, 1850) for n in range(1, 6)
]
CJK = re.compile(r"[一-鿿]")
DIGIT_OK = re.compile(r"\d{1,2}-\d{1,2}")  # 章号形态, 剔除后不得再剩数字
BADWORDS = ["抓手", "赋能", "闭环", "颗粒度", "对齐", "心智", "生态位", "打法沉淀", "组合拳"]


def check(fname, lo, hi):
    path = FRONT / fname
    if not path.exists():
        return 0, [f"缺文件 {fname}"]
    text = path.read_text(encoding="utf-8")
    body_lines = [ln for ln in text.splitlines() if not ln.lstrip().startswith("#")]
    body = "\n".join(body_lines)
    n = len(CJK.findall(body))
    errs = []
    if not (lo <= n <= hi):
        errs.append(f"汉字数 {n} 不在带 [{lo},{hi}]")
    rest = DIGIT_OK.sub("", body)
    bad_nums = re.findall(r"\d+", rest)
    if bad_nums:
        errs.append(f"非法阿拉伯数字: {bad_nums[:5]}")
    hits = [w for w in BADWORDS if w in body]
    if hits:
        errs.append(f"禁词: {hits}")
    return n, errs


def main():
    fails = 0
    print(f"{'文件':<18}{'CJK':>6}  备注")
    for fname, lo, hi in SPECS:
        n, errs = check(fname, lo, hi)
        note = "PASS" if not errs else "; ".join(errs)
        if errs:
            fails += 1
        print(f"{fname:<18}{n:>6}  {note}")
    print("FRONT " + ("PASS 全绿" if fails == 0 else f"FAIL ×{fails}"))
    sys.exit(1 if fails else 0)


if __name__ == "__main__":
    main()
