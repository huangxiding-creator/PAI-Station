# -*- coding: utf-8 -*-
"""_tmp_slop_audit2.py <file> — 量化口径: tokens/types/缺口 + 重复窗口榜 + slop上下文"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, SKELETON_GRAMS, _ngram_stats, metrics, CHAPTER_TYPES

path = sys.argv[1]
text = open(path, encoding="utf-8").read()

mt = metrics(text)
nt, tg = _ngram_stats(text)
print(f"cjk={mt['cjk_chars']} tokens={tg} types={nt} rate={mt['new_ngram_rate']} "
      f"redund={mt['redundancy_ratio']} slop={mt['slop_hits']}")

# --- slop hits with line numbers ---
line_starts = [0]
for i, ch in enumerate(text):
    if ch == "\n": line_starts.append(i + 1)
import bisect
def lineno(p): return bisect.bisect_right(line_starts, p)
print("\n--SLOP--")
tot = 0
for name, pat in SLOP_PATTERNS:
    for m in re.finditer(pat, text):
        tot += 1
        s = max(0, m.start() - 20); e = min(len(text), m.end() + 20)
        print(f"[{name}] L{lineno(m.start())}: …{text[s:e]}…".replace("\n", "⏎"))
print(f"slop_total={tot}")

# --- repeated windows ---
seg_re = re.compile(r"[\u4e00-\u9fff]+")
win = collections.Counter()
for seg in seg_re.findall(text):
    n = len(seg)
    if n < 8: continue
    for L in (8, 6):
        for i in range(n - L + 1):
            win[seg[i:i+L]] += 1
# keep maximal-ish: drop a window if it is a strict substring of a more-repeated equal-count window
cand = [(g, c) for g, c in win.items() if c >= 3 and g not in SKELETON_GRAMS]
cand.sort(key=lambda x: -(len(x[0]) * x[1]))
shown = 0
skip = set()
print("\n--REPEATED WINDOWS (len*count desc, top 70)--")
out = []
for g, c in cand:
    if any(g in s for s in skip): continue
    skip.add(g)
    out.append((g, c))
    if len(out) >= 70: break
for g, c in out:
    print(f"  x{c} [{len(g)}] {g}")
