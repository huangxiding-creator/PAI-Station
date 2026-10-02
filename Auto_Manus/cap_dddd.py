# -*- coding: utf-8 -*-
"""ddddocr 点选验证码一条龙 — det 定位字块 + 分类认字 + 目标序匹配.

用法: python cap_dddd.py <img.jpg> <目标字逗串如:操,娩,朵,购>
输出: 每块坐标+识别字, 以及按目标序排列的点击坐标 JSON.
"""
import sys
import json
import io

from PIL import Image
import ddddocr

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

IMG = sys.argv[1]
TARGETS = [c for c in sys.argv[2].replace("，", ",").split(",") if c.strip()]

img = Image.open(IMG).convert("RGB")
buf = io.BytesIO()
img.save(buf, format="PNG")

det = ddddocr.DdddOcr(det=True, show_ad=False)
bboxes = det.detection(open(IMG, "rb").read())
print(f"[det] {len(bboxes)} boxes")

cls = ddddocr.DdddOcr(show_ad=False)

results = []
for i, bb in enumerate(bboxes):
    x1, y1, x2, y2 = bb
    pad = 2
    crop = img.crop((max(0, x1 - pad), max(0, y1 - pad),
                     min(img.width, x2 + pad), min(img.height, y2 + pad)))
    up = crop.resize((crop.width * 4, crop.height * 4), Image.LANCZOS)
    b2 = io.BytesIO()
    up.save(b2, format="PNG")
    ch = cls.classification(b2.getvalue())
    cx, cy = (x1 + x2) // 2, (y1 + y2) // 2
    results.append({"i": i, "cx": cx, "cy": cy, "w": x2 - x1, "h": y2 - y1, "ch": ch})
    print(f"  #{i} ({cx},{cy}) {x2-x1}x{y2-y1} -> {ch!r}")

# 按指令序输出命中坐标 (识别串包含目标字 → 该块; 未命中目标报缺口)
pick = []
for t in TARGETS:
    hit = next((r for r in results if t in r["ch"] or r["ch"] in t), None)
    if hit:
        pick.append({"char": t, "cx": hit["cx"], "cy": hit["cy"], "raw": hit["ch"]})
    else:
        pick.append({"char": t, "miss": True})
print("[pick]", json.dumps(pick, ensure_ascii=False))
