# -*- coding: utf-8 -*-
# usage: m2_gate.py <chapter_md>  -- wordcount band + anchors + own_calc + jargon
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
t = open(sys.argv[1], encoding='utf-8').read()
cjk = lambda s: len(re.findall(r'[\u4e00-\u9fff]', s))
body = t.split('## 一、',1)[1].rsplit('---',1)[0] if '## 一、' in t else t
n = cjk(body)
print(f"body_cjk={n} target=6800 band=[6460,7140] -> {'PASS' if 6460<=n<=7140 else 'FAIL'}")
anchors = len(set(re.findall(r'P00\d{4}', t)))  # 先算后嵌: f-string 表达式内反斜杠是 3.12+ 语法, 311 拒绝
print(f"anchors={anchors} own_calc={t.count('own_calc')}")
for w in ['抓手','赋能','闭环','颗粒度','对齐','心智','生态位','打法沉淀','组合拳' if '组合拳' in body else 'ZZZ']:
    if w in body: print(f"jargon_hit: {w}")
