# -*- coding: utf-8 -*-
"""Wave2/3 预抽取: 浙宁冀青黑闽津鲁滇 9 省源 -> work/m2/<slug>.txt/.headings.md
主对话专用; 与 wave-1 agent 前缀(黔琼皖新川)零冲突。幂等: 已存在则跳过。
"""
import glob
import os
import subprocess
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE = r"F:\新建文件夹\AI总包创新院\总包研报"
PY = r"C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe"
EX = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2_extract.py"
OUT = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2"

JOBS = [
    ("浙江", "zhejiang"),
    ("宁夏", "ningxia"),
    ("河北", "hebei"),
    ("青海", "qinghai"),
    ("黑龙江", "heilongjiang"),
    ("福建", "fujian"),
    ("天津", "tianjin"),
    ("山东", "shandong"),
    ("云南", "yunnan"),
]

for kw, slug in JOBS:
    out = os.path.join(OUT, slug)
    if os.path.exists(out + ".txt"):
        print(f"[{kw}] skip (exists)")
        continue
    cands = glob.glob(os.path.join(BASE, f"*{kw}*", "*.docx"))
    if not cands:
        print(f"[{kw}] NO DOCX under *{kw}*")
        continue
    src = max(cands, key=os.path.getsize)
    r = subprocess.run(
        [PY, EX, src, out],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
    )
    tail = (r.stdout or r.stderr or "").strip().splitlines()
    print(f"[{kw}] {os.path.basename(src)[:48]} (of {len(cands)}) -> {tail[-1] if tail else 'NO OUTPUT'}")
print("DONE")
