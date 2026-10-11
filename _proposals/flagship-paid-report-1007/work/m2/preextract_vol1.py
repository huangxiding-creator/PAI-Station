# -*- coding: utf-8 -*-
"""卷一 1-8 预抽取: 创效30招 + 从100篇论文看华东院 -> work/m2/topic_<slug>.txt
两源各自独立 bank (无合并 -> 全部 k=0 无偏移). 幂等: bank 已存在则跳过.
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
TMP = os.path.join(OUT, "_vol1_tmp")
os.makedirs(TMP, exist_ok=True)

# (slug, [glob 关键词...]) — 与 preextract_topic 同剔重规则
JOBS = [
    # 1-8 盈利真相: 创效30招 (招式名录在 5-3, 杠杆量化在 1-8)
    ("chuangxiao", ["*中国企业EPC业务创效30招*"]),
    # 1-8 盈利真相: 华东院论文稿 (企业池稿 ent_huadong 已在 2-16 用, 此为论文稿)
    ("lunwen", ["*从100篇论文看电建华东院*"]),
]

for slug, kws in JOBS:
    bank = os.path.join(OUT, f"topic_{slug}.txt")
    if os.path.exists(bank):
        print(f"[{slug}] skip (exists)")
        continue
    srcs = []
    for kw in kws:
        srcs += glob.glob(os.path.join(BASE, kw, "*.docx"))
    srcs = [s for s in srcs if "副本" not in os.path.basename(s)
            and not os.path.basename(s).startswith("~$")
            and os.path.getsize(s) > 10000]
    # 同目录多稿只取最大 (单目录单稿为主)
    by_dir = {}
    for s in srcs:
        d = os.path.dirname(s)
        if d not in by_dir or os.path.getsize(s) > os.path.getsize(by_dir[d]):
            by_dir[d] = s
    srcs = sorted(by_dir.values(), key=lambda s: (-os.path.getsize(s), s))
    if not srcs:
        print(f"[{slug}] NO DOCX")
        continue
    src = srcs[0]
    tp = os.path.join(TMP, f"{slug}_0")
    r = subprocess.run([PY, EX, src, tp], capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    if not os.path.exists(tp + ".txt"):
        print(f"[{slug}] EXTRACT FAIL: {os.path.basename(src)[:40]} :: {(r.stderr or '')[:120]}")
        continue
    raw = open(tp + ".txt", encoding="utf-8").read()
    hp = open(tp + ".headings.md", encoding="utf-8").read()
    open(bank, "w", encoding="utf-8").write(raw)
    open(os.path.join(OUT, f"topic_{slug}.headings.md"), "w", encoding="utf-8").write(hp)
    os.remove(tp + ".txt")
    if os.path.exists(tp + ".headings.md"):
        os.remove(tp + ".headings.md")
    print(f"[{slug}] {os.path.basename(src)[:44]} -> topic_{slug}.txt ({len(raw)} chars)")
print("DONE")
