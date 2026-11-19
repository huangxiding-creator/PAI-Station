# -*- coding: utf-8 -*-
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
lines = open('bank_ch05.md', encoding='utf-8', errors='replace').read().splitlines()
for i in (5, 6):
    ln = lines[i]
    print(i, repr(ln[:20]))
    print('  startswith ## P0:', ln.startswith('## P0'))
    print('  first char ord:', ord(ln[0]) if ln else None)
    print('  contains path:', '路径' in ln)
