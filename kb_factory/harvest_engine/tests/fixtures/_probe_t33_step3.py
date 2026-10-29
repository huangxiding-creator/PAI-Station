# -*- coding: utf-8 -*-
"""T33 取样探针③：三份 GT 首页图走验收同链 dump 文字层（誊录定稿依据）。

链=缓存首页图→build_image_pdf（像素拼 1 页）→make_pdf_ocr_searchable（T33 钩子，150dpi
重采样+空行过滤）→pypdfium2 get_text_range 抽文字层。GT 誊录以本链实测文字层为准，
交叉对照探针②原图 ocr_image 行集人工确认词真实可见（容错=0 的可复现前提=同链同引擎）。
"""
import json
import re
import sys
from pathlib import Path

_FIX = Path(__file__).resolve().parent
sys.path.insert(0, str(_FIX.parents[3]))
sys.path.insert(1, str(_FIX.parents[2]))

import pypdfium2 as pdfium  # noqa: E402

from harvest_engine.adapters.book118 import make_pdf_ocr_searchable  # type: ignore
from harvest_engine.pdf.image_pdf import build_image_pdf  # type: ignore

ROOT = _FIX / "book118_gt_pages"
WORK = ROOT / "_chain_probe"


def text_layer(pdf_path: Path) -> str:
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        return "".join(p.get_textpage().get_text_range() for p in doc)


out = {}
for doc_dir in sorted(p for p in ROOT.iterdir() if p.is_dir()):
    img_path = next(doc_dir.glob("0001.*"))
    w = WORK / doc_dir.name
    w.mkdir(parents=True, exist_ok=True)
    image_pdf = build_image_pdf([img_path], w / "page1.pdf")
    stats = make_pdf_ocr_searchable(image_pdf, w / "page1_ocr.pdf")
    layer = text_layer(w / "page1_ocr.pdf")
    out[doc_dir.name] = {"chars": stats.chars, "lines": stats.lines,
                         "per_page": stats.per_page, "text_layer": layer}
    print(f"===== {doc_dir.name} chars={stats.chars} lines={stats.lines}")
    print("RAW:", repr(layer[:400]))
    print("NORM:", re.sub(r'\s+', '', layer)[:400])

(WORK / "_chain_layers.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print("dumped ->", WORK / "_chain_layers.json")
