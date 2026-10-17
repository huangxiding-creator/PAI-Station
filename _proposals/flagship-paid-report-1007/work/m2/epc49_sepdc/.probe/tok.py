# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8')
d = r'E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/epc49_sepdc'
chap = open(d+'/ch05.md', encoding='utf-8').read()
bank = open(d+'/bank_ch05.md', encoding='utf-8').read()
toks = []
for m in re.finditer(r'(\d[\d,]*(?:\.\d+)?)(亿|万|元|%|％|倍|个|页|字)', chap):
    toks.append(m.group(1).replace(',', '') + m.group(2))
passing = sorted(set(t for t in set(toks) if t in bank))
print('PASS TOKENS (%d):' % len(passing))
print(' '.join(passing))
