# -*- coding: utf-8 -*-
import re, io, collections
P = 'sched/nblm_out/ch10_编辑稿.md'
t = io.open(P, encoding='utf-8', newline='').read().lstrip('﻿')
s = t.replace('\r\n', '\n')

print('cjk_basic(U+4E00-9FFF):', len(re.findall('[一-鿿]', s)))
print('cjk_incl_extA:', len(re.findall('[一-鿿㐀-䶿]', s)))
print('lines:', s.count('\n') + 1)

lines = s.split('\n')
heads = [l for l in lines if l.startswith('#')]
dups = [h for h, c in collections.Counter(heads).items() if c > 1]
print('heading count:', len(heads))
print('dup headings:', dups if dups else 'NONE')

for key in ['小结要点', '证据边界', '本章证据边界', '源引用对照']:
    print('head[%s]:' % key, [(i + 1, l) for i, l in enumerate(lines) if l.startswith('#') and key in l])

# spot-check: 3 subsection titles each exactly once (no two-version coexistence)
for h in ['### 10.1.2', '### 10.4.2', '### 10.7.3']:
    print('spot[%s] count=' % h, sum(1 for l in lines if l.startswith(h)))

cite = re.compile(r'\[\d+(?:\s*[,，\-–]\s*\d+)*\]')
print('total [N] tokens:', len(cite.findall(s)))
print('max ref num:', max(int(m.group(1)) for m in re.finditer(r'\[(\d+)', s)))

shown = 0
for i, ln in enumerate(lines, 1):
    m = re.search(r'\[\d+(?:\s*[,，\-–]\s*\d+)*\]\s*[。；;.]?\s*$', ln.rstrip())
    if m and shown < 5:
        print('end_cite L%d: ...%s' % (i, m.group(0)))
        shown += 1

residue = ['继续', '至此结束', '下一步建议', '我可以为您', 'losses', 'monthly', 'LSTM']
for pat in residue:
    n = s.count(pat)
    if n:
        print('RESIDUE %s x%d at lines:' % (pat, n), [i + 1 for i, l in enumerate(lines) if pat in l])
print('residue scan done')
