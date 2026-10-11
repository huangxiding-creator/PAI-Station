# -*- coding: utf-8 -*-
"""m2_gate3_vol2 — 卷二[融合]章(2-0 导论 / 2-29 对标矩阵)章节互引数字门.

与 m2_gate3(卷三 3-0 用)同精神, 源换成被引 2-N 企业章:
  - 按句切分 (。；\n); 含 own_calc 的句子豁免 (自算已自证).
  - 句中数字 (亿/万/%/个百分点 后缀 或 独立年份) 必须逐字出现在该句引用的
    2-N 章节文件里 (逗号归一化子串匹配).
  - 带数字但无任何 2-N 章引用的句子 -> UNREF (融合章数字必须挂章节引用).
  - 引用不存在/越界 (N 须 1..28, 0/29 是融合章自身) -> NO_CHAPTER.

usage: python m2_gate3_vol2.py <fusion_md> <vol_dir>
exit: 0 恒 (判据在打印行), 2 = 写作冻结闸 (复用 collection_gate)
"""
import re
import sys
import glob
import os

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
# ---- 写作冻结硬闸 (同 m2_gate/m2_gate2/m2_gate3) ----
import json as _j
from pathlib import Path as _P
try:
    _g = _j.loads((_P(__file__).parent / "collection_gate_state.json")
                  .read_text(encoding="utf-8"))
except Exception:
    _g = {}
if not _g.get("user_approved"):
    print("⛔ COLLECTION_GATE: 写作冻结中 (python collection_gate.py status)")
    sys.exit(2)

md_path, vol_dir = sys.argv[1], sys.argv[2]
text = open(md_path, encoding='utf-8').read()

# 章文件定位: 2-N-*.md, N∈1..28 (0/29 为融合章自身, 不作被引源)
_chap_files = {}
for p in glob.glob(os.path.join(vol_dir, '2-*.md')):
    m = re.match(r'2-(\d+)-', os.path.basename(p))
    if m and 1 <= int(m.group(1)) <= 28:
        _chap_files[int(m.group(1))] = p
_chap_text = {k: open(v, encoding='utf-8').read() for k, v in _chap_files.items()}

NUM = re.compile(r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))')
YEAR = re.compile(r'(?<![\d.])(?:19|20)\d{2}(?![\d.])')
REF = re.compile(r'2-(2[0-8]|1[0-9]|[1-9])(?!\d)')
norm = lambda s: s.replace(',', '').replace('，', '')

body = text.split('## 一、', 1)[1].rsplit('---', 1)[0] if '## 一、' in text else text
anchors = sorted({int(m) for m in REF.findall(text)})

checks = passed = 0
bad = []
for s in re.split(r'[。；\n]', body):
    if 'own_calc' in s:
        continue
    nums = [n for n in NUM.findall(s)] + [y for y in YEAR.findall(s)]
    if not nums:
        continue
    refs = sorted({int(m) for m in REF.findall(s)})
    if not refs:
        bad.append(f"UNREF: {' '.join(nums)} :: {s[:60]}")
        checks += 1
        continue
    ctxs = []
    for r in refs:
        if r not in _chap_text:
            bad.append(f"NO_CHAPTER: 2-{r} :: {s[:60]}")
            ctxs = None
            break
        ctxs.append(_chap_text[r])
    if ctxs is None:
        continue
    for nn in set(nums):
        checks += 1
        if any(norm(nn) in norm(c) for c in ctxs):
            passed += 1
        else:
            bad.append(f"MISS {nn} @2-{'/'.join(map(str, refs))} :: {s[:60]}")

print(f"num_checks={checks} passed={passed} fail={len(bad)} "
      f"-> {'PASS' if not bad else 'FAIL'}")
print(f"chapter_refs={len(anchors)} -> {anchors}")
for b in bad:
    print(" ", b)
