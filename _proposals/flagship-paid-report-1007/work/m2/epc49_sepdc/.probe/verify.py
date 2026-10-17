# -*- coding: utf-8 -*-
import re, sys, json
sys.stdout.reconfigure(encoding='utf-8')
d = r'E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/epc49_sepdc'
chap = open(d+'/ch05.md', encoding='utf-8').read()
bank = open(d+'/bank_ch05.md', encoding='utf-8').read()
UNITS = '亿|万|元|%|％|倍|个|页|字'
def run(rx, label):
    toks = []
    for m in re.finditer(rx, chap):
        toks.append(m.group(1).replace(',', '') + m.group(2))
    miss = sorted(set(t for t in set(toks) if t not in bank))
    print(f'{label}: tokens={len(set(toks))} miss={len(miss)}', miss[:20])
    return miss
m1 = run(r'(\d[\d,]*(?:\.\d+)?)(%s)' % UNITS, 'EXACT')
m2 = run(r'(\d[\d,]*(?:\.\d+)?)\s*(%s)' % UNITS, 'STRICT(ws-tolerant)')
# pool-metadata & residual checks
print('213页 in chap:', '213页' in chap, '| 213 in chap:', chap.count('213'))
print('CJK chars:', sum(1 for c in chap if '\u4e00' <= c <= '\u9fff'))
# anchors used vs bank anchors present
used = set(re.findall(r'P(\d{4})', chap))
have = set(re.findall(r'## P(\d{4})', bank))
print('anchors used:', sorted(used), 'invalid:', sorted(used - have))
