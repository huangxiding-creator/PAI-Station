# -*- coding: utf-8 -*-
"""bid26_gate3 — BID26 互引门 (gate3 族: 融合章「见第N章」核验).

规则: 融合章 (三态：[融合]) 每章 ≥3 处「见第N章」且 N 指向存在的章
(1-12, 非自指); 被引章内数字与本章引用的交叉事实不得矛盾 (人工位,
机检只做存在性+指向); 精编/原创章不强制互引。

用法: py -X utf8 .../work/m2/bid26_gate3.py   # exit 0=全过
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

BID = Path(__file__).resolve().parent / "bid26"
REF_RE = re.compile(r"见第(\d+)章|第(\d+)章(?!.*(?:世纪|条))")


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    files = {int(f.stem[2:4]): f for f in BID.glob("ch*.md")}
    n_ok = 0
    checked = 0
    for no, f in sorted(files.items()):
        text = f.read_text(encoding="utf-8")
        m = re.search(r"三态[*＊=＝行]{0,3}\s*[：:=＝]?\s*\[([精融原][编合创])\]",
                      text[:800])
        ctype = m.group(1) if m else "精编"
        refs = sorted({int(a or b) for a, b in REF_RE.findall(text)})
        refs = [r for r in refs if r != no]           # 去自指
        dangling = [r for r in refs if r not in files]
        if ctype == "融合":
            checked += 1
            ok = len(refs) >= 3 and not dangling
            n_ok += ok
            print(f"[gate3] 第{no}章[融合]: 互引 {len(refs)} 处 → {refs} "
                  f"{'✅' if ok else '❌ (需≥3且无悬空)'}"
                  + (f" 悬空: {dangling}" if dangling else ""))
        else:
            print(f"[gate3] 第{no}章[{ctype}]: 互引 {len(refs)} 处 (不强制)")
    print(f"[gate3] 融合章核验 {n_ok} (融合章共 {checked})")
    return 0 if checked and n_ok == checked else 2


if __name__ == "__main__":
    raise SystemExit(main())
