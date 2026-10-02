# -*- coding: utf-8 -*-
"""搜狗点选验证码自动解题周期 — 第1步: 取图+候选字块定位.

用法: python cap_cycle.py <img_b64_file> <targets如:操,娩,朵,购>
输出: cap_chars/NN.png (x5放大候选块) + cap_cycle.json (块元数据+闭集提示词)
"""
import sys
from pathlib import Path

import cv2
import numpy as np
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

b64_file, targets = sys.argv[1], sys.argv[2].split(",")
OUT = Path("cap_chars")
OUT.mkdir(exist_ok=True)
for f in OUT.glob("*.png"):
    f.unlink()

import base64
raw = Path(b64_file).read_text().strip()
if "," in raw[:200]:
    raw = raw.split(",", 1)[1]
img = Image.open(__import__("io").BytesIO(base64.b64decode(raw))).convert("RGB")
img.save("cap_now.jpg")
W, H = img.size
arr = np.asarray(img)[:, :, ::-1].copy()  # BGR
hsv = cv2.cvtColor(arr, cv2.COLOR_BGR2HSV)
Hh, S = hsv[:, :, 0].astype(int), hsv[:, :, 1].astype(int)

# ---- 色族掩码并集 (字色 vs 底色 H30-49) ----
bands = {"红": (0, 10), "橙": (11, 29), "青蓝": (76, 129), "紫红": (130, 165)}
mask = np.zeros((H, W), bool)
for lo, hi in bands.values():
    mask |= (S > 55) & (Hh >= lo) & (Hh <= hi)

# 亮黄 (45-50 但避开底色): 须高饱和
mask |= (S > 110) & (Hh >= 45) & (Hh <= 52)

boxes = []
for band_name, (lo, hi) in list(bands.items()) + [("亮黄", (45, 52))]:
    m = (S > (110 if band_name == "亮黄" else 55)) & (Hh >= lo) & (Hh <= hi)
    m = cv2.dilate(m.astype(np.uint8), cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (7, 7)), 1)
    n, _, stats, _ = cv2.connectedComponentsWithStats(m, 8)
    for i in range(1, n):
        x, y, w, h, a = stats[i]
        if 16 <= w <= 80 and 16 <= h <= 80 and a >= 120:
            boxes.append({"x": int(x), "y": int(y), "w": int(w), "h": int(h),
                          "src": band_name, "area": int(a)})

# ---- 重叠合并 (IoU>0.15 或中心距<15px → 同块) ----
merged = []
for b in sorted(boxes, key=lambda b: -b["area"]):
    cx, cy = b["x"] + b["w"] / 2, b["y"] + b["h"] / 2
    hit = False
    for m in merged:
        mx, my = m["x"] + m["w"] / 2, m["y"] + m["h"] / 2
        if abs(cx - mx) < 16 and abs(cy - my) < 16:
            hit = True
            m["src"] += "+" + b["src"]
            x0, y0 = min(m["x"], b["x"]), min(m["y"], b["y"])
            x1 = max(m["x"] + m["w"], b["x"] + b["w"])
            y1 = max(m["y"] + m["h"], b["y"] + b["h"])
            m.update({"x": x0, "y": y0, "w": x1 - x0, "h": y1 - y0})
            break
    if not hit:
        merged.append(dict(b))

# ---- Canny 边缘簇兜底 (融入底色的字) ----
gray = cv2.cvtColor(arr, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(cv2.GaussianBlur(gray, (3, 3), 0), 40, 110)
edges = cv2.dilate(edges, cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5)), 1)
n, _, stats, _ = cv2.connectedComponentsWithStats(edges, 8)
for i in range(1, n):
    x, y, w, h, a = stats[i]
    if 16 <= w <= 80 and 16 <= h <= 80 and a >= 100:
        cx, cy = x + w / 2, y + h / 2
        if not any(abs(cx - (m["x"] + m["w"] / 2)) < 25 and abs(cy - (m["y"] + m["h"] / 2)) < 25 for m in merged):
            merged.append({"x": int(x), "y": int(y), "w": int(w), "h": int(h),
                           "src": "edge", "area": int(a)})

# 阅读序排序
merged.sort(key=lambda m: (m["y"] // 60, m["x"]))

# ---- 裁片 x5 ----
meta = []
for i, b in enumerate(merged):
    pad = 6
    c = img.crop((max(0, b["x"] - pad), max(0, b["y"] - pad),
                  min(W, b["x"] + b["w"] + pad), min(H, b["y"] + b["h"] + pad)))
    c = c.resize((c.width * 5, c.height * 5), Image.LANCZOS)
    c.save(OUT / f"{i:02d}.png")
    meta.append({"id": i, "cx": int(b["x"] + b["w"] / 2), "cy": int(b["y"] + b["h"] / 2),
                 "bbox": [b["x"], b["y"], b["w"], b["h"]], "src": b["src"], "area": b["area"]})

import json
Path("cap_cycle.json").write_text(json.dumps(
    {"img": "cap_now.jpg", "size": [W, H], "targets": targets, "blocks": meta},
    ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[cycle] {W}x{H} blocks={len(meta)} targets={targets}")
for m in meta:
    print(f"  #{m['id']} ({m['cx']},{m['cy']}) {m['src']} {m['area']}px")
