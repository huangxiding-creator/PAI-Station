# -*- coding: utf-8 -*-
"""段级新鲜度预检: 候选段的非骨架2/3-gram 中, 全章未见过的占比."""
import re, sys
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SKELETON_GRAMS, _CJK_SEG_RE, metrics

ch = open("_ch04_final.md", encoding="utf-8").read()
existing = set()
for seg in _CJK_SEG_RE.findall(ch):
    n = len(seg)
    for i in range(n-1):
        g = seg[i:i+2]
        if g not in SKELETON_GRAMS: existing.add(g)
    for i in range(n-2):
        g = seg[i:i+3]
        if g not in SKELETON_GRAMS: existing.add(g)

def freshness(p):
    grams, new = [], 0
    for seg in _CJK_SEG_RE.findall(p):
        n = len(seg)
        for i in range(n-1):
            g = seg[i:i+2]
            if g not in SKELETON_GRAMS:
                grams.append(g); new += (g not in existing)
        for i in range(n-2):
            g = seg[i:i+3]
            if g not in SKELETON_GRAMS:
                grams.append(g); new += (g not in existing)
    return (new/len(grams) if grams else 1.0), len(grams)

if __name__ == "__main__":
    cand = sys.argv[1:]
    for i, p in enumerate(cand):
        f, n = freshness(p)
        print(f"para{i}: fresh={f:.2f} grams={n}")
