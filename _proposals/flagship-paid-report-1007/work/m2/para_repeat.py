# -*- coding: utf-8 -*-
"""para_repeat.py <file> — 按段(非表格非标题)统计重复token占比, 排出最值得改写的段"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SKELETON_GRAMS, _ngram_stats, metrics
from density_gate import _CJK_SEG_RE

path = sys.argv[1]
text = open(path, encoding="utf-8").read()
mt = metrics(text)
nt, tg = _ngram_stats(text)
print(f"cjk={mt['cjk_chars']} tokens={tg} types={nt} rate={mt['new_ngram_rate']} "
      f"-> need_types@const_tokens={0.62*tg:.0f} (+{0.62*tg-nt:.0f}) [ch09口径0.62; ch10/11=0.649]")

# gram -> occurrence count (excluding skeleton from types but count tokens)
g2 = collections.Counter(); g3 = collections.Counter()
paras = [p for p in text.split("\n") if p.strip() and not p.startswith(("|", "#", "> 出品", "（本章完"))]
for p in paras:
    for seg in _CJK_SEG_RE.findall(p):
        for i in range(len(seg)-1): g2[seg[i:i+2]] += 1
        for i in range(len(seg)-2): g3[seg[i:i+3]] += 1

seen2, seen3 = set(), set()
rows = []
for idx, p in enumerate(paras):
    rep = tot = 0
    for seg in _CJK_SEG_RE.findall(p):
        for i in range(len(seg)-1):
            g = seg[i:i+2]; tot += 1
            if g in seen2 or g in SKELETON_GRAMS: rep += 1
            else: seen2.add(g)
        for i in range(len(seg)-2):
            g = seg[i:i+3]; tot += 1
            if g in seen3 or g in SKELETON_GRAMS: rep += 1
            else: seen3.add(g)
    cjk = len(re.findall(r"[\u4e00-\u9fff]", p))
    if tot > 20: rows.append((rep, tot, idx, cjk, p))
rows.sort(reverse=True)
print("\nTOP repeat-heavy paragraphs (rep_tokens, tot_tokens, cjk):")
for rep, tot, idx, cjk, p in rows[:22]:
    print(f"  rep={rep:4d} tot={tot:4d} cjk={cjk:4d} :: {p[:76]}")
