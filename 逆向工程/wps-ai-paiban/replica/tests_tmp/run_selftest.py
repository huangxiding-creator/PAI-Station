#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""oplist_verify.py 自测跑批。

case1 strict-props：plan 里 main_text 带 sz=22 而规范没写字号 → 无中生有，exit 1
case2 import-batch：干净用例 → exit 0
case3 strict-props：规范四号(14pt) vs plan 三号(16pt)，加粗/行距缺失 → 不一致，exit 2

用法：py -3 run_selftest.py
"""
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CLI = os.path.normpath(os.path.join(HERE, "..", "oplist_verify.py"))
PY = sys.executable


def run(plan, spec, out):
    return subprocess.run(
        [PY, "-X", "utf8", CLI,
         os.path.join(HERE, plan), os.path.join(HERE, spec), "-o", os.path.join(HERE, out)],
        capture_output=True, text=True, encoding="utf-8", errors="replace")


def main():
    failures = []

    r1 = run("plan_selftest.json", "spec_selftest.txt", "comparison_selftest.md")
    print("[case1 strict-props]", r1.stdout.strip())
    if r1.returncode != 1:
        failures.append(f"case1 应 exit=1（sz=22 无中生有），实际 {r1.returncode}")
    with open(os.path.join(HERE, "comparison_selftest.md"), encoding="utf-8") as f:
        md1 = f.read()
    if "| 字号（fontSize） | 22pt | （未写明） | — | 无中生有 |" not in md1:
        failures.append("case1 报告未检出 fontSize=22pt 无中生有行")
    if "一致**: 10 | **无中生有**: 1" not in md1:
        failures.append("case1 三态统计应为 一致10/无中生有1")

    r2 = run("plan_import.json", "spec_import.txt", "comparison_import.md")
    print("[case2 import-batch]", r2.stdout.strip())
    if r2.returncode != 0:
        failures.append(f"case2 应 exit=0，实际 {r2.returncode}")

    r3 = run("plan_mismatch.json", "spec_mismatch.txt", "comparison_mismatch.md")
    print("[case3 mismatch]", r3.stdout.strip())
    if r3.returncode != 2:
        failures.append(f"case3 应 exit=2（不一致），实际 {r3.returncode}")
    with open(os.path.join(HERE, "comparison_mismatch.md"), encoding="utf-8") as f:
        md3 = f.read()
    if "| 字号（fontSize） | 16pt | 四号=14pt |" not in md3:
        failures.append("case3 未生成 四号=14pt 规范要求列")
    if "（oplist 未设置）" not in md3 or "**缺失**: 2" not in md3:
        failures.append("case3 加粗/行距缺失未计入缺失清单")

    if failures:
        print("SELFTEST FAIL:")
        for x in failures:
            print(" -", x)
        return 1
    print("SELFTEST PASS: strict exit=1(无中生有) / import-batch exit=0 / mismatch exit=2")
    return 0


if __name__ == "__main__":
    sys.exit(main())
