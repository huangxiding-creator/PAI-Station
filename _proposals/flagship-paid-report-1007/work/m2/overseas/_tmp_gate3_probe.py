# -*- coding: utf-8 -*-
"""gate3 定锚探针: 对每条缺口句算全量数字集, 检验候选锚(±3句带锚句的P-id)覆盖性,
不覆盖则 bank 全搜含全部数字的锚, 输出可选锚清单."""
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

ch_file, bank_file = sys.argv[1], sys.argv[2]
chap = open(ch_file, encoding='utf-8').read()
bank = open(bank_file, encoding='utf-8').read()

_FW = { **{c: c - 0xFEE0 for c in range(0xFF10, 0xFF1A)},
        0xFF05: 0x25, 0xFF0E: 0x2E }
norm = lambda x: x.translate(_FW).replace(',', '').replace('，', '').replace(' ', '')
num_pat = re.compile(
    r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])')

# bank 解析 (同 gate2, N3: 出处行入锚)
src, cur, buf, meta = {}, None, [], ''
for line in bank.splitlines():
    m = re.match(r'##\s*(P\d{6})', line.strip())
    if m:
        if cur: src[cur] = (meta + '\n' + '\n'.join(buf)) if meta else '\n'.join(buf)
        cur, buf, meta = int(m.group(1)[1:]), [], ''
    elif cur is not None:
        if line.startswith('出处:'):
            meta = line
        elif not line.startswith('路径:'):
            buf.append(line)
if cur: src[cur] = (meta + '\n' + '\n'.join(buf)) if meta else '\n'.join(buf)
BNORM = {k: norm(v) for k, v in src.items()}

body = re.sub(r'\[[^\[\]]*\]', lambda m: m.group(0).replace('；', ';'), chap)
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

def covers(anchor_id, req):
    t = BNORM.get(anchor_id, '')
    return t and all(rn in t for rn in req)

print(f"### {ch_file}  bank_anchors={len(src)}")
for i, (p, s) in enumerate(parts):
    if 'own_calc' in s or re.search(r'P\d{6}', s): continue
    ns = nums_of(s, False)
    miss = [n for n in ns if n not in pool]
    if not miss: continue
    full = sorted(set(ns), key=ns.index)
    near = set()
    for j in range(max(0, i-3), min(len(parts), i+4)):
        near |= {int(x) for x in re.findall(r'P(\d{6})', parts[j][1])}
    ok_near = [a for a in sorted(near) if covers(a, full)]
    # bank 全搜 (限已在本章被引的锚优先)
    cited = {int(x) for x in re.findall(r'P(\d{6})', chap)}
    ok_cited = [a for a in sorted(cited) if a not in ok_near and covers(a, full)]
    ok_any = [a for a in sorted(BNORM) if a not in ok_near and a not in ok_cited and covers(a, full)]
    print(f"\nGAP @{p} miss={miss} full={full}")
    print(f"  S: {s.strip()[:100]}")
    print(f"  near_anchors={sorted(near)} -> COVER: {ok_near}")
    print(f"  cited_cover: {ok_cited[:6]}{'...' if len(ok_cited)>6 else ''}")
    if not ok_near and not ok_cited:
        print(f"  bank_cover: {ok_any[:8]}{'...' if len(ok_any)>8 else ''} (total {len(ok_any)})")
