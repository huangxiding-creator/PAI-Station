# -*- coding: utf-8 -*-
"""Render pages of the Lanzhou EPC system-doc PDF to PNG for visual reading."""
import sys, os
import pymupdf

sys.stdout.reconfigure(encoding="utf-8")

PDF = r"D:\兰州水源地专著\03、EPC项目管理体系文件\兰州水源地工程EPC项目管理体系文件 (20151119提交版).pdf"
OUT = r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区\RESEARCH_DOCKET\deep\_tixi_pages"
os.makedirs(OUT, exist_ok=True)

start = int(sys.argv[1])  # 1-based inclusive
end = int(sys.argv[2])    # 1-based inclusive
zoom = float(sys.argv[3]) if len(sys.argv) > 3 else 2.0  # 2.0 ~= 144 dpi

doc = pymupdf.open(PDF)
mat = pymupdf.Matrix(zoom, zoom)
for p in range(start - 1, min(end, doc.page_count)):
    page = doc[p]
    pix = page.get_pixmap(matrix=mat)
    name = os.path.join(OUT, "p%03d.png" % (p + 1))
    pix.save(name)
print("rendered", start, "-", min(end, doc.page_count), "of", doc.page_count)
