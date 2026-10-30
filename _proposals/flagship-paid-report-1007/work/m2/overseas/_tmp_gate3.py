# -*- coding: utf-8 -*-
"""gate3 传递可溯判定 (EPC-OVERSEAS 战役适配件).
逻辑: num_pat = 数字(亿/万/%/个百分点后缀或年份); 对每句: 无P锚且含数字
→ 该数字须在同章任一带锚句的数字池中 (norm后比对, 全角归一).
usage: py -X utf8 _tmp_gate3.py <chapter_md> [gap_sentence_id]
"""
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

chap = open(sys.argv[1], encoding='utf-8').read()

_FW = { **{c: c - 0xFEE0 for c in range(0xFF10, 0xFF1A)},
        0xFF05: 0x25, 0xFF0E: 0x2E }
norm = lambda x: x.translate(_FW).replace(',', '').replace('，', '').replace(' ', '')

num_pat = re.compile(
    r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])')

# N1: 方括号内全角分号不作句界
body = re.sub(r'\[[^\[\]]*\]', lambda m: m.group(0).replace('；', ';'), chap)
sents = re.split(r'[。；\n]', body)

def nums_of(s, anchored):
    t = s
    if anchored:
        t = re.sub(r'\[[^\[\]]*[来源来][^\[\]]*\]', '', t)  # 去引用标注(标题可能带数字)
        t = re.sub(r'P\d{6}', '', t)
    return [norm(m) for m in num_pat.findall(t)]

# 数字池: 全章带锚句的数字
pool = set()
for s in sents:
    if 'own_calc' in s: continue
    if re.search(r'P\d{6}', s):
        pool.update(nums_of(s, True))

gap_sents, gap_nums = [], 0
for s in sents:
    if 'own_calc' in s: continue
    if re.search(r'P\d{6}', s): continue
    ns = nums_of(s, False)
    miss = [n for n in ns if n not in pool]
    if miss:
        gap_sents.append((miss, s.strip()[:90]))
        gap_nums += len(miss)

name = sys.argv[1].replace('\\', '/').split('/')[-1]
print(f"{name}: gap_sents={len(gap_sents)} gap_nums={gap_nums} -> {'PASS' if not gap_sents else 'FAIL'}")
for g in gap_sents:
    print('  GAP', g[0], '|', g[1])
sys.exit(0 if not gap_sents else 1)
