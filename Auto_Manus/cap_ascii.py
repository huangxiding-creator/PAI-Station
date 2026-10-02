# -*- coding: utf-8 -*-
"""验证码字块定位 — 二值化+连通域, 渲染 ASCII art 供人工(模型)读字.
输入: 图片路径  输出: 每个字块的 bbox + ASCII 渲染.
"""
import sys
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

IMG = sys.argv[1] if len(sys.argv) > 1 else "cap_sogou.jpg"
COLS = int(sys.argv[2]) if len(sys.argv) > 2 else 22   # 每块渲染列数

img = Image.open(IMG).convert("L")
W, H = img.size
px = img.load()

# 自适应阈值: 验证码字色深于背景
hist = [0] * 256
for y in range(H):
    for x in range(W):
        hist[px[x, y]] += 1
total = W * H
acc = 0
thr = 128
for v in range(256):
    acc += hist[v]
    if acc >= total * 0.55:      # 55 分位 — 字与背景的谷
        thr = v
        break

dark = [[1 if px[x, y] < thr else 0 for x in range(W)] for y in range(H)]

# 连通域 (4邻接, 迭代洪泛; 图小无妨)
seen = [[0] * W for _ in range(H)]
boxes = []
for y0 in range(H):
    for x0 in range(W):
        if not dark[y0][x0] or seen[y0][x0]:
            continue
        stack = [(x0, y0)]
        seen[y0][x0] = 1
        minx = maxx = x0
        miny = maxy = y0
        n = 0
        while stack:
            x, y = stack.pop()
            n += 1
            minx, maxx = min(minx, x), max(maxx, x)
            miny, maxy = min(miny, y), max(maxy, y)
            for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                nx, ny = x + dx, y + dy
                if 0 <= nx < W and 0 <= ny < H and dark[ny][nx] and not seen[ny][nx]:
                    seen[ny][nx] = 1
                    stack.append((nx, ny))
        boxes.append({"x": minx, "y": miny, "w": maxx - minx + 1,
                      "h": maxy - miny + 1, "n": n})

# 字块过滤: 验证码汉字约 20-50px 宽高, 像素数足够
cand = [b for b in boxes if 14 <= b["w"] <= 70 and 14 <= b["h"] <= 70
        and b["n"] >= 40]
cand.sort(key=lambda b: (b["x"] + b["y"]))   # 粗略阅读序: 左上优先
# 按行聚类再按 x 排 (验证码常两行)
rows = []
for b in sorted(cand, key=lambda b: b["y"]):
    for r in rows:
        if abs(b["y"] - r["y0"]) < 25:
            r["items"].append(b)
            break
    else:
        rows.append({"y0": b["y"], "items": [b]})
ordered = []
for r in sorted(rows, key=lambda r: r["y0"]):
    ordered.extend(sorted(r["items"], key=lambda b: b["x"]))

print(f"size={W}x{H} thr={thr} boxes={len(boxes)} candidates={len(ordered)}\n")
for i, b in enumerate(ordered):
    cx, cy = b["x"] + b["w"] // 2, b["y"] + b["h"] // 2
    print(f"--- #{i} bbox=({b['x']},{b['y']},{b['w']}x{b['h']}) "
          f"center=({cx},{cy}) px={b['n']}")
    step = max(1, b["h"] // COLS)
    for y in range(b["y"], b["y"] + b["h"], step):
        line = "".join(
            "#" if dark[y][x] else "."
            for x in range(b["x"], b["x"] + b["w"], max(1, step // 2)))
        print("  " + line)
    print()
