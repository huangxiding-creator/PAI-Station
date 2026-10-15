# -*- coding: utf-8 -*-
"""bid26_merge — 成书装配器 (BID26 S3: 12章+前言 → merged md).

用法: py -X utf8 .../work/m2/bid26_merge.py [--out bid26_merged.md]
前置: 全章 sweep PASS (主编复验), gate3 融合章互引过门。
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

BID = Path(__file__).resolve().parent / "bid26"
TITLE = "# 工程总承包招投标合规指南（2026 版）"


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    out_name = "bid26_merged.md"
    if "--out" in sys.argv:
        out_name = sys.argv[sys.argv.index("--out") + 1]
    chapters = sorted(BID.glob("ch*.md"), key=lambda p: int(p.stem[2:4]))
    if len(chapters) != 12:
        print(f"[merge] 章数异常 {len(chapters)}/12, 拒装配")
        return 2
    parts = [TITLE, "",
             "> 专题研报 · 总包智库 | 数字可溯 · 每个关键数字标注出处", ""]
    front = BID / "front.md"
    if front.exists():
        t = front.read_text(encoding="utf-8")
        t = re.sub(r"^# 前言\s*", "## 关于本书", t)   # 前言降级为章内节
        parts += [t.rstrip(), "", "---", ""]
    for ch in chapters:
        t = ch.read_text(encoding="utf-8").rstrip()
        parts += [t, "", "---", ""]
    out = BID / out_name
    out.write_text("\n".join(parts), encoding="utf-8")
    cjk = len(re.findall(r"[一-鿿]", out.read_text(encoding="utf-8")))
    print(f"[merge] 12章+前言 → {out} ({out.stat().st_size // 1024}KB, "
          f"正文 CJK {cjk:,})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
