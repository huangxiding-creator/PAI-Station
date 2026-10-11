# -*- coding: utf-8 -*-
"""卷五预抽取: 马斯克五步法(5-2) + 中国铁设(5-6) + 浙江水利(5-6) -> work/m2/topic_<slug>.txt
单源单稿 (无多稿偏移), 幂等: bank 已存在则跳过.
"""
import glob
import os
import subprocess
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE_YB = r"F:\新建文件夹\AI总包创新院\总包研报"          # 马斯克 (与 vol1 同根)
BASE_DJ = r"F:\新建文件夹\AI总包创新院\独家研究报告"        # 铁设/浙水利 (独家底稿)
PY = r"C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe"
EX = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2_extract.py"
OUT = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2"
TMP = os.path.join(OUT, "_vol5_tmp")
os.makedirs(TMP, exist_ok=True)

# (slug, 完整 docx 路径) — 逐源点名 (独家目录文件少, 直接点名最稳)
JOBS = [
    # 5-2 第一性方法×EPC: 马斯克五步法 (电子书版为正身; 排版副本不取)
    ("wubufa", os.path.join(BASE_YB, "1《马斯克成大事五步法实践指北》",
                            "电子书：《马斯克成大事五步法实践指北》（总包创研院）.docx")),
    # 5-6 独家样本 I: 中国铁设 (EXCL-01†13万)
    ("tieshe", os.path.join(BASE_DJ, "《中国铁设如何做EPC总承包？》260617.docx")),
    # 5-6 独家样本 II: 浙江水利 (EXCL-02†)
    ("zjshuili", os.path.join(BASE_DJ, "《浙江省水利工程商机研究报告》总包创研院.docx")),
]

for slug, src in JOBS:
    bank = os.path.join(OUT, f"topic_{slug}.txt")
    if os.path.exists(bank):
        print(f"[{slug}] skip (exists)")
        continue
    if not os.path.exists(src):
        # 马斯克目录名容错: glob 找一遍
        alt = glob.glob(os.path.join(os.path.dirname(src), "*.docx"))
        alt = [a for a in alt if "副本" not in os.path.basename(a)
               and "排版" not in os.path.basename(a)
               and not os.path.basename(a).startswith("~$")]
        if not alt:
            print(f"[{slug}] NO DOCX: {src[:80]}")
            continue
        src = max(alt, key=os.path.getsize)
    tp = os.path.join(TMP, f"{slug}_0")
    r = subprocess.run([PY, EX, src, tp], capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    if not os.path.exists(tp + ".txt"):
        print(f"[{slug}] EXTRACT FAIL: {os.path.basename(src)[:40]} :: {(r.stderr or '')[:120]}")
        continue
    raw = open(tp + ".txt", encoding="utf-8").read()
    hp = open(tp + ".headings.md", encoding="utf-8").read()
    open(bank, "w", encoding="utf-8").write(raw)
    open(os.path.join(OUT, f"topic_{slug}.headings.md"), encoding="utf-8").write(hp)
    os.remove(tp + ".txt")
    if os.path.exists(tp + ".headings.md"):
        os.remove(tp + ".headings.md")
    print(f"[{slug}] {os.path.basename(src)[:44]} -> topic_{slug}.txt ({len(raw)} chars)")
print("DONE")
