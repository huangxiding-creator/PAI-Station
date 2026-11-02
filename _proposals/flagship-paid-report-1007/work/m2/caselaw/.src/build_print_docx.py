# -*- coding: utf-8 -*-
"""build_print_docx — 判例谱系报告印刷版生成器 (1102 顶级咨询气质令).

从 REPORT_FULL.md 重建可直接印刷的 docx:
  封面(留白/主色) + 版权页 + 目录(TOC域) + 章扉页 + 三线表(表X-Y编号) +
  ASCII图区块(图X-Y/等宽/浅底) + 页眉章名域 + 页脚页码域 + 三节式页码.
真结构不造假: 真标题样式/真表格/真编号列表/TOC与STYLEREF/PAGE域.
用法: E:/AI-Station/.venv/Scripts/python.exe -X utf8 build_print_docx.py
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

import docx
from docx import Document
from docx.enum.section import WD_SECTION
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_BREAK
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

SRC = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\caselaw\sched\out\REPORT_FULL.md")
OUT = SRC.parent / "工程造价争议判例谱系与调解实务研究报告_印刷版.docx"
TITLE = "工程造价争议判例谱系与调解实务研究报告"
ORG = "总包创研院研究团队"
VERSION = "2026年11月版"
PRIMARY = RGBColor(0x1F, 0x38, 0x64)      # 咨询深蓝
ACCENT = RGBColor(0x8F, 0xA3, 0xBF)       # 浅蓝灰
BODY_FONT = "宋体"
HEAD_FONT = "黑体"
MONO_FONT = "Consolas"
LATIN_BODY = "Times New Roman"


# ---------------------------------------------------------------- md 解析
def parse_blocks(md: str) -> list[dict]:
    lines = md.splitlines()
    blocks, i = [], 0

    def table_kind(blk: list[str]) -> str:
        if any(re.match(r"^\s*\+[-=+]+\+?\s*$", l) or
               (l.strip().startswith("+") and "---" in l) for l in blk):
            return "ascii_table"
        if any(re.match(r"^\s*\|[\s:|-]+\|\s*$", l) and "-" in l for l in blk):
            return "std_table"
        return "ascii_table"

    while i < len(lines):
        ln = lines[i]
        s = ln.strip()
        if not s:
            i += 1
            continue
        if s.startswith("```"):
            buf = []
            i += 1
            while i < len(lines) and not lines[i].strip().startswith("```"):
                buf.append(lines[i])
                i += 1
            i += 1
            blocks.append({"t": "figure", "text": "\n".join(buf)})
            continue
        if s.startswith("|"):
            buf = []
            while i < len(lines) and lines[i].strip().startswith(("|", "+")):
                buf.append(lines[i].strip())
                i += 1
            kind = table_kind(buf)
            if kind == "std_table":
                rows = []
                for r in buf:
                    cells = [c.strip() for c in r.strip("|").split("|")]
                    if all(re.fullmatch(r"[\s:|-]*", c) for c in cells):
                        continue                 # 分隔行
                    rows.append(cells)
                blocks.append({"t": "table", "rows": rows})
            else:
                blocks.append({"t": "figure", "text": "\n".join(buf)})
            continue
        m = re.match(r"^(#{1,4})\s+(.*)$", s)
        if m:
            blocks.append({"t": f"h{len(m.group(1))}", "text": m.group(2).strip()})
            i += 1
            continue
        if s.startswith("> "):
            buf = []
            while i < len(lines) and lines[i].strip().startswith(">"):
                buf.append(lines[i].strip().lstrip(">").strip())
                i += 1
            blocks.append({"t": "quote", "text": " ".join(x for x in buf if x)})
            continue
        if s == "---":
            blocks.append({"t": "hr"})
            i += 1
            continue
        m = re.match(r"^(\d+)[.、]\s+(.*)$", s)
        if m:
            blocks.append({"t": "ol", "items": [m.group(2)]})
            i += 1
            while i < len(lines) and re.match(r"^\d+[.、]\s+", lines[i].strip()):
                blocks[-1]["items"].append(re.sub(r"^\d+[.、]\s+", "", lines[i].strip()))
                i += 1
            continue
        if s.startswith(("- ", "* ")):
            blocks.append({"t": "ul", "items": [s[2:].strip()]})
            i += 1
            while i < len(lines) and lines[i].strip().startswith(("- ", "* ")):
                blocks[-1]["items"].append(lines[i].strip()[2:].strip())
                i += 1
            continue
        # 普通段落: 连续非结构行并段
        buf = [s]
        i += 1
        while i < len(lines):
            nxt = lines[i].strip()
            if (not nxt or nxt.startswith(("#", ">", "|", "```", "- ", "* ", "---"))
                    or re.match(r"^\d+[.、]\s+", nxt)):
                break
            buf.append(nxt)
            i += 1
        blocks.append({"t": "para", "text": " ".join(buf)})
    return blocks



def _disp_w(s: str) -> int:
    return sum(2 if ord(c) > 0x2E7F else 1 for c in s)


def _mono_align(text: str, target: int | None = None) -> str:
    """图块行按显示宽右补空格对齐 (中文2列/ASCII1列, 保作者终端布局)."""
    lines = text.splitlines()
    w = target or max((_disp_w(l.rstrip()) for l in lines), default=0)
    w = min(w, 92)                       # 版心容宽
    out = []
    for l in lines:
        l = l.rstrip()
        pad = w - _disp_w(l)
        out.append(l + (" " * pad if pad > 0 else ""))
    return chr(10).join(out)


# ---------------------------------------------------------------- 域与底层
def add_field(par, instr: str):
    r = par.add_run()
    fld = OxmlElement("w:fldSimple")
    fld.set(qn("w:instr"), instr)
    r._r.addnext(fld)
    fr = OxmlElement("w:r")
    t = OxmlElement("w:t")
    t.text = " "
    fr.append(t)
    fld.append(fr)


def set_cell_bg(cell, hexcolor: str):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:fill"), hexcolor)
    tcPr.append(shd)


def set_table_borders(tbl, style: str = "triple"):
    tblPr = tbl._tbl.tblPr
    borders = OxmlElement("w:tblBorders")
    spec = {
        "triple": [("top", "12"), ("bottom", "12"),
                   ("insideH", "none"), ("insideV", "none"),
                   ("left", "none"), ("right", "none")],
        "grid": [("top", "6"), ("bottom", "6"), ("insideH", "4"),
                 ("insideV", "4"), ("left", "6"), ("right", "6")],
    }[style]
    for edge, sz in spec:
        e = OxmlElement(f"w:{edge}")
        e.set(qn("w:val"), "single")
        e.set(qn("w:sz"), sz)
        e.set(qn("w:color"), "1F3864" if style == "triple" else "BFBFBF")
        borders.append(e)
    tblPr.append(borders)


def bottom_rule(par, color="1F3864", sz="8"):
    pPr = par._p.get_or_add_pPr()
    pbdr = OxmlElement("w:pBdr")
    b = OxmlElement("w:bottom")
    b.set(qn("w:val"), "single")
    b.set(qn("w:sz"), sz)
    b.set(qn("w:space"), "4")
    b.set(qn("w:color"), color)
    pbdr.append(b)
    pPr.append(pbdr)


def shade_par(par, fill="F2F5FA"):
    pPr = par._p.get_or_add_pPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:fill"), fill)
    pPr.append(shd)


def left_rule(par, color="1F3864", sz="16"):
    pPr = par._p.get_or_add_pPr()
    pbdr = OxmlElement("w:pBdr")
    b = OxmlElement("w:left")
    b.set(qn("w:val"), "single")
    b.set(qn("w:sz"), sz)
    b.set(qn("w:space"), "8")
    b.set(qn("w:color"), color)
    pbdr.append(b)
    pPr.append(pbdr)


# ---------------------------------------------------------------- inline 渲染
INLINE = re.compile(r"(\*\*[^*]+\*\*|`[^`]+`)")


def render_inline(par, text: str, size=10.5, color=None, font=BODY_FONT):
    for seg in INLINE.split(text):
        if not seg:
            continue
        if seg.startswith("**") and seg.endswith("**"):
            r = par.add_run(seg[2:-2])
            r.bold = True
        elif seg.startswith("`") and seg.endswith("`"):
            r = par.add_run(seg[1:-1])
            r.font.name = MONO_FONT
        else:
            r = par.add_run(seg)
        r.font.size = Pt(size)
        if color:
            r.font.color.rgb = color
        r.font.name = r.font.name or font
        r._element.rPr.rFonts.set(qn("w:eastAsia"), font)


# ---------------------------------------------------------------- 样式
def setup_styles(doc: Document):
    st = doc.styles
    n = st["Normal"]
    n.font.name = LATIN_BODY
    n.font.size = Pt(10.5)
    n._element.rPr.rFonts.set(qn("w:eastAsia"), BODY_FONT)
    pf = n.paragraph_format
    pf.line_spacing = 1.5
    pf.space_after = Pt(4)

    for name, sz, color, before, after in (
        ("Heading 1", 20, PRIMARY, 24, 14),
        ("Heading 2", 15, PRIMARY, 16, 8),
        ("Heading 3", 12.5, PRIMARY, 12, 6),
        ("Heading 4", 11, PRIMARY, 10, 4),
    ):
        h = st[name]
        h.font.name = HEAD_FONT
        h.font.size = Pt(sz)
        h.font.bold = True
        h.font.color.rgb = color
        h._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
        h.paragraph_format.space_before = Pt(before)
        h.paragraph_format.space_after = Pt(after)
        h.paragraph_format.alignment = WD_ALIGN_PARAGRAPH.LEFT
        h.paragraph_format.keep_with_next = True


# ---------------------------------------------------------------- 页眉页脚
def clear_section_hf(sec):
    """显式断链并清空本节页眉页脚 (封面/版权节用)."""
    for part in (sec.header, sec.footer):
        part.is_linked_to_previous = False
        for p in part.paragraphs:
            p.text = ""


def decorate_section(sec, header_text: str, page_fmt: str):
    sec.header.is_linked_to_previous = False
    hp = sec.header.paragraphs[0]
    hp.text = ""
    r = hp.add_run(header_text)
    r.font.size = Pt(8)
    r.font.color.rgb = ACCENT
    hp.alignment = WD_ALIGN_PARAGRAPH.LEFT
    bottom_rule(hp, color="BFBFBF", sz="4")

    sec.footer.is_linked_to_previous = False
    fp = sec.footer.paragraphs[0]
    fp.text = ""
    fp.alignment = WD_ALIGN_PARAGRAPH.CENTER
    add_field(fp, page_fmt)
    for rr in fp.runs:
        rr.font.size = Pt(9)
        rr.font.color.rgb = ACCENT


# ---------------------------------------------------------------- 主流程
def main() -> int:
    md = SRC.read_text(encoding="utf-8")
    blocks = parse_blocks(md)
    print(f"[gen] 解析 {len(blocks)} 块")

    doc = Document()
    setup_styles(doc)
    cp = doc.core_properties
    cp.title = TITLE
    cp.author = ORG

    sec0 = doc.sections[0]
    for attr in ("top_margin", "bottom_margin"):
        setattr(sec0, attr, Cm(2.4))
    sec0.left_margin = sec0.right_margin = Cm(2.6)
    clear_section_hf(sec0)

    # ---- 封面 ----
    for _ in range(6):
        doc.add_paragraph()
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r = p.add_run(TITLE)
    r.font.size = Pt(30)
    r.font.name = HEAD_FONT
    r._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
    r.font.color.rgb = PRIMARY
    p2 = doc.add_paragraph()
    p2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r2 = p2.add_run("12 章 · 22.6 万字 · 判例谱系 × 调解实务 × 2026 新仲裁法")
    r2.font.size = Pt(13)
    r2.font.color.rgb = ACCENT
    for _ in range(10):
        doc.add_paragraph()
    p3 = doc.add_paragraph()
    p3.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r3 = p3.add_run(f"{ORG}\n{VERSION}")
    r3.font.size = Pt(12)
    r3.font.color.rgb = PRIMARY

    # ---- 版权页 (新节 无页眉) ----
    sec1 = doc.add_section(WD_SECTION.NEW_PAGE)
    clear_section_hf(sec1)
    doc.add_paragraph()
    for txt in (
        f"出　品：{ORG}",
        "版　本：2026年11月（第1版）",
        "字　数：226,155 汉字（总装实测）",
        "证据纪律：全书案号、当事人、案情数字与裁判要点均取自事实资料库实收原文，"
        "随文标注锚号可回溯核验；逐章通过 claim 级核查与数字溯源双账核验。",
        "版权声明：本报告仅供购买方内部研究使用，未经出品方书面许可，",
        "不得以任何形式复制、转载、摘编或对外传播。",
    ):
        pp = doc.add_paragraph()
        pp.paragraph_format.first_line_indent = Cm(0)
        pp.paragraph_format.line_spacing = 1.8
        render_inline(pp, txt, size=11, color=RGBColor(0x40, 0x40, 0x40))

    # ---- 目录 (新节 罗马页码) ----
    sec2 = doc.add_section(WD_SECTION.NEW_PAGE)
    decorate_section(sec2, TITLE, "PAGE \\* roman")
    tp = doc.add_paragraph()
    tr = tp.add_run("目　录")
    tr.font.size = Pt(18)
    tr.font.name = HEAD_FONT
    tr._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
    tr.font.color.rgb = PRIMARY
    tp.paragraph_format.space_after = Pt(18)
    toc_p = doc.add_paragraph()
    add_field(toc_p, r'TOC \o "1-2" \h \z \u')

    # ---- 正文 (新节 阿拉伯页码 从1起) ----
    sec3 = doc.add_section(WD_SECTION.NEW_PAGE)
    decorate_section(sec3, TITLE, "PAGE")
    sectPr = sec3._sectPr
    pg = sectPr.find(qn("w:pgNumType"))
    if pg is None:
        pg = OxmlElement("w:pgNumType")
        sectPr.append(pg)
    pg.set(qn("w:start"), "1")

    ch = 0
    tbl_n = fig_n = 0
    for b in blocks:
        t = b["t"]
        if t == "h1":
            ch += 1
            tbl_n = fig_n = 0
            doc.add_page_break()
            doc.add_paragraph()
            num, _, rest = b["text"].partition(" ")
            p = doc.add_paragraph()
            p.paragraph_format.space_after = Pt(2)
            r = p.add_run(num)
            r.font.size = Pt(40)
            r.font.name = HEAD_FONT
            r._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
            r.font.color.rgb = PRIMARY
            hp = doc.add_paragraph()
            hr = hp.add_run(rest)
            hr.font.size = Pt(22)
            hr.font.name = HEAD_FONT
            hr._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
            hr.font.color.rgb = PRIMARY
            hp.paragraph_format.space_after = Pt(6)
            bottom_rule(hp, sz="16")
            doc.add_paragraph()
        elif t in ("h2", "h3", "h4"):
            style_map = {"h2": "Heading 2", "h3": "Heading 3", "h4": "Heading 4"}
            doc.add_paragraph(b["text"], style=style_map[t])
        elif t == "para":
            p = doc.add_paragraph()
            p.alignment = WD_ALIGN_PARAGRAPH.LEFT
            p.paragraph_format.first_line_indent = Cm(0.74)
            render_inline(p, b["text"])
        elif t == "quote":
            p = doc.add_paragraph()
            p.paragraph_format.left_indent = Cm(0.6)
            p.paragraph_format.line_spacing = 1.4
            left_rule(p)
            shade_par(p)
            render_inline(p, b["text"], size=9.5, color=RGBColor(0x44, 0x50, 0x66))
        elif t == "ol":
            for i2, item in enumerate(b["items"], 1):
                p = doc.add_paragraph(style="List Number")
                p.alignment = WD_ALIGN_PARAGRAPH.LEFT
                p.paragraph_format.left_indent = Cm(0.9)
                render_inline(p, item)
        elif t == "ul":
            for item in b["items"]:
                p = doc.add_paragraph(style="List Bullet")
                p.alignment = WD_ALIGN_PARAGRAPH.LEFT
                render_inline(p, item)
        elif t == "hr":
            continue                                   # 章已分页, 分隔线弃
        elif t == "table":
            tbl_n += 1
            rows = b["rows"]
            cap = doc.add_paragraph()
            cap.paragraph_format.space_after = Pt(2)
            cr = cap.add_run(f"表 {ch}-{tbl_n}")
            cr.font.size = Pt(9)
            cr.bold = True
            cr.font.color.rgb = PRIMARY
            if rows and len(rows[0]) == 1:
                cr2 = cap.add_run("　" + rows[0][0][:40])
                cr2.font.size = Pt(9)
                cr2.font.color.rgb = ACCENT
            tbl = doc.add_table(rows=len(rows), cols=max(len(r) for r in rows))
            tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
            set_table_borders(tbl, "triple")
            for ri, row in enumerate(rows):
                for ci in range(len(tbl.rows[ri].cells)):
                    cell = tbl.rows[ri].cells[ci]
                    txt = row[ci] if ci < len(row) else ""
                    cp2 = cell.paragraphs[0]
                    cp2.paragraph_format.line_spacing = 1.15
                    cp2.paragraph_format.space_after = Pt(1)
                    render_inline(cp2, txt, size=8.5)
                    if ri == 0:
                        for rr in cp2.runs:
                            rr.bold = True
                            rr.font.color.rgb = PRIMARY
                        set_cell_bg(cell, "EEF2F8")
            doc.add_paragraph().paragraph_format.space_after = Pt(2)
        elif t == "figure":
            fig_n += 1
            cap = doc.add_paragraph()
            cap.paragraph_format.space_after = Pt(2)
            cr = cap.add_run(f"图 {ch}-{fig_n}")
            cr.font.size = Pt(9)
            cr.bold = True
            cr.font.color.rgb = PRIMARY
            for ln in _mono_align(b["text"]).splitlines():
                p = doc.add_paragraph()
                p.paragraph_format.line_spacing = 1.0
                p.paragraph_format.space_after = Pt(0)
                p.paragraph_format.left_indent = Cm(0.3)
                shade_par(p, "F7F9FC")
                r = p.add_run(ln if ln.strip() else " ")
                r.font.name = MONO_FONT
                r._element.rPr.rFonts.set(qn("w:eastAsia"), BODY_FONT)
                r.font.size = Pt(7.5)
            doc.add_paragraph().paragraph_format.space_after = Pt(2)

    doc.save(str(OUT))
    print(f"[gen] 写出 {OUT} ({OUT.stat().st_size:,} B)")
    print("[gen] 提示: Word 打开后按 Ctrl+A → F9 更新目录/页码域, 再另存定稿")
    return 0


if __name__ == "__main__":
    sys.exit(main())
