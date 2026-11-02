# -*- coding: utf-8 -*-
"""FOMI-EPC 素材整备: 01-04 目录 docx/pptx 文本抽取 + PDF 页数/文本层/TOC 盘点.
产物: 05 Super-Skill工作区/extracted/*.txt + manifest.json
用法: py -X utf8 extract_docs.py [docx|pptx|pdf|all]
"""
import json
import sys
from pathlib import Path

import fitz  # pymupdf
from docx import Document
from pptx import Presentation

ROOT = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划")
OUT = ROOT / "05 Super-Skill工作区" / "extracted"
OUT.mkdir(parents=True, exist_ok=True)
MANIFEST = OUT / "manifest.json"

which = sys.argv[1] if len(sys.argv) > 1 else "all"
rows = []


def load_manifest():
    if MANIFEST.is_file():
        try:
            return json.loads(MANIFEST.read_text(encoding="utf-8"))
        except Exception:
            return []
    return []


def save_manifest():
    MANIFEST.write_text(json.dumps(rows, ensure_ascii=False, indent=1),
                        encoding="utf-8")


def dump(name: str, text: str) -> str:
    p = OUT / (name + ".txt")
    p.write_text(text, encoding="utf-8")
    return str(p)


def do_docx():
    for p in sorted(ROOT.rglob("*.docx")):
        if "05 Super-Skill" in str(p) or p.name.startswith("~$"):
            continue
        try:
            d = Document(str(p))
            parts = ["# DOCX: %s" % p.name]
            for para in d.paragraphs:
                t = para.text.strip()
                if t:
                    parts.append(t)
            for i, tbl in enumerate(d.tables, 1):
                parts.append("[TABLE %d]" % i)
                for row in tbl.rows:
                    cells = [c.text.strip().replace("\n", " ") for c in row.cells]
                    if any(cells):
                        parts.append(" | ".join(cells))
            text = "\n".join(parts)
            out = dump(p.stem, text)
            rows.append({"file": str(p.relative_to(ROOT)), "type": "docx",
                         "chars": len(text), "out": out})
        except Exception as e:
            rows.append({"file": str(p.relative_to(ROOT)), "type": "docx",
                         "error": repr(e)[:200]})


def do_pptx():
    for p in sorted(ROOT.rglob("*.pptx")):
        try:
            prs = Presentation(str(p))
            parts = ["# PPTX: %s slides=%d" % (p.name, len(prs.slides))]
            for idx, slide in enumerate(prs.slides, 1):
                parts.append("\n===== Slide %d =====" % idx)
                for shape in slide.shapes:
                    try:
                        if shape.has_text_frame:
                            for para in shape.text_frame.paragraphs:
                                t = "".join(r.text for r in para.runs).strip()
                                if t:
                                    parts.append(t)
                        if getattr(shape, "has_table", False):
                            for row in shape.table.rows:
                                parts.append(" | ".join(
                                    c.text.strip() for c in row.cells))
                    except Exception:
                        continue
                try:
                    if slide.has_notes_slide and slide.notes_slide.notes_text_frame:
                        nt = slide.notes_slide.notes_text_frame.text.strip()
                        if nt:
                            parts.append("[NOTES] " + nt[:800])
                except Exception:
                    pass
            text = "\n".join(parts)
            out = dump(p.stem, text)
            rows.append({"file": str(p.relative_to(ROOT)), "type": "pptx",
                         "chars": len(text), "slides": len(prs.slides),
                         "out": out})
        except Exception as e:
            rows.append({"file": str(p.relative_to(ROOT)), "type": "pptx",
                         "error": repr(e)[:200]})


def do_pdf():
    for p in sorted(ROOT.rglob("*.pdf")):
        try:
            doc = fitz.open(str(p))
            n = len(doc)
            sample = sum(len(doc[i].get_text().strip()) for i in range(min(n, 30)))
            toc = doc.get_toc()
            toc_lines = ["%s%s ... p%d" % ("  " * (lv - 1), t, pg)
                         for lv, t, pg in toc[:120]]
            meta_txt = ("# PDF: %s\npages=%d\nsample_text_chars(first30)=%d\n"
                        "toc_entries=%d\n\n## TOC(bookmarks)\n%s"
                        % (p.name, n, sample, len(toc), "\n".join(toc_lines)))
            out = dump(p.stem + "__meta", meta_txt)
            row = {"file": str(p.relative_to(ROOT)), "type": "pdf", "pages": n,
                   "sample_chars": sample, "toc_entries": len(toc), "out": out}
            if sample >= 3000 and n <= 900:      # 文本层可用 → 全文转储供精读
                full = []
                for i in range(n):
                    full.append("\n<<<PAGE %d>>>\n%s" % (i + 1, doc[i].get_text()))
                ftext = "".join(full)
                fout = dump(p.stem + "__fulltext", ftext)
                row["fulltext"] = fout
                row["fulltext_chars"] = len(ftext)
            rows.append(row)
            doc.close()
        except Exception as e:
            rows.append({"file": str(p.relative_to(ROOT)), "type": "pdf",
                         "error": repr(e)[:200]})


rows = load_manifest()
seen = {r.get("file") for r in rows}
if which in ("docx", "all"):
    do_docx()
if which in ("pptx", "all"):
    do_pptx()
if which in ("pdf", "all"):
    do_pdf()
save_manifest()
print(json.dumps(rows, ensure_ascii=False, indent=1))
