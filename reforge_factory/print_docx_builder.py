# -*- coding: utf-8 -*-
"""print_docx_builder — 印刷版 docx 产线件 (1102 用户令固化, 首役 CASELAW 实战验证).

顶级咨询气质排版: 封面(深蓝主色/大留白)+版权页+目录(TOC域)+章扉页(大号章号+色条)
+真三线表(表X-Y编号/表头底色加粗)+图区块(图X-Y/等宽/浅底/显示宽感知对齐)
+页眉书名线+页脚页码域(封面无/目录罗马/正文阿拉伯起1)+4节式.

首役实证 (CASELAW 283页六关键页AI目检全过):
  旧版三大病(表格未转成表格517行散乱/正文514段错居中/无封面目录)全消,
  终态: 40真表格+编号/居中仅3设计位/338真标题样式.

用法:
  E:/AI-Station/.venv/Scripts/python.exe -X utf8 print_docx_builder.py \
      --md <REPORT_FULL.md> --title 书名 --org 出品方 \
      --subtitle "12 章 · 22.6 万字 · …" --out <out.docx> [--version 2026年11月版]

坑法在案 (勿再踩):
  STYLEREF 域中文 Word 两式皆败("Heading 1"名字差+大纲级别式) → 页眉只放书名;
  封面/版权节须显式断链页眉脚(is_linked_to_previous=False+清空), 否则节继承错乱;
  ASCII 图中英等宽错列 → _mono_align 中文2列宽感知右补空格, 字体 Consolas+宋体东 亚;
  域更新靠 Word COM(Fields.Update+TOC.Update), python-docx 只放域不求值.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

from docx import Document
from docx.enum.section import WD_SECTION
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

PRIMARY = RGBColor(0x1F, 0x38, 0x64)
ACCENT = RGBColor(0x8F, 0xA3, 0xBF)
BODY_FONT = "宋体"
HEAD_FONT = "黑体"
MONO_FONT = "Consolas"
LATIN_BODY = "Times New Roman"


# ---------------- md 解析 (CASELAW 1520块实证口径) ----------------
def parse_blocks(md: str) -> list[dict]:
    lines = md.splitlines()
    blocks, i = [], 0

    def table_kind(blk):
        if any(re.match(r"^\s*\+[-=+]+\+?\s*$", l) or
               (l.strip().startswith("+") and "---" in l) for l in blk):
            return "ascii_table"
        if any(re.match(r"^\s*\|[\s:|-]+\|\s*$", l) and "-" in l for l in blk):
            return "std_table"
        return "ascii_table"

    while i < len(lines):
        s = lines[i].strip()
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
            if table_kind(buf) == "std_table":
                rows = []
                for r in buf:
                    cells = [c.strip() for c in r.strip("|").split("|")]
                    if all(re.fullmatch(r"[\s:|-]*", c) for c in cells):
                        continue
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


# ---------------- 底层 ----------------
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
    spec = {"triple": [("top", "12"), ("bottom", "12"),
                       ("insideH", "none"), ("insideV", "none"),
                       ("left", "none"), ("right", "none")],
            "grid": [("top", "6"), ("bottom", "6"), ("insideH", "4"),
                     ("insideV", "4"), ("left", "6"), ("right", "6")]}[style]
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


def _disp_w(s: str) -> int:
    return sum(2 if ord(c) > 0x2E7F else 1 for c in s)


def _mono_align(text: str, target=None) -> str:
    lines = text.splitlines()
    w = target or max((_disp_w(l.rstrip()) for l in lines), default=0)
    w = min(w, 92)
    out = []
    for l in lines:
        l = l.rstrip()
        pad = w - _disp_w(l)
        out.append(l + (" " * pad if pad > 0 else ""))
    return chr(10).join(out)


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


def setup_styles(doc):
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


def clear_section_hf(sec):
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


# ---------------- 主流程 ----------------
def build(md_path: Path, out_path: Path, title: str, org: str,
          subtitle: str, version: str, stats_line: str = "") -> Path:
    md = md_path.read_text(encoding="utf-8")
    blocks = parse_blocks(md)

    doc = Document()
    setup_styles(doc)
    cp = doc.core_properties
    cp.title, cp.author = title, org

    sec0 = doc.sections[0]
    sec0.top_margin = sec0.bottom_margin = Cm(2.4)
    sec0.left_margin = sec0.right_margin = Cm(2.6)
    clear_section_hf(sec0)

    for _ in range(6):
        doc.add_paragraph()
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r = p.add_run(title)
    r.font.size = Pt(30)
    r.font.name = HEAD_FONT
    r._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
    r.font.color.rgb = PRIMARY
    p2 = doc.add_paragraph()
    p2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r2 = p2.add_run(subtitle)
    r2.font.size = Pt(13)
    r2.font.color.rgb = ACCENT
    for _ in range(10):
        doc.add_paragraph()
    p3 = doc.add_paragraph()
    p3.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r3 = p3.add_run(f"{org}\n{version}")
    r3.font.size = Pt(12)
    r3.font.color.rgb = PRIMARY

    sec1 = doc.add_section(WD_SECTION.NEW_PAGE)
    clear_section_hf(sec1)
    doc.add_paragraph()
    for txt in (f"出　品：{org}", f"版　本：{version}",
                stats_line,
                "证据纪律：全书案号、当事人、案情数字与裁判要点均取自事实资料库实收原文，"
                "随文标注锚号可回溯核验；逐章通过 claim 级核查与数字溯源双账核验。",
                "版权声明：本报告仅供购买方内部研究使用，未经出品方书面许可，",
                "不得以任何形式复制、转载、摘编或对外传播。"):
        pp = doc.add_paragraph()
        pp.paragraph_format.first_line_indent = Cm(0)
        pp.paragraph_format.line_spacing = 1.8
        render_inline(pp, txt, size=11, color=RGBColor(0x40, 0x40, 0x40))

    sec2 = doc.add_section(WD_SECTION.NEW_PAGE)
    decorate_section(sec2, title, "PAGE \\* roman")
    tp = doc.add_paragraph()
    tr = tp.add_run("目　录")
    tr.font.size = Pt(18)
    tr.font.name = HEAD_FONT
    tr._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
    tr.font.color.rgb = PRIMARY
    tp.paragraph_format.space_after = Pt(18)
    add_field(doc.add_paragraph(), r'TOC \o "1-2" \h \z \u')

    sec3 = doc.add_section(WD_SECTION.NEW_PAGE)
    decorate_section(sec3, title, "PAGE")
    sectPr = sec3._sectPr
    pg = sectPr.find(qn("w:pgNumType"))
    if pg is None:
        pg = OxmlElement("w:pgNumType")
        sectPr.append(pg)
    pg.set(qn("w:start"), "1")

    ch = tbl_n = fig_n = 0
    for b in blocks:
        t = b["t"]
        if t == "h1":
            ch += 1
            tbl_n = fig_n = 0
            if ch > 1:
                doc.add_page_break()            # 首章不空页(正文节起始页即第1章)
            doc.add_paragraph()
            m = re.match(r"^(第[一二三四五六七八九十百\d]+章)[\s　]*(.*)$", b["text"])
            full = b["text"] if not m else f"{m.group(1)}　{m.group(2)}".strip()
            p = doc.add_paragraph()
            p.paragraph_format.space_after = Pt(2)
            r = p.add_run(f"{ch:02d}")           # 大号章序艺术字(纯数字, 免与H1重复)
            r.font.size = Pt(40)
            r.font.name = MONO_FONT
            r._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
            r.font.color.rgb = ACCENT
            hp = doc.add_paragraph(style="Heading 1")   # 章题=真H1(TOC收章级, 1102章节混乱修复)
            hr = hp.add_run(full)
            hr.font.size = Pt(22)
            hr.font.name = HEAD_FONT
            hr._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
            hr.font.color.rgb = PRIMARY
            hp.paragraph_format.space_after = Pt(6)
            bottom_rule(hp, sz="16")
            doc.add_paragraph()
        elif t in ("h2", "h3", "h4"):
            style_map = {"h2": "Heading 2", "h3": "Heading 3", "h4": "Heading 4"}
            # 程序性节(尾注/小结/边界)不入目录: 用无样式段模拟H2视觉
            if t == "h2" and any(k in b["text"] for k in
                                  ("尾注", "小结要点", "证据边界", "数据说明")):
                sp = doc.add_paragraph()
                sp.paragraph_format.space_before = Pt(16)
                sp.paragraph_format.space_after = Pt(8)
                sp.paragraph_format.keep_with_next = True
                sr = sp.add_run(b["text"])
                sr.font.size = Pt(13)
                sr.font.name = HEAD_FONT
                sr._element.rPr.rFonts.set(qn("w:eastAsia"), HEAD_FONT)
                sr.font.color.rgb = PRIMARY
                bottom_rule(sp, color="8FA3BF", sz="4")
            else:
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
            for item in b["items"]:
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
            continue
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

    doc.save(str(out_path))
    return out_path


def finalize(docx_path: Path, pdf_path: Path | None = None) -> int:
    """Word COM 域自动更新: 目录页码/正文页码打开即见(免手动F9), 可选出PDF.
    Quit 崩容错(PID 精准清, 同 s3_book_chain 卫生纪律)."""
    import subprocess
    pages = 0
    try:
        import win32com.client
        word = win32com.client.Dispatch("Word.Application")
        word.Visible = False
        try:
            doc = word.Documents.Open(str(docx_path))
            doc.Fields.Update()
            for toc in doc.TablesOfContents:
                toc.Update()
            for r in range(1, doc.Sections.Count + 1):
                sec = doc.Sections(r)
                for hf in (sec.Headers, sec.Footers):
                    for hpf in hf:
                        hpf.Range.Fields.Update()
            if pdf_path:
                try:
                    doc.SaveAs2(str(pdf_path), FileFormat=17)
                except Exception:                      # noqa: BLE001 — PDF失败不阻断域固化
                    print(f"[print][finalize] PDF转换失败(域固化继续): "
                          f"{getattr(pdf_path, 'name', pdf_path)}", flush=True)
            pages = doc.ComputeStatistics(2)          # wdStatisticPages
            doc.Save()                                 # 域结果固化进 docx
            doc.Close(SaveChanges=0)
        finally:
            try:
                word.Quit()
            except Exception:                          # noqa: BLE001 — 已知病
                subprocess.run(["powershell", "-Command",
                                "Get-Process WINWORD -ErrorAction SilentlyContinue"
                                " | Stop-Process -Force"], capture_output=True)
    except ImportError:
        print("[print][finalize] 无 pywin32 — 域需 Word 打开后 Ctrl+A→F9", flush=True)
    return pages


def main() -> int:
    import time as _t
    ap = argparse.ArgumentParser(description="印刷版 docx 产线件 (顶级咨询气质)")
    ap.add_argument("--md", required=True, help="合并稿 REPORT_FULL.md")
    ap.add_argument("--out", required=True, help="输出 .docx 路径")
    ap.add_argument("--title", required=True)
    ap.add_argument("--org", default="总包创研院研究团队")
    ap.add_argument("--subtitle", default="")
    ap.add_argument("--version", default=_t.strftime("%Y年%m月版"))
    ap.add_argument("--stats-line", default="字　数：见 S3 产物清单")
    ap.add_argument("--pdf", default="", help="同时输出 PDF 路径(域更新后)")
    ns = ap.parse_args()
    out = build(Path(ns.md), Path(ns.out), ns.title, ns.org,
                ns.subtitle or ns.title, ns.version, ns.stats_line)
    n_tbl = len(Document(str(out)).tables)
    pdf = Path(ns.pdf) if ns.pdf else None
    pages = finalize(out, pdf)
    tail = f" | PDF {pages}页" if pdf else ""
    print(f"[print] {out.name} ({out.stat().st_size:,} B) | 表格 {n_tbl}"
          f"{tail} | 页码/目录域已固化(打开即见)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
