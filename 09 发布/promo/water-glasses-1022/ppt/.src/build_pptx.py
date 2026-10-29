# -*- coding: utf-8 -*-
"""PPTX 导出 — 上游 build_pptx.py 契约的本地实现:
验证过的整页 PNG → 每页一张满幅图(按 PNG 纵横比), 设 deck 标题,
每页标题写入演讲者备注(可达性最佳努力)。
"""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from pptx import Presentation
from pptx.util import Inches

SRC = Path(__file__).resolve().parent
VAL = SRC / "validate"
OUT = SRC.parent / "水利安全AI眼镜-产品宣传PPT.pptx"

manifest = json.loads((SRC / "slides" / "deck.json").read_text(encoding="utf-8"))

prs = Presentation()
prs.core_properties.title = manifest["main_title"]
prs.core_properties.author = "总包创研院"

for i, s in enumerate(manifest["slides"]):
    png = VAL / f"page-{i + 1:02d}.png"
    assert png.exists(), f"missing {png}"
    slide = prs.slides.add_slide(prs.slide_layouts[6])  # blank
    slide.shapes.add_picture(str(png), 0, 0, width=Inches(13.333), height=Inches(7.5))
    # 演讲者备注: 页面标题(从源文件抓第一个 slide-title / cover-title)
    src = (SRC / "slides" / f"{s['id']}.html").read_text(encoding="utf-8")
    import re
    m = re.search(r'class="(?:slide-title|cover-title)"[^>]*>([^<]+)<', src)
    title = (m.group(1).strip() if m else s["id"]).replace("<br>", " ")
    notes = slide.notes_slide.notes_text_frame
    notes.text = f"{i + 1:02d} · {title}"

prs.save(str(OUT))
print("pptx saved:", OUT, f"({OUT.stat().st_size // 1024} KB, {len(manifest['slides'])} slides)")
