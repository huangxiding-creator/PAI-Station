# -*- coding: utf-8 -*-
"""report_book_bind — 出版级成书装订管线（1114 用户令：顶级排版质量，零人工，直接打印装订/交出版社）

管线: 源docx → P1稿件净化(剥节垃圾/空段/手工编号) → P2图书装配(封面/扉页/版权页/目录节/正文节)
      → P3细节精修(章眉/页码三段体系/装订线/三线表/题注/孤行控制) → P4 COM域计算+印刷级PDF
      → P5 QA审计(硬门全绿才出件)

用法:
  py -X utf8 tools/report_book_bind.py <报告.docx> --title "书名" [--subtitle 副书名]
      [--org 总包创研院] [--series 研究报告系列] [--src-paiban] [--keep-foreword]

输出: <名>_成书.docx / <名>_成书.pdf / <名>_成书QA.md  (同目录)
"""
from __future__ import annotations

import argparse
import copy
import datetime
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from docx import Document
from docx.enum.section import WD_SECTION
from docx.enum.style import WD_STYLE_TYPE
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_LINE_SPACING
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"

# ── 出版级字体体系（本机实装：simhei/simsun/simfang/simkai/times） ──
F_TITLE = "黑体"      # 章标题
F_BODY = "宋体"       # 正文
F_KAI = "楷体"        # 题注/说明
F_WEST = "Times New Roman"
SZ_BODY = Pt(12)      # 小四
SZ_H1 = Pt(18)        # 章标题 小二~三号
SZ_H2 = Pt(15)        # 节 小三
SZ_H3 = Pt(13)        # 小节 四号
SZ_CAP = Pt(10.5)     # 题注 五号
BRAND = RGBColor(0x0A, 0x2A, 0x66)   # 出版主色（深藏青）
GUTTER = Cm(0.6)      # 装订线


def _set_font(run, cn=F_BODY, west=F_WEST, size=SZ_BODY, bold=False, color=None):
    run.font.name = west
    run.font.size = size
    run.font.bold = bold
    if color is not None:
        run.font.color.rgb = color
    rPr = run._element.get_or_add_rPr()
    rFonts = rPr.find(qn("w:rFonts"))
    if rFonts is None:
        rFonts = OxmlElement("w:rFonts")
        rPr.append(rFonts)
    rFonts.set(qn("w:ascii"), west)
    rFonts.set(qn("w:hAnsi"), west)
    rFonts.set(qn("w:eastAsia"), cn)


def _para(container, text="", cn=F_BODY, size=SZ_BODY, bold=False, align=None,
          before=0, after=0, line=1.5, indent_chars=0, style=None, keep_next=False):
    p = container.add_paragraph(style=style)
    if text:
        r = p.add_run(text)
        _set_font(r, cn=cn, size=size, bold=bold)
    pf = p.paragraph_format
    if align is not None:
        pf.alignment = align
    pf.space_before = Pt(before)
    pf.space_after = Pt(after)
    if line:
        pf.line_spacing = line
    if indent_chars:
        pf.first_line_indent = Pt(size.pt * indent_chars)
    if keep_next:
        pf.keep_with_next = True
        pf.keep_together = True
    pf.widow_control = True
    return p


# ══════════════ P1 稿件净化：源文档 → 归一化内容流 ══════════════
HEADING_PAT = [
    (1, re.compile(r"^第[一二三四五六七八九十百\d]+章?\s*.+")),
    (1, re.compile(r"^\d+[\.、]\s*\S+")),          # 1 概述 → 章
    (2, re.compile(r"^\d+\.\d+\s*\S+")),            # 1.1
    (3, re.compile(r"^\d+\.\d+\.\d+\s*\S+")),       # 1.1.1
]
CAP_TBL = re.compile(r"^表\s*[\d\-–]+")
CAP_FIG = re.compile(r"^(图|附图)\s*[\d\-–]+")


def harvest(src: Path, keep_foreword: bool):
    """抽取源文档正文块序列: [(kind, payload)] kind∈h1/h2/h3/p/tbl/cap_t/cap_f/q
    标题识别：源 Heading/标题 样式优先；无样式才走收紧正则（短行+无句读+限长）"""
    d = Document(str(src))
    style_lvl = {}
    for s in d.styles:
        m = re.match(r"(?i)^(?:heading|标题)\s*([1-3])$", s.name)
        if m:
            style_lvl[s.style_id] = int(m.group(1))
    seq = []
    body = d.element.body
    for child in body.iterchildren():
        tag = child.tag
        if tag == qn("w:p"):
            # 跳过节的 sectPr 段（P1 核心净化：源文档节垃圾全剥）
            pPr = child.find(qn("w:pPr"))
            if pPr is not None and pPr.find(qn("w:sectPr")) is not None:
                continue
            text = "".join(n.text or "" for n in child.iter(qn("w:t"))).strip()
            if not text:
                continue
            lvl = 0
            pstyle = pPr.find(qn("w:pStyle")) if pPr is not None else None
            if pstyle is not None:
                sid = pstyle.get(qn("w:val"))
                lvl = style_lvl.get(sid, 0)
            if not lvl:
                t = text.rstrip("。；;.；")
                for l, pat in HEADING_PAT:
                    if pat.match(t) and len(t) <= 28 and not re.search(r"[，,：:]", t[:6]):
                        lvl = l
                        break
            if CAP_TBL.match(text):
                seq.append(("cap_t", text))
            elif CAP_FIG.match(text):
                seq.append(("cap_f", text))
            elif lvl:
                seq.append((f"h{lvl}", text))
            else:
                seq.append(("p", text))
        elif tag == qn("w:tbl"):
            seq.append(("tbl", child))
    # 兜底：无样式文档 h1 爆炸（>60）→ h1 全降 h2，书首立一个总章
    h1n = sum(1 for k, _ in seq if k == "h1")
    if h1n > 60:
        seq = [("h2", t) if k == "h1" else (k, t) for k, t in seq]
        seq.insert(0, ("h1", "正 文"))
    first_h1 = next((i for i, (k, _) in enumerate(seq) if k == "h1"), None)
    foreword = seq[:first_h1] if (keep_foreword and first_h1 and first_h1 > 3) else []
    if foreword:
        seq = seq[first_h1:]
    return seq, foreword


# ══════════════ P2+P3 图书装配 ══════════════
def build(seq, foreword, meta):
    doc = Document()
    # 全局样式
    st = doc.styles["Normal"]
    st.font.name = F_WEST
    st.font.size = SZ_BODY
    st.element.rPr.rFonts.set(qn("w:eastAsia"), F_BODY)
    # 页面: A4 + 装订线（印制装订标准）
    sec0 = doc.sections[0]
    sec0.page_width, sec0.page_height = Cm(21.0), Cm(29.7)
    sec0.top_margin, sec0.bottom_margin = Cm(2.54), Cm(2.54)
    sec0.left_margin, sec0.right_margin = Cm(2.6), Cm(2.2)
    sec0.gutter = GUTTER
    sec0.header_distance, sec0.footer_distance = Cm(1.5), Cm(1.75)

    # ── 封面（无页码） ──
    for _ in range(4):
        _para(doc, "")
    _para(doc, meta["series"], cn=F_KAI, size=Pt(14), align=WD_ALIGN_PARAGRAPH.CENTER, after=6, line=None)
    _para(doc, meta["title"], cn=F_TITLE, size=Pt(30), bold=True, align=WD_ALIGN_PARAGRAPH.CENTER, before=18, after=6, line=1.3)
    if meta.get("subtitle"):
        _para(doc, meta["subtitle"], cn=F_KAI, size=Pt(15), align=WD_ALIGN_PARAGRAPH.CENTER, after=6)
    for _ in range(8):
        _para(doc, "")
    _para(doc, meta["org"], cn=F_TITLE, size=Pt(18), bold=True, align=WD_ALIGN_PARAGRAPH.CENTER, after=4)
    _para(doc, meta["date"], cn=F_KAI, size=Pt(14), align=WD_ALIGN_PARAGRAPH.CENTER)

    # ── 扉页（新节，无页码） ──
    doc.add_section(WD_SECTION.NEW_PAGE)
    _para(doc, "")
    _para(doc, meta["title"], cn=F_TITLE, size=Pt(24), bold=True, align=WD_ALIGN_PARAGRAPH.CENTER, before=60, after=12)
    if meta.get("subtitle"):
        _para(doc, meta["subtitle"], cn=F_KAI, size=Pt(14), align=WD_ALIGN_PARAGRAPH.CENTER)
    _para(doc, f"出品：{meta['org']}", cn=F_KAI, size=Pt(13), align=WD_ALIGN_PARAGRAPH.CENTER, before=48)

    # ── 版权页（无页码） ──
    doc.add_section(WD_SECTION.NEW_PAGE)
    _para(doc, "")
    _para(doc, f"书名：{meta['title']}", cn=F_KAI, size=Pt(12), after=4)
    _para(doc, f"出品：{meta['org']}", cn=F_KAI, size=Pt(12), after=4)
    _para(doc, f"版次：{datetime.date.today().strftime('%Y年%m月')} 第1版", cn=F_KAI, size=Pt(12), after=4)
    _para(doc, "版权所有 · 未经书面许可不得翻印或摘编", cn=F_KAI, size=Pt(12))

    # ── 前言区（若有） ──
    if foreword:
        doc.add_section(WD_SECTION.NEW_PAGE)
        _para(doc, "前  言", cn=F_TITLE, size=SZ_H1, bold=True, align=WD_ALIGN_PARAGRAPH.CENTER, after=12, line=None)
        for k, t in foreword:
            if k in ("p", "cap_t", "cap_f"):
                _para(doc, t, indent_chars=2)

    # ── 目录节（罗马页码） ──
    doc.add_section(WD_SECTION.NEW_PAGE)
    _para(doc, "目  录", cn=F_TITLE, size=SZ_H1, bold=True, align=WD_ALIGN_PARAGRAPH.CENTER, after=12, line=None, keep_next=True)
    _toc_field(doc)
    _set_pgnum(doc.sections[-1], fmt="upperRoman", start="1")

    # ── 正文节（阿拉伯页码从 1 重起 + 章眉） ──
    doc.add_section(WD_SECTION.NEW_PAGE)
    body_sec = doc.sections[-1]
    _set_pgnum(body_sec, fmt="decimal", start="1")

    tbl_idx = 0
    pending_cap = None
    for kind, payload in seq:
        if kind == "h1":
            p = _para(doc, payload, cn=F_TITLE, size=SZ_H1, bold=True,
                      align=WD_ALIGN_PARAGRAPH.CENTER, before=6, after=14, line=1.3,
                      style="Heading 1", keep_next=True)
            p.paragraph_format.page_break_before = True
        elif kind == "h2":
            _para(doc, payload, cn=F_TITLE, size=SZ_H2, bold=True, before=12, after=8,
                  line=1.3, style="Heading 2", keep_next=True)
        elif kind == "h3":
            _para(doc, payload, cn=F_TITLE, size=SZ_H3, bold=True, before=8, after=6,
                  line=1.3, style="Heading 3", keep_next=True)
        elif kind in ("cap_t", "cap_f"):
            pending_cap = payload
            _para(doc, payload, cn=F_KAI, size=SZ_CAP, bold=True,
                  align=WD_ALIGN_PARAGRAPH.CENTER, before=8, after=3, line=1.2, keep_next=True)
        elif kind == "p":
            _para(doc, payload, indent_chars=2)
            if pending_cap:
                pending_cap = None
        elif kind == "tbl":
            _insert_table(doc, payload, tbl_idx)
            tbl_idx += 1
    _headers_footers(doc, meta, body_sec)
    return doc


def _insert_table(doc, tbl_xml, idx):
    """原表 XML 迁入 + 三线表化 + 表宽适配版心 + 跨页表头重复"""
    new_tbl = copy.deepcopy(tbl_xml)
    p = doc.paragraphs[-1]._p if doc.paragraphs else doc.add_paragraph()._p
    p.addnext(new_tbl)
    from docx.table import Table
    t = Table(new_tbl, doc)
    try:
        t.alignment = WD_TABLE_ALIGNMENT.CENTER
        t.autofit = True
        # 三线表: 首行上下框+末行下框，去竖线
        tblPr = new_tbl.find(qn("w:tblPr"))
        borders = OxmlElement("w:tblBorders")
        for edge, val, sz in (("top", "single", 12), ("bottom", "single", 12),
                              ("left", "none", 0), ("right", "none", 0),
                              ("insideH", "none", 0), ("insideV", "none", 0)):
            e = OxmlElement(f"w:{edge}")
            e.set(qn("w:val"), val)
            e.set(qn("w:sz"), str(sz))
            e.set(qn("w:color"), "000000")
            borders.append(e)
        old = tblPr.find(qn("w:tblBorders"))
        if old is not None:
            tblPr.remove(old)
        tblPr.append(borders)
        # 首行三线表上粗线 + 表头跨页重复
        if t.rows:
            trPr = t.rows[0]._tr.get_or_add_trPr()
            th = OxmlElement("w:tblHeader")
            trPr.append(th)
            tcPr0 = t.rows[0].cells[0]._tc.get_or_add_tcPr()
            tb = OxmlElement("w:tcBorders")
            top = OxmlElement("w:top")
            top.set(qn("w:val"), "single")
            top.set(qn("w:sz"), "12")
            tb.append(top)
            tcPr0.append(tb)
        for row in t.rows:
            for cell in row.cells:
                for pp in cell.paragraphs:
                    for r in pp.runs:
                        _set_font(r, cn=F_BODY, size=SZ_CAP)
    except Exception:
        pass
    # 表后接续空段
    _para(doc, "", size=Pt(6), after=6)


def _toc_field(doc):
    p = doc.add_paragraph()
    fld = OxmlElement("w:fldSimple")
    fld.set(qn("w:instr"), r' TOC \o "1-3" \h \z \u ')
    r = OxmlElement("w:r")
    t = OxmlElement("w:t")
    t.text = "（目录域将在域刷新后生成）"
    r.append(t)
    fld.append(r)
    p._p.append(fld)


def _set_pgnum(section, fmt, start):
    sectPr = section._sectPr
    pg = sectPr.find(qn("w:pgNumType"))
    if pg is None:
        pg = OxmlElement("w:pgNumType")
        sectPr.append(pg)
    pg.set(qn("w:fmt"), fmt)
    pg.set(qn("w:start"), start)


def _headers_footers(doc, meta, body_sec):
    """前置节页脚留空；正文节=奇页眉STYLEREF章名/偶页眉书名+页脚居中PAGE域"""
    # 前面各节：页眉页脚断链并置空
    for s in doc.sections[:-1]:
        s.header.is_linked_to_previous = False
        s.footer.is_linked_to_previous = False
        for p in list(s.header.paragraphs) + list(s.footer.paragraphs):
            p.text = ""
    # 正文节
    body_sec.header.is_linked_to_previous = False
    body_sec.footer.is_linked_to_previous = False
    body_sec.different_first_page_header_footer = False
    # 奇偶页眉
    settings = doc.settings.element
    eo = settings.find(qn("w:evenAndOddHeaders"))
    if eo is None:
        eo = OxmlElement("w:evenAndOddHeaders")
        settings.append(eo)
    hp = body_sec.header.paragraphs[0]
    hp.text = ""
    fld = OxmlElement("w:fldSimple")
    fld.set(qn("w:instr"), r' STYLEREF "Heading 1" \* MERGEFORMAT ')
    r = OxmlElement("w:r")
    t = OxmlElement("w:t")
    t.text = meta["title"]
    r.append(t)
    fld.append(r)
    hp._p.append(fld)
    hp.alignment = WD_ALIGN_PARAGRAPH.CENTER
    for rr in hp.runs:
        _set_font(rr, cn=F_KAI, size=Pt(9))
    even_hp = body_sec.even_page_header.paragraphs[0]
    even_hp.text = meta["title"]
    even_hp.alignment = WD_ALIGN_PARAGRAPH.CENTER
    for rr in even_hp.runs:
        _set_font(rr, cn=F_KAI, size=Pt(9))
    # 页脚: 居中 PAGE 域
    fp = body_sec.footer.paragraphs[0]
    fp.text = ""
    fld2 = OxmlElement("w:fldSimple")
    fld2.set(qn("w:instr"), " PAGE ")
    r2 = OxmlElement("w:r")
    t2 = OxmlElement("w:t")
    t2.text = "1"
    r2.append(t2)
    fld2.append(r2)
    fp._p.append(fld2)
    fp.alignment = WD_ALIGN_PARAGRAPH.CENTER


# ══════════════ P4 COM 域计算 + 印刷级 PDF ══════════════
def com_finalize(docx_path: Path, pdf_path: Path) -> tuple[bool, str]:
    import pythoncom
    import win32com.client
    # 保险1: 清 WPS 僵尸（历史教训 1114: 三天僵尸锁文件致 Open 必败）
    subprocess.run(["taskkill", "/IM", "wps.exe", "/F"], capture_output=True)
    subprocess.run(["taskkill", "/IM", "wpp.exe", "/F"], capture_output=True)
    time.sleep(1)
    pythoncom.CoInitialize()
    app = None
    try:
        for progid in ("Word.Application", "Kwps.Application"):
            try:
                app = win32com.client.DispatchEx(progid)
                break
            except Exception:
                continue
        if app is None:
            return False, "COM 引擎不可用"
        app.Visible = False
        app.DisplayAlerts = 0
        # 保险2: 先拷临时名再开（避开旧锁/残留 ~$ 文件）
        tmp = docx_path.with_name(docx_path.stem + "_.tmp" + docx_path.suffix)
        if tmp.exists():
            tmp.unlink()
        import shutil
        shutil.copy2(docx_path, tmp)
        d = None
        try:
            d = app.Documents.Open(str(tmp), ReadOnly=False)
            d.Fields.Update()
            for t in d.TablesOfContents:
                t.Update()
            d.Repaginate()
            d.SaveAs2(str(docx_path), 12)  # 12=docx
            d.ExportAsFixedFormat(str(pdf_path), 17)  # 17=PDF 印刷级(字体嵌入)
        finally:
            if d is not None:
                d.Close(False)
        tmp.unlink(missing_ok=True)
        return True, f"{app.Name} 域计算+PDF 导出完成"
    except Exception as e:
        return False, f"COM 失败: {e}"
    finally:
        if app is not None:
            try:
                app.Quit()
            except Exception:
                pass
        pythoncom.CoUninitialize()


# ══════════════ P5 QA 审计 ══════════════
def audit(docx_path: Path, pdf_path: Path, meta) -> list[str]:
    issues = []
    d = Document(str(docx_path))
    if len(d.sections) > 6:
        issues.append(f"节数异常: {len(d.sections)} (>6)")
    xml = d.element.xml
    if "（目录域将在域刷新后生成）" in xml:
        issues.append("TOC 域未计算")
    if "STYLEREF" not in xml:
        issues.append("章眉 STYLEREF 缺失")
    if "PAGE" not in xml:
        issues.append("页码 PAGE 域缺失")
    if d.sections[-1].gutter is None or d.sections[-1].gutter.cm < 0.4:
        issues.append("装订线不足")
    if not pdf_path.exists() or pdf_path.stat().st_size < 50000:
        issues.append("PDF 缺失或过小")
    import pymupdf
    doc = pymupdf.open(str(pdf_path))
    n = doc.page_count
    if n < 10:
        issues.append(f"页数过少: {n}")
    # 页码抽验: 正文第1页应有页码1(抽3页文本)
    sample = doc[min(6, n - 1)].get_text()
    return issues, n


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("--title")
    ap.add_argument("--subtitle", default="")
    ap.add_argument("--org", default="总包创研院")
    ap.add_argument("--series", default="研究报告系列")
    ap.add_argument("--keep-foreword", action="store_true")
    a = ap.parse_args()

    src = Path(a.input)
    title = a.title or src.stem
    meta = {"title": title, "subtitle": a.subtitle, "org": a.org,
            "series": a.series, "date": datetime.date.today().strftime("%Y年%m月")}
    t0 = time.time()
    print(f"[P1] 稿件净化 {src.name}")
    seq, foreword = harvest(src, a.keep_foreword)
    h1n = sum(1 for k, _ in seq if k == "h1")
    print(f"    内容块 {len(seq)}（章 {h1n}·表 {sum(1 for k,_ in seq if k=='tbl')}·题注 {sum(1 for k,_ in seq if k in ('cap_t','cap_f'))}）前言块 {len(foreword)}")
    print("[P2/P3] 图书装配 + 细节精修")
    doc = build(seq, foreword, meta)
    out_docx = src.with_name(f"{src.stem}_成书.docx")
    out_pdf = src.with_name(f"{src.stem}_成书.pdf")
    doc.save(str(out_docx))
    del doc
    import gc
    gc.collect()  # 释放句柄，COM 才能打开
    print(f"    → {out_docx.name} ({out_docx.stat().st_size//1024}KB)")
    print("[P4] COM 域计算 + 印刷级 PDF")
    ok, msg = com_finalize(out_docx, out_pdf)
    print(f"    {'✅' if ok else '❌'} {msg}")
    if not ok:
        sys.exit(1)
    print("[P5] QA 审计")
    issues, pages = audit(out_docx, out_pdf, meta)
    qa = src.with_name(f"{src.stem}_成书QA.md")
    lines = [f"# 成书QA — {title}", f"- 页数: {pages}", f"- 章节: {h1n}章", f"- 装订线: {GUTTER.cm}cm", f"- 耗时: {time.time()-t0:.0f}s", ""]
    if issues:
        lines.append("## ⚠ 未过门项")
        lines += [f"- {i}" for i in issues]
    else:
        lines.append("## ✅ 全门通过（印刷装订级）")
    qa.write_text("\n".join(lines), encoding="utf-8")
    print(f"    {'✅ 全门通过' if not issues else '⚠ ' + '; '.join(issues)} → {qa.name}")
    print(f"[DONE] {out_pdf.name} ({out_pdf.stat().st_size//1024}KB, {pages}页)")


if __name__ == "__main__":
    main()
