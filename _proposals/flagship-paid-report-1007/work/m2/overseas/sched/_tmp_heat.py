# -*- coding: utf-8 -*-
"""repeat-heat: 找出"冗余token质量"最高的句段 — 重写优先级排序"""
import re, sys
from pathlib import Path
sys.path.insert(0, r'E:\AI-Station\reforge_factory')
import density_gate as dg

def analyze(path, topn=30):
    t = Path(path).read_text(encoding='utf-8')
    # 只看正文: 排除表格行/标题行/代码块
    lines, out_lines, in_code = t.split('\n'), [], False
    for ln in lines:
        s = ln.strip()
        if s.startswith('```'): in_code = not in_code; continue
        if in_code or s.startswith('|') or s.startswith('#'): continue
        out_lines.append(ln)
    body = '\n'.join(out_lines)
    # gram 计数 (全文, 含表格标题 — 类型计数按全文)
    from collections import Counter
    cnt = Counter()
    for seg in dg._CJK_SEG_RE.findall(t):
        for i in range(len(seg)-1):
            g = seg[i:i+2]
            if g not in dg.SKELETON_GRAMS: cnt[g] += 1
        for i in range(len(seg)-2):
            g = seg[i:i+3]
            if g not in dg.SKELETON_GRAMS: cnt[g] += 1
    # 按句切正文
    sents = [s for s in re.split(r'(?<=[。；：！？])|\n', body) if re.search(r'[\u4e00-\u9fff]', s)]
    rows = []
    for s in sents:
        cjk = len(re.findall(r'[\u4e00-\u9fff]', s))
        if cjk < 12: continue
        exc = 0; tot = 0
        for seg in dg._CJK_SEG_RE.findall(s):
            for i in range(len(seg)-1):
                g = seg[i:i+2]
                if g not in dg.SKELETON_GRAMS: tot += 1; exc += cnt[g]-1
            for i in range(len(seg)-2):
                g = seg[i:i+3]
                if g not in dg.SKELETON_GRAMS: tot += 1; exc += cnt[g]-1
        rows.append((exc, cjk, tot, s.strip()))
    rows.sort(reverse=True)
    print(f'file={path} prose_sents={len(rows)}')
    top = rows[:topn]
    for exc, cjk, tot, s in top:
        print(f'[exc={exc:4d} cjk={cjk:3d} ratio={exc/max(1,tot):.2f}] {s[:90]}')

if __name__ == '__main__':
    analyze(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 else 30)
