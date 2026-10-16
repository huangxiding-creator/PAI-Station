# -*- coding: utf-8 -*-
"""audit_1008 复审抽帧: 修复后 ent22/prov07 关键拍 (t9=8.1页/t13=highlight稳态)."""
import sys
from pathlib import Path

import imageio.v3 as iio
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
BASE = Path(r"E:\AI-Station\report_platform\promo\videos")
OUT = BASE / "audit_1008" / "jpg"
OUT.mkdir(parents=True, exist_ok=True)
SHOTS = {"t9": 9.0, "t12": 12.0, "t13": 13.0}   # idx = int(t*30)
for slug in ("ent22_v1_am", "prov07_v1_am"):
    mp4 = BASE / f"{slug}.mp4"
    for tag, t in SHOTS.items():
        img = iio.imread(str(mp4), index=int(t * 30))
        p = OUT / f"{slug}_{tag}.jpg"
        Image.fromarray(img).convert("RGB").save(p, quality=92)
        print(f"[ext] {p.name} {p.stat().st_size//1024}KB")
print("done")
