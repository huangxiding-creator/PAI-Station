"""微信读书 Book 对象 → Markdown / DOCX 专业排版导出（L3 导出层）。

MD：YAML 头（元数据）+ 锚点目录 + 章节层级渲染；
DOCX：封面页（居中大字）+ 点线目录页 + Heading 层级 + 中文字体规范
（雅黑标题/宋体正文）+ 图片嵌入 + 页脚页码——超越 hundun_to_docx 的
三级映射（ADR-6：直接消费块模型而非 MD 往返）。

图片本地化：image_mapper 回调（src → 本地相对路径或 None）由批量层
注入；DOCX 嵌入本地文件，MD 写相对引用。
"""
import re

from docx import Document
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_TAB_ALIGNMENT, WD_TAB_LEADER
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

from paistation.forge.weread_html import escape_md, html_to_blocks

_GRAY = RGBColor(0x80, 0x80, 0x80)
_LIGHT = RGBColor(0xA0, 0xA0, 0xA0)


def _anchor(title: str) -> str:
    """GitHub 风格标题锚点：小写拉丁、空白转 -、去标点、保留中日韩。"""
    text = re.sub(r"[^\w一-鿿\- ]", "", escape_md(title).replace("\\", ""))
    return re.sub(r"\s+", "-", text.strip().lower())


def to_markdown(book: dict, image_mapper=None) -> str:
    """Book → Markdown 全文。image_mapper(src)->本地相对路径|None。"""
    meta = ["---",
            f"title: {book.get('title', '')}",
            f"author: {book.get('author', '')}",
            f'bookId: "{book.get("bookId", "")}"',
            f"format: {book.get('format', '')}",
            f"totalWords: {book.get('totalWords', 0)}",
            f"partial: {str(book.get('partial', False)).lower()}",
            f"fetchedAt: {book.get('fetchedAt', '')}",
            "source: 微信读书",
            "---", ""]
    parts = ["\n".join(meta),
             f"# {book.get('title', '')}", "",
             f"> {book.get('author', '')} · 微信读书 · "
             f"{book.get('format', '')}", ""]
    if book.get("intro"):
        parts += ["**简介**：" + book["intro"].strip(), ""]

    toc = ["## 目录", ""]
    for ch in book.get("chapters", []):
        indent = "  " * max(0, int(ch.get("level", 1)) - 1)
        toc.append(f"{indent}- [{ch['title']}](#{_anchor(ch['title'])})")
    parts += toc + ["", "---", ""]

    for ch in book.get("chapters", []):
        if ch.get("skipped"):
            parts += [f"## {ch['title']}", "",
                      f"> ⚠️ 本章未提取：{ch['skipped']}", ""]
            continue
        parts += _chapter_md(ch, image_mapper) + [""]
    if book.get("partial"):
        parts += ["---", "", "**部分提取说明**：" +
                  "；".join(book.get("partialReasons", [])), ""]
    return "\n".join(parts)


def _norm_text(text: str) -> str:
    return re.sub(r"\s+", "", text or "")


def _dedup_title_heading(blocks: list, title: str) -> list:
    """去章首重复标题：epub 各章文件惯以复述章名（2026-09 实测，
    形态有 para 复述 / h1 复述 / 标题+署名混排，且可连续出现）。

    与章名全等的开头块（heading 或 para）循环删除；含署名混排
    （"推荐序\\n马云|…"）→ 降级为正文段保留署名。
    """
    name = _norm_text(title)
    if not name:
        return blocks
    out = list(blocks)
    while out:
        first = out[0]
        head = _norm_text(first.get("text", ""))
        if first.get("kind") not in ("heading", "para"):
            break
        if head == name:
            out = out[1:]                                 # 全等复述，剥除
            continue
        if first["kind"] == "heading" and head.startswith(name):
            return [dict(first, kind="para")] + out[1:]   # 署名混排降级
        break
    return out


def _chapter_md(chapter: dict, image_mapper) -> list:
    level = max(1, min(int(chapter.get("level", 1)) + 1, 6))
    lines = ["#" * level + " " + escape_md(chapter.get("title", "")), ""]
    blocks, _ = html_to_blocks(chapter.get("html", ""))
    blocks = _dedup_title_heading(blocks, chapter.get("title", ""))
    for blk in blocks:
        kind = blk["kind"]
        if kind == "heading":
            lines += ["#" * min(blk["level"] + level, 6) + " " + blk["text"],
                      ""]
        elif kind == "li":
            marker = f"{blk['index']}. " if blk.get("ordered") else "- "
            lines.append(marker + blk["text"])
        elif kind == "quote":
            lines += ["> " + blk["text"], ""]
        elif kind == "img":
            src = blk["src"]
            if image_mapper:
                local = image_mapper(src)
                if local:
                    src = local
            lines += [f"![{blk['alt']}]({src})", ""]
        else:
            lines += [blk["text"], ""]
    while lines and lines[-1] == "":
        lines.pop()
    return lines


# ---------- DOCX ----------

def to_docx(book: dict, out_path: str, image_mapper=None,
            cover_image: str = "") -> str:
    """Book → DOCX（封面/点线目录/层级标题/中文字体/页码）。返回路径。"""
    doc = Document()
    _setup_page(doc)
    _setup_fonts(doc)

    # 封面页
    _center_para(doc, book.get("title", ""), size=26, bold=True,
                 space_before=120)
    _center_para(doc, book.get("author", ""), size=14)
    meta = " · ".join(f"{label}：{book.get(key, '')}"
                      for label, key in (("格式", "format"),
                                         ("总字数", "totalWords"),
                                         ("提取时间", "fetchedAt")))
    _center_para(doc, meta, size=10, color=_GRAY)
    _center_para(doc, "来源：微信读书 · 仅供个人学习研究", size=9, color=_LIGHT)
    if cover_image:
        try:
            doc.add_picture(cover_image, width=Cm(10))
            doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
        except Exception:                       # noqa: BLE001 - 封面失败不挡导出
            pass
    doc.add_page_break()

    # 目录页（点线引导）
    doc.add_heading("目录", level=1)
    for ch in book.get("chapters", []):
        indent = Cm(0.6 * (max(1, int(ch.get("level", 1))) - 1))
        _toc_entry(doc, ch.get("title", ""), indent)
    doc.add_page_break()

    # 正文
    for ch in book.get("chapters", []):
        doc.add_heading(ch.get("title", ""),
                        level=min(int(ch.get("level", 1)) + 1, 4))
        if ch.get("skipped"):
            _note_para(doc, f"本章未提取：{ch['skipped']}")
            continue
        _add_chapter_body(doc, ch, image_mapper)
    if book.get("partial"):
        _note_para(doc, "部分提取说明：" +
                   "；".join(book.get("partialReasons", [])))
    _add_page_number(doc)
    doc.save(out_path)
    return out_path


def _setup_page(doc) -> None:
    for section in doc.sections:
        section.page_width, section.page_height = Cm(21.0), Cm(29.7)  # A4
        section.top_margin = section.bottom_margin = Cm(2.54)
        section.left_margin = section.right_margin = Cm(3.18)


def _setup_fonts(doc) -> None:
    """Normal=宋体正文；Heading1-3=微软雅黑（中文字体双设置铁律）。"""
    normal = doc.styles["Normal"]
    normal.font.name = "Calibri"
    normal.font.size = Pt(11)
    normal._element.rPr.rFonts.set(qn("w:eastAsia"), "宋体")
    for name, size in (("Heading 1", 16), ("Heading 2", 14),
                       ("Heading 3", 12)):
        st = doc.styles[name]
        st.font.name = "Calibri"
        st.font.size = Pt(size)
        st.font.bold = True
        st.font.color.rgb = RGBColor(0x1F, 0x1F, 0x1F)
        st.element.get_or_add_rPr().get_or_add_rFonts().set(
            qn("w:eastAsia"), "微软雅黑")


def _center_para(doc, text, size=12, bold=False, space_before=0,
                 color=None) -> None:
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    if space_before:
        p.paragraph_format.space_before = Pt(space_before)
    run = p.add_run(text)
    run.font.size = Pt(size)
    run.font.bold = bold
    run.font.name = "Calibri"
    run._element.rPr.rFonts.set(qn("w:eastAsia"), "微软雅黑")
    if color:
        run.font.color.rgb = color


def _toc_entry(doc, title: str, indent) -> None:
    p = doc.add_paragraph()
    pf = p.paragraph_format
    pf.left_indent = indent
    pf.tab_stops.add_tab_stop(Cm(14.5), WD_TAB_ALIGNMENT.RIGHT,
                              WD_TAB_LEADER.DOTS)
    run = p.add_run(title)
    run.font.size = Pt(10.5)


def _note_para(doc, text: str) -> None:
    p = doc.add_paragraph()
    run = p.add_run(text)
    run.font.size = Pt(9)
    run.font.italic = True
    run.font.color.rgb = _GRAY


def _add_chapter_body(doc, ch, image_mapper) -> None:
    base_level = min(int(ch.get("level", 1)) + 1, 4)
    blocks = html_to_blocks(ch.get("html", ""))[0]
    blocks = _dedup_title_heading(blocks, ch.get("title", ""))
    for blk in blocks:
        kind = blk["kind"]
        if kind == "heading":
            doc.add_heading(blk["text"],
                            level=min(base_level + blk["level"] - 1, 4))
        elif kind == "img":
            local = image_mapper(blk["src"]) if image_mapper else None
            added = False
            if local:
                try:
                    doc.add_picture(local, width=Cm(12))
                    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
                    added = True
                except Exception:               # noqa: BLE001 - 图片缺不挡导出
                    pass
            if not added:
                p = doc.add_paragraph()
                p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                run = p.add_run(f"〔图：{blk['alt'] or '插图'}〕")
                run.font.size = Pt(9)
                run.font.color.rgb = _GRAY
        elif kind == "li":
            marker = f"{blk['index']}. " if blk.get("ordered") else "• "
            _docx_rich_para(doc, marker + blk["text"])
        elif kind == "quote":
            p = _docx_rich_para(doc, blk["text"])
            p.paragraph_format.left_indent = Cm(0.74)
            for run in p.runs:
                run.font.italic = True
        else:
            _docx_rich_para(doc, blk["text"])


def _docx_rich_para(doc, text: str):
    """支持 **加粗**/*斜体* 行内标记的富文本段落。"""
    p = doc.add_paragraph()
    for seg, bold, italic in _split_inline(text):
        if not seg:
            continue
        run = p.add_run(seg)
        run.font.bold = bold or None
        run.font.italic = italic or None
        run.font.size = Pt(11)
        run.font.name = "Calibri"
        run._element.rPr.rFonts.set(qn("w:eastAsia"), "宋体")
    return p


def _split_inline(text: str) -> list:
    """按 **…** / *…* 切分为 (片段, 粗, 斜) 三元组序列。"""
    out = []
    pos = 0
    for m in re.finditer(r"\*\*(.+?)\*\*|\*([^*]+?)\*", text):
        if m.start() > pos:
            out.append((text[pos:m.start()], False, False))
        if m.group(1) is not None:
            out.append((m.group(1), True, False))
        else:
            out.append((m.group(2), False, True))
        pos = m.end()
    if pos < len(text):
        out.append((text[pos:], False, False))
    return out


def _add_page_number(doc) -> None:
    """页脚居中页码域（打开文档即显示）。"""
    for section in doc.sections:
        footer_p = section.footer.paragraphs[0]
        footer_p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        fld = OxmlElement("w:fldSimple")
        fld.set(qn("w:instr"), "PAGE")
        run = OxmlElement("w:r")
        t = OxmlElement("w:t")
        t.text = "1"
        run.append(t)
        fld.append(run)
        footer_p._p.append(fld)
