# -*- coding: utf-8 -*-
"""patch_styles — WPS 刷域回存后的终修补丁: 内置 Heading 1/2/3 样式级 rFonts 恢复字面字体.

WPS 回存会把样式 rFonts 归一为主题字体; run 级已带字面黑体/雅黑(渲染无恙),
本步把样式定义本体也恢复字面属性(协调方要求: 只改内置样式属性, 不新建样式).
只动 styles.xml, 不触碰 document.xml 域缓存与 TOC 条目.
"""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from docx import Document
from docx.oxml import OxmlElement
from docx.oxml.ns import qn

OUT = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/visa/sched/out/REPORT_FULL_出版级.docx"

WANT = {"Heading 1": "黑体", "Heading 2": "微软雅黑", "Heading 3": "微软雅黑", "Normal": "微软雅黑"}

doc = Document(OUT)
for s in doc.styles:
    nm = s.name
    if nm not in WANT or s.type is not None and str(s.type) != "PARAGRAPH (1)":
        continue
    rpr = s.element.get_or_add_rPr()
    rf = rpr.find(qn("w:rFonts"))
    if rf is None:
        rf = OxmlElement("w:rFonts")
        # rPr 子序: rFonts 应在 rStyle 之后最前
        first = rpr.find(qn("w:rStyle"))
        if first is not None:
            first.addnext(rf)
        else:
            rpr.insert(0, rf)
    for attr in ("w:asciiTheme", "w:hAnsiTheme", "w:eastAsiaTheme", "w:cstheme"):
        if rf.get(qn(attr)) is not None:
            del rf.attrib[qn(attr)]
    for a in ("w:eastAsia", "w:ascii", "w:hAnsi"):
        rf.set(qn(a), WANT[nm])
    print(f"patched style {nm}: rFonts -> {WANT[nm]}")
doc.save(OUT)
print("saved:", OUT)
