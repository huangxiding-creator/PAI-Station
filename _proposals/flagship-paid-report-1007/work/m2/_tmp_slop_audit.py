# -*- coding: utf-8 -*-
"""_tmp_slop_audit.py <file> — slop 命中上下文 + 重复 n-gram/短语 Top 榜"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, SKELETON_GRAMS, metrics

path = sys.argv[1]
text = open(path, encoding="utf-8").read()
lines = text.split("\n")
off = 0; line_of = []
for ln in lines:
    off += len(ln) + 1
    line_of.append(off)

def lineno(pos):
    lo, hi = 0, len(line_of) - 1
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if line_of[mid] <= pos: lo = mid
        else: hi = mid - 1
    return lo + 1

print(f"=== SLOP HITS {path} ===")
tot = 0
for name, pat in SLOP_PATTERNS:
    for m in re.finditer(pat, text):
        tot += 1
        s = max(0, m.start() - 25); e = min(len(text), m.end() + 25)
        ctx = text[s:e].replace("\n", "⏎")
        print(f"[{name}] L{lineno(m.start())}: …{ctx}…")
print(f"TOTAL={tot}")

print(f"\n=== TOP REPEATED 3-GRAMS (non-skeleton, count>=8) ===")
seg_re = re.compile(r"[\u4e00-\u9fff]+")
c3 = collections.Counter()
c2 = collections.Counter()
for seg in seg_re.findall(text):
    for i in range(len(seg) - 2): c3[seg[i:i+3]] += 1
    for i in range(len(seg) - 1): c2[seg[i:i+2]] += 1
sk = SKELETON_GRAMS
for g, n in c3.most_common(400):
    if n >= 8 and g not in sk: print(f"  {g} x{n}")
print(f"\n=== TOP REPEATED 2-GRAMS (non-skeleton, count>=15) ===")
for g, n in c2.most_common(600):
    if n >= 15 and g not in sk: print(f"  {g} x{n}")

# repeated long runs: find any 8+ char substring appearing >=3 times
print(f"\n=== REPEATED PHRASES >=8 chars, >=3x (greedy) ===")
seen = set()
done = set()
for m in re.finditer(r"[\u4e00-\u9fff，。：；、％%—]{12,}", text):
    run = m.group(0)
    for L in range(len(run), 11, -1):
        for i in range(0, len(run) - L + 1):
            ph = run[i:i+L]
            if ph in done: continue
            n = text.count(ph)
            if n >= 3:
                print(f"  x{n}: {ph}")
                # mark substrings as covered
                for j in range(len(ph)):
                    for k in range(j+8, len(ph)+1): done.add(ph[j:k])
print("\n=== METRICS ===")
mt = metrics(text)
print(mt)
