# -*- coding: utf-8 -*-
"""docx_zongbao — 总包创研院研究报告排版器 (1114 金标准逆向: 用户手排20261114全参数复刻).

标准(实测自用户手排版): A4/边距上下2.54cm左右3.18cm/章题黑体18pt段后18pt/
节题14B·12B层级/正文微软雅黑9pt单倍行距首行缩进44pt/页眉版权/页脚页码/目录12pt.
用法: py -X utf8 docx_zongbao.py in.docx -o out.docx
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

from docx import Document
from docx.enum.style import WD_STYLE_TYPE
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

FONT_BODY = "微软雅黑"
FONT_H1 = "黑体"


def set_font(style, name, size, bold=None, color=None):
    f = style.font
    f.name = name
    f.size = Pt(size)
    if bold is not None:
        f.bold = bold
    if color:
        f.color.rgb = RGBColor(*color)
    rpr = style.element.get_or_add_rPr()
    rf = rpr.find(qn("w:rFonts"))
    if rf is None:
        rf = rpr.makeelement(qn("w:rFonts"), {})
        rpr.append(rf)
    rf.set(qn("w:eastAsia"), name)
    rf.set(qn("w:ascii"), name)
    rf.set(qn("w:hAnsi"), name)


def set_spacing(style, line=None, before=None, after=None, indent=None):
    pf = style.paragraph_format
    if line is not None:
        pf.line_spacing = line
    if before is not None:
        pf.space_before = Pt(before)
    if after is not None:
        pf.space_after = Pt(after)
    if indent is not None:
        pf.first_line_indent = Pt(indent)


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("docx")
    ap.add_argument("-o", "--out", required=True)
    ns = ap.parse_args()
    doc = Document(ns.docx)
    S = doc.styles

    # ---- 页面: A4 边距上下2.54 左右3.18 ----
    for sec in doc.sections:
        sec.page_width = Cm(21.0)
        sec.page_height = Cm(29.7)
        sec.top_margin = Cm(2.54)
        sec.bottom_margin = Cm(2.54)
        sec.left_margin = Cm(3.18)
        sec.right_margin = Cm(3.18)

    # ---- 样式族 (总包金标准) ----
    if "Normal" in [s.name for s in S]:
        n = S["Normal"]
        set_font(n, FONT_BODY, 9)
        set_spacing(n, line=1.0, before=0, after=4)
    hmap = [
        ("Heading 1", FONT_H1, 18, False, None, 24, 18),
        ("Heading 2", FONT_BODY, 14, True, (0x1F, 0x3A, 0x5F), 12, 6),
        ("Heading 3", FONT_BODY, 12, True, (0x1F, 0x3A, 0x5F), 6, 3),
        ("Heading 4", FONT_BODY, 12, True, None, 3, 2),
    ]
    for nm, fn, sz, bd, col, bf, af in hmap:
        try:
            h = S[nm]
        except KeyError:
            continue
        set_font(h, fn, sz, bold=bd, color=col)
        set_spacing(h, line=1.3, before=bf, after=af)
    for nm in ("List Bullet", "List Number"):
        try:
            ls = S[nm]
            set_font(ls, FONT_BODY, 9)
            set_spacing(ls, line=1.0, before=0, after=2)
        except KeyError:
            pass

    # ---- 正文段落: 字体9pt + 首行缩进44pt (金标准880twips) ----
    body_styles = {"Normal"}
    for p in doc.paragraphs:
        st = p.style.name if p.style is not None else "Normal"
        is_body = st in body_styles or st.startswith("List")
        if is_body:
            for r in p.runs:
                r.font.name = FONT_BODY
                r.font.size = Pt(9)
                rpr = r._element.get_or_add_rPr()
                rf = rpr.find(qn("w:rFonts"))
                if rf is None:
                    rf = rpr.makeelement(qn("w:rFonts"), {})
                    rpr.append(rf)
                rf.set(qn("w:eastAsia"), FONT_BODY)
            if st == "Normal" and p.text.strip():
                pf = p.paragraph_format
                if not pf.first_line_indent:
                    pf.first_line_indent = Pt(44)

    # ---- 表格: 表内9pt + 三线风(保现有网格, 归一字号) ----
    for t in doc.tables:
        for row in t.rows:
            for cell in row.cells:
                for p in cell.paragraphs:
                    for r in p.runs:
                        r.font.size = Pt(9)
                        r.font.name = FONT_BODY

    # ---- 页眉: 版权声明 ----
    for sec in doc.sections:
        sec.different_first_page_header_footer = False
        hdr = sec.header
        hdr.is_linked_to_previous = False
        hp = hdr.paragraphs[0] if hdr.paragraphs else hdr.add_paragraph()
        hp.text = ""
        run = hp.add_run("总包创研院版权所有，侵权必究！")
        run.font.name = FONT_BODY
        run.font.size = Pt(8)
        run.font.color.rgb = RGBColor(0x80, 0x80, 0x80)
        hp.alignment = WD_ALIGN_PARAGRAPH.RIGHT

    # ---- 页脚: 居中页码 ----
    for sec in doc.sections:
        ftr = sec.footer
        ftr.is_linked_to_previous = False
        fp = ftr.paragraphs[0] if ftr.paragraphs else ftr.add_paragraph()
        fp.text = ""
        fp.alignment = WD_ALIGN_PARAGRAPH.CENTER
        run = fp.add_run()
        fld1 = run._element.makeelement(qn("w:fldChar"), {qn("w:fldCharType"): "begin"})
        run._element.append(fld1)
        run2 = fp.add_run()
        instr = run2._element.makeelement(qn("w:instrText"), {})
        instr.text = " PAGE "
        run2._element.append(instr)
        run3 = fp.add_run()
        fld2 = run3._element.makeelement(qn("w:fldChar"), {qn("w:fldCharType"): "end"})
        run3._element.append(fld2)
        for rr in (run, run2, run3):
            rr.font.size = Pt(9)
            rr.font.name = FONT_BODY

    out = Path(ns.out)
    doc.save(out)
    print(f"[zongbao] ✓ {out} ({out.stat().st_size:,}B)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
