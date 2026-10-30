# -*- coding: utf-8 -*-
"""_tmp_gate2_probe2 — 复刻 gate2 判定, 只打印 MISS 段; 对每个 MISS 数字给全bank命中(含出处行标记)."""
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

ch_no = sys.argv[1]
M2 = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/overseas/sched"
chap = open(f"{M2}/_ch{ch_no}_p1.md", encoding='utf-8').read()
bank = open(f"{M2}/bank_ch{ch_no}.md", encoding='utf-8').read()

# parse bank: body + 出处-line separately
src, src_meta, cur, buf, meta = {}, {}, None, [], ''
for line in bank.splitlines():
    m = re.match(r'##\s*(P\d{6})', line.strip())
    if m:
        if cur: src[cur] = '\n'.join(buf); src_meta[cur] = meta
        cur, buf, meta = int(m.group(1)[1:]), [], ''
    elif cur is not None:
        if line.startswith('出处:'): meta = line
        elif not line.startswith('路径:'): buf.append(line)
if cur: src[cur] = '\n'.join(buf); src_meta[cur] = meta

def norm(x): return x.replace(',', '').replace('，', '').replace(' ', '')

print(f"########## ch{ch_no} failing segments ##########")
for s in re.split(r'[。；\n]', chap):
    if 'own_calc' in s: continue
    if re.search(r'P\d{6}\s*[-–—]', s): continue
    anchors = [int(x) for x in re.findall(r'P(\d{6})', s)]
    if not anchors: continue
    s_clean = re.sub(r'P\d{6}', '', s)
    nums = set(re.findall(r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])', s_clean))
    if not nums: continue
    ctxs = [src.get(a, '') for a in set(anchors)]
    fails = [nn for nn in nums if not any(c and norm(nn) in norm(c) for c in ctxs)]
    if not fails: continue
    print(f"\n>> MISS nums={sorted(fails)} anchors={sorted(set(anchors))}")
    print(f"   SEG: {s[:180]}")
    for nn in sorted(fails):
        # bank-wide: body hits and 出处-line hits
        bh = [a for a, t in sorted(src.items()) if norm(nn) in norm(t)]
        mh = [a for a, t in sorted(src_meta.items()) if norm(nn) in norm(t)]
        print(f"   [{nn}] body-hits={bh} chuchu-hits={mh}")
