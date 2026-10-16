# -*- coding: utf-8 -*-
"""接触条带: 两片各抽 8.5-14.0s 八帧横拼, 一次看懂页面序列与 highlight 落点."""
import sys
from pathlib import Path

import imageio.v3 as iio
from PIL import Image, ImageDraw

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
BASE = Path(r"E:\AI-Station\report_platform\promo\videos")
OUT = BASE / "audit_1008" / "jpg"
TIMES = [8.5, 9.5, 10.5, 11.2, 11.6, 12.0, 12.5, 14.0]   # idx=int(t*30)
TH_W = 300
for slug in ("ent22_v1_am", "prov07_v1_am"):
    mp4 = BASE / f"{slug}.mp4"
    thumbs = []
    for t in TIMES:
        img = Image.fromarray(iio.imread(str(mp4), index=int(t * 30))
                              ).convert("RGB")
        h = int(img.height * TH_W / img.width)
        thumbs.append(img.resize((TH_W, h), Image.LANCZOS))
    gap, label_h = 8, 34
    W = len(thumbs) * TH_W + (len(thumbs) - 1) * gap
    H = max(t.height for t in thumbs) + label_h
    strip = Image.new("RGB", (W, H), "#333")
    d = ImageDraw.Draw(strip)
    for i, (t, th) in enumerate(zip(TIMES, thumbs)):
        x = i * (TH_W + gap)
        strip.paste(th, (x, label_h))
        d.text((x + 6, 6), f"{t}s", fill="#FFF")
    p = OUT / f"{slug}_strip.jpg"
    strip.save(p, quality=88)
    print(f"[strip] {p.name} {strip.width}x{strip.height} {p.stat().st_size//1024}KB")
print("done")
