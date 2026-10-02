# -*- coding: utf-8 -*-
"""点选验证码字定位 — 系统字体模板匹配 (全确定性, 零网络零OCR).

原理: 目标字已知 (指令文本自含), 无需识别图上每个字 — 只需在候选字块里
找出与「字体渲染的目标字模板」最匹配的块. 蓝底深蓝字, 灰度阈值分离,
连通域切块, 48x48 归一 + 模板多字体多旋转穷举, IoU 择优.
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFont

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

IMG = sys.argv[1] if len(sys.argv) > 1 else "cap_sogou.jpg"
TARGETS = sys.argv[2:] or ["邵", "帝", "滦", "拦"]

THR = 110          # 灰度阈值: 字色(深蓝) vs 背景(浅蓝)
SIZE = 48          # 归一化边长
FONTS = [          # Windows 系统字体 (验证码常用楷/黑/雅黑系)
    r"C:\Windows\Fonts\simkai.ttf",
    r"C:\Windows\Fonts\msyh.ttc",
    r"C:\Windows\Fonts\simhei.ttf",
    r"C:\Windows\Fonts\simsun.ttc",
    r"C:\Windows\Fonts\simfang.ttf",
]

img = Image.open(IMG).convert("L")
W, H = img.size
g = np.asarray(img, dtype=np.uint8)
dark = g < THR

# ---- 连通域 (8邻接, numpy 洪泛) ----
seen = np.zeros_like(dark, dtype=bool)
boxes = []
idx = np.argwhere(dark)
ys, xs = idx[:, 0], idx[:, 1]
order = np.lexsort((xs, ys))
for i in order:
    y0, x0 = ys[i], xs[i]
    if seen[y0, x0]:
        continue
    stack = [(y0, x0)]
    seen[y0, x0] = True
    minx = maxx = x0
    miny = maxy = y0
    n = 0
    while stack:
        y, x = stack.pop()
        n += 1
        if x < minx: minx = x
        if x > maxx: maxx = x
        if y < miny: miny = y
        if y > maxy: maxy = y
        for dy in (-1, 0, 1):
            for dx in (-1, 0, 1):
                ny, nx = y + dy, x + dx
                if (0 <= ny < H and 0 <= nx < W and dark[ny, nx]
                        and not seen[ny, nx]):
                    seen[ny, nx] = True
                    stack.append((ny, nx))
    w, h = maxx - minx + 1, maxy - miny + 1
    if 16 <= w <= 60 and 16 <= h <= 60 and n >= 60:
        boxes.append((minx, miny, w, h))

print(f"[match] size={W}x{H} thr={THR} 候选字块={len(boxes)}")


def norm_patch(bx, by, bw, bh) -> np.ndarray:
    """字块 → 紧致裁剪 → SIZE×SIZE 二值 (1=字)."""
    patch = dark[by:by + bh, bx:bx + bw]
    ys_, xs_ = np.nonzero(patch)
    p = patch[ys_.min():ys_.max() + 1, xs_.min():xs_.max() + 1]
    im = Image.fromarray((p * 255).astype(np.uint8))
    im = im.resize((SIZE, SIZE), Image.LANCZOS)
    return np.asarray(im) > 127


def render_tpl(ch: str, fontpath: str, rot: int) -> np.ndarray:
    """目标字模板 → SIZE×SIZE 二值 (带旋转)."""
    f = ImageFont.truetype(fontpath, SIZE - 8)
    im = Image.new("L", (SIZE * 2, SIZE * 2), 0)
    d = ImageDraw.Draw(im)
    d.text((SIZE // 2, SIZE // 2), ch, fill=255, font=f)
    if rot:
        im = im.rotate(rot, resample=Image.BICUBIC)
    a = np.asarray(im) > 127
    ys_, xs_ = np.nonzero(a)
    a = a[ys_.min():ys_.max() + 1, xs_.min():xs_.max() + 1]
    im2 = Image.fromarray((a * 255).astype(np.uint8)).resize(
        (SIZE, SIZE), Image.LANCZOS)
    return np.asarray(im2) > 127


def iou(a: np.ndarray, b: np.ndarray) -> float:
    return (a & b).sum() / max(1, (a | b).sum())


patches = [norm_patch(*b) for b in boxes]
tpls = {}
for ch in TARGETS:
    best = []
    for fp in FONTS:
        if not Path(fp).exists():
            continue
        for rot in (-15, -10, -5, 0, 5, 10, 15):
            t = render_tpl(ch, fp, rot)
            best.append((iou(patches[0], t), t))  # 占位, 用全 patch 评
    tpls[ch] = best

# 全局打分: 每目标字 × 每字块 × 每模板, IoU 最大者胜 (一字块只许配一字)
scores = []
for ch in TARGETS:
    for bi, p in enumerate(patches):
        for _, t in tpls[ch]:
            scores.append((iou(p, t), ch, bi))

scores.sort(reverse=True)
used_box, used_ch, result = set(), set(), []
for s, ch, bi in scores:
    if ch in used_ch or bi in used_box:
        continue
    used_ch.add(ch)
    used_box.add(bi)
    bx, by, bw, bh = boxes[bi]
    result.append({"char": ch, "cx": bx + bw // 2, "cy": by + bh // 2,
                   "iou": round(float(s), 3)})
    print(f"  {ch} ← 块#{bi} bbox={boxes[bi]} IoU={s:.3f}")

print("\n" + __import__("json").dumps(result, ensure_ascii=False))
