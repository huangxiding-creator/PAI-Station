# -*- coding: utf-8 -*-
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
out = []
for n in ['05','06','07','08']:
    lines = open('bank_ch%s.md' % n, encoding='utf-8', errors='replace').read().splitlines()
    cur = None
    out.append('=== ch%s ===' % n)
    hits = 0
    for ln in lines:
        if ln.startswith('## P0'):
            cur = ln.split()[0][3:]
        elif ln[:1] == '路径'[0] and '路径' in ln[:4] and cur:
            out.append(cur + ' | ' + ln[3:].strip())
            cur = None
            hits += 1
    out.append('(hits %d)' % hits)
txt = '\n'.join(out)
open('_anchor_map.txt', 'w', encoding='utf-8').write(txt)
print(txt)
