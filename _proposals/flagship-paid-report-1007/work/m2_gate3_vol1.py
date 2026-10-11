# -*- coding: utf-8 -*-
"""m2_gate3_vol1 — 卷一[融合]章跨卷互引数字门 (同 m2_gate3_vol4 精神, 跨卷版).

  - REF = (?<![\\d.])([1-4])-(\\d{1,2})(?!\\d): 1-N(兄弟章, 排自身)/2-N(1-28)/
    3-N(1-17)/4-N(1-8), 越界 -> NO_CHAPTER.
  - 句中数字 (亿/万/%/个百分点 后缀 或 独立年份) 必须逐字出现在该句引用的
    某一章 md 里 (逗号归一化子串匹配); own_calc 句豁免.
  - 带数字句无任何合法引用 -> UNREF.

usage: python m2_gate3_vol1.py <fusion_md> <own_num>
exit: 0 恒 (判据在打印行), 2 = 写作冻结闸 (复用 collection_gate)
"""
import re
import sys
import glob
import os

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
# ---- 写作冻结硬闸 (同 m2_gate2/m2_gate3_vol4) ----
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

BB = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                  "..", "_proposals", "flagship-paid-report-1007", "bluebook")
BB = os.path.normpath(os.path.join(
    r"E:\AI-Station\_proposals\flagship-paid-report-1007", "bluebook"))

md_path, own_num = sys.argv[1], int(sys.argv[2])
text = open(md_path, encoding='utf-8').read()

RANGES = {1: (1, 9), 2: (0, 29), 3: (0, 17), 4: (0, 9)}


def chap_text(vol, num):
    if vol not in RANGES:
        return None
    lo, hi = RANGES[vol]
    if not (lo <= num <= hi) or (vol == 1 and num == own_num):
        return None
    hits = glob.glob(os.path.join(BB, f"vol{vol}", f"{vol}-{num}-*.md"))
    return open(hits[0], encoding='utf-8').read() if len(hits) == 1 else None


NUM = re.compile(r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))')
YEAR = re.compile(r'(?<![\d.])(?:19|20)\d{2}(?![\d.])')
REF = re.compile(r'(?<![\d.])([1-4])-(\d{1,2})(?!\d)')
norm = lambda s: s.replace(',', '').replace('，', '')

body = text.split('## 一、', 1)[1].rsplit('---', 1)[0] if '## 一、' in text else text
anchors = sorted({(int(m.group(1)), int(m.group(2)))
                  for m in REF.finditer(text)})

checks = passed = 0
bad = []
for s in re.split(r'[。；\n]', body):
    if 'own_calc' in s:
        continue
    nums = NUM.findall(s) + YEAR.findall(s)
    if not nums:
        continue
    refs = sorted({(int(m.group(1)), int(m.group(2)))
                   for m in REF.finditer(s)})
    ctxs = []
    for v, n in refs:
        t = chap_text(v, n)
        if t is None:
            bad.append(f"NO_CHAPTER: {v}-{n} :: {s[:60]}")
        else:
            ctxs.append(t)
    if not refs:
        bad.append(f"UNREF: {' '.join(nums)} :: {s[:60]}")
        checks += 1
        continue
    for nn in set(nums):
        checks += 1
        if any(norm(nn) in norm(c) for c in ctxs):
            passed += 1
        else:
            bad.append(f"MISS {nn} @{','.join(f'{v}-{n}' for v, n in refs)} :: {s[:60]}")

print(f"num_checks={checks} passed={passed} fail={len(bad)} "
      f"-> {'PASS' if not bad else 'FAIL'}")
print(f"chapter_refs={len(anchors)} -> {['%d-%d' % a for a in anchors]}")
for b in bad[:20]:
    print(" ", b)
