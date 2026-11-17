# -*- coding: utf-8 -*-
"""pub_grade_pipeline — 出版级排版两步管线: WPS AI引擎做结构 + 金标准做字体.
Step 1: aipaiban.py (WPS AI逆向) — 智能标签+TOC域+三线表+分页+页码
Step 2: docx_zongbao.py (用户金标准) — 9pt雅黑正文+页眉版权+边距+封面
用法: py -X utf8 pub_grade_pipeline.py in.docx -o out.docx [--title 书名 --subtitle 副题]
"""
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

REPO = Path(r"E:\AI-Station")
AIPAIBAN = REPO / "逆向工程" / "wps-ai-paiban" / "replica" / "aipaiban.py"
ZONGBAO = REPO / "tools" / "docx_zongbao_world.py"


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("docx")
    ap.add_argument("-o", "--out", required=True)
    ap.add_argument("--title", default="")
    ap.add_argument("--subtitle", default="")
    ap.add_argument("--preset", default="beauty")
    ap.add_argument("--theme", default="steel-blue")
    ns = ap.parse_args()

    src = Path(ns.docx)
    out = Path(ns.out)

    # Step 1: WPS AI 引擎 — 结构层(TOC/三线表/分页/页码)
    tmp = out.with_name(out.stem + "_step1_wps_ai.docx")
    cmd1 = [
        sys.executable, "-X", "utf8", str(AIPAIBAN),
        str(src),
        "--preset", ns.preset,
        "--theme", ns.theme,
        "--toc", "on",
        "--page-numbers", "on",
        "--h1-break", "on",
        "--table-style", "three_line",
        "--mode", "full",
        "-o", str(tmp),
    ]
    print(f"[step1] WPS AI 引擎: {ns.preset}/{ns.theme}")
    r1 = subprocess.run(cmd1, capture_output=True, text=True, encoding="utf-8",
                        errors="replace", timeout=600)
    if r1.returncode != 0 or not tmp.exists():
        print(f"[step1] ✗ {(r1.stderr or '')[-200:]}")
        return 1
    print(f"[step1] ✓ {tmp.stat().st_size:,}B")

    # Step 2: 金标准 — 字体层(9pt雅黑/页眉版权/边距/封面)
    cmd2 = [
        sys.executable, "-X", "utf8", str(ZONGBAO),
        str(tmp),
        "-o", str(out),
    ]
    if ns.title:
        cmd2 += ["--title", ns.title]
    if ns.subtitle:
        cmd2 += ["--subtitle", ns.subtitle]
    print(f"[step2] 金标准: 9pt雅黑+页眉版权+封面")
    r2 = subprocess.run(cmd2, capture_output=True, text=True, encoding="utf-8",
                        errors="replace", timeout=600)
    if r2.returncode != 0 or not out.exists():
        print(f"[step2] ✗ {(r2.stderr or '')[-200:]}")
        return 1
    print(f"[step2] ✓ {out} ({out.stat().st_size:,}B)")

    # 清理中间件
    tmp.unlink(missing_ok=True)
    print(f"[done] 两步管线完毕 → {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
