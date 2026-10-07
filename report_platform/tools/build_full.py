# -*- coding: utf-8 -*-
"""build_full — 定稿 docx → content/full/{sku}.html 片段 + PDF 就位 (F5a-2).

产出片段供 /api/reader/content 注入 #doc (无 <html> 壳):
  Heading1→h1(章) Heading2→h2(节·反馈锚定粒度) 表格→内联样式 table.
用法: python tools/build_full.py --sku R50-SNEI \
        --docx <定稿.docx> [--pdf <定稿.pdf>]
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]

_TD = "padding:7px 9px;border:1px solid #E7DFD2;font-size:13.5px;vertical-align:top"
_TH = _TD + ";background:#0F2A43;color:#fff;font-weight:600"


def _esc(s: str) -> str:
    return (s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;"))


def docx_to_html(docx: Path) -> str:
    from docx import Document
    from docx.table import Table
    from docx.text.paragraph import Paragraph

    doc = Document(str(docx))
    out: list[str] = []
    for el in doc.element.body.iterchildren():
        tag = el.tag.split("}")[-1]
        if tag == "p":
            p = Paragraph(el, doc)
            txt = p.text.strip()
            if not txt:
                continue
            style = (p.style.name or "").lower()
            bold = txt.startswith("**") and txt.endswith("**")
            body = _esc(txt.strip("*"))
            if "heading 1" in style or style == "title":
                out.append(f"<h1>{body}</h1>")
            elif "heading 2" in style:
                out.append(f"<h2>{body}</h2>")
            elif "heading 3" in style or bold:
                out.append(f"<p><strong>{body}</strong></p>")
            else:
                out.append(f"<p>{body}</p>")
        elif tag == "tbl":
            t = Table(el, doc)
            rows = t.rows
            if not rows:
                continue
            buf = ['<table style="border-collapse:collapse;margin:14px 0;'
                   'width:100%;table-layout:fixed">']
            for ri, row in enumerate(rows):
                buf.append("<tr>")
                for cell in row.cells:
                    txt = _esc(" ".join(
                        pp.text.strip() for pp in cell.paragraphs
                        if pp.text.strip())[:200])
                    buf.append(f"<td style=\"{_TH if ri == 0 else _TD}\">"
                               f"{txt or ' '}</td>")
                buf.append("</tr>")
            buf.append("</table>")
            out.append("".join(buf))
    return "\n".join(out)


def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="定稿 docx→全文 html+pdf 就位")
    ap.add_argument("--sku", required=True)
    ap.add_argument("--docx", required=True)
    ap.add_argument("--pdf", default="")
    ns = ap.parse_args(argv)
    full = ROOT / "content" / "full"
    full.mkdir(parents=True, exist_ok=True)
    html = docx_to_html(Path(ns.docx))
    (full / f"{ns.sku}.html").write_text(html, encoding="utf-8")
    h2n = len(re.findall(r"<h2>", html))
    if ns.pdf:
        import shutil
        shutil.copyfile(ns.pdf, full / f"{ns.sku}.pdf")
    print(f"[full] {ns.sku}: {len(html)} chars html, {h2n} h2 锚点, "
          f"pdf={'✓' if ns.pdf else '—'}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
