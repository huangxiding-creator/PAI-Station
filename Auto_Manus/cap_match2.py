# -*- coding: utf-8 -*-
"""点选验证码字定位 v2 — 色族掩码二值化 + 系统字体模板 IoU 匹配.

区别于 v1 (灰度阈值): 用 HSV 色族掩码把渐变彩字转二值块, 抗纹理背景.
每块 × 目标字 × 字体 × 旋转 全穷举, IoU 贪心分配 + margin 置信.
用法: python cap_match2.py <img.jpg> <目标字逗串> [--debug]
"""
import sys
import json
from pathlib import Path

import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

IMG = sys.argv[1]
TARGETS = [c for c in sys.argv[2].replace("，", ",").split(",") if c.strip()]
DEBUG = "--debug" in sys.argv

SIZE = 48
FONTS = [
    r"C:\Windows\Fonts\simkai.ttf",
    r"C:\Windows\Fonts\msyh.ttc",
    r"C:\Windows\Fonts\simhei.ttf",
    r"C:\Windows\Fonts\simsun.ttc",
    r"C:\Windows\Fonts\simfang.ttf",
]
ROTS = (-15, -12, -9, -6, -3, 0, 3, 6, 9, 12, 15)

arr = cv2.imread(IMG)
H, W = arr.shape[:2]
hsv = cv2.cvtColor(arr, cv2.COLOR_BGR2HSV)
Hh, S = hsv[:, :, 0].astype(int), hsv[:, :, 1].astype(int)

# ---- 色族掩码 (与 cap_cycle 一致) ----
bands = {"红": (0, 10), "橙": (11, 29), "青蓝": (76, 129), "紫红": (130, 165)}
charmask = np.zeros((H, W), bool)
for lo, hi in bands.values():
    charmask |= (S > 55) & (Hh >= lo) & (Hh <= hi)
charmask |= (S > 110) & (Hh >= 45) & (Hh <= 52)

# 膨胀连接断笔画
m = cv2.dilate(charmask.astype(np.uint8),
               cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5)), 1)
n, _, stats, _ = cv2.connectedComponentsWithStats(m, 8)
blocks = []
for i in range(1, n):
    x, y, w, h, a = stats[i]
    if 18 <= w <= 70 and 20 <= h <= 70 and a >= 150:
        blocks.append((int(x), int(y), int(w), int(h)))
print(f"[match2] {W}x{H} 候选块={len(blocks)}")

if DEBUG:
    vis = arr.copy()
    for x, y, w, h in blocks:
        cv2.rectangle(vis, (x, y), (x + w, y + h), (0, 0, 255), 1)
    cv2.imwrite("cap_match2_debug.jpg", vis)


def norm_mask(bx, by, bw, bh):
    """块 bbox 内 charmask 紧致裁剪 → SIZE×SIZE 二值."""
    patch = charmask[by:by + bh, bx:bx + bw]
    ys, xs = np.nonzero(patch)
    if len(ys) < 30:
        return None
    p = patch[ys.min():ys.max() + 1, xs.min():xs.max() + 1]
    im = Image.fromarray((p * 255).astype(np.uint8)).resize((SIZE, SIZE), Image.LANCZOS)
    return np.asarray(im) > 127


_TPL = {}


def tpl(ch, fp, rot):
    key = (ch, fp, rot)
    if key in _TPL:
        return _TPL[key]
    f = ImageFont.truetype(fp, SIZE - 8)
    im = Image.new("L", (SIZE * 2, SIZE * 2), 0)
    ImageDraw.Draw(im).text((SIZE // 2, SIZE // 2), ch, fill=255, font=f)
    if rot:
        im = im.rotate(rot, resample=Image.BICUBIC)
    a = np.asarray(im) > 127
    ys, xs = np.nonzero(a)
    a = a[ys.min():ys.max() + 1, xs.min():xs.max() + 1]
    im2 = Image.fromarray((a * 255).astype(np.uint8)).resize((SIZE, SIZE), Image.LANCZOS)
    t = np.asarray(im2) > 127
    _TPL[key] = t
    return t


def iou(a, b):
    return (a & b).sum() / max(1, (a | b).sum())


patches = [(b, norm_mask(*b)) for b in blocks]
patches = [(b, p) for b, p in patches if p is not None]

# ---- 全打分 ----
scores = {}  # (ch, bi) -> best iou over fonts/rots
for bi, (b, p) in enumerate(patches):
    for ch in TARGETS:
        best = 0.0
        for fp in FONTS:
            if not Path(fp).exists():
                continue
            for rot in ROTS:
                v = iou(p, tpl(ch, fp, rot))
                if v > best:
                    best = v
        scores[(ch, bi)] = best

# 每块在闭集内外的区分: 干扰字基准 = 该块对所有非目标模板? 闭集只有目标字,
# 干扰判据 = 该块四个目标字 IoU 全 < 0.22
print("\n[块×字 IoU 矩阵]")
hdr = "  块" + "".join(f"  {ch} " for ch in TARGETS) + " max"
print(hdr)
rows = []
for bi, (b, p) in enumerate(patches):
    vals = [scores[(ch, bi)] for ch in TARGETS]
    rows.append((bi, b, vals))
    print(f" #{bi:02d}({b[0]+b[2]//2:3d},{b[1]+b[3]//2:3d}) " +
          "".join(f"{v:.2f}" for v in vals) + f"  {max(vals):.2f}")

# ---- 贪心分配 (一字一块) ----
flat = sorted(((v, ch, bi) for (ch, bi), v in scores.items()), reverse=True)
used_ch, used_bi, pick = set(), set(), []
for v, ch, bi in flat:
    if ch in used_ch or bi in used_bi or v < 0.15:
        continue
    used_ch.add(ch)
    used_bi.add(bi)
    b = patches[bi][0]
    pick.append({"char": ch, "cx": int(b[0] + b[2] / 2), "cy": int(b[1] + b[3] / 2), "iou": round(v, 3)})

print("\n[pick]")
for p in pick:
    print(f"  {p['char']} @ ({p['cx']},{p['cy']}) iou={p['iou']}")
print(json.dumps(pick, ensure_ascii=False))
