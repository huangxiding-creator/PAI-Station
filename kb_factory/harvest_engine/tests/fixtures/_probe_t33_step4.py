# -*- coding: utf-8 -*-
"""T33 取样探针④：合成中文页验收链实测（离线用例 GT 誊录定稿依据，零网络）。

合成页=PIL+simhei 画「页眉标题+正文两行」（792×1120 白底黑字，同 book118 页几何）
→build_image_pdf→make_pdf_ocr_searchable→pypdfium2 抽文字层 dump。
"""
import re
import sys
from pathlib import Path

_FIX = Path(__file__).resolve().parent
sys.path.insert(0, str(_FIX.parents[3]))
sys.path.insert(1, str(_FIX.parents[2]))

import pypdfium2 as pdfium  # noqa: E402
from PIL import Image, ImageDraw, ImageFont  # noqa: E402

from harvest_engine.adapters.book118 import make_pdf_ocr_searchable  # type: ignore
from harvest_engine.pdf.image_pdf import build_image_pdf  # type: ignore

W = _FIX / "book118_gt_pages" / "_chain_probe" / "synthetic"
W.mkdir(parents=True, exist_ok=True)

HEADER = "某培训学院教学督导制度"
BODY1 = "教学督导委员会负责全院教学质量的检查与评估"
BODY2 = "督导检查记录按学期归档并定期通报"

im = Image.new("RGB", (792, 1120), (255, 255, 255))
d = ImageDraw.Draw(im)
f_head = ImageFont.truetype(r"C:\Windows\Fonts\simhei.ttf", 28)
f_title = ImageFont.truetype(r"C:\Windows\Fonts\simhei.ttf", 44)
f_body = ImageFont.truetype(r"C:\Windows\Fonts\simhei.ttf", 30)
d.text((396, 120), HEADER, font=f_head, fill=(80, 80, 80), anchor="ma")
d.text((396, 260), "教学督导工作实施细则", font=f_title, fill=(0, 0, 0), anchor="ma")
d.text((90, 420), BODY1 + "。", font=f_body, fill=(0, 0, 0))
d.text((90, 470), BODY2 + "。", font=f_body, fill=(0, 0, 0))
img = W / "synthetic_page.png"
im.save(img)

pdf = build_image_pdf([img], W / "synthetic.pdf")
stats = make_pdf_ocr_searchable(pdf, W / "synthetic_ocr.pdf")
with pdfium.PdfDocument(str(W / "synthetic_ocr.pdf")) as doc:
    layer = "".join(p.get_textpage().get_text_range() for p in doc)
print("chars=", stats.chars, "lines=", stats.lines)
print("RAW:", repr(layer))
print("NORM:", re.sub(r"\s+", "", layer))
