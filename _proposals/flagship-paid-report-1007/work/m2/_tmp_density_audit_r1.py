# -*- coding: utf-8 -*-
"""_tmp_density_audit_r1 — top50 ch01-06 密度修订侦察 (slop命中行号/重复ngram账/冗余窗口).
只读审计, 不改章节文件."""
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import density_gate as dg

SCHED = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\top50\sched")
CHAPTERS = sys.argv[1:] or [f"_ch0{i}_final.md" for i in range(1, 7)]


def audit(fname: str) -> None:
    path = SCHED / fname
    text = path.read_text(encoding="utf-8")
    lines = text.split("\n")
    m = dg.metrics(text)
    print(f"\n{'='*70}\n## {fname}  cjk={m['cjk_chars']}  redun={m['redundancy_ratio']}  "
          f"ngram={m['new_ngram_rate']}  slop={m['slop_hits']}({m['slop_density_per_kchar']}/kchar)")

    # --- slop 命中: 样式名/行号/上下文 ---
    for name, pat in dg.SLOP_PATTERNS:
        rx = re.compile(pat)
        for ln, line in enumerate(lines, 1):
            for mo in rx.finditer(line):
                s = max(0, mo.start() - 18)
                ctx = line[s:mo.end() + 18].strip()
                print(f"  [SLOP:{name}] L{ln}: …{ctx}…")

    # --- ngram 账: G/T, top 重复非骨架 ngram ---
    new_types, total = dg._ngram_stats(text)
    print(f"  [NGRAM] types={new_types} tokens={total}")
    cnt2, cnt3 = Counter(), Counter()
    for seg in dg._CJK_SEG_RE.findall(text):
        for i in range(len(seg) - 1):
            g = seg[i:i + 2]
            if g not in dg.SKELETON_GRAMS:
                cnt2[g] += 1
        for i in range(len(seg) - 2):
            g = seg[i:i + 3]
            if g not in dg.SKELETON_GRAMS:
                cnt3[g] += 1
    top = [(g, c) for g, c in (cnt2.most_common(40) + cnt3.most_common(40)) if c >= 8]
    top.sort(key=lambda x: -x[1])
    shown = 0
    for g, c in top:
        if shown >= 26:
            break
        print(f"  [REP:{c}x] {g}")
        shown += 1
    print(f"  [CITE] 来源_long={len(re.findall(r'[来源][:：] P', text))} "
          f"short={len(re.findall(r'(?<![[(])P[0-9]{6}(?=[),])', text))}")

    # --- 冗余窗口: 前8000汉字覆盖到哪一行; 前后半各自行区间 ---
    acc = 0
    win_end_line = None
    half_line = None
    half_target = 4000
    for ln, line in enumerate(lines, 1):
        n = len(dg._CJK_CHAR_RE.findall(line))
        if n:
            prev = acc
            acc += n
            if win_end_line is None and acc >= 8000:
                win_end_line = (ln, acc)
            if half_line is None and acc >= half_target:
                half_line = (ln, prev, acc)
    print(f"  [WINDOW] 4000字界≈L{half_line}  8000字界≈L{win_end_line}  总行={len(lines)}")


for f in CHAPTERS:
    audit(f)
