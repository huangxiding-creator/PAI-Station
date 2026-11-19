# -*- coding: utf-8 -*-
"""Count keyword hits per anchor in a bank."""
import sys, io, re
sys.path.insert(0, '.')
from _bank_index import load_bank
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

bank = sys.argv[1]
kws = sys.argv[2].split(',')
anchors = load_bank(bank)
rows = []
for a in anchors:
    body = '\n'.join(a['lines'])
    counts = [body.count(k) for k in kws]
    if sum(counts) > 0:
        rows.append((sum(counts), a['id'], counts, a['path'][:36]))
rows.sort(reverse=True)
print('kw order:', kws)
for tot, pid, counts, path in rows:
    print('%-4d %-8s %-28s %s' % (tot, pid, counts, path))
