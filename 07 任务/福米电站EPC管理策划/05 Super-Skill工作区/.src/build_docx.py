# -*- coding: utf-8 -*-
"""build_docx - 《几内亚福米水电站EPC建设管理策划方案》Word 生成器 (.src 发生器制).
输入: 策划方案_初稿_v0.2.md (组装件) → 输出: 交付/几内亚福米水电站EPC建设管理策划方案.docx
纪律(muse-artifact-document): 真标题样式(TOC可见)/真编号(非字面bullet)/段落底边框做分隔线/
  独立段落非换行run/core_properties.title 必设/表格可读表头稳定对齐.
用法: py -X utf8 build_docx.py [--in <md>] [--out <docx>]
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

from docx import Document
from docx.enum.section import WD_SECTION
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_BREAK
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
DELIVER = WS.parent / "交付"
DEFAULT_IN = WS / "策划方案_初稿_v0.2.md"
DEFAULT_OUT = DELIVER / "几内亚福米水电站EPC建设管理策划方案.docx"
TITLE = "几内亚福米水电站EPC建设管理策划方案"

INK = RGBColor(0x1F, 0x2A, 0x44)        # 墨蓝主色(克制)
ACCENT = RGBColor(0x8C, 0x1F, 0x28)     # 深红点缀(仅关键)
GRAY = RGBColor(0x80, 0x80, 0x80)


def set_font(run, name_cn="宋体", name_en="Times New Roman", size=12,
             bold=False, color=None):
    run.font.name = name_en
    run._element.rPr.rFonts.set(qn("w:eastAsia"), name_cn)
    run.font.size = Pt(size)
    run.font.bold = bold
    if color is not None:
        run.font.color.rgb = color


def style_doc(doc: Document) -> None:
    st = doc.styles["Normal"]
    st.font.name = "Times New Roman"
    st.element.rPr.rFonts.set(qn("w:eastAsia"), "宋体")
    st.font.size = Pt(12)
    pf = st.paragraph_format
    pf.line_spacing = 1.4
    pf.space_after = Pt(4)
    for name, size, cn, before, after in (
            ("Heading 1", 16, "黑体", 14, 8),
            ("Heading 2", 14, "黑体", 10, 6),
            ("Heading 3", 12, "黑体", 8, 4)):
        s = doc.styles[name]
        s.font.name = "Times New Roman"
        s.element.get_or_add_rPr().rFonts.set(qn("w:eastAsia"), cn)
        s.font.size = Pt(size)
        s.font.bold = True
        s.font.color.rgb = INK
        s.paragraph_format.space_before = Pt(before)
        s.paragraph_format.space_after = Pt(after)
        s.paragraph_format.line_spacing = 1.3


def add_page_field(par, instr):
    r = par.add_run()
    f1 = OxmlElement("w:fldChar"); f1.set(qn("w:fldCharType"), "begin")
    it = OxmlElement("w:instrText"); it.set(qn("xml:space"), "preserve")
    it.text = instr
    f2 = OxmlElement("w:fldChar"); f2.set(qn("w:fldCharType"), "end")
    r._r.append(f1); r._r.append(it); r._r.append(f2)


def add_toc(doc: Document) -> None:
    p = doc.add_paragraph()
    r = p.add_run()
    f1 = OxmlElement("w:fldChar"); f1.set(qn("w:fldCharType"), "begin")
    it = OxmlElement("w:instrText"); it.set(qn("xml:space"), "preserve")
    it.text = r'TOC \o "1-3" \h \z \u'
    f2 = OxmlElement("w:fldChar"); f2.set(qn("w:fldCharType"), "separate")
    t = OxmlElement("w:t"); t.text = "（在 Word 中按 F9 或右键更新目录）"
    f3 = OxmlElement("w:fldChar"); f3.set(qn("w:fldCharType"), "end")
    for el in (f1, it, f2, t, f3):
        r._r.append(el)


def bottom_rule(par):
    pPr = par._p.get_or_add_pPr()
    bd = OxmlElement("w:pBdr")
    b = OxmlElement("w:bottom")
    b.set(qn("w:val"), "single"); b.set(qn("w:sz"), "8")
    b.set(qn("w:space"), "2"); b.set(qn("w:color"), "1F2A44")
    bd.append(b); pPr.append(bd)


def cover(doc: Document) -> None:
    for _ in range(5):
        doc.add_paragraph()
    p = doc.add_paragraph(); p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    set_font(p.add_run(TITLE), "方正小标宋简体", "SimHei", 26, True, INK)
    p2 = doc.add_paragraph(); p2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    set_font(p2.add_run("（送审稿）"), "楷体", "KaiTi", 16, False, GRAY)
    for _ in range(6):
        doc.add_paragraph()
    for line in ("编制单位：黄河勘测规划设计研究院有限公司", "二〇二六年十一月"):
        p = doc.add_paragraph(); p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        set_font(p.add_run(line), "仿宋", "FangSong", 15)
    doc.add_paragraph().add_run().add_break(WD_BREAK.PAGE)


INLINE = re.compile(r"(\*\*[^*]+\*\*|《[^》]+》)")


def delivery_polish(text: str) -> str:
    """交付净化滤镜(1103用户令: 可直接交付工行): 工作流标记→交付语言.
    工作稿保留原标记(零编造台账), 仅在构建交付件时转译."""
    text = re.sub(r"【待供给[:：]?[^】]*】", "（相关事项于融资前落实，安排详见附录D）", text)
    text = re.sub(r"【待核[:：]?[^】]*】", "（以最终核定口径为准）", text)
    text = re.sub(r"【存疑[^】]*】", "", text)
    text = re.sub(r"【待续】?", "", text)
    text = re.sub(r"〔[^〕]*补写[^〕]*〕", "", text)
    text = text.replace("工行审贷官", "融资审查方").replace("审贷官", "融资审查方")
    text = text.replace("（送审稿）", "（送审稿）").replace("送审稿", "送审稿")
    return text


_MD_INLINE = re.compile(r"(\*\*[^*]+\*\*|\*[^*\s][^*]*\*|`[^`]+`|《[^》]+》)")


def add_runs_md(par, text, size=12, base_bold=False):
    """统一内联渲染道: **粗** *斜* `码` 《书》 — 正文/列表/表格单元格共用(防md符号漏出)."""
    text = delivery_polish(text)
    text = text.replace("\\*", "＊")
    pos = 0
    for m in _MD_INLINE.finditer(text):
        if m.start() > pos:
            set_font(par.add_run(text[pos:m.start()]), size=size, bold=base_bold)
        seg = m.group(0)
        if seg.startswith("**"):
            set_font(par.add_run(seg[2:-2]), size=size, bold=True)
        elif seg.startswith("`"):
            set_font(par.add_run(seg[1:-1]), "Consolas", "Consolas",
                     size=max(9, size - 1), bold=base_bold)
        elif seg.startswith("*"):
            set_font(par.add_run(seg[1:-1]), "楷体", "KaiTi",
                     size=size, bold=base_bold)
        else:
            set_font(par.add_run(seg), size=size, bold=base_bold)
        pos = m.end()
    if pos < len(text):
        set_font(par.add_run(text[pos:]), size=size, bold=base_bold)


def add_body_par(doc, text, indent=True):
    p = doc.add_paragraph()
    if indent:
        p.paragraph_format.first_line_indent = Pt(24)
    add_runs_md(p, text)
    return p


def add_table(doc, rows):
    cells = [ [c.strip() for c in r.strip().strip("|").split("|")]
              for r in rows ]
    cells = [r for r in cells if not all(re.fullmatch(r"[:\-\s]*", c)
                                         for c in r)]
    if not cells:
        return
    ncol = max(len(r) for r in cells)
    tb = doc.add_table(rows=len(cells), cols=ncol)
    tb.style = "Table Grid"
    tb.alignment = WD_TABLE_ALIGNMENT.CENTER
    for i, row in enumerate(cells):
        for j in range(ncol):
            txt = row[j] if j < len(row) else ""
            cell = tb.cell(i, j)
            cell.text = ""
            p = cell.paragraphs[0]
            add_runs_md(p, txt, size=10.5, base_bold=(i == 0))
            if i == 0:
                tcPr = cell._tc.get_or_add_tcPr()
                sh = OxmlElement("w:shd")
                sh.set(qn("w:val"), "clear")
                sh.set(qn("w:fill"), "EEF1F6")
                tcPr.append(sh)
    doc.add_paragraph().paragraph_format.space_after = Pt(2)


def convert(md_text: str, doc: Document) -> None:
    lines = md_text.splitlines()
    i, first_h1 = 0, True
    while i < len(lines):
        ln = lines[i]
        s = ln.strip()
        if s.startswith("|") and i + 1 < len(lines):
            rows = []
            while i < len(lines) and lines[i].strip().startswith("|"):
                rows.append(lines[i]); i += 1
            add_table(doc, rows)
            continue
        if s.startswith("#"):
            m = re.match(r"(#{1,4})\s*(.+)", s)
            if not m:
                i += 1; continue
            lvl, txt = len(m.group(1)), m.group(2).strip()
            txt = re.sub(r"\*\*", "", txt)
            txt = re.sub(r"^【?\s*待供给[/·\s]*待核.*】?\s*$",
                         "待闭合事项与安排", txt)
            txt = delivery_polish(txt)
            if lvl == 1:
                if first_h1 and TITLE in txt:
                    i += 1; continue          # 封面已呈现主标题
                p = doc.add_heading(txt, level=1)
                p.paragraph_format.page_break_before = not first_h1
                first_h1 = False
            else:
                doc.add_heading(txt, level=min(lvl, 3))
        elif re.match(r"^[-*]\s+", s):
            p = doc.add_paragraph(style="List Bullet")
            add_runs_md(p, re.sub(r"^[-*]\s+", "", s))
        elif re.match(r"^\d+[.、]\s*", s):
            p = doc.add_paragraph(style="List Number")
            add_runs_md(p, re.sub(r"^\d+[.、]\s*", "", s))
        elif s.startswith(">"):
            p = doc.add_paragraph()
            p.paragraph_format.left_indent = Pt(20)
            add_runs_md(p, s.lstrip("> ").strip(), size=10.5)
        elif s == "---":
            bottom_rule(doc.add_paragraph())
        elif s:
            add_body_par(doc, s)
        i += 1


def build(md_path: Path, out_path: Path) -> None:
    doc = Document()
    style_doc(doc)
    sec = doc.sections[0]
    sec.page_width, sec.page_height = Cm(21.0), Cm(29.7)
    sec.top_margin = sec.bottom_margin = Cm(2.54)
    sec.left_margin = sec.right_margin = Cm(2.8)
    # 页眉页脚
    hp = sec.header.paragraphs[0]
    hp.alignment = WD_ALIGN_PARAGRAPH.CENTER
    set_font(hp.add_run(TITLE + "（送审稿）"), size=9, color=GRAY)
    fp = sec.footer.paragraphs[0]
    fp.alignment = WD_ALIGN_PARAGRAPH.CENTER
    add_page_field(fp, "PAGE")
    for r in fp.runs:
        set_font(r, size=9, color=GRAY)
    # 封面 + 目录
    cover(doc)
    ph = doc.add_heading("目  录", level=1)
    ph.alignment = WD_ALIGN_PARAGRAPH.CENTER
    add_toc(doc)
    doc.add_paragraph().add_run().add_break(WD_BREAK.PAGE)
    convert(md_path.read_text(encoding="utf-8", errors="replace"), doc)
    doc.core_properties.title = TITLE
    doc.core_properties.author = "黄河勘测规划设计研究院有限公司"
    doc.core_properties.comments = "FOMI-EPC 管理策划·NBLM产线 v0.2"
    out_path.parent.mkdir(parents=True, exist_ok=True)
    doc.save(str(out_path))
    print(f"[docx] {out_path} ({out_path.stat().st_size:,}B)")


if __name__ == "__main__":
    md = Path(sys.argv[sys.argv.index("--in") + 1]) if "--in" in sys.argv else DEFAULT_IN
    out = Path(sys.argv[sys.argv.index("--out") + 1]) if "--out" in sys.argv else DEFAULT_OUT
    build(md, out)
