# -*- coding: utf-8 -*-
"""docx_zongbao2 — 总包标准·世界顶级出版版 (1114用户令: 在金标准基座上进阶).

v2 六道工艺 (基座=docx_zongbao金标准, 全保留):
  ①章题起新页+章号大字版式 ②页眉奇偶体系(偶=版权/奇=章名) ③目录前导点+页码右齐
  ④表格三线化+表头底纹+跨页重复表头 ⑤孤寡行控制+两端对齐+避头尾 ⑥引文案例框样式
用法: py -X utf8 docx_zongbao2.py in.docx -o out.docx
"""
from __future__ import annotations

import argparse
import copy
import re
import sys
from pathlib import Path

from docx import Document
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_TAB_ALIGNMENT, WD_TAB_LEADER
from docx.oxml.ns import qn
from docx.oxml import OxmlElement
from docx.shared import Cm, Pt, RGBColor

FONT_BODY = "微软雅黑"
FONT_H1 = "黑体"
INK = RGBColor(0x1A, 0x1A, 0x1A)
ACCENT = RGBColor(0x1F, 0x3A, 0x5F)


def _rf(rpr, name):
    rf = rpr.find(qn("w:rFonts"))
    if rf is None:
        rf = OxmlElement("w:rFonts")
        rpr.append(rf)
    for a in ("w:eastAsia", "w:ascii", "w:hAnsi"):
        rf.set(qn(a), name)


def run_style(run, name=FONT_BODY, size=9, bold=None, color=None):
    run.font.name = name
    run.font.size = Pt(size)
    if bold is not None:
        run.font.bold = bold
    if color is not None:
        run.font.color.rgb = color
    _rf(run._element.get_or_add_rPr(), name)


def set_cell_bg(cell, hexcolor):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:fill"), hexcolor)
    tcPr.append(shd)


def table_borders(tbl, top_sz=12, bot_sz=12, inside_h=4):
    """三线表: 顶/底粗线+栏目线细, 无竖线."""
    tblPr = tbl._tbl.tblPr
    old = tblPr.find(qn("w:tblBorders"))
    if old is not None:
        tblPr.remove(old)
    b = OxmlElement("w:tblBorders")
    for tag, sz in (("top", top_sz), ("bottom", bot_sz),
                    ("insideH", inside_h)):
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


def orphan_ctrl(p):
    ppr = p._p.get_or_add_pPr()
    e = OxmlElement("w:widowControl")
    e.set(qn("w:val"), "true")
    ppr.append(e)


def kinsoku(p):
    """避头尾+自动调整中西文间距."""
    ppr = p._p.get_or_add_pPr()
    for tag in ("w:kinsoku", "w:autoSpaceDE", "w:autoSpaceDN"):
        e = OxmlElement(tag)
        e.set(qn("w:val"), "true")
        ppr.append(e)


def fld(p, instr, size=9):
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
        run_style(r, size=size)


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("docx")
    ap.add_argument("-o", "--out", required=True)
    ns = ap.parse_args()
    doc = Document(ns.docx)

    # ---------- settings: 奇偶页眉 ----------
    settings = doc.settings.element
    oe = settings.find(qn("w:evenAndOddHeaders"))
    if oe is None:
        oe = OxmlElement("w:evenAndOddHeaders")
        settings.append(oe)

    for sec in doc.sections:
        sec.page_width, sec.page_height = Cm(21.0), Cm(29.7)
        sec.top_margin = sec.bottom_margin = Cm(2.54)
        sec.left_margin = sec.right_margin = Cm(3.18)
        sec.header_distance = Cm(1.5)
        sec.footer_distance = Cm(1.75)
        sec.different_first_page_header_footer = True

        # 页眉: 偶=版权 / 奇=章名域(STYLEREF)
        even = sec.even_page_header
        even.is_linked_to_previous = False
        ep = even.paragraphs[0] if even.paragraphs else even.add_paragraph()
        ep.text = ""
        er = ep.add_run("总包创研院版权所有，侵权必究！")
        run_style(er, size=8, color=RGBColor(0x99, 0x99, 0x99))
        ep.alignment = WD_ALIGN_PARAGRAPH.LEFT
        odd = sec.header
        odd.is_linked_to_previous = False
        op = odd.paragraphs[0] if odd.paragraphs else odd.add_paragraph()
        op.text = ""
        fld(op, " STYLEREF 1 \\s \\* MERGEFORMAT ", size=8)
        op.alignment = WD_ALIGN_PARAGRAPH.RIGHT
        for r in op.runs:
            r.font.color.rgb = RGBColor(0x99, 0x99, 0x99)
        # 首页(章起页)页眉空
        fp_ = sec.first_page_header
        fp_.is_linked_to_previous = False
        if fp_.paragraphs:
            fp_.paragraphs[0].text = ""
        # 页脚: 奇数页码居中(首页也留页码)
        for ftr in (sec.footer, sec.even_page_footer, sec.first_page_footer):
            ftr.is_linked_to_previous = False
            p0 = ftr.paragraphs[0] if ftr.paragraphs else ftr.add_paragraph()
            p0.text = ""
            p0.alignment = WD_ALIGN_PARAGRAPH.CENTER
            fld(p0, " PAGE ", size=9)

    # ---------- 正文段: 字号字体+孤寡+避头尾+两端对齐 ----------
    for p in doc.paragraphs:
        st = p.style.name if p.style else "Normal"
        if st.startswith(("Heading", "TOC", "美化目录")):
            continue
        if st == "Normal" and p.text.strip():
            p.alignment = WD_ALIGN_PARAGRAPH.JUSTIFY
            if not p.paragraph_format.first_line_indent:
                p.paragraph_format.first_line_indent = Pt(44)
            p.paragraph_format.space_after = Pt(4)
        orphan_ctrl(p)
        kinsoku(p)
        for r in p.runs:
            run_style(r, size=9, color=INK)

    # ---------- 章题起新页 + 章号大字版式 ----------
    h1s = [p for p in doc.paragraphs
           if p.style is not None and p.style.name == "Heading 1"]
    for i, p in enumerate(h1s):
        # 起新页(除第一个——封面目录后)
        if i > 0:
            ppr = p._p.get_or_add_pPr()
            pb = OxmlElement("w:pageBreakBefore")
            ppr.append(pb)
        # 章号行: 「第N章」大字独立行 + 题文行
        m = re.match(r"第([一二三四五六七八九十百\d]+)章\s*(.*)", p.text.strip())
        if m and p.runs:
            p.runs[0].text = f"第{m.group(1)}章"
            for r in p.runs[1:]:
                r.text = ""
            p.runs[0].font.size = Pt(26)
            p.runs[0].font.color.rgb = ACCENT
            p.runs[0].font.name = FONT_H1
            _rf(p.runs[0]._element.get_or_add_rPr(), FONT_H1)
            # 题文第二段
            np = p.insert_paragraph_before("")
            nr = np.add_run(m.group(2))
            run_style(nr, FONT_H1, 20, bold=False, color=INK)
            np.paragraph_format.space_before = Pt(2)
            np.paragraph_format.space_after = Pt(6)
            # 装饰细线段
            lp = np.insert_paragraph_before("")
            lr = lp.add_run("─" * 14)
            run_style(lr, FONT_BODY, 9, color=ACCENT)
            lp.paragraph_format.space_after = Pt(18)
        p.paragraph_format.space_before = Pt(24)
        p.paragraph_format.space_after = Pt(18)

    # ---------- 目录: 前导点+右齐页码 ----------
    for p in doc.paragraphs:
        if p.style is not None and (p.style.name.startswith("toc") or "目录" in (p.style.name or "")):
            p.paragraph_format.tab_stops.add_tab_stop(
                Cm(14.6), WD_TAB_ALIGNMENT.RIGHT, WD_TAB_LEADER.DOTS)
            for r in p.runs:
                run_style(r, size=10.5)

    # ---------- 表格: 三线+表头底纹+重复表头 ----------
    for t in doc.tables:
        table_borders(t)
        t.alignment = WD_TABLE_ALIGNMENT.CENTER
        if t.rows:
            repeat_header(t.rows[0])
            for c in t.rows[0].cells:
                set_cell_bg(c, "EEF2F7")
                for p in c.paragraphs:
                    for r in p.runs:
                        run_style(r, size=9, bold=True, color=ACCENT)
        for row in t.rows[1:]:
            for c in row.cells:
                for p in c.paragraphs:
                    for r in p.runs:
                        run_style(r, size=9, color=INK)

    out = Path(ns.out)
    doc.save(out)
    print(f"[zongbao2] ✓ {out} ({out.stat().st_size:,}B) | 章{len(h1s)} 表{len(doc.tables)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
