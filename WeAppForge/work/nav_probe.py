# -*- coding: utf-8 -*-
"""导航栏像素探针：辨析截图渲染的是哪个版本。
红 #ca3a3a/#d93a35 ≈ 线上版1.0.7老壳 ｜ 藏青 #081a36 + 橙 #ff9432 ≈ 我们的蓝图版。"""
import sys
from PIL import Image

path = sys.argv[1] if len(sys.argv) > 1 else r"E:\AI-Station\WeAppForge\work\mp_win_20576_0.png"
im = Image.open(path).convert("RGB")
w, h = im.size
print(f"IMG {w}x{h} {path}")


def region_rows(y0, y1, label):
    """统计 [y0,y1) 区域的主要颜色桶。"""
    buckets = {}
    for y in range(y0, min(y1, h)):
        for x in range(0, w, 4):
            r, g, b = im.getpixel((x, y))
            key = (r // 24 * 24, g // 24 * 24, b // 24 * 24)
            buckets[key] = buckets.get(key, 0) + 1
    total = sum(buckets.values()) or 1
    top = sorted(buckets.items(), key=lambda kv: -kv[1])[:6]
    for (rgb, n) in top:
        print(f"  {label} y{y0}-{y1} #{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x} {n * 100 // total}%")
    return top


# 导航栏区域（顶部 10%），主体区域（30-60%），全图
nav = region_rows(0, max(1, h // 10), "NAV")
body = region_rows(int(h * 0.3), int(h * 0.6), "BODY")

nav_hex = ["#%02x%02x%02x" % c for c, _ in nav[:3]]
nav_str = " ".join(nav_hex)


def classify(pairs):
    rr = sum(c[0] for c, _ in pairs) / max(1, len(pairs))
    gg = sum(c[1] for c, _ in pairs) / max(1, len(pairs))
    bb = sum(c[2] for c, _ in pairs) / max(1, len(pairs))
    if rr > gg + 30 and rr > bb + 30:
        return "RELEASE_OLD_DEMO_RED_NAV"
    if bb > 60 and bb > rr + 30:
        return "OURS_BLUEPRINT_NAVY"
    if gg > 230 and rr > 230 and bb > 230:
        return "WHITE_DOMINANT"
    return "MIXED"


print("NAV_HEX:", nav_str)
print("VERDICT:", classify(nav))
