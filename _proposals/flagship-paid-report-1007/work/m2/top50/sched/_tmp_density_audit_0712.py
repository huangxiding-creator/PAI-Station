# -*- coding: utf-8 -*-
"""密度修订审计器 ch07-12: slop命中定位(正文/表格/标题) + ngram types/tokens账 + 高频重复ngram清单"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, SKELETON_GRAMS, metrics

BASE = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\top50\sched"
CH = ["07", "08", "09", "10", "12"]   # ch11 不动

def line_kind(line):
    s = line.lstrip()
    if s.startswith("|"):
        return "TABLE"
    if s.startswith("#"):
        return "HEAD"
    if s.startswith(">"):
        return "QUOTE"
    return "PROSE"

for ch in CH:
    p = f"{BASE}\\_ch{ch}_final.md"
    text = open(p, encoding="utf-8").read()
    lines = text.split("\n")
    m = metrics(text)
    print(f"\n######## ch{ch} cjk={m['cjk_chars']} ngram={m['new_ngram_rate']} slop={m['slop_hits']}({m['slop_density_per_kchar']}) redun={m['redundancy_ratio']}")
    # slop 命中定位
    for ln_no, ln in enumerate(lines, 1):
        for name, pat in SLOP_PATTERNS:
            for mm in re.finditer(pat, ln):
                kind = line_kind(ln)
                ctx = ln.strip()
                if len(ctx) > 70:
                    i = mm.start()
                    lo, hi = max(0, i - 35), min(len(ctx), i + 35)
                    ctx = ("..." if lo else "") + ctx[lo:hi] + ("..." if hi < len(ctx) else "")
                print(f"  [{kind}] L{ln_no} <{name}> {ctx}")
    # ngram 账
    seg_re = re.compile(r"[\u4e00-\u9fff]+")
    total = 0; types = set(); tok_count = collections.Counter()
    for seg in seg_re.findall(text):
        n = len(seg)
        for i in range(n - 1):
            g = seg[i:i+2]; total += 1; tok_count[g] += 1
            if g not in SKELETON_GRAMS: types.add(g)
        for i in range(n - 2):
            g = seg[i:i+3]; total += 1; tok_count[g] += 1
            if g not in SKELETON_GRAMS: types.add(g)
    nt = len(types)
    need = 0.54 * total
    print(f"  ngram账: types={nt} tokens={total} rate={nt/total:.4f} 需types>= {need:.0f} (Δ={need-nt:+.0f})")
    # 高频重复非骨架3gram(重复>=6次)
    rep3 = [(g, c) for g, c in tok_count.items() if len(g) == 3 and g not in SKELETON_GRAMS and c >= 6]
    rep3.sort(key=lambda x: -x[1])
    print(f"  高频3gram(>=6次) top30: " + " ".join(f"{g}:{c}" for g, c in rep3[:30]))
    rep2 = [(g, c) for g, c in tok_count.items() if len(g) == 2 and g not in SKELETON_GRAMS and c >= 12]
    rep2.sort(key=lambda x: -x[1])
    print(f"  高频2gram(>=12次) top25: " + " ".join(f"{g}:{c}" for g, c in rep2[:25]))
