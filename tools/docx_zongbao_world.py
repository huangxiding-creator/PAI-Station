# -*- coding: utf-8 -*-
"""docx_zongbao_world — 总包标准·世界顶级出版版 三层全量 (1114用户全批).

一层=金标准基座+六工艺(zongbao2) 二层=内容呈现(导读卡/案例框/要点卡/表题规范)
三层=封面页版式. 用法: py -X utf8 docx_zongbao_world.py in.docx -o out.docx [--title 书名 --subtitle 副题]
"""
from __future__ import annotations

import argparse
import re
import sys
from datetime import date
from pathlib import Path

from docx import Document
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_TAB_ALIGNMENT, WD_TAB_LEADER
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

FONT_BODY = "微软雅黑"
FONT_H1 = "黑体"
INK = RGBColor(0x1A, 0x1A, 0x1A)
ACCENT = RGBColor(0x1F, 0x3A, 0x5F)
GREY = RGBColor(0x99, 0x99, 0x99)
CASE_BG = "F5F7FA"


def _rf(rpr, name):
    rf = rpr.find(qn("w:rFonts"))
    if rf is None:
        rf = OxmlElement("w:rFonts")
        rpr.append(rf)
    for a in ("w:eastAsia", "w:ascii", "w:hAnsi"):
        rf.set(qn(a), name)


def rstyle(run, name=FONT_BODY, size=9, bold=None, color=INK):
    run.font.name = name
    run.font.size = Pt(size)
    if bold is not None:
        run.font.bold = bold
    if color is not None:
        run.font.color.rgb = color
    _rf(run._element.get_or_add_rPr(), name)


def p_shading(p, fill):
    ppr = p._p.get_or_add_pPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:fill"), fill)
    ppr.append(shd)


def p_border(p, side="left", color="1F3A5F", sz=18):
    ppr = p._p.get_or_add_pPr()
    pbdr = ppr.find(qn("w:pBdr"))
    if pbdr is None:
        pbdr = OxmlElement("w:pBdr")
        ppr.append(pbdr)
    e = OxmlElement(f"w:{side}")
    e.set(qn("w:val"), "single")
    e.set(qn("w:sz"), str(sz))
    e.set(qn("w:space"), "4")
    e.set(qn("w:color"), color)
    pbdr.append(e)


def cell_bg(cell, fill):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:fill"), fill)
    tcPr.append(shd)


def tbl_borders(tbl):
    tblPr = tbl._tbl.tblPr
    old = tblPr.find(qn("w:tblBorders"))
    if old is not None:
        tblPr.remove(old)
    b = OxmlElement("w:tblBorders")
    for tag, sz in (("top", 12), ("bottom", 12), ("insideH", 4)):
        e = OxmlElement(f"w:{tag}")
        e.set(qn("w:val"), "single")
        e.set(qn("w:sz"), str(sz))
        e.set(qn("w:color"), "1A1A1A")
        b.append(e)
    for tag in ("left", "right", "insideV"):
        e = OxmlElement(f"w:{tag}")
        e.set(qn("w:val"), "none")
        b.append(e)
    tblPr.append(b)


def repeat_header(row):
    trPr = row._tr.get_or_add_trPr()
    th = OxmlElement("w:tblHeader")
    th.set(qn("w:val"), "true")
    trPr.append(th)


def fld(p, instr, size=9, color=None):
    rs = []
    r1 = p.add_run()
    fc = OxmlElement("w:fldChar")
    fc.set(qn("w:fldCharType"), "begin")
    r1._element.append(fc)
    r2 = p.add_run()
    it = OxmlElement("w:instrText")
    it.text = instr
    r2._element.append(it)
    r3 = p.add_run()
    fe = OxmlElement("w:fldChar")
    fe.set(qn("w:fldCharType"), "end")
    r3._element.append(fe)
    for r in (r1, r2, r3):
        rstyle(r, size=size, color=color)
    return rs


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("docx")
    ap.add_argument("-o", "--out", required=True)
    ap.add_argument("--title", default="")
    ap.add_argument("--subtitle", default="")
    ns = ap.parse_args()
    doc = Document(ns.docx)

    # ================= 三层·封面页 =================
    body = doc.sections[0]
    first = doc.paragraphs[0]
    cover_title = ns.title or (first.text.strip()[:40] if first else "")
    cov = doc.add_paragraph()
    cov._p.addprevious(cov._p.makeelement(qn("w:p"), {}))
    # 简化: 在文首插入封面段落组(倒插法)
    def insert_before_first(text, size, bold, color, space_after=6, align=WD_ALIGN_PARAGRAPH.CENTER, font=FONT_H1):
        p = first.insert_paragraph_before("")
        r = p.add_run(text)
        rstyle(r, font, size, bold=bold, color=color)
        p.alignment = align
        p.paragraph_format.space_after = Pt(space_after)
        return p

    if cover_title:
        insert_before_first("", 9, False, INK, space_after=90)
        t = insert_before_first(cover_title, 26, True, ACCENT, space_after=10)
        if ns.subtitle:
            insert_before_first(ns.subtitle, 13, False, INK, space_after=16)
        insert_before_first("─" * 16, 9, False, ACCENT, space_after=110)
        insert_before_first("总包创研院研究团队 出品", 12, True, INK, space_after=8)
        insert_before_first(date.today().strftime("%Y年%m月"), 10, False, GREY, space_after=8)
        # 封面后分页
        pb = insert_before_first("", 9, False, INK, space_after=0)
        ppr = pb._p.get_or_add_pPr()
        br = OxmlElement("w:pageBreakBefore")
        ppr.append(br)

    # ================= 一层·六工艺 =================
    settings = doc.settings.element
    if settings.find(qn("w:evenAndOddHeaders")) is None:
        settings.append(OxmlElement("w:evenAndOddHeaders"))
    for sec in doc.sections:
        sec.page_width, sec.page_height = Cm(21.0), Cm(29.7)
        sec.top_margin = sec.bottom_margin = Cm(2.54)
        sec.left_margin = sec.right_margin = Cm(3.18)
        sec.header_distance = Cm(1.5)
        sec.footer_distance = Cm(1.75)
        sec.different_first_page_header_footer = True
        even = sec.even_page_header
        even.is_linked_to_previous = False
        ep = even.paragraphs[0] if even.paragraphs else even.add_paragraph()
        ep.text = ""
        er = ep.add_run("总包创研院版权所有，侵权必究！")
        rstyle(er, size=8, color=GREY)
        ep.alignment = WD_ALIGN_PARAGRAPH.LEFT
        odd = sec.header
        odd.is_linked_to_previous = False
        op = odd.paragraphs[0] if odd.paragraphs else odd.add_paragraph()
        op.text = ""
        fld(op, " STYLEREF 1 \\s \\* MERGEFORMAT ", size=8, color=GREY)
        op.alignment = WD_ALIGN_PARAGRAPH.RIGHT
        fph = sec.first_page_header
        fph.is_linked_to_previous = False
        if fph.paragraphs:
            fph.paragraphs[0].text = ""
        for ftr in (sec.footer, sec.even_page_footer, sec.first_page_footer):
            ftr.is_linked_to_previous = False
            p0 = ftr.paragraphs[0] if ftr.paragraphs else ftr.add_paragraph()
            p0.text = ""
            p0.alignment = WD_ALIGN_PARAGRAPH.CENTER
            fld(p0, " PAGE ", size=9)

    # 正文段工艺
    paras = doc.paragraphs
    h1s = [p for p in paras if p.style is not None and p.style.name == "Heading 1"]
    for p in paras:
        st = p.style.name if p.style else "Normal"
        if st.startswith(("Heading", "toc", "TOC", "美化目录", "Title")):
            continue
        if st == "Normal" and p.text.strip():
            p.alignment = WD_ALIGN_PARAGRAPH.JUSTIFY
            if not p.paragraph_format.first_line_indent:
                p.paragraph_format.first_line_indent = Pt(44)
            p.paragraph_format.space_after = Pt(4)
        ppr = p._p.get_or_add_pPr()
        wc = OxmlElement("w:widowControl")
        wc.set(qn("w:val"), "true")
        ppr.append(wc)
        for tag in ("w:kinsoku", "w:autoSpaceDE", "w:autoSpaceDN"):
            e = OxmlElement(tag)
            e.set(qn("w:val"), "true")
            ppr.append(e)
        for r in p.runs:
            rstyle(r, size=9)

    # 章题版式
    for i, p in enumerate(h1s):
        if i > 0:
            ppr = p._p.get_or_add_pPr()
            ppr.append(OxmlElement("w:pageBreakBefore"))
        m = re.match(r"第([一二三四五六七八九十百\d]+)章\s*(.*)", p.text.strip())
        if m and p.runs:
            p.runs[0].text = f"第{m.group(1)}章"
            for r in p.runs[1:]:
                r.text = ""
            rstyle(p.runs[0], FONT_H1, 26, color=ACCENT)
            np_ = p.insert_paragraph_before("")
            nr = np_.add_run(m.group(2))
            rstyle(nr, FONT_H1, 20, color=INK)
            np_.paragraph_format.space_before = Pt(2)
            np_.paragraph_format.space_after = Pt(6)
            lp = np_.insert_paragraph_before("")
            lr = lp.add_run("─" * 14)
            rstyle(lr, size=9, color=ACCENT)
            lp.paragraph_format.space_after = Pt(18)
        p.paragraph_format.space_before = Pt(24)
        p.paragraph_format.space_after = Pt(18)

    # 目录工艺
    for p in paras:
        if p.style is not None and (p.style.name.lower().startswith("toc") or "目录" in (p.style.name or "")):
            p.paragraph_format.tab_stops.add_tab_stop(Cm(14.6), WD_TAB_ALIGNMENT.RIGHT, WD_TAB_LEADER.DOTS)
            for r in p.runs:
                rstyle(r, size=10.5)

    # ================= 二层·内容呈现 =================
    # 导读卡: 章题后首段(含【本章导读】或长度>200) → 卡片化
    for i, p in enumerate(h1s):
        nxt = None
        for q in paras[paras.index(p) + 1:]:
            if q.style is not None and q.style.name.startswith("Heading"):
                break
            if q.text.strip():
                nxt = q
                break
        if nxt is not None and len(nxt.text.strip()) > 150:
            p_shading(nxt, "F2F5F9")
            p_border(nxt, "left", "1F3A5F", 24)
            nxt.paragraph_format.left_indent = Pt(10)
            nxt.paragraph_format.space_before = Pt(8)
            nxt.paragraph_format.space_after = Pt(10)
            for r in nxt.runs:
                r.font.size = Pt(9.5)
    # 案例框: 案号开头的段落 → 框化(该段+后续至空行距离2段)
    for p in paras:
        t = p.text.strip()
        if re.match(r"^（?\(?\d{4}\)?）?\s*(最高法|民|刑|行)", t) or t.startswith("【案例") or re.match(r"^案例[：:\d]", t):
            p_shading(p, CASE_BG)
            p_border(p, "left", "C9A876", 18)
            p.paragraph_format.left_indent = Pt(10)
            for r in p.runs[:3]:
                r.font.bold = True
    # 要点卡: 「小结要点」后至下个标题的列表段 → accent引导
    for i, p in enumerate(paras):
        if "小结要点" in p.text and p.style is not None and p.style.name.startswith("Heading"):
            for q in paras[i + 1:]:
                if q.style is not None and q.style.name.startswith("Heading"):
                    break
                if q.text.strip():
                    q.paragraph_format.left_indent = Pt(14)
                    p_border(q, "left", "C9A876", 10)
            break
    # 表题规范: 表N-M开头的短段 → 居中加粗小字
    for p in paras:
        if re.match(r"^表\s*\d+[-–]\d+", p.text.strip()) and len(p.text.strip()) < 40:
            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
            for r in p.runs:
                rstyle(r, size=9, bold=True, color=ACCENT)

    # 表格工艺
    for t in doc.tables:
        tbl_borders(t)
        t.alignment = WD_TABLE_ALIGNMENT.CENTER
        if t.rows:
            repeat_header(t.rows[0])
            for c in t.rows[0].cells:
                cell_bg(c, "EEF2F7")
                for p in c.paragraphs:
                    for r in p.runs:
                        rstyle(r, size=9, bold=True, color=ACCENT)
        for row in t.rows[1:]:
            for c in row.cells:
                for p in c.paragraphs:
                    for r in p.runs:
                        rstyle(r, size=9)

    out = Path(ns.out)
    doc.save(out)
    print(f"[world] ✓ {out} ({out.stat().st_size:,}B) | 章{len(h1s)} 表{len(doc.tables)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
