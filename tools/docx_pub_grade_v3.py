# -*- coding: utf-8 -*-
"""docx_pub_grade_v3 — 出版级排版引擎 v3 (P1微工艺 + P2内容呈现 + P4导航索引).

基座 = 总包金标准(docx_zongbao 1114) + 出版级v1(build_pub_grade 1117).
v3 在其上叠加三层:
  P1 排版微工艺: 基线网格14pt精确行距 / 首字下沉(framePr dropped 2行22pt) /
      标点悬挂(overflowPunct) / 中英混排(autoSpaceDE/DN) / 避头尾(kinsoku) /
      孤寡行(widowControl) / 两端对齐(jc=both)
  P2 内容呈现: 判例案例框(F5F7FA+左3pt竖线) / markdown管道表转三线表+数字列右对齐 /
      行动·检查清单勾选框(□) / 章首关键要点卡(F0F5FA+9.5pt) / Pull Quote(12pt上下装饰线)
  P4 导航索引: 专业封面(titlePg) / WPS原生TOC域(结果留空+dirty) / 执行摘要页 /
      奇偶页眉(evenAndOddHeaders, STYLEREF「标题 1」本地化) / 页脚PAGE域

注意: autoSpaceDE/DN/kinsoku/overflowPunct 在 OOXML 规范中是 w:pPr 段落属性
(而非 rPr), 引擎按规范落位, 效果与需求一致.

用法: py -X utf8 docx_pub_grade_v3.py [build|verify]
源:   _proposals/flagship-paid-report-1007/work/m2/visa/sched/out/REPORT_FULL.docx
出:   同目录 REPORT_FULL_v3出版级.docx
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

from docx import Document
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_BREAK
from docx.text.run import Run
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.parts.hdrftr import FooterPart, HeaderPart
from docx.shared import Cm, Pt, RGBColor

HERE = Path(__file__).resolve().parent
# 1118修: 支持命令行传入路径; 无参时默认visa(向后兼容)
import sys as _sys
_args = [a for a in _sys.argv[1:] if not a.startswith("-")]
if len(_args) >= 1:
    SRC = Path(_args[0])
    OUTDIR = SRC.parent
else:
    OUTDIR = HERE.parent / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "visa" / "sched" / "out"
    SRC = OUTDIR / "REPORT_FULL.docx"
OUT = OUTDIR / "REPORT_FULL_v3出版级.docx"

F_BODY = "微软雅黑"
F_H1 = "黑体"
C_NAVY = (0x1F, 0x3A, 0x5F)
C_GRAY = (0x99, 0x99, 0x99)   # P4 spec: 页眉灰 #999999
C_MID = (0x59, 0x59, 0x59)
C_GOLD = "C9A876"
LINE_TWIPS = "280"            # P1.1 基线网格: 14pt = 280 twips 固定值 (9pt × 1.56)

# ---- 修补本venv python-docx 1.2.0 缺失的 header/footer 模板文件 ----
_HDR = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    '<w:hdr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"/>'
).encode("utf-8")
_FTR = _HDR.replace(b"w:hdr", b"w:ftr")
HeaderPart._default_header_xml = classmethod(lambda cls: _HDR)  # type: ignore[method-assign]
FooterPart._default_footer_xml = classmethod(lambda cls: _FTR)  # type: ignore[method-assign]

# CT_Settings 规范顺序(子集): evenAndOddHeaders / updateFields 安全插入
_SETTINGS_ORDER = [
    "writeProtection", "view", "zoom", "removePersonalInformation",
    "defaultTabStop", "autoHyphenation", "evenAndOddHeaders", "characterSpacingControl",
    "printTwoOnOne", "strictFirstAndLastChars", "savePreviewPicture", "updateFields",
    "hdrShapeDefaults", "footnotePr", "endnotePr", "compat", "docVars", "rsids", "mathPr",
]

# OOXML 规范子元素顺序 (本脚本涉及的; 防 Word/WPS「文档修复」弹窗).
# v3 扩展: pPr 增补 kinsoku/wordWrap/overflowPunct/autoSpaceDE/autoSpaceDN (P1 微工艺落位).
_ORDER = {
    "pPr": ["w:pStyle", "w:keepNext", "w:keepLines", "w:pageBreakBefore", "w:framePr",
            "w:widowControl", "w:numPr", "w:suppressLineNumbers", "w:pBdr", "w:shd",
            "w:tabs", "w:suppressAutoHyphens", "w:kinsoku", "w:wordWrap",
            "w:overflowPunct", "w:autoSpaceDE", "w:autoSpaceDN", "w:bidi",
            "w:snapToGrid", "w:spacing", "w:ind", "w:contextualSpacing",
            "w:jc", "w:outlineLvl", "w:rPr", "w:sectPr"],
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

CASE_START_RE = re.compile(r"^[（(]\s*(?:19|20)\d{2}\s*[）)]")   # P2.1 字面规则: （20XX）开头
CHECK_TRIGGERS = ("行动清单", "检查清单", "审查清单")             # P2.3 (审查清单=检查清单变体, 在案扩展)
NUM_STRIP_RE = re.compile(r"[\d０-９.,%％，、\-—~≈\s万亿元亿年月日号元（）()/+xX]")


# ---------------------------------------------------------------- 基础件
def insert_ordered(parent, el):
    """按 CT_* 规范顺序插入; 单例子元素先移除旧值(幂等)."""
    ptag = parent.tag.split("}", 1)[-1]
    seq = [qn(t) for t in _ORDER.get(ptag, [])]
    for old in parent.findall(el.tag):
        parent.remove(old)
    if el.tag not in seq:
        parent.append(el)
        return el
    my = seq.index(el.tag)
    for child in parent:
        if child.tag in seq and seq.index(child.tag) > my:
            child.addprevious(el)
            return el
    parent.append(el)
    return el


def settings_insert(settings_el, tag):
    if settings_el.find(qn(f"w:{tag}")) is not None:
        return
    el = OxmlElement(f"w:{tag}")
    if tag != "evenAndOddHeaders":
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


def fmt_run(run, name=None, size=None, bold=None, color=None):
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
    if color is not None:
        run.font.color.rgb = RGBColor(*color)


def set_line_exact(p, before=None, after=None):
    """P1.1 基线网格: 行距=固定值14pt; 兼并段前/段后(twips 20/pt)."""
    ppr = p._p.get_or_add_pPr()
    sp = ppr.find(qn("w:spacing"))
    if sp is None:
        sp = insert_ordered(ppr, OxmlElement("w:spacing"))
    sp.set(qn("w:line"), LINE_TWIPS)
    sp.set(qn("w:lineRule"), "exact")
    if before is not None:
        sp.set(qn("w:before"), str(int(before * 20)))
    if after is not None:
        sp.set(qn("w:after"), str(int(after * 20)))
    return sp


def set_line_auto(p, before=None, after=None):
    """装饰性段落(Pull Quote/首字下沉框)用自动行距, 防大字号被精确行距裁切."""
    ppr = p._p.get_or_add_pPr()
    sp = ppr.find(qn("w:spacing"))
    if sp is None:
        sp = insert_ordered(ppr, OxmlElement("w:spacing"))
    sp.set(qn("w:line"), "240")
    sp.set(qn("w:lineRule"), "auto")
    if before is not None:
        sp.set(qn("w:before"), str(int(before * 20)))
    if after is not None:
        sp.set(qn("w:after"), str(int(after * 20)))


def ppr_flag(p, tag, val="true"):
    """置 w:pPr 布尔微工艺位 (widowControl/kinsoku/overflowPunct/autoSpaceDE/DN...)."""
    el = OxmlElement(f"w:{tag}")
    el.set(qn("w:val"), val)
    insert_ordered(p._p.get_or_add_pPr(), el)


def para_shd(p, fill):
    el = OxmlElement("w:shd")
    el.set(qn("w:val"), "clear")
    el.set(qn("w:color"), "auto")
    el.set(qn("w:fill"), fill)
    insert_ordered(p._p.get_or_add_pPr(), el)


def para_border(p, edge, sz, color, space="4"):
    ppr = p._p.get_or_add_pPr()
    pbdr = ppr.find(qn("w:pBdr"))
    if pbdr is None:
        pbdr = insert_ordered(ppr, OxmlElement("w:pBdr"))
    for old in pbdr.findall(qn(f"w:{edge}")):
        pbdr.remove(old)
    e = OxmlElement(f"w:{edge}")
    e.set(qn("w:val"), "single")
    e.set(qn("w:sz"), str(sz))
    e.set(qn("w:space"), space)
    e.set(qn("w:color"), color)
    pbdr.append(e)
    return e


def add_field(paragraph, instr, cached_text=None):
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


def first_char(text):
    """首字下沉取字: 跳过行首标点/引号/空白, 返回(i, ch)."""
    for i, ch in enumerate(text):
        if ch.strip() and ch not in "「『（《〈“‘【":
            return i, ch
    return 0, text[:1] or " "


# ---------------------------------------------------------------- 构建
def build():
    doc = Document(str(SRC))

    # ============ 0) 删除旧伪封面(首H1前的Normal段), 真正文自"导论"H1起 ============
    paras = doc.paragraphs
    first_h1 = next(i for i, p in enumerate(paras) if p.style.name == "Heading 1")
    anchor = paras[first_h1]._p
    removed = 0
    for child in list(doc.element.body):
        if child is anchor:
            break
        if child.tag == qn("w:p"):
            child.getparent().remove(child)
            removed += 1
    print(f"[strip] removed {removed} pseudo-cover paras before first H1")
    assert 0 < removed < 20, "旧封面删除量异常"

    # ============ 1) 内容分类 (在改动样式前, 按元素身份记账) ============
    paras = doc.paragraphs
    ids = {id(p._p): i for i, p in enumerate(paras)}

    def bold_len(p):
        return sum(len(r.text) for r in p.runs if r.font.bold)

    # P2.5 Pull Quote: 整段加粗>50字且<80字 (本册即【项目案例N】判例标题族)
    pull_quote = set()
    for p in paras:
        t = p.text.strip()
        if t and len(t) < 80 and bold_len(p) > 50:
            pull_quote.add(id(p._p))

    # P2.1 案例研究框: 判例标题(【项目案例…】或（20XX）开头) + 其后连续的加粗列表体段
    case_box, case_block_first, case_block_last = {}, {}, {}
    for i, p in enumerate(paras):
        t = p.text.strip()
        is_title = t.startswith("【项目案例") or bool(CASE_START_RE.match(t)) \
            or id(p._p) in pull_quote
        if not is_title:
            continue
        block = []
        j = i + 1
        while j < len(paras) and len(block) < 8:
            q = paras[j]
            if q.style.name != "List Bullet" or not q.text.strip():
                break
            block.append(q)
            j += 1
        if block:
            for q in block:
                case_box[id(q._p)] = True
            case_block_first[id(block[0]._p)] = True
            case_block_last[id(block[-1]._p)] = True
    # 字面规则兜底: 以（19XX/20XX）开头的段落本身即判例段 → 直接成框
    for p in paras:
        if CASE_START_RE.match(p.text.strip()):
            case_box[id(p._p)] = True
            case_block_first[id(p._p)] = True
            case_block_last[id(p._p)] = True

    # P2.3 勾选框: 「行动/检查/审查清单」之后的有序列表簇
    checkbox = set()
    idx = [i for i, p in enumerate(paras) if p.style.name == "List Number"]
    clusters = []
    for i in idx:
        if clusters and i == clusters[-1][-1] + 1:
            clusters[-1].append(i)
        else:
            clusters.append([i])
    for cl in clusters:
        hit = False
        for j in range(cl[0] - 1, max(-1, cl[0] - 13), -1):
            t = paras[j].text
            if any(k in t for k in CHECK_TRIGGERS):
                hit = True
                break
            if paras[j].style.name.startswith("Heading"):
                break
        if hit:
            for j in cl:
                checkbox.add(id(paras[j]._p))
    print(f"[classify] pull_quotes={len(pull_quote)} case_paras={len(case_box)} "
          f"case_blocks={len(case_block_first)} checkbox_items={len(checkbox)}")

    # ============ 2) P2.2 markdown管道表 → 真三线表 ============
    # 表行 = 以|开头的段落; 表头标签按列语义给定(阶段/核心动作/关键纪律/依据章节),
    # 被残缺单元污染的提示段只保留提示文本.
    all_p = doc.paragraphs
    pipe_ids, tip_dirty = [], []
    for p in all_p:
        t = p.text.strip()
        if t.count("|") >= 2:
            if t.startswith("|"):
                pipe_ids.append(id(p._p))
            else:
                tip_dirty.append(id(p._p))
    # 连续管道行聚簇
    blocks, cur = [], []
    for p in all_p:
        if id(p._p) in pipe_ids:
            cur.append(p)
        else:
            if cur:
                blocks.append(cur)
            cur = []
    if cur:
        blocks.append(cur)
    HEADER_LABELS = {2: ["项目", "要点"], 3: ["阶段", "核心动作", "关键纪律"],
                     4: ["阶段", "核心动作", "关键纪律", "依据章节"]}
    n_pipe = 0
    for block in blocks:
        grid = [[c.strip() for c in q.text.strip().strip("|").split("|")] for q in block]
        ncols = max(len(r) for r in grid)
        labels = HEADER_LABELS.get(ncols, [f"列{ i + 1}" for i in range(ncols)])
        tbl = doc.add_table(rows=1 + len(grid), cols=ncols)
        tbl._tbl.getparent().remove(tbl._tbl)
        block[0]._p.addprevious(tbl._tbl)
        for c in range(ncols):
            tbl.rows[0].cells[c].paragraphs[0].add_run(labels[c])
        for ri, row in enumerate(grid):
            for c in range(ncols):
                txt = row[c] if c < len(row) else ""
                tbl.rows[1 + ri].cells[c].paragraphs[0].add_run(txt)
        for q in block:
            q._p.getparent().remove(q._p)
        n_pipe += len(block)
    for pid in tip_dirty:
        for p in doc.paragraphs:
            if id(p._p) == pid and " | " in p.text:
                keep = p.text.split(" | ")[0].strip()
                for r in list(p.runs):
                    r._element.getparent().remove(r._element)
                if keep:
                    p.add_run(keep)
                break
    print(f"[pipe] converted_rows={n_pipe} blocks={len(blocks)} tips_cleaned={len(tip_dirty)}")

    # ============ 3) 样式族 (金标准 + 基座) ============
    S = doc.styles
    normal = S["Normal"]
    set_style_font(normal, F_BODY, 9)
    npr = normal.element.get_or_add_pPr()
    nsp = insert_ordered(npr, OxmlElement("w:spacing"))
    nsp.set(qn("w:line"), LINE_TWIPS)
    nsp.set(qn("w:lineRule"), "exact")
    nsp.set(qn("w:after"), "80")
    hmap = [
        ("Heading 1", F_H1, 18, False, None, 24, 18),
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
        pf = h.paragraph_format
        pf.space_before = Pt(bf)
        pf.space_after = Pt(af)
        pf.line_spacing = 1.3
        pf.keep_with_next = True
    S["Heading 1"].paragraph_format.alignment = WD_ALIGN_PARAGRAPH.CENTER
    for nm in ("List Bullet", "List Number"):
        try:
            ls = S[nm]
            set_style_font(ls, F_BODY, 9)
            ls.paragraph_format.space_after = Pt(2)
        except KeyError:
            pass

    # ============ 4) P4.1 专业封面 + P4.2 TOC域 + P4.3 执行摘要页 ============
    paras = doc.paragraphs
    anchor_p = paras[0]
    assert anchor_p.style.name == "Heading 1"
    protected = set()

    def ins(text="", style=None, align=WD_ALIGN_PARAGRAPH.CENTER, auto_line=True):
        p = anchor_p.insert_paragraph_before("", style=style)
        protected.add(id(p._p))
        p.alignment = align
        pf = p.paragraph_format
        pf.space_before = Pt(0)
        pf.space_after = Pt(0)
        if auto_line:
            set_line_auto(p)  # 封面大字防被14pt精确行距裁切
        if text:
            p.add_run(text)
        return p

    # -- 封面 (独立首页, titlePg 无页眉页脚) --
    p_title = ins()
    p_title.paragraph_format.space_before = Pt(180)          # 段前180pt
    r = p_title.add_run("工程签证与变更索赔实战研究报告")
    fmt_run(r, name=F_H1, size=28, bold=True, color=C_NAVY)  # 黑体28pt #1F3A5F
    p_sub = ins()
    p_sub.paragraph_format.space_before = Pt(16)
    r = p_sub.add_run("签证管理·费用工期索赔·争议裁判——从规则到行动")
    fmt_run(r, name=F_BODY, size=12, color=C_MID)
    # 金色装饰线: 底边框 + 双侧缩进收窄至14字符宽(14×9pt=126pt)
    p_line = ins()
    p_line.paragraph_format.space_before = Pt(54)
    p_line.paragraph_format.left_indent = Cm(5.1)
    p_line.paragraph_format.right_indent = Cm(5.1)
    para_border(p_line, "bottom", 18, C_GOLD, space="1")     # 粗线 2.25pt
    p_pub = ins()
    p_pub.paragraph_format.space_before = Pt(232)
    r = p_pub.add_run("总包创研院研究团队 出品")
    fmt_run(r, name=F_BODY, size=14, bold=True)
    p_date = ins()
    p_date.paragraph_format.space_before = Pt(10)
    r = p_date.add_run("2026年11月")
    fmt_run(r, name=F_BODY, size=11, color=C_MID)

    # -- 目录页 (titlePg 之后第2页): 非Heading标题 + WPS原生TOC域, 结果留空 --
    p_toc_title = ins()
    p_toc_title.paragraph_format.page_break_before = True
    p_toc_title.paragraph_format.space_after = Pt(22)
    r = p_toc_title.add_run("目  录")
    fmt_run(r, name=F_H1, size=16, bold=True, color=C_NAVY)
    p_hint = ins(align=WD_ALIGN_PARAGRAPH.LEFT)
    r = p_hint.add_run("（目录域：打开后右键此处 →「更新域」，即自动生成带页码的三级目录）")
    fmt_run(r, name=F_BODY, size=8, color=C_GRAY)
    p_toc = ins(align=WD_ALIGN_PARAGRAPH.LEFT)
    fld = OxmlElement("w:fldSimple")
    fld.set(qn("w:instr"), 'TOC \\o "1-3" \\h \\z \\u')
    fld.set(qn("w:dirty"), "true")                            # 域结果留空, 打开即自动更新
    p_toc._p.append(fld)

    # -- 执行摘要页: 导论前3段正文的萃取副本 --
    p_exec_h1 = ins("执行摘要", style=S["Heading 1"], auto_line=False)
    protected.discard(id(p_exec_h1._p))                       # 参与 H1 全局格式化
    plist = doc.paragraphs
    intro_idx = next(i for i, p in enumerate(plist)
                     if p.style.name == "Heading 1" and p.text.strip() == "导论")
    body3 = []
    for q in plist[intro_idx:]:
        if len(body3) == 3:
            break
        if q.style.name == "Normal" and q.text.strip() and id(q._p) not in protected:
            body3.append(q.text.strip())
    for txt in body3:
        pe = ins(txt, align=WD_ALIGN_PARAGRAPH.JUSTIFY)
        protected.discard(id(pe._p))                          # 摘要正文段参与全局格式化

    # ============ 5) P1 全局正文微工艺 ============
    stats = {"exact": 0, "both": 0, "bullet2normal": 0}
    for p in doc.paragraphs:
        if id(p._p) in protected:
            continue
        st = p.style.name
        if st == "Heading 1":
            continue
        if st == "List Bullet":
            p.style = normal                                  # 禁无序列表 → 转正文(金标准)
            st = "Normal"
            stats["bullet2normal"] += 1
        if st not in ("Normal", "List Number", "Heading 2", "Heading 3", "Heading 4"):
            continue
        if st in ("Heading 2", "Heading 3", "Heading 4"):
            for run in p.runs:
                fmt_run(run, name=F_BODY, size=14 if st == "Heading 2" else 12,
                        bold=True, color=C_NAVY)
            continue
        is_case = id(p._p) in case_box
        is_chk = id(p._p) in checkbox
        for run in p.runs:
            fmt_run(run, name=F_BODY, size=9)
        pf = p.paragraph_format
        set_line_exact(p)                                     # P1.1 基线网格 14pt
        ppr_flag(p, "widowControl")                           # P1.6 孤寡行
        ppr_flag(p, "kinsoku")                                # P1.5 避头尾
        ppr_flag(p, "overflowPunct")                          # P1.3 标点悬挂
        ppr_flag(p, "autoSpaceDE")                            # P1.4 中英混排
        ppr_flag(p, "autoSpaceDN")
        if p.text.strip():
            p.alignment = WD_ALIGN_PARAGRAPH.JUSTIFY          # P1.7 两端对齐
            stats["both"] += 1
        stats["exact"] += 1
        if st == "Normal" and p.text.strip():
            pf.first_line_indent = Pt(44)                     # 金标准首行缩进
        if is_case:
            pf.first_line_indent = Pt(0)
        if is_chk:
            p.style = normal
            ppr = p._p.get_or_add_pPr()                       # 去编号: □ 即行动标记
            for nm in ppr.findall(qn("w:numPr")):
                ppr.remove(nm)
            pf.first_line_indent = Pt(0)
    print(f"[P1] exact_line={stats['exact']} justified={stats['both']} "
          f"bullet2normal={stats['bullet2normal']}")

    # ============ 6) P2 装饰器 ============
    # 6a 勾选框: 每项前加「□ 」+ 悬挂缩进
    n_chk = 0
    for p in doc.paragraphs:
        if id(p._p) in checkbox:
            el = OxmlElement("w:r")
            first_r = next((r for r in p.runs if r.text), None)
            if first_r is not None:
                first_r._element.addprevious(el)
            else:
                p._p.append(el)
            new_r = Run(el, p)
            new_r.text = "□ "
            fmt_run(new_r, name=F_BODY, size=9)
            pf = p.paragraph_format
            pf.left_indent = Pt(18)
            pf.first_line_indent = Pt(-18)
            n_chk += 1
    # 6b 案例研究框: 浅灰底 + 左3pt竖线 + 左缩进10pt + 块首段前8/块尾段后8
    n_box = 0
    for p in doc.paragraphs:
        if id(p._p) not in case_box:
            continue
        para_shd(p, "F5F7FA")
        para_border(p, "left", 24, "1F3A5F", space="4")
        pf = p.paragraph_format
        pf.left_indent = Pt(10)
        pf.first_line_indent = Pt(0)
        before = 8 if id(p._p) in case_block_first else 0
        after = 8 if id(p._p) in case_block_last else 0
        set_line_exact(p, before=before, after=after)
        n_box += 1
    # 6c Pull Quote: 加粗长句 → 12pt居中#1F3A5F + 上下装饰线 + 段前后16pt
    n_pq = 0
    for p in doc.paragraphs:
        if id(p._p) not in pull_quote:
            continue
        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        pf = p.paragraph_format
        pf.left_indent = Pt(40)
        pf.right_indent = Pt(40)
        pf.first_line_indent = Pt(0)
        set_line_auto(p, before=16, after=16)                 # 12pt大字防裁切
        para_border(p, "top", 6, C_GOLD, space="10")
        para_border(p, "bottom", 6, C_GOLD, space="10")
        for run in p.runs:
            fmt_run(run, name=F_BODY, size=12, bold=True, color=C_NAVY)
        n_pq += 1
    # 6d+P1.2 章首首字下沉 + P2.4 关键要点卡 (同一目标段: 框内下沉字)
    # 按XML兄弟轴遍历(元素身份稳定), 不用索引——本循环自身会插段, 索引会漂移.
    n_dc = n_card = 0
    snap = {id(p._p): p for p in doc.paragraphs}

    def _style_of(el):
        ppr = el.find(qn("w:pPr"))
        if ppr is None:
            return "Normal"
        ps = ppr.find(qn("w:pStyle"))
        return ps.get(qn("w:val")) if ps is not None else "Normal"

    def _text_of(el):
        out = []
        for r in el.findall(qn("w:r")):
            for t in r.findall(qn("w:t")):
                out.append(t.text or "")
        return "".join(out)

    for p in doc.paragraphs:
        if p.style.name != "Heading 1" or id(p._p) in protected:
            continue
        target = None
        for sib in p._p.itersiblings():
            if sib.tag != qn("w:p"):
                continue                                    # 跨过表格等块
            stn = _style_of(sib)
            if stn in ("Heading1", "1", "Heading 1"):
                break
            if stn in ("Normal", "ListNumber", "List Number") \
                    and _text_of(sib).strip():
                target = snap.get(id(sib))
                break
        if target is None or len(target.text.strip()) < 40:
            continue
        # 首字下沉: framePr dropped 2行, 首字22pt#1F3A5F黑体
        lead = next((r for r in target.runs if r.text), None)
        if lead is None:
            continue
        i0, ch = first_char(lead.text)
        frame = target.insert_paragraph_before("")
        fppr = frame._p.get_or_add_pPr()
        fpr = OxmlElement("w:framePr")
        fpr.set(qn("w:dropCap"), "dropped")
        fpr.set(qn("w:lines"), "2")
        fpr.set(qn("w:wrap"), "around")
        fpr.set(qn("w:vAnchor"), "text")
        fpr.set(qn("w:hAnchor"), "text")
        fpr.set(qn("w:hSpace"), "180")
        insert_ordered(fppr, fpr)
        fr = frame.add_run(ch)
        fmt_run(fr, name=F_H1, size=22, color=C_NAVY)
        frame.paragraph_format.first_line_indent = Pt(0)
        set_line_auto(frame, before=0, after=0)
        # 原段去掉首字(前导标点保留在正文)
        lead.text = lead.text[:i0] + lead.text[i0 + 1:]
        n_dc += 1
        # 关键要点卡: >150字 → 浅蓝底+左蓝线+9.5pt+左缩进10pt
        if len(target.text.strip()) > 149:
            para_shd(target, "F0F5FA")
            para_border(target, "left", 24, "1F3A5F", space="4")
            pf = target.paragraph_format
            pf.left_indent = Pt(10)
            pf.first_line_indent = Pt(0)
            for run in target.runs:
                fmt_run(run, name=F_BODY, size=9.5)
            n_card += 1
    print(f"[P2] checkboxes={n_chk} case_boxes={n_box} pull_quotes={n_pq} "
          f"drop_caps={n_dc} key_cards={n_card}")

    # ============ 7) 章标题层 (H1黑体18居中+章起新页) ============
    for p in doc.paragraphs:
        if p.style.name != "Heading 1":
            continue
        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        pf = p.paragraph_format
        pf.page_break_before = True
        pf.space_before = Pt(24)
        pf.space_after = Pt(18)
        for run in p.runs:
            fmt_run(run, name=F_H1, size=18, bold=False)

    # ============ 8) 表格: 三线表 + 表头底纹 + 跨页重复 + 数字列右对齐 ============
    n_tbl = n_numcol = 0
    for t in doc.tables:
        n_tbl += 1
        tblPr = t._tbl.tblPr
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
        # 数字列右对齐 (P2.2): 非表头列中 ≥60% 单元格为数值型 → 该列数据右对齐
        ncols = len(t.columns)
        for c in range(ncols):
            vals = []
            for row in t.rows[1:]:
                try:
                    vals.append(row.cells[c].text.strip())
                except IndexError:
                    vals.append("")
            vals = [v for v in vals if v]
            if len(vals) >= 2:
                numish = sum(1 for v in vals if len(NUM_STRIP_RE.sub("", v)) <= 1)
                if numish / len(vals) >= 0.6:
                    for row in t.rows[1:]:
                        try:
                            cell = row.cells[c]
                        except IndexError:
                            continue
                        for cp in cell.paragraphs:
                            cp.alignment = WD_ALIGN_PARAGRAPH.RIGHT
                    n_numcol += 1
        for row in t.rows:
            for cell in row.cells:
                for cp in cell.paragraphs:
                    pf = cp.paragraph_format
                    pf.space_before = Pt(1)
                    pf.space_after = Pt(1)
                    pf.first_line_indent = Pt(0)
                    set_line_exact(cp)                        # 表内同基线网格
                    for run in cp.runs:
                        fmt_run(run, name=F_BODY, size=9)
        for cell in header_row.cells:
            for cp in cell.paragraphs:
                for run in cp.runs:
                    fmt_run(run, name=F_BODY, size=9, bold=True, color=C_NAVY)
    print(f"[tables] styled={n_tbl} numeric_cols_right={n_numcol}")

    # ============ 9) P4.4 页面 + 奇偶页眉页脚 + evenAndOddHeaders ============
    settings_insert(doc.settings.element, "evenAndOddHeaders")
    settings_insert(doc.settings.element, "updateFields")
    for sec in doc.sections:
        sec.page_width = Cm(21.0)
        sec.page_height = Cm(29.7)
        sec.top_margin = Cm(2.54)
        sec.bottom_margin = Cm(2.54)
        sec.left_margin = Cm(3.18)
        sec.right_margin = Cm(3.18)
        sec.different_first_page_header_footer = True         # 封面(titlePg)无页眉页脚

        def prep(part):
            part.is_linked_to_previous = False
            p0 = part.paragraphs[0] if part.paragraphs else part.add_paragraph()
            for extra in part.paragraphs[1:]:
                extra._p.getparent().remove(extra._p)
            for r in list(p0.runs):
                r._element.getparent().remove(r._element)
            return p0

        # 奇页页眉: STYLEREF 引用章名 (WPS 须用本地化内置名「标题 1」)
        hp = prep(sec.header)
        hp.alignment = WD_ALIGN_PARAGRAPH.RIGHT
        hp.paragraph_format.space_after = Pt(0)
        for run in add_field(hp, ' STYLEREF "标题 1" \\* MERGEFORMAT ', "导论"):
            fmt_run(run, name=F_BODY, size=8, color=C_GRAY)
        # 偶页页眉: 版权声明
        ep = prep(sec.even_page_header)
        ep.alignment = WD_ALIGN_PARAGRAPH.RIGHT
        ep.paragraph_format.space_after = Pt(0)
        r = ep.add_run("总包创研院版权所有，侵权必究！")
        fmt_run(r, name=F_BODY, size=8, color=C_GRAY)
        # 首页页眉: 空
        prep(sec.first_page_header)
        # 页脚: 奇/偶 PAGE域居中9pt, 首页空
        for fter, empty in ((sec.footer, False), (sec.even_page_footer, False),
                            (sec.first_page_footer, True)):
            fp = prep(fter)
            fp.alignment = WD_ALIGN_PARAGRAPH.CENTER
            fp.paragraph_format.space_after = Pt(0)
            if not empty:
                for run in add_field(fp, " PAGE "):
                    fmt_run(run, name=F_BODY, size=9, color=C_MID)

    cp_ = doc.core_properties
    cp_.title = "工程签证与变更索赔实战研究报告"
    cp_.author = "总包创研院研究团队"

    doc.save(str(OUT))
    print(f"[save] {OUT} ({OUT.stat().st_size:,} B)")
    return str(OUT)


# ---------------------------------------------------------------- 验证
def verify():
    d = Document(str(OUT))
    paras = d.paragraphs
    doc_xml = d.element.xml

    # 1 封面
    head_txt = "".join(p.text for p in paras[:12])
    cover_ok = ("工程签证与变更索赔实战研究报告" in head_txt
                and "总包创研院研究团队" in head_txt and "2026年11月" in head_txt)
    for p in paras[:8]:
        for r in p.runs:
            if r.text.strip() == "工程签证与变更索赔实战研究报告" \
                    and r.font.size and abs(r.font.size.pt - 28.0) < 0.01:
                cover_ok = cover_ok and bool(r.font.bold)

    # 2 TOC 域
    toc_ok = ('TOC \\o' in doc_xml) or any(
        "TOC" in (t or "") for t in d.element.body.xpath(".//w:instrText/text()"))

    # 3 H1
    h1s = [p for p in paras if p.style.name == "Heading 1"]

    # 4 页眉 (版权 + STYLEREF本地化) / evenAndOddHeaders
    stylerEF = copyr = ev = False
    for sec in d.sections:
        for hf in (sec.header, sec.even_page_header):
            x = "" if hf.is_linked_to_previous else hf._element.xml
            if "STYLEREF" in x and "标题 1" in x:
                stylerEF = True
            if "总包创研院版权所有" in x:
                copyr = True
    ev = d.settings.element.find(qn("w:evenAndOddHeaders")) is not None

    # 5 页脚 PAGE 域
    pagef = False
    for sec in d.sections:
        for hf in (sec.footer, sec.even_page_footer):
            x = "" if hf.is_linked_to_previous else hf._element.xml
            if "PAGE" in x:
                pagef = True

    # 6 案例框段落底色
    case_boxes = len(d.element.body.xpath('.//w:pPr/w:shd[@w:fill="F5F7FA"]'))

    # 7 首字下沉 (framePr dropped + 首字>正文)
    drop_caps = len(d.element.body.xpath('.//w:framePr[@w:dropCap="dropped"]'))
    dc_size_ok = 0
    for p in paras:
        fpr = p._p.find(qn("w:pPr"))
        fpr = fpr.find(qn("w:framePr")) if fpr is not None else None
        if fpr is not None and p.runs and p.runs[0].font.size \
                and p.runs[0].font.size.pt > 9.5:
            dc_size_ok += 1

    # P1 微工艺计数
    xp = d.element.body.xpath
    micro = {
        "exact_line_14pt": len(xp('.//w:spacing[@w:line="280"][@w:lineRule="exact"]')),
        "overflow_punct": len(xp('.//w:pPr/w:overflowPunct')),
        "auto_space_de": len(xp('.//w:pPr/w:autoSpaceDE')),
        "auto_space_dn": len(xp('.//w:pPr/w:autoSpaceDN')),
        "kinsoku": len(xp('.//w:pPr/w:kinsoku')),
        "widow_control": len(xp('.//w:pPr/w:widowControl')),
        "justified": len(xp('.//w:pPr/w:jc[@w:val="both"]')),
    }
    # P2 计数
    p2 = {
        "key_cards": len(xp('.//w:pPr/w:shd[@w:fill="F0F5FA"]')),
        "pull_quotes": len(d.element.body.xpath('.//w:pPr/w:pBdr/w:top[@w:color="C9A876"]')),
        "checkboxes": sum(p.text.count("□") for p in paras),
        "pipe_paras_left": sum(1 for p in paras if p.text.count("|") >= 2),
        "tables": len(d.tables),
        "tbl_header_rows": len(d.element.body.xpath(".//w:tblHeader")),
        "header_shading_cells": len(d.element.body.xpath('.//w:shd[@w:fill="EEF2F7"]')),
    }
    # 执行摘要页
    exec_ok = any(p.style.name == "Heading 1" and p.text.strip() == "执行摘要"
                  for p in paras[:30])

    # XML 良构 + 子元素顺序
    import zipfile
    from lxml import etree
    order_bad = 0
    with zipfile.ZipFile(str(OUT)) as zf:
        for n in [x for x in zf.namelist() if x.endswith(".xml")]:
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

    return {
        "output_path": str(OUT),
        "cover_ok": bool(cover_ok),
        "toc_ok": bool(toc_ok),
        "h1_count": len(h1s),
        "headers_ok": bool(stylerEF and copyr and ev),
        "page_foot_ok": bool(pagef),
        "case_boxes": case_boxes,
        "drop_caps": drop_caps,
        "drop_cap_size_ok": dc_size_ok,
        "exec_summary_ok": bool(exec_ok),
        "p1_micro": micro,
        "p2": p2,
        "all_xml_wellformed": bool(xml_ok),
        "ooxml_child_order_violations": order_bad,
        "total_paragraphs": len(paras),
    }


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    mode = sys.argv[1] if len(sys.argv) > 1 else "build"
    if mode == "verify":
        print(json.dumps(verify(), ensure_ascii=False, indent=2))
    else:
        build()
        print(json.dumps(verify(), ensure_ascii=False, indent=2))
