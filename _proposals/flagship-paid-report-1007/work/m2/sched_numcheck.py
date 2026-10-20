# -*- coding: utf-8 -*-
"""sched_numcheck — 数字-锚点核验器 (EPC-SCHED, 仿 m2_gate2 逻辑适配本役格式).

章文锚 （P00xxxx）; bank 段头 '## P00xxxx'。规则与 1010 冻结令同源:
句中含锚且含数字(亿/万/%/年份) → 数字须逐字存在于所引锚的 bank 段
(own_calc 句豁免; 'P00xxxx-' 范围引豁免)。
用法: py sched_numcheck.py sched/chNN.md sched/bank_chNN.md
"""
from __future__ import annotations

import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def load_bank(path: str) -> dict[int, str]:
    segs: dict[int, str] = {}
    cur: int | None = None
    buf: list[str] = []
    for line in open(path, encoding="utf-8"):
        m = re.match(r"## P(\d{6})", line)
        if m:
            if cur is not None:
                segs[cur] = "\n".join(buf)
            cur = int(m.group(1))
            buf = [line]
        elif cur is not None:
            buf.append(line)
    if cur is not None:
        segs[cur] = "\n".join(buf)
    return segs


def main() -> int:
    chap = open(sys.argv[1], encoding="utf-8").read()
    segs = load_bank(sys.argv[2])
    norm = lambda x: x.replace(",", "").replace("，", "") \
        .replace(" ", "").replace(",", "")
    checked = passed = 0
    bad: list[tuple] = []
    for s in re.split(r"[。；\n]", chap):
        if "own_calc" in s:
            continue
        if re.search(r"P\d{6}\s*[-–—]", s):
            continue
        anchors = [int(x) for x in re.findall(r"P(\d{6})", s)]
        if not anchors:
            continue
        s_clean = re.sub(r"P\d{6}", "", s)
        nums = set(re.findall(
            r"\d[\d,，]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))"
            r"|(?<![\d.])(?:19|20)\d{2}(?![\d.])", s_clean))
        if not nums:
            continue
        ctxs = [segs.get(a) for a in set(anchors)]
        for a in set(anchors):
            if segs.get(a) is None:
                bad.append((a, "ANCHOR_NOT_FOUND", s[:60]))
        for nn in nums:
            checked += 1
            if any(c and norm(nn) in norm(c) for c in ctxs):
                passed += 1
            else:
                bad.append((anchors[0], f"NUM_{nn}", s[:70]))
    print(f"num_checks={checked} passed={passed} fail={len(bad)} "
          f"-> {'PASS' if not bad else 'FAIL'}")
    for b in bad[:12]:
        print("  ✗", b[0], b[1], "|", b[2])
    return 0 if not bad else 1


if __name__ == "__main__":
    raise SystemExit(main())
