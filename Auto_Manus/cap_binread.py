# -*- coding: utf-8 -*-
"""点选验证码认字 v3 — 色掩码二值化成实心字形, 双引擎认字:
  A) ddddocr 分类器 (训练分布=实心验证码字, 二值字形远比渐变原图贴近)
  B) 系统字体模板 IoU (干净二值 vs 模板, 比噪声色掩码 v2 可靠)
用法: python cap_binread.py <img.jpg> <目标字逗串>
"""
import sys
import io
import json
from pathlib import Path

import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

IMG = sys.argv[1]
TARGETS = [c for c in sys.argv[2].replace("，", ",").split(",") if c.strip()]

import ddddocr

arr = cv2.imread(IMG)
H, W = arr.shape[:2]
hsv = cv2.cvtColor(arr, cv2.COLOR_BGR2HSV)
Hh, S = hsv[:, :, 0].astype(int), hsv[:, :, 1].astype(int)

# ---- 全字掩码: 任何饱和色但排除底色黄带 H30-49 ----
charmask = ((S > 60) & ((Hh < 26) | (Hh > 54))).astype(np.uint8)

# ---- 候选块: 全掩码连通域, 字号过滤 ----
d = cv2.dilate(charmask, cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5)), 1)
cn, _, stats, _ = cv2.connectedComponentsWithStats(d, 8)
blocks = []
for i in range(1, cn):
    x, y, w, h, a = stats[i]
    if 20 <= w <= 70 and 22 <= h <= 70 and a >= 180:
        blocks.append((int(x), int(y), int(w), int(h)))
blocks.sort(key=lambda b: (b[1] // 60, b[0]))
print(f"[binread] {W}x{H} blocks={len(blocks)}")

# ---- 每块: bbox内掩码 → 紧致二值字形 → 双引擎 ----
SIZE = 64
cls = ddddocr.DdddOcr(show_ad=False)

FONTS = [r"C:\Windows\Fonts\simkai.ttf", r"C:\Windows\Fonts\msyh.ttc",
         r"C:\Windows\Fonts\simhei.ttf", r"C:\Windows\Fonts\simsun.ttc",
         r"C:\Windows\Fonts\simfang.ttf"]
ROTS = (-12, -9, -6, -3, 0, 3, 6, 9, 12)


def binarize_block(bx, by, bw, bh):
    """块 bbox 内 charmask 紧致化 → 白底黑字 SIZE×SIZE."""
    pad = 3
    x1, y1 = max(0, bx - pad), max(0, by - pad)
    x2, y2 = min(W, bx + bw + pad), min(H, by + bh + pad)
    patch = charmask[y1:y2, x1:x2]
    # 腐蚀1px去毛刺再膨胀回, 平滑边缘
    k = np.ones((3, 3), np.uint8)
    patch = cv2.morphologyEx(patch, cv2.MORPH_OPEN, k)
    ys, xs = np.nonzero(patch)
    if len(ys) < 60:
        return None, None
    patch = patch[ys.min():ys.max() + 1, xs.min():xs.max() + 1]
    ph, pw = patch.shape
    side = max(ph, pw)
    canvas = np.zeros((side + 12, side + 12), np.uint8)
    canvas[6:6 + ph, 6 + (side - pw) // 2:6 + (side - pw) // 2 + pw] = patch
    im = Image.fromarray((255 - canvas * 255).astype(np.uint8))  # 白底黑字
    im = im.resize((SIZE, SIZE), Image.LANCZOS)
    binmask = np.asarray(im) < 128
    return im, binmask


_TPL = {}


def tpl(ch, fp, rot):
    key = (ch, fp, rot)
    if key in _TPL:
        return _TPL[key]
    f = ImageFont.truetype(fp, SIZE - 10)
    t = Image.new("L", (SIZE * 2, SIZE * 2), 255)
    ImageDraw.Draw(t).text((SIZE // 2, SIZE // 2), ch, fill=0, font=f)
    if rot:
        t = t.rotate(rot, resample=Image.BICUBIC, fillcolor=255)
    a = np.asarray(t) < 128
    ys, xs = np.nonzero(a)
    a = a[ys.min():ys.max() + 1, xs.min():xs.max() + 1]
    ph, pw = a.shape
    side = max(ph, pw)
    c = np.zeros((side + 12, side + 12), bool)
    c[6:6 + ph, 6 + (side - pw) // 2:6 + (side - pw) // 2 + pw] = a
    t2 = Image.fromarray((~c * 255).astype(np.uint8)).resize((SIZE, SIZE), Image.LANCZOS)
    m = np.asarray(t2) < 128
    _TPL[key] = m
    return m


def iou(a, b):
    return (a & b).sum() / max(1, (a | b).sum())


results = []
for bi, (bx, by, bw, bh) in enumerate(blocks):
    im, binmask = binarize_block(bx, by, bw, bh)
    if im is None:
        continue
    b2 = io.BytesIO()
    im.save(b2, format="PNG")
    ch = cls.classification(b2.getvalue())
    # 模板 IoU: 目标字 + 干扰判定基准
    tScores = {}
    for t in TARGETS:
        best = 0.0
        for fp in FONTS:
            if not Path(fp).exists():
                continue
            for rot in ROTS:
                best = max(best, iou(binmask, tpl(t, fp, rot)))
        tScores[t] = round(best, 3)
    cx, cy = bx + bw // 2, by + bh // 2
    results.append({"i": bi, "cx": cx, "cy": cy, "ddddocr": ch, "tpl": tScores})
    im.save(f"cap_bin_{bi}.png")
    top = max(tScores, key=tScores.get)
    print(f"  #{bi} ({cx},{cy}) {bw}x{bh} ddddocr={ch!r} tpl_best={top}:{tScores[top]} all={tScores}")

print("[binread]", json.dumps(results, ensure_ascii=False))
