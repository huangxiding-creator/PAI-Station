# -*- coding: utf-8 -*-
"""官网图片 → 小程序包内图片: 统一缩放宽/高 + JPEG 重压缩 (目标总预算 ≤1MB)."""
from __future__ import annotations

import io
import sys
from pathlib import Path

from PIL import Image

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

SRC = Path(r"E:\AI-Station\website\zongbaoshuo")
DST = Path(r"E:\AI-Station\website\zongbaoshuo-miniprogram\images")
DST.mkdir(parents=True, exist_ok=True)
PAPER = (244, 241, 232)   # #f4f1e8 透明底垫色

# (源文件, 输出名, 最大宽, 最大高, JPEG质量)
JOBS = [
    ("hero_main.png",         "hero.jpg",          900, 1400, 78),
    ("shot-leopard.jpg",      "leopard.jpg",       800, 1000, 74),
    ("shot-factory-ui.jpg",   "factory.jpg",       800, 1000, 74),
    ("shot-aipo.jpg",         "aipo.jpg",          800, 1000, 74),
    ("shot-station.jpg",      "station.jpg",       800, 1000, 74),
    ("glasses-hero.jpg",      "glasses-hero.jpg",  800, 1000, 76),
    ("glasses-principle.jpg", "glasses-how.jpg",   800, 1000, 76),
    ("robot-figure.jpg",      "robot.jpg",         640, 1200, 76),
    ("qrcode-zongbaojun.jpg", "qr-zongbaojun.jpg", 640, 640,  86),
    ("qrcode-brain-mini.png", "qr-brain.jpg",      420, 420,  88),
    ("qrcode-zhiku.png",      "qr-zhiku.jpg",      420, 420,  88),
]


def main() -> int:
    total = 0
    for src_name, out_name, max_w, max_h, q in JOBS:
        src = SRC / src_name
        if not src.exists():
            print(f"[skip] 源缺失: {src_name}")
            continue
        im = Image.open(src)
        if im.mode in ("RGBA", "P", "LA"):
            im = im.convert("RGBA")
            bg = Image.new("RGB", im.size, PAPER)
            bg.paste(im, mask=im.split()[-1])
            im = bg
        elif im.mode != "RGB":
            im = im.convert("RGB")
        im.thumbnail((max_w, max_h), Image.LANCZOS)
        out = DST / out_name
        im.save(out, "JPEG", quality=q, optimize=True, progressive=True)
        kb = out.stat().st_size / 1024
        total += kb
        print(f"[ok] {out_name:<20} {im.size[0]}x{im.size[1]}  {kb:7.1f} KB  (源 {src.stat().st_size/1024:.0f} KB)")
    print(f"---- 合计 {total:.1f} KB")
    return 0


if __name__ == "__main__":
    sys.exit(main())
