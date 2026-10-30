# -*- coding: utf-8 -*-
"""gate3 缺口侦察: 对每条真缺口句打印 ±3 句上下文(带锚句标出P-id), 便于人工定锚."""
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

chap = open(sys.argv[1], encoding='utf-8').read()

_FW = { **{c: c - 0xFEE0 for c in range(0xFF10, 0xFF1A)},
        0xFF05: 0x25, 0xFF0E: 0x2E }
norm = lambda x: x.translate(_FW).replace(',', '').replace('，', '').replace(' ', '')
num_pat = re.compile(
    r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])')

body = re.sub(r'\[[^\[\]]*\]', lambda m: m.group(0).replace('；', ';'), chap)

# 带位置切句
parts, pos = [], 0
for m in re.finditer(r'[。；\n]', body):
    parts.append((pos, body[pos:m.start()]))
    pos = m.start() + 1
parts.append((pos, body[pos:]))

def nums_of(s, anchored):
    t = s
    if anchored:
        t = re.sub(r'\[[^\[\]]*[来源来][^\[\]]*\]', '', t)
        t = re.sub(r'P\d{6}', '', t)
    return [norm(m) for m in num_pat.findall(t)]

pool = set()
for _, s in parts:
    if 'own_calc' in s: continue
    if re.search(r'P\d{6}', s):
        pool.update(nums_of(s, True))

for i, (p, s) in enumerate(parts):
    if 'own_calc' in s or re.search(r'P\d{6}', s): continue
    ns = nums_of(s, False)
    miss = [n for n in ns if n not in pool]
    if not miss: continue
    print(f"\n===== GAP @char{p} miss={miss}")
    print(f"  SENT: {s.strip()[:150]}")
    for j in range(max(0, i-3), min(len(parts), i+4)):
        q = parts[j][1].strip()
        if not q: continue
        anc = re.findall(r'P\d{6}', q)
        tag = ' ANC<' + ','.join(a for a in anc) + '>' if anc else ''
        mark = ' >>> ' if j == i else '     '
        print(f"{mark}[{j}]{tag} {q[:110]}")
