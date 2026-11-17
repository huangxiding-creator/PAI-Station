# -*- coding: utf-8 -*-
"""build_pub_grade — 第16份《工程签证与变更索赔实战研究报告》出版级重排.

三项硬需求: ①专业封面 ②WPS原生TOC域(带页码) ③章标题层级(H1/H2/H3).
基座 = 总包金标准(docx_zongbao.py 1114) + 用户 1117 三点指摘.

用法: python -X utf8 build_pub_grade.py
源:   ../out/REPORT_FULL.docx  →  出: ../out/REPORT_FULL_出版级.docx
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

from docx import Document
from docx.enum.style import WD_STYLE_TYPE
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_BREAK
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.parts.hdrftr import FooterPart, HeaderPart
from docx.shared import Cm, Pt, RGBColor

HERE = Path(__file__).resolve().parent
SRC = HERE.parent / "out" / "REPORT_FULL.docx"
OUT = HERE.parent / "out" / "REPORT_FULL_出版级.docx"

F_BODY = "微软雅黑"
F_H1 = "黑体"
C_NAVY = (0x1F, 0x3A, 0x5F)
C_GRAY = (0x80, 0x80, 0x80)
C_GOLD = (0xC9, 0xA8, 0x76)
C_MID = (0x59, 0x59, 0x59)

# ---- 修补本venv python-docx 1.2.0 缺失的 header/footer 模板文件 (templates/ 目录残缺) ----
_HDR = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    '<w:hdr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"/>'
).encode("utf-8")
_FTR = _HDR.replace(b"w:hdr", b"w:ftr")
HeaderPart._default_header_xml = classmethod(lambda cls: _HDR)  # type: ignore[method-assign]
FooterPart._default_footer_xml = classmethod(lambda cls: _FTR)  # type: ignore[method-assign]

# CT_Settings 规范顺序(子集, 用于 evenAndOddHeaders/updateFields 安全插入)
_SETTINGS_ORDER = [
    "writeProtection", "view", "zoom", "removePersonalInformation",
    "defaultTabStop", "autoHyphenation", "evenAndOddHeaders", "characterSpacingControl",
    "printTwoOnOne", "strictFirstAndLastChars", "savePreviewPicture", "updateFields",
    "hdrShapeDefaults", "footnotePr", "endnotePr", "compat", "docVars", "rsids", "mathPr",
]
_LOCAL = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"

# OOXML 规范子元素顺序 (只列本脚本涉及的; 用于防 Word/WPS「文档修复」弹窗)
_ORDER = {
    "pPr": ["w:pStyle", "w:keepNext", "w:keepLines", "w:pageBreakBefore", "w:framePr",
            "w:widowControl", "w:numPr", "w:suppressLineNumbers", "w:pBdr", "w:shd",
            "w:tabs", "w:spacing", "w:ind", "w:contextualSpacing", "w:jc",
            "w:outlineLvl", "w:rPr", "w:sectPr"],
    "rPr": ["w:rStyle", "w:rFonts", "w:b", "w:bCs", "w:i", "w:iCs", "w:caps", "w:strike",
            "w:color", "w:spacing", "w:sz", "w:szCs", "w:u", "w:lang"],
    "tcPr": ["w:cnfStyle", "w:tcW", "w:gridSpan", "w:hMerge", "w:vMerge", "w:tcBorders",
             "w:shd", "w:noWrap", "w:tcMar", "w:textDirection", "w:vAlign", "w:hideMark"],
    "tblPr": ["w:tblStyle", "w:tblpPr", "w:tblOverlap", "w:bidiVisual", "w:tblW", "w:jc",
              "w:tblCellSpacing", "w:tblInd", "w:tblBorders", "w:shd", "w:tblLayout",
              "w:tblCellMar", "w:tblLook", "w:tblCaption", "w:tblDescription"],
    "trPr": ["w:cnfStyle", "w:divId", "w:gridBefore", "w:gridAfter", "w:wBefore", "w:wAfter",
             "w:cantSplit", "w:trHeight", "w:tblHeader", "w:tblCellSpacing", "w:jc", "w:hidden"],
}


def insert_ordered(parent, el):
    """按 CT_* 规范顺序插入 el; 单例元素已存在同标签则先移除旧值(幂等)."""
    ptag = parent.tag.split("}", 1)[-1]
    seq = [qn(t) for t in _ORDER.get(ptag, [])]
    for old in parent.findall(el.tag):
        parent.remove(old)  # 本脚本所用均为单例子元素
    if el.tag not in seq:
        parent.append(el)  # 顺序表未覆盖的标签: 追加(保守)
        return el
    my = seq.index(el.tag)
    for child in parent:
        if child.tag in seq and seq.index(child.tag) > my:
            child.addprevious(el)
            return el
    parent.append(el)
    return el


def settings_insert(settings_el, tag):
    """按规范顺序插入 settings 子元素(幂等)."""
    if settings_el.find(qn(f"w:{tag}")) is not None:
        return
    el = OxmlElement(f"w:{tag}")
    if tag == "evenAndOddHeaders":
        pass
    else:
        el.set(qn("w:val"), "true")
    my_idx = _SETTINGS_ORDER.index(tag)
    for child in settings_el:
        cname = child.tag.split("}", 1)[-1]
        if cname in _SETTINGS_ORDER and _SETTINGS_ORDER.index(cname) > my_idx:
            child.addprevious(el)
            return
    settings_el.append(el)


def set_style_font(style, name, size, bold=None, color=None):
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
        rf = insert_ordered(rpr, OxmlElement("w:rFonts"))
    for a in ("w:eastAsia", "w:ascii", "w:hAnsi", "w:cs"):
        rf.set(qn(a), name)


def set_style_spacing(style, line=None, before=None, after=None, align=None,
                      keep_next=None, widow=None):
    pf = style.paragraph_format
    if line is not None:
        pf.line_spacing = line
    if before is not None:
        pf.space_before = Pt(before)
    if after is not None:
        pf.space_after = Pt(after)
    if align is not None:
        pf.alignment = align
    if keep_next is not None:
        pf.keep_with_next = keep_next
    if widow is not None:
        pf.widow_control = widow


def fmt_run(run, name=None, size=None, bold=None, italic=None, color=None):
    if name:
        run.font.name = name
        rpr = run._element.get_or_add_rPr()
        rf = rpr.find(qn("w:rFonts"))
        if rf is None:
            rf = insert_ordered(rpr, OxmlElement("w:rFonts"))
        for a in ("w:eastAsia", "w:ascii", "w:hAnsi", "w:cs"):
            rf.set(qn(a), name)
    if size is not None:
        run.font.size = Pt(size)
    if bold is not None:
        run.font.bold = bold
    if italic is not None:
        run.font.italic = italic
    if color is not None:
        run.font.color.rgb = RGBColor(*color)


def add_field(paragraph, instr, cached_text=None):
    """复杂域: begin / instrText / [cached] / end, 全部run同格式由调用方后处理."""
    r1 = paragraph.add_run()
    fc = OxmlElement("w:fldChar")
    fc.set(qn("w:fldCharType"), "begin")
    r1._element.append(fc)
    r2 = paragraph.add_run()
    it = OxmlElement("w:instrText")
    it.set(qn("xml:space"), "preserve")
    it.text = instr
    r2._element.append(it)
    rc = None
    if cached_text is not None:
        rc = paragraph.add_run(cached_text)
    r3 = paragraph.add_run()
    fe = OxmlElement("w:fldChar")
    fe.set(qn("w:fldCharType"), "end")
    r3._element.append(fe)
    return [r1, r2, r3] + ([rc] if rc is not None else [])


def build():
    doc = Document(str(SRC))

    # ============ 0) 删除旧伪封面(0-2) + 手工目录块(3-110), 真正文从"导论"H1起 ============
    paras = doc.paragraphs
    first_h1 = next(i for i, p in enumerate(paras) if p.style.name == "Heading 1" and "目" not in p.text)
    anchor_el = paras[first_h1]._p
    removed, tables_seen = 0, 0
    for child in list(doc.element.body):
        if child is anchor_el:
            break
        tag = child.tag.split("}", 1)[-1]
        if tag == "tbl":
            tables_seen += 1
            continue  # 不删表(实测0张, 保险分支)
        if tag == "p":
            child.getparent().remove(child)
            removed += 1
    print(f"[strip] removed {removed} paras before first real H1 (idx={first_h1}), tables kept={tables_seen}")
    assert removed >= 100, "旧目录块删除量异常"

    # ============ 1) 样式族 (总包金标准 + 1117指摘) ============
    S = doc.styles
    normal = S["Normal"]
    set_style_font(normal, F_BODY, 9)
    set_style_spacing(normal, line=1.0, before=0, after=4, widow=True)
    hmap = [
        ("Heading 1", F_H1, 18, False, None, 24, 18),          # 黑体18 章题 居中另设
        ("Heading 2", F_BODY, 14, True, C_NAVY, 12, 6),
        ("Heading 3", F_BODY, 12, True, C_NAVY, 6, 3),
        ("Heading 4", F_BODY, 12, True, None, 3, 2),
    ]
    for nm, fn, sz, bd, col, bf, af in hmap:
        try:
            h = S[nm]
        except KeyError:
            continue
        set_style_font(h, fn, sz, bold=bd, color=col)
        set_style_spacing(h, line=1.3, before=Pt(bf).pt, after=af, keep_next=True)
    S["Heading 1"].paragraph_format.alignment = WD_ALIGN_PARAGRAPH.CENTER
    for nm in ("List Bullet", "List Number"):
        try:
            ls = S[nm]
            set_style_font(ls, F_BODY, 9)
            set_style_spacing(ls, line=1.0, before=0, after=2, widow=True)
        except KeyError:
            pass

    # ============ 2) 专业封面 (第一页独立) + TOC页, 插在正文前 ============
    anchor = doc.paragraphs[0]  # 现为"导论"H1
    assert anchor.style.name == "Heading 1"

    protected = set()  # 封面/目录页段落: 不参与正文批量格式化

    def ins(text="", before=0, after=0, line=None, align=WD_ALIGN_PARAGRAPH.CENTER):
        p = anchor.insert_paragraph_before("")
        protected.add(p._p)
        p.alignment = align
        pf = p.paragraph_format
        pf.space_before = Pt(before)
        pf.space_after = Pt(after)
        if line:
            pf.line_spacing = line
        pf.first_line_indent = Pt(0)
        if text:
            p.add_run(text)
        return p

    # 书名 28pt 黑体加粗 深蓝 居中
    p_title = ins(before=150, after=6, line=1.35)
    r = p_title.add_run("工程签证与变更索赔实战研究报告")
    fmt_run(r, name=F_H1, size=28, bold=True, color=C_NAVY)
    # 副题 12pt 居中
    p_sub = ins(before=14, after=0)
    r = p_sub.add_run("签证管理 · 费用工期索赔 · 争议裁判——从规则到行动")
    fmt_run(r, name=F_BODY, size=12, color=C_MID)
    # 金色装饰短线 (段落底边框 + 双侧缩进收窄)
    p_line = ins(before=52, after=0)
    p_line.paragraph_format.left_indent = Cm(5.5)
    p_line.paragraph_format.right_indent = Cm(5.5)
    pbdr = OxmlElement("w:pBdr")
    bottom = OxmlElement("w:bottom")
    bottom.set(qn("w:val"), "single")
    bottom.set(qn("w:sz"), "12")
    bottom.set(qn("w:space"), "1")
    bottom.set(qn("w:color"), "C9A876")
    pbdr.append(bottom)
    insert_ordered(p_line._p.get_or_add_pPr(), pbdr)
    # 出品 14pt 加粗 居中 (下推至版心下部)
    p_pub = ins(before=235, after=0)
    r = p_pub.add_run("出品：总包创研院研究团队")
    fmt_run(r, name=F_BODY, size=14, bold=True)
    # 日期 11pt 居中
    p_date = ins(before=10, after=0)
    r = p_date.add_run("2026年11月")
    fmt_run(r, name=F_BODY, size=11, color=C_MID)
    # 封面后强制分页
    p_break = ins()
    p_break.add_run().add_break(WD_BREAK.PAGE)

    # ---- TOC 页: 标题(非Heading1, 避免自引用) + WPS原生TOC域 ----
    p_toc_title = ins(before=6, after=22)
    p_toc_title.paragraph_format.page_break_before = True
    r = p_toc_title.add_run("目  录")
    fmt_run(r, name=F_H1, size=16, bold=True, color=C_NAVY)
    p_toc = ins(align=WD_ALIGN_PARAGRAPH.LEFT)
    fld = OxmlElement("w:fldSimple")
    fld.set(qn("w:instr"), 'TOC \\o "1-3" \\h \\z \\u')
    fld.set(qn("w:dirty"), "true")
    fr = OxmlElement("w:r")
    frpr = OxmlElement("w:rPr")
    rfonts = OxmlElement("w:rFonts")
    for a in ("w:eastAsia", "w:ascii", "w:hAnsi"):
        rfonts.set(qn(a), F_BODY)
    col = OxmlElement("w:color")
    col.set(qn("w:val"), "808080")
    sz = OxmlElement("w:sz")
    sz.set(qn("w:val"), "18")
    frpr.append(rfonts)
    frpr.append(col)
    frpr.append(sz)
    ft = OxmlElement("w:t")
    ft.set(qn("xml:space"), "preserve")
    ft.text = "（目录域已插入：在 WPS/Word 中右键此处 →「更新域」，即自动生成带页码的三级目录）"
    fr.append(frpr)
    fr.append(ft)
    fld.append(fr)
    p_toc._p.append(fld)

    # ============ 3) 章节标题层级 + 正文 ============
    h1_titles = []
    for p in doc.paragraphs:
        if p._p in protected:
            continue
        st = p.style.name
        txt = p.text.strip()
        if st == "Heading 1":
            p.alignment = WD_ALIGN_PARAGRAPH.CENTER
            p.paragraph_format.page_break_before = True   # 章起新页(含导论, 亦充当目录页后分页)
            p.paragraph_format.space_before = Pt(24)
            p.paragraph_format.space_after = Pt(18)
            for run in p.runs:
                fmt_run(run, name=F_H1, size=18, bold=False)
            h1_titles.append(txt)
        elif st in ("Heading 2", "Heading 3"):
            for run in p.runs:
                fmt_run(run, name=F_BODY, size=14 if st == "Heading 2" else 12,
                        bold=True, color=C_NAVY)
        elif st == "List Bullet":
            p.style = normal           # 禁无序列表 → 转正文
            st = "Normal"
        if st in ("Normal", "List Number") and p.style.name in ("Normal", "List Number"):
            is_normal = p.style.name == "Normal"
            for run in p.runs:
                fmt_run(run, name=F_BODY, size=9)
            pf = p.paragraph_format
            pf.widow_control = True
            if is_normal and txt:
                p.alignment = WD_ALIGN_PARAGRAPH.JUSTIFY
                if not pf.first_line_indent:
                    pf.first_line_indent = Pt(44)

    # ============ 4) 三线表 + 表头底纹 + 跨页重复表头 ============
    n_tbl = 0
    for t in doc.tables:
        n_tbl += 1
        tblPr = t._tbl.tblPr
        # 清旧边框 → 三线: 顶/底 1.5pt(sz12), 其余无
        old = tblPr.find(qn("w:tblBorders"))
        if old is not None:
            tblPr.remove(old)
        borders = OxmlElement("w:tblBorders")
        for edge, val, szv in (("top", "single", "12"), ("left", "none", "0"),
                               ("bottom", "single", "12"), ("right", "none", "0"),
                               ("insideH", "none", "0"), ("insideV", "none", "0")):
            e = OxmlElement(f"w:{edge}")
            e.set(qn("w:val"), val)
            e.set(qn("w:sz"), szv)
            e.set(qn("w:space"), "0")
            e.set(qn("w:color"), "1F3A5F" if val == "single" else "auto")
            borders.append(e)
        insert_ordered(tblPr, borders)
        # 表头行: 重复表头 + 底纹 + 栏目线(sz4) + 加粗
        header_row = t.rows[0]
        trPr = header_row._tr.get_or_add_trPr()
        if trPr.find(qn("w:tblHeader")) is None:
            insert_ordered(trPr, OxmlElement("w:tblHeader"))
        for cell in header_row.cells:
            tcPr = cell._tc.get_or_add_tcPr()
            tcb = OxmlElement("w:tcBorders")
            b = OxmlElement("w:bottom")
            b.set(qn("w:val"), "single")
            b.set(qn("w:sz"), "4")
            b.set(qn("w:space"), "0")
            b.set(qn("w:color"), "1F3A5F")
            tcb.append(b)
            insert_ordered(tcPr, tcb)
            shd = OxmlElement("w:shd")
            shd.set(qn("w:val"), "clear")
            shd.set(qn("w:fill"), "EEF2F7")
            insert_ordered(tcPr, shd)
        # 表内 9pt 雅黑, 段距归零, 去首行缩进
        for row in t.rows:
            for cell in row.cells:
                for p in cell.paragraphs:
                    pf = p.paragraph_format
                    pf.space_before = Pt(1)
                    pf.space_after = Pt(1)
                    pf.line_spacing = 1.0
                    pf.first_line_indent = Pt(0)
                    for run in p.runs:
                        fmt_run(run, name=F_BODY, size=9)
        for cell in header_row.cells:
            for p in cell.paragraphs:
                for run in p.runs:
                    fmt_run(run, name=F_BODY, size=9, bold=True)

    # ============ 5) 页面 + 奇偶页眉 + 三页脚 ============
    settings_insert(doc.settings.element, "evenAndOddHeaders")
    settings_insert(doc.settings.element, "updateFields")
    for sec in doc.sections:
        sec.page_width = Cm(21.0)
        sec.page_height = Cm(29.7)
        sec.top_margin = Cm(2.54)
        sec.bottom_margin = Cm(2.54)
        sec.left_margin = Cm(3.18)
        sec.right_margin = Cm(3.18)
        sec.different_first_page_header_footer = True   # 封面页无页眉页脚

        def style_hf(par, align=WD_ALIGN_PARAGRAPH.RIGHT, size=8, color=C_GRAY):
            par.alignment = align
            par.paragraph_format.space_after = Pt(0)
            return size, color

        # 奇页页眉: 章名 STYLEREF 域
        hdr = sec.header
        hdr.is_linked_to_previous = False
        hp = hdr.paragraphs[0] if hdr.paragraphs else hdr.add_paragraph()
        for extra in hdr.paragraphs[1:]:
            extra._p.getparent().remove(extra._p)
        hp.text = ""
        # WPS 实测: STYLEREF "Heading 1" 报「错误！未定义样式。」, 须用本地化内置名「标题 1」
        for run in add_field(hp, ' STYLEREF "标题 1" \\* MERGEFORMAT ', "导论"):
            fmt_run(run, name=F_BODY, size=8, color=C_GRAY)
        style_hf(hp)
        # 偶页页眉: 版权声明
        eh = sec.even_page_header
        eh.is_linked_to_previous = False
        ep = eh.paragraphs[0] if eh.paragraphs else eh.add_paragraph()
        for extra in eh.paragraphs[1:]:
            extra._p.getparent().remove(extra._p)
        ep.text = ""
        r = ep.add_run("总包创研院版权所有，侵权必究！")
        fmt_run(r, name=F_BODY, size=8, color=C_GRAY)
        style_hf(ep)
        # 首页页眉: 空
        fh = sec.first_page_header
        fh.is_linked_to_previous = False
        if not fh.paragraphs:
            fh.add_paragraph("")
        for extra in fh.paragraphs[1:]:
            extra._p.getparent().remove(extra._p)
        fp0 = fh.paragraphs[0]
        fp0.text = ""
        # 页脚 ×3: 居中页码域 (奇/偶), 首页空
        for fter, empty in ((sec.footer, False), (sec.even_page_footer, False),
                            (sec.first_page_footer, True)):
            fter.is_linked_to_previous = False
            fpar = fter.paragraphs[0] if fter.paragraphs else fter.add_paragraph()
            for extra in fter.paragraphs[1:]:
                extra._p.getparent().remove(extra._p)
            fpar.text = ""
            fpar.alignment = WD_ALIGN_PARAGRAPH.CENTER
            if not empty:
                for run in add_field(fpar, " PAGE "):
                    fmt_run(run, name=F_BODY, size=9, color=C_MID)

    cp = doc.core_properties
    cp.title = "工程签证与变更索赔实战研究报告"
    cp.author = "总包创研院研究团队"

    doc.save(str(OUT))
    print(f"[save] {OUT} ({OUT.stat().st_size:,} B), H1={len(h1_titles)}")
    for t in h1_titles:
        print("  H1:", t[:46])
    return len(h1_titles)


def verify():
    d = Document(str(OUT))
    paras = d.paragraphs
    doc_xml = d.element.xml
    # 1) 封面
    head_txt = "".join(p.text for p in paras[:12])
    cover_ok = "工程签证与变更索赔实战研究报告" in head_txt and "总包创研院研究团队" in head_txt
    title_sz_ok = False
    for p in paras[:8]:
        for r in p.runs:
            if r.text.strip() == "工程签证与变更索赔实战研究报告" and r.font.size is not None \
                    and abs(r.font.size.pt - 28.0) < 0.01 and r.font.bold:
                title_sz_ok = True
    # 2) TOC 域 (fldSimple 或 WPS 规范化后的复杂域均可; dirty 非必需——域结果已缓存)
    instr_list = d.element.body.xpath(".//w:instrText/text()")
    toc_field_ok = any("TOC" in (t or "") and "\\o" in (t or "") for t in instr_list) or "TOC \\o" in doc_xml
    toc_dirty = 'w:dirty="true"' in doc_xml
    toc_cached_entries = sum(1 for t in instr_list if t and " HYPERLINK \\l _Toc" in t)
    # 3) H1
    h1 = [p for p in paras if p.style.name == "Heading 1"]
    h1_pbb = sum(1 for p in h1 if p.paragraph_format.page_break_before)
    h1_center = sum(1 for p in h1 if p.alignment == WD_ALIGN_PARAGRAPH.CENTER)
    # 4) 页眉页脚域
    stylerEF, pagef, copyr = False, False, False
    for sec in d.sections:
        for hf in (sec.header, sec.even_page_header, sec.first_page_header,
                   sec.footer, sec.even_page_footer, sec.first_page_footer):
            x = "" if hf.is_linked_to_previous else hf._element.xml
            if "STYLEREF" in x:
                stylerEF = True
            if "PAGE" in x:
                pagef = True
            if "总包创研院版权所有" in x:
                copyr = True
    hf_ok = stylerEF and pagef and copyr
    ev = d.settings.element.find(qn("w:evenAndOddHeaders")) is not None
    upd = d.settings.element.find(qn("w:updateFields")) is not None
    # 5) 三线表/表头
    tbl_n = len(d.tables)
    rep = len(d.element.body.xpath(".//w:tblHeader"))
    shd = len(d.element.body.xpath('.//w:shd[@w:fill="EEF2F7"]'))
    # 6) 列表纪律: 无序列表归零, 有序列表保留
    from collections import Counter
    style_counts = Counter(p.style.name for p in paras)
    # 7) 全包 XML 良构 + 本脚本已知标签的子元素顺序合法
    import zipfile
    from lxml import etree
    order_bad = 0
    with zipfile.ZipFile(str(OUT)) as zf:
        parts = [n for n in zf.namelist() if n.endswith(".xml")]
        for n in parts:
            root = etree.fromstring(zf.read(n))
            for el in root.iter():
                ptag = el.tag.split("}", 1)[-1]
                if ptag in _ORDER:
                    seq = [qn(t) for t in _ORDER[ptag]]
                    last = -1
                    for ch in el:
                        if ch.tag in seq:
                            k = seq.index(ch.tag)
                            if k < last:
                                order_bad += 1
                            last = max(last, k)
        xml_ok = True
    # 8) Heading 1 内置样式定义 = 黑体 18pt 居中
    h1_style_ok = False
    for s in d.styles:
        if s.name == "Heading 1":
            f = s.font
            rpr = s.element.find(qn("w:rPr"))
            rf = rpr.find(qn("w:rFonts")) if rpr is not None else None
            h1_style_ok = (f.size is not None and abs(f.size.pt - 18.0) < 0.01
                           and rf is not None and rf.get(qn("w:eastAsia")) == F_H1)
    return {
        "output_path": str(OUT),
        "cover_ok": bool(cover_ok and title_sz_ok),
        "toc_field_ok": bool(toc_field_ok),
        "toc_cached_entry_count": toc_cached_entries,
        "h1_count": len(h1),
        "h1_page_break_count": h1_pbb,
        "h1_centered_count": h1_center,
        "h1_builtin_style_ok": bool(h1_style_ok),
        "headers_footers_ok": bool(hf_ok),
        "even_odd_headers_setting": ev,
        "update_fields_on_open": upd,
        "page_break_runs": doc_xml.count('w:type="page"'),
        "table_count": tbl_n,
        "tblHeader_rows": rep,
        "header_shading_cells": shd,
        "list_bullet_remaining": style_counts.get("List Bullet", 0),
        "list_number_kept": style_counts.get("List Number", 0),
        "all_xml_wellformed": xml_ok,
        "ooxml_child_order_violations": order_bad,
        "total_paragraphs": len(paras),
    }


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    if len(sys.argv) > 1 and sys.argv[1] == "verify":
        print(json.dumps(verify(), ensure_ascii=False, indent=2))
    else:
        build()
        print(json.dumps(verify(), ensure_ascii=False, indent=2))
