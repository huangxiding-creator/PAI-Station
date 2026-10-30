# -*- coding: utf-8 -*-
"""模拟器: 测候选插入段对章节 new_ngram_rate 的边际贡献"""
import re, sys
from pathlib import Path
sys.path.insert(0, r'E:\AI-Station\reforge_factory')
import density_gate as dg

def grams(text):
    toks, types = [], set()
    for seg in dg._CJK_SEG_RE.findall(text):
        for i in range(len(seg) - 1):
            g = seg[i:i+2]; toks.append(g)
            if g not in dg.SKELETON_GRAMS: types.add(g)
        for i in range(len(seg) - 2):
            g = seg[i:i+3]; toks.append(g)
            if g not in dg.SKELETON_GRAMS: types.add(g)
    return toks, types

def simulate(chapter_text, candidates):
    _, U = grams(chapter_text)
    t0, _ = grams(chapter_text)
    T0 = len(t0)
    for c in candidates:
        tc, uc = grams(c)
        # marginal: types in candidate not already in chapter
        marg = len(uc - U)
        print(f'cand cjk={len(re.findall(chr(91)+"\u4e00-\u9fff"+chr(93), c))} tokens={len(tc)} newtypes={marg} r_marg={marg/max(1,len(tc)):.3f}')
    allc = '\n'.join(candidates)
    ta, ua = grams(chapter_text + '\n' + allc)
    print(f'combined rate={(len(ua)-0)/(len(ta)):.4f} (base {len(U)}/{len(t0)}={len(U)/len(t0):.4f})')

if __name__ == '__main__':
    ch = open(sys.argv[1], encoding='utf-8').read()
    cands = Path(sys.argv[2]).read_text(encoding='utf-8').split('\n@@@\n')
    simulate(ch, [c for c in cands if c.strip()])
