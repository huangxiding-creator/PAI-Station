# -*- coding: utf-8 -*-
# usage: m2_gate2.py <chapter_md> <source_txt>  -- number-at-anchor verification
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
# ---- 写作冻结硬闸 (1010 用户两连令, 见 collection_gate.py) ----
import json as _j
from pathlib import Path as _P
try:
    _g = _j.loads((_P(__file__).parent / "collection_gate_state.json")
                  .read_text(encoding="utf-8"))
except Exception:
    _g = {}
if not _g.get("user_approved"):
    print("⛔ COLLECTION_GATE: 调研搜集字数门未达标/用户未验收 — "
          "写作冻结中 (python collection_gate.py status 看门态)")
    sys.exit(2)
chap = open(sys.argv[1], encoding='utf-8').read()
src = {}
for line in open(sys.argv[2], encoding='utf-8'):
    m = re.match(r'\[P(\d{6})\]\s?(.*)', line.strip())
    if m: src[int(m.group(1))] = m.group(2)
order = sorted(src)
def para_text(a):
    if a not in src: return None
    i = order.index(a)
    return ' '.join(src.get(order[j],'') for j in (i-1,i,i+1) if 0<=j<len(order))
norm = lambda x: x.replace(',','').replace('，','').replace(' ','')
body = chap.split('## 一、',1)[1]
checked = passed = 0; bad = []
for s in re.split(r'[。；\n]', body):
    if 'own_calc' in s: continue
    if re.search(r'P\d{6}\s*[-–—]', s): continue
    anchors = [int(x) for x in re.findall(r'P(\d{6})', s)]
    if not anchors: continue
    s_clean = re.sub(r'P\d{6}', '', s)
    nums = set(re.findall(r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])', s_clean))
    if not nums: continue
    ctxs = [para_text(a) for a in set(anchors)]
    for a in set(anchors):
        if para_text(a) is None: bad.append((a,'ANCHOR_NOT_FOUND',''))
    for nn in nums:
        checked += 1
        if any(c and norm(nn) in norm(c) for c in ctxs): passed += 1
        else: bad.append((anchors[0], f'NUM_{nn}', s[:70]))
print(f"num_checks={checked} passed={passed} fail={len(bad)} -> {'PASS' if not bad else 'FAIL'}")
for b in bad[:12]: print("  MISS", b[0], b[1], '|', b[2])
