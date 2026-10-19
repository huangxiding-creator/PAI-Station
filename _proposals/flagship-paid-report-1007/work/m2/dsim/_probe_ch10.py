# -*- coding: utf-8 -*-
import re, json, sys
sys.stdout.reconfigure(encoding='utf-8')
base = r'E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/dsim'
chap = open(base + r'/ch10.md', encoding='utf-8').read()
bank = open(base + r'/bank_ch10.md', encoding='utf-8').read()
actual = set(json.load(open(base + r'/anchor_miss.json', encoding='utf-8'))['10'])

bank_nc = bank.replace(',', '').replace('，', '')
for name, unit_rx in [
    ('A_units', r'(亿|万|元|%|％|倍|个|页|字)'),
    ('B_units', r'(亿|万|元|%|％|倍|个|页|字|年|家|项|篇|人|卷)'),
]:
    tokens = []
    for m in re.finditer(r'(\d[\d,]*(?:\.\d+)?)' + unit_rx, chap):
        num = m.group(1).replace(',', '')
        tokens.append(num + m.group(2))
    toks = sorted(set(tokens))
    for bankname, banktext in [('raw', bank), ('nocomma', bank_nc)]:
        miss = set(t for t in toks if t not in banktext)
        inter = miss & actual
        print(f'{name}/{bankname}: tokens={len(toks)} miss={len(miss)} actual={len(actual)} hit={len(inter)} extra={sorted(miss-actual)[:10]} missed_by={sorted(actual-miss)[:10]}')
