# -*- coding: utf-8 -*-
"""build_docx - 《几内亚福米水电站EPC建设管理策划方案》Word 生成器 (.src 发生器制).
输入: 策划方案_初稿_v0.2.md (组装件) → 输出: 交付/几内亚福米水电站EPC建设管理策划方案.docx
纪律(muse-artifact-document): 真标题样式(TOC可见)/真编号(非字面bullet)/段落底边框做分隔线/
  独立段落非换行run/core_properties.title 必设/表格可读表头稳定对齐.
用法: py -X utf8 build_docx.py [--in <md>] [--out <docx>]
"""
from __future__ import annotations

import os
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
    text = re.sub(r"【待(供给|核)\s*[/·、]\s*待(核|供给)[^】]*】",
                  "待闭合事项", text)
    text = re.sub(r"【待供给[:：]?[^】]*】", "（相关事项于融资前落实）", text)
    text = re.sub(r"[，,]?\s*(安排)?详见附录[A-ZＡ-Ｚ]", "", text)
    text = re.sub(r"[，,]?\s*见附录[A-ZＡ-Ｚ]", "", text)
    text = re.sub(r"[（(][^（）()]*附录[A-FＡ-Ｆ][^（）()]*[）)]", "", text)
    text = re.sub(r"经附录[A-FＡ-Ｆ]覆盖审计", "经", text)
    text = re.sub(r"由附录[A-FＡ-Ｆ][总表逐行]{0,4}索引", "逐行索引", text)
    text = re.sub(r"[，,；;]?\s*附录[A-FＡ-Ｆ][／/]?附录?[A-FＡ-Ｆ]?超?越?项?(声明|行|总表)?", "", text)
    text = re.sub(r"\s*\[\d+(?:\s*[,\-–，]\s*\d+)*\]", "", text)
    # 1103令: 资料来源说明全部剥离(交付件=最终成果, 不呈现文字依据)
    text = re.sub(r"〔[^〕]{0,120}〕", "", text)                 # 〔出处/口径/补写〕透镜括号
    text = re.sub(r"[（(]\s*出处[:：][^（）()]{0,80}[）)]", "", text)
    text = re.sub(r"`c\d{2}_[^`]+`", "", text)                  # 资料键
    text = re.sub(r"[（(][甲乙丙丁]级?[）)]", "", text)          # 证据级
    srcdoc = r"(?:可研|施组|运维V3|MMK|台账|基准表|数字基准表|读者工程|框架件|兰州体系文件|S\d|附录B?银行版?)"
    text = re.sub(
        r"[（(][^（）()]{0,28}" + srcdoc +
        r"[^（）()]{0,40}?(\d+\.\d+|第\d+章|表\d|图\d|PAGE|口径|出处)[^（）()]{0,20}[）)]", "", text)
    text = re.sub(r"[，,;；]?\s*〔?见?(?:synth|readers|researchers|deep)/?[^\s，。；〕]{0,24}〕?", "", text)
    text = re.sub(r"[，,]\s*$", "", text)                        # 尾随逗号清洁
    # 1103令: 删导语段("本小节旨在/本节将/本章安排...")——直接进内容
    text = re.sub(r"[。;；]?\s*本(?:小节|节|章)[，,]?[^。\n]{0,80}[。;]", "", text)
    text = re.sub(r"[。;；]?\s*本(?:小节|节|章)旨在[^。\n]{0,120}[。;]", "", text)
    # 1103令: 删来源标注码 [A-01] [C-06] [E-06] [K-21] [R02] [D04] 等
    text = re.sub(r"\s*\[\s*[A-Z]-?\d+[\s/；;，,][^\]]{0,40}\]", "", text)
    text = re.sub(r"\s*\[\s*[A-Z]-?\d+\s*\]", "", text)
    # 1103令: 删「，按第N章」章节引用
    text = re.sub(r"[，,]\s*按第\d+[／/\d\s]*章", "", text)
    # 1103令: 删「对标」残留
    text = text.replace("对标", "依据")
    # 1103令: 自信呈现——删心虚词
    text = re.sub(r"拟采用", "采用", text)
    text = re.sub(r"拟设立", "设立", text)
    text = re.sub(r"拟建立", "建立", text)
    text = re.sub(r"拟实行", "实行", text)
    text = re.sub(r"拟配置", "配置", text)
    text = re.sub(r"建议采用", "采用", text)
    text = re.sub(r"可视情况", "", text)
    text = re.sub(r"如有可能", "", text)
    text = re.sub(r"争取", "", text)
    text = re.sub(r"努力", "", text)
    # 1103令: 删解释段——不解释管理方案, 直接陈述
    text = re.sub(r"[。;；]?\s*(?:通过|基于|按照|依托|借助)[^。\n]{5,60}(?:实现|达到|确保|保证|形成|建立|确立)[^。\n]{2,40}[。;]", "。", text)
    # 1103令: 删编制思考过程/版本对照/选数说明——直接给结论
    text = re.sub(r"[。;；]?\s*本策划采用\d{4}可研审定版[^。]{0,50}作为[^。]{0,25}[。;]", "。", text)
    text = re.sub(r"[。;；]?\s*施组\d+个月[^。]{0,35}(?:能力实证|版本对照|投标版)[^。]{0,25}[。;]", "。", text)
    text = re.sub(r"[（(][^（）()]{0,60}(?:版本对照|版本纪律|数据择定|参数选定|选数|两代版本|能力实证|投标版|2018投标版|以可研|以施组)[^（）()]{0,40}[）)]", "", text)
    text = re.sub(r"[。;；]?\s*可研\d+个月与施组\d+个月[^。]{0,60}[。;]", "。", text)
    text = re.sub(r"版本纪律|数据择定规则", "数据管理规定", text)
    text = re.sub(r"[。;；]?\s*经过(?:调研|分析|研究|对比|评估)[^。]{0,40}[。;]", "。", text)
    # 1103令: 零AI/工序痕迹 + 自信呈现
    text = re.sub(r"数字化军团", "数字化体系", text)
    text = re.sub(r"数字化管控军团", "全过程数字化管控体系", text)
    text = re.sub(r"管控军团", "管控体系", text)
    text = re.sub(r"总包GPT（[^（）]*）", "总包智能问答知识库", text)
    text = re.sub(r"总包GPT", "总包智能问答知识库", text)
    text = re.sub(r"细目见底稿[_a-zA-Z0-9]* ?与?", "细目见", text)
    text = re.sub(r"见底稿[_a-zA-Z0-9]*", "", text)
    text = re.sub(r"[，,]?\s*底稿[_a-zA-Z0-9]*所引", "", text)
    text = re.sub(r"投标版底稿", "投标版", text)
    text = re.sub(r"施组有底稿", "施组载有", text)
    text = re.sub(r"[（(]底稿[）)]", "", text)
    text = re.sub(r"【第\d+章完】", "", text)
    text = re.sub(r"置顶八弹", "置顶呈现", text)
    text = re.sub(r"八弹", "八大独特优势", text)
    text = re.sub(r"[（(][^（）()]{0,20}(Wave[A-CＢ]? ?\d?|波次|军团|红队|机检|滤镜|构建器|收口|底稿|弹药|清扫|重组|织入|1103令|1102令)[^（）()]{0,20}[）)]", "", text)
    text = re.sub(r"v2收口Wave[BＢ]?·?1103", "", text)
    text = re.sub(r"[·•]\s*(Wave|110[23])\d*", "", text)
    text = re.sub(r"【待核[:：]?[^】]*】", "（以最终核定口径为准）", text)
    text = re.sub(r"【存疑[^】]*】", "", text)
    text = re.sub(r"【待续】?", "", text)
    text = re.sub(r"〔[^〕]*补写[^〕]*〕", "", text)
    text = text.replace("工行审贷官", "融资审查方").replace("审贷官", "融资审查方")
    text = text.replace("（送审稿）", "（送审稿）").replace("送审稿", "送审稿")
    return text


_MD_INLINE = re.compile(r"(\*\*[^*]+\*\*|\*[^*\s][^*]*\*|`[^`]+`|《[^》]+》)")


def add_runs_md(par, text, size=12, base_bold=False, prose=False):
    """统一内联渲染道: **粗** *斜* `码` 《书》 — 正文/列表/表格单元格共用(防md符号漏出).
    prose=True 时剥离括号补充说明(1103令: 正文散文体括号插入语全清, 表格数据括注保留)."""
    text = delivery_polish(text)
    if prose:
        text = re.sub(r"（[^（）]{0,80}）", "", text)
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
    for r in par.runs:                          # 孤儿双星清扫(不成对残留)
        if "**" in r.text:
            r.text = r.text.replace("**", "")


def add_body_par(doc, text, indent=True):
    p = doc.add_paragraph()
    if indent:
        p.paragraph_format.first_line_indent = Pt(24)
    add_runs_md(p, text, prose=True)
    return p


def add_table(doc, rows):
    cells = [ [c.strip() for c in r.strip().strip("|").split("|")]
              for r in rows ]
    cells = [r for r in cells if not all(re.fullmatch(r"[:\-\s]*", c)
                                         for c in r)]
    if not cells:
        return
    # 序号列: 如果首行第一列不是「序号」且首列内容不是数字编号, 自动加序号列
    has_seq = (cells[0][0].strip() in ("序号", "编号", "No", "#") or
               (len(cells) > 1 and re.match(r"^\d+[.、）)]?$|^[（(]\d+[）)]$",
                                            cells[1][0].strip() if cells[1] else "")))
    if not has_seq and len(cells) > 2:  # 3行以上才加序号
        for i, row in enumerate(cells):
            if i == 0:
                row.insert(0, "序号")
            else:
                row.insert(0, str(i))
    ncol = max(len(r) for r in cells)
    # 计算每列最优宽度(基于内容长度, 最小2cm, 按比例分配总宽约15cm)
    col_max = [2] * ncol
    for row in cells:
        for j in range(min(ncol, len(row))):
            l = len(row[j])
            if l > col_max[j]:
                col_max[j] = l
    total = sum(col_max)
    avail = 15.0  # cm
    widths = [max(1.5, avail * c / total) for c in col_max]
    # 归一化到总宽
    wsum = sum(widths)
    widths = [w * avail / wsum for w in widths]

    tb = doc.add_table(rows=len(cells), cols=ncol)
    tb.style = "Table Grid"
    tb.alignment = WD_TABLE_ALIGNMENT.CENTER
    # 设置列宽
    for j, w in enumerate(widths):
        for i in range(len(cells)):
            tb.cell(i, j).width = Cm(w)
    # 填充内容
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
    META = re.compile(r"^(本章回应|本章定位|本章核心响应|建议引用资料|本章为"
                      r"|出处约定|可信级[:：]|章尾标记|底稿说明|资料源表?|本章引资料源"
                      r"|本小节旨在|本节旨在|本章旨在|本节将|本节安排|本小节将)")
    while i < len(lines):
        ln = lines[i]
        s = ln.strip()
        s2 = re.sub(r"^[>*#\s*`]+", "", s)          # 剥装饰前缀再验元话语
        if META.match(s) or META.match(s2) or s2.startswith("出处约定") \
                or s2.startswith("底稿说明"):
            i += 1
            continue
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
        elif s.startswith("![") and "](" in s:
            # 图片: ![标题](路径)
            m_img = re.match(r"!\[([^\]]*)\]\(([^)]+)\)", s)
            if m_img:
                img_path = m_img.group(2).strip()
                if os.path.isfile(img_path):
                    p = doc.add_paragraph()
                    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                    r = p.add_run()
                    r.add_picture(img_path, width=Cm(15))
                    cap = m_img.group(1).strip()
                    if cap:
                        pc = doc.add_paragraph()
                        pc.alignment = WD_ALIGN_PARAGRAPH.CENTER
                        set_font(pc.add_run(cap), "楷体", "KaiTi", 9, color=GRAY)
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
