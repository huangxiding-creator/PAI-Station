# -*- coding: utf-8 -*-
"""Survey case headers within a bank's case-slice anchors."""
import sys, io, re
sys.path.insert(0, '.')
from _bank_index import load_bank
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

bank = sys.argv[1]
anchors = load_bank(bank)
for a in anchors:
    body = '\n'.join(a['lines'])
    if '案号' not in body:
        continue
    ids = re.findall(r'案号[:：]\s*([^\n]{4,60})', body)
    names = re.findall(r'案件名称[:：]\s*([^\n]{4,80})', body)
    print('==', a['id'], a['path'])
    for i, cid in enumerate(ids[:8]):
        nm = names[i] if i < len(names) else ''
        print('   ', cid.strip(), '|', nm.strip()[:60])
