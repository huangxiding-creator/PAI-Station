# -*- coding: utf-8 -*-
"""验证码分割 — 局部对比度自适应二值化 + 粘连块投影切分 + 裁剪落盘.

背景=平滑渐变(蓝系), 字=短笔画高频 → dark = g < blur(g) - delta.
切分后每字块存 cap_chars/NN.png (8x 放大), 供 OCR/模板匹配双验证.
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageFilter

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

IMG = sys.argv[1] if len(sys.argv) > 1 else "cap_sogou.jpg"
OUT = Path("cap_chars")
DELTA = 14          # 局部对比差: 字须比邻域背景暗 14 灰阶以上
BLUR = 9            # 背景估计半径 (>笔画宽度)
MIN_BOX = 15        # 最小字块边长

img = Image.open(IMG).convert("L")
W, H = img.size
g = np.asarray(img, dtype=np.int16)
bg = np.asarray(img.filter(ImageFilter.GaussianBlur(BLUR)), dtype=np.int16)
dark = (g < bg - DELTA)

# ---- 连通域 (8邻接) ----
seen = np.zeros_like(dark, dtype=bool)
raw_boxes = []
ys, xs = np.nonzero(dark)
for i in np.lexsort((xs, ys)):
    y0, x0 = int(ys[i]), int(xs[i])
    if seen[y0, x0]:
        continue
    stack = [(y0, x0)]
    seen[y0, x0] = True
    minx = maxx = x0
    miny = maxy = y0
    pts = []
    while stack:
        y, x = stack.pop()
        pts.append((y, x))
        if x < minx: minx = x
        if x > maxx: maxx = x
        if y < miny: miny = y
        if y > maxy: maxy = y
        for dy in (-1, 0, 1):
            for dx in (-1, 0, 1):
                ny, nx = y + dy, x + dx
                if 0 <= ny < H and 0 <= nx < W and dark[ny, nx] and not seen[ny, nx]:
                    seen[ny, nx] = True
                    stack.append((ny, nx))
    raw_boxes.append((minx, miny, maxx - minx + 1, maxy - miny + 1, pts))

# ---- 字块过滤 + 粘连切分 (宽>1.6×高 → 垂直投影谷切) ----
boxes = []
for minx, miny, w, h, pts in raw_boxes:
    if w < MIN_BOX or h < MIN_BOX or len(pts) < 60:
        continue
    if w <= h * 1.6:
        boxes.append((minx, miny, w, h))
        continue
    # 投影谷切分
    proj = np.zeros(w, dtype=int)
    for (y, x) in pts:
        proj[x - minx] += 1
    splits, blank = [0], 2
    for i in range(1, w - 1):
        if proj[i] <= blank and proj[i - 1] > blank:
            splits.append(i)
    splits.append(w)
    segs = []
    for a, b in zip(splits[:-1], splits[1:]):
        col = proj[a:b]
        if col.sum() < 60 or (b - a) < MIN_BOX:
            continue
        sub = [(y, x) for (y, x) in pts if a <= x - minx < b]
        ys_ = [p[0] for p in sub]
        xs_ = [p[1] for p in sub]
        segs.append((minx + min(xs_), miny + min(ys_),
                     max(xs_) - min(xs_) + 1, max(ys_) - min(ys_) + 1))
    boxes.extend(segs if segs else [(minx, miny, w, h)])

OUT.mkdir(exist_ok=True)
for f in OUT.glob("*.png"):
    f.unlink()
meta = []
for i, (bx, by, bw, bh) in enumerate(boxes):
    pad = 4
    crop = img.crop((max(0, bx - pad), max(0, by - pad),
                     min(W, bx + bw + pad), min(H, by + bh + pad)))
    s = 8
    crop = crop.resize((crop.width * s, crop.height * s), Image.LANCZOS)
    crop.save(OUT / f"{i:02d}.png")
    meta.append({"id": i, "x": int(bx), "y": int(by), "w": int(bw), "h": int(bh),
                 "cx": int(bx + bw / 2), "cy": int(by + bh / 2)})
    print(f"  块#{i} bbox=({bx},{by},{bw}x{bh}) center=({int(bx+bw/2)},{int(by+bh/2)}) → {OUT}/{i:02d}.png")

import json
Path("cap_seg.json").write_text(json.dumps(meta, ensure_ascii=False, indent=1),
                                encoding="utf-8")
print(f"[seg] {len(boxes)} 块 → {OUT}/ + cap_seg.json")
