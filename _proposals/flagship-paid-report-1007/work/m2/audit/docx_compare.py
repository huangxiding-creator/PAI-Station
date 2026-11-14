# -*- coding: utf-8 -*-
"""docx_compare — 金标准对照解剖器: 用户手排 vs WES排版引擎输出.
全维度: 页面设置/样式表/字体字号分布/段落间距/标题层级/表格样式/页眉页脚/目录.
"""
import sys
import zipfile
import re
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
USER = Path(r"E:\AI-Station\ResearchFactory-Eng\06 迭代优化\《EPC工程审计与决算实战研究报告》（总包创研院）20261114.docx")
MINE = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\audit\sched\out\REPORT_FULL_WPS排版版.docx")


def anatomy(fp: Path, tag: str):
    z = zipfile.ZipFile(fp)
    doc = z.read("word/document.xml").decode("utf-8", "replace")
    styles = z.read("word/styles.xml").decode("utf-8", "replace") if "word/styles.xml" in z.namelist() else ""
    print(f"\n{'='*20} {tag} {'='*20}")
    # 1. 页面设置 (sectPr)
    for m in re.finditer(r"<w:sectPr.*?</w:sectPr>", doc, re.S):
        s = m.group(0)
        pg = re.search(r'<w:pgSz w:w="(\d+)" w:h="(\d+)"', s)
        mg = re.search(r'<w:pgMar w:top="(-?\d+)" w:right="(-?\d+)" w:bottom="(-?\d+)" w:left="(-?\d+)"', s)
        if pg:
            print(f"页面: {int(pg.group(1))/20}x{int(pg.group(2))/20}pt", end=" ")
        if mg:
            print(f"边距 上{int(mg.group(1))/20} 右{int(mg.group(2))/20} 下{int(mg.group(3))/20} 左{int(mg.group(4))/20}pt")
    # 2. 字体分布 (run级 rFonts)
    fonts = Counter(re.findall(r'w:eastAsia="([^"]+)"', doc))
    print(f"中文字体: {dict(fonts.most_common(5))}")
    # 3. 字号分布
    szs = Counter(re.findall(r'<w:sz w:val="(\d+)"', doc))
    szs_pt = {f"{int(k)/2:g}pt": v for k, v in szs.most_common(8)}
    print(f"字号分布: {szs_pt}")
    # 4. 行距
    spac = Counter(re.findall(r'<w:spacing[^/]*w:line="(\d+)"', doc))
    print(f"行距(1/240行): {dict(spac.most_common(4))}")
    before = Counter(re.findall(r'w:before="(\d+)"', doc))
    print(f"段前距(1/20pt): {dict(before.most_common(4))}")
    # 5. 段首缩进
    ind = Counter(re.findall(r'<w:ind w:firstLine="(\d+)"', doc))
    print(f"首行缩进(1/20pt): {dict(ind.most_common(4))}")
    # 6. 标题样式使用
    pstyles = Counter(re.findall(r'<w:pStyle w:val="([^"]+)"', doc))
    print(f"段落样式: {dict(pstyles.most_common(10))}")
    # 7. 表格
    tbl_n = len(re.findall(r"<w:tbl>", doc))
    tbl_styles = Counter(re.findall(r"<w:tblStyle w:val=\"([^\"]+)\"", doc))
    print(f"表格数: {tbl_n} | 表样式: {dict(tbl_styles.most_common(4))}")
    # 8. 页眉页脚
    hdr = [n for n in z.namelist() if "header" in n]
    ftr = [n for n in z.namelist() if "footer" in n]
    print(f"页眉{len(hdr)}个 页脚{len(ftr)}个")
    if hdr:
        h0 = z.read(sorted(hdr)[0]).decode("utf-8", "replace")
        htxt = "".join(re.findall(r"<w:t[^>]*>([^<]*)</w:t>", h0))
        pgnum = "PAGE" in h0 or "PAGE" in (z.read(sorted(ftr)[0]).decode("utf-8","replace") if ftr else "")
        print(f"页眉文本样例: {htxt[:40]!r} | 页码域: {pgnum}")
    # 9. 目录
    print(f"TOC域: {len(re.findall(r'TOC ', doc))}处")
    # 10. 样式表定义数
    print(f"样式定义: {len(re.findall(r'<w:style ', styles))}个")
    z.close()


anatomy(USER, "用户手排·金标准")
anatomy(MINE, "WPS引擎·我方")
