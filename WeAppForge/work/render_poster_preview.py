# -*- coding: utf-8 -*-
"""海报预览渲染（v0.7.0 视觉自检用；假二维码，真码由 wxacode 生成）。"""
import io
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")

from PIL import Image

from qianwen_engine import poster

buf = io.BytesIO()
Image.new("RGB", (60, 60), (20, 20, 20)).save(buf, format="PNG")

png = poster.build(
    "EPC合同里的调差条款被业主删了，结算时还能主张调差款吗？",
    ["结论：调差款仍可主张，删条不等于权利消灭",
     "依据：通用条款调差机制与清单计价规范均有明确机制",
     "操作：结算时同步提交量差证据，走争议评审流程"],
    buf.getvalue(),
    meta={"chars": 2860, "cites": 4},
)
out = Path(r"E:\AI-Station\WeAppForge\work\poster_v070_preview3.png")
out.write_bytes(png)
print("bytes:", len(png), "->", out)
