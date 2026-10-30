# -*- coding: utf-8 -*-
"""Numeric audit: every number-bearing token in _ch02_p1.md must trace to bank_ch02.md."""
import re, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

p1 = r'E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch02_p1.md'
bank = r'E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\bank_ch02.md'
t = open(p1, encoding='utf-8').read()
b = open(bank, encoding='utf-8').read()

b_nospace = re.sub(r'\s+', '', b)
b_norm = (b_nospace.replace('\uff08', '(').replace('\uff09', ')')
          .replace('\u3010', '[').replace('\u3011', ']')
          .replace('\u3014', '[').replace('\uff3b', '[').replace('\uff3d', ']'))

def norm(s):
    s = s.strip()
    return (s.replace('\uff08', '(').replace('\uff09', ')')
             .replace('\u3010', '[').replace('\u3011', ']')
             .replace('\u3014', '[').replace('\uff3b', '[').replace('\uff3d', ']'))

cands = set()

# 1) doc numbers: XXX〔YYYY〕N号  (full/half width brackets, spaces tolerated in bank)
for m in re.finditer(r'[\u4e00-\u9fff]{0,10}(?:[\u3014\[\uff08(\u3010]\s*\d{4}\s*[\u3015\]\uff09)\u3011]\s*\d{1,4}\s*\u53f7)', t):
    cands.add(('WENHAO', m.group(0)))
# special OCR-variant doc numbers (letter O in year)
for pat in [r'\u664b\u5efa\u6807\u5b9a\u5b57.{0,4}2008.{0,3}1\u53f7',
            r'\u5b81\u5efa\uff08\u79d1\uff09\u5b57.{0,6}2011.{0,4}23\s*\u53f7',
            r'\u5efa\u6807.{0,4}2013.{0,3}44\u53f7']:
    for m in re.finditer(pat, t):
        cands.add(('WENHAO_OCR', m.group(0)))

# 2) standard codes
for m in re.finditer(r'(?:GB|JTG(?:/T)?|ZYA\d?)[\s/-]*\d{2,6}(?:-\d{2,4})?', t):
    cands.add(('STD', m.group(0)))
for m in re.finditer(r'GB\s*\d{5}(?:-\d{4})?', t):
    cands.add(('STD', m.group(0)))

# 3) dates
for m in re.finditer(r'(?:19|20)\d{2}\u5e74\d{1,2}\u6708\d{1,2}\u65e5', t):
    cands.add(('DATE', m.group(0)))
for m in re.finditer(r'(?:19|20)\d{2}\u5e74\d{1,2}\u6708', t):
    cands.add(('YMO', m.group(0)))
for m in re.finditer(r'(?:19|20)\d{2}\u5e74', t):
    cands.add(('YEAR', m.group(0)))

# 4) percentages
for m in re.finditer(r'\d{1,3}%', t):
    cands.add(('PCT', m.group(0)))

# 5) counts with units
for m in re.finditer(r'\d+(?:\.\d+)?(?:\u4e07|\u4ebf)?(?:\u5143)?(?:\u5bb6|\u540d|\u6761|\u4e2a|\u672c|\u65e5|\u7ae0|\u6b21|\u7701(?:\u5e02)?|\u5c4a|\u4eba|\u518c)', t):
    s = m.group(0)
    if not re.match(r'^\d+\u5e74$', s):
        cands.add(('CNT', s))

# 6) article refs
for m in re.finditer(r'\u7b2c[\u4e00-\u9fff\d]+\u6761', t):
    cands.add(('TIAO', m.group(0)))

missing, ok = [], 0
for kind, c in sorted(cands):
    cn = norm(c)
    cn_ns = re.sub(r'\s+', '', cn)
    if cn_ns in b_norm or c in b:
        ok += 1
        continue
    if kind == 'WENHAO_OCR':
        # check with O-substitution (bank OCR used letter O for zero)
        variant = re.sub(r'\s+', '', cn).replace('0', 'O')
        if variant in b_norm:
            ok += 1
            continue
    missing.append((kind, c))

print('candidates:', ok + len(missing), '| verified:', ok, '| manual-check:', len(missing))
for kind, c in missing:
    print('MISSING', kind, repr(c))
