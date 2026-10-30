# -*- coding: utf-8 -*-
"""深改轮分析器: 按块(段落)统计 n-gram 重复贡献 + 全局高频重复gram定位."""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SKELETON_GRAMS, metrics, _CJK_SEG_RE

def grams_of(text):
    """(token列表, type集合) — 段内 2/3-gram, 与 density_gate 同口径."""
    toks, types = [], set()
    for seg in _CJK_SEG_RE.findall(text):
        n = len(seg)
        for i in range(n - 1):
            g = seg[i:i+2]; toks.append(g)
            if g not in SKELETON_GRAMS: types.add(g)
        for i in range(n - 2):
            g = seg[i:i+3]; toks.append(g)
            if g not in SKELETON_GRAMS: types.add(g)
    return toks, types

def analyze(path):
    t = open(path, encoding="utf-8").read()
    # 块 = 空行分隔的非空行簇 (保留行号)
    lines = t.split("\n")
    blocks, cur, start = [], [], None
    for i, ln in enumerate(lines, 1):
        if ln.strip():
            if start is None: start = i
            cur.append(ln)
        else:
            if cur: blocks.append((start, "\n".join(cur))); cur, start = [], None
    if cur: blocks.append((start, "\n".join(cur)))

    m = metrics(t)
    print(f"== {path}  cjk={m['cjk_chars']} rate={m['new_ngram_rate']} redund={m['redundancy_ratio']}")

    # 全局 type 集合 → 找出"全局只出现1次type占比"参考
    # 每块: tokens, types(块内去重), 以及与"全局其他块"共享的 types
    all_types = collections.Counter()
    blk_info = []
    for st, b in blocks:
        toks, types = grams_of(b)
        cjk = len(re.findall(r"[一-鿿]", b))
        blk_info.append([st, b, len(toks), len(types), cjk])
        for ty in types: all_types[ty] += 1   # 出现于多少个块

    # 块的"全局新颖度" = 本块types中全局只在此块出现的 / 本块types
    ranked = []
    for st, b, nt, nty, cjk in blk_info:
        toks, types = grams_of(b)
        uniq = sum(1 for ty in types if all_types[ty] == 1)
        # rep_tokens = 块内重复token (tot - distinct_non_skeleton)
        rep = nt - len(types)
        ranked.append((rep, nt, len(types), uniq, cjk, st, b))

    ranked.sort(key=lambda x: -x[0])
    print(f"总块数 {len(blocks)}; top 重复贡献块 (rep=tot-types):")
    for rep, nt, nty, uniq, cjk, st, b in ranked[:18]:
        head = b.split("\n")[0][:46]
        print(f"  L{st:<4} rep={rep:<4} tot={nt:<4} typ={nty:<4} uniqT={uniq:<4} cjk={cjk:<4} {head}")
    return t, ranked

if __name__ == "__main__":
    for f in sys.argv[1:]:
        analyze(f)
