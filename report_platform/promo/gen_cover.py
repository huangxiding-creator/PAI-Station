# -*- coding: utf-8 -*-
"""gen_cover — 视频号封面生成器（1012 世界级审美版 v3，图纸语言）。

设计要点（终审判词修复固化）：
  ① 字腔配对=刻意设计：数字/拉丁用 Bahnschrift（DIN 系工程字体），中文用雅黑粗体；
    EPC 与中文同基线混排（max-ascent 对齐）
  ② 中段经营：图纸尺寸标注线 |<— 五卷本 · 每个数字可回查 —>| 填腰，不留死白
  ③ 数据秀场：数字 96pt DIN + 单位基线严格对齐 + 发丝立柱分隔
  ④ 题名均质行距 152px；刊头字号统一（品牌 48 / 右注 DIN 26）
用法: python -X utf8 gen_cover.py   → videos/bluebook_v1_cover.png
"""
import datetime
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")
from qianwen_engine.poster import _font_pair, NAVY_DEEP, ORANGE, INK_SOFT, MIST, HAIR, WHITE
from PIL import Image, ImageDraw, ImageFont

fr, fb = _font_pair()
BAHN = r"C:\Windows\Fontsahnschrift.ttf"

def fdin(size):
    try:
        return ImageFont.truetype(BAHN, size)
    except Exception:
        return fb(size)

W, H = 1080, 1920
img = Image.new("RGB", (W, H), NAVY_DEEP)
d = ImageDraw.Draw(img)
M = 72
AVAIL = W - M * 2

d.rectangle([36, 36, W - 36, H - 36], outline=(90, 106, 126), width=2)
for cx, cy in ((36, 36), (W - 36, 36), (36, H - 36), (W - 36, H - 36)):
    d.line([(cx - 14, cy), (cx + 14, cy)], fill=MIST, width=2)
    d.line([(cx, cy - 14), (cx, cy + 14)], fill=MIST, width=2)

d.text((M, 92), "总包AI顾问", font=fb(48), fill=WHITE)
_today = datetime.date.today().strftime("%Y.%m.%d")
d.text((W - M - d.textlength(_today, font=fdin(26)), 100), _today, font=fdin(26), fill=MIST)
d.text((W - M - d.textlength("SHT 01 · RESEARCH", font=fdin(26)), 140), "SHT 01 · RESEARCH", font=fdin(26), fill=MIST)
d.line([(M, 192), (W - M, 192)], fill=MIST, width=3)

d.rectangle([M, 250, M + 14, 268], fill=ORANGE)
x = M + 34
for ch in "深度研究 · ":
    d.text((x, 246), ch, font=fr(30), fill=MIST)
    x += d.textlength(ch, font=fr(30)) + 4
for ch in "RESEARCH REPORT":
    d.text((x, 246), ch, font=fdin(30), fill=MIST)
    x += d.textlength(ch, font=fdin(30)) + 5

SIZE = 112
f_cjk, f_din = fb(SIZE), fdin(SIZE)

def draw_parts(y, parts, color):
    ascents = [f.getmetrics()[0] for _, f in parts]
    ma = max(ascents)
    xx = M
    for (text, font), asc in zip(parts, ascents):
        d.text((xx, y + (ma - asc)), text, font=font, fill=color)
        xx += d.textlength(text, font=font)

y = 322
draw_parts(y, [("一本卖一万块的", f_cjk)], WHITE)
y += 152
draw_parts(y, [("EPC", f_din), ("蓝皮书", f_cjk)], WHITE)
y += 152
draw_parts(y, [("凭什么？", f_cjk)], ORANGE)
y += 152

dy = y + 56
line_y = dy + 90
d.line([(M + 20, line_y), (W - M - 20, line_y)], fill=MIST, width=2)
for ex in (M + 20, W - M - 20):
    d.line([(ex, line_y - 10), (ex, line_y + 10)], fill=MIST, width=2)
for ax, sgn in ((M + 56, 1), (W - M - 56, -1)):
    d.line([(ax, line_y), (ax - sgn * 14, line_y - 8)], fill=MIST, width=2)
    d.line([(ax, line_y), (ax - sgn * 14, line_y + 8)], fill=MIST, width=2)
cap = "五卷本 · 每个数字可回查"
f_cap = fr(34)
cw = d.textlength(cap, font=f_cap)
d.rectangle([(W - cw) / 2 - 28, line_y - 24, (W + cw) / 2 + 28, line_y + 24], fill=NAVY_DEEP)
d.text(((W - cw) / 2, line_y - 19), cap, font=f_cap, fill=WHITE)

sy = line_y + 130
f_num, f_unit = fdin(96), fr(30)
stats = [("50", "万字"), ("74", "章"), ("737", "页")]
asc_n, asc_u = f_num.getmetrics()[0], f_unit.getmetrics()[0]
blocks = [(n, u, d.textlength(n, font=f_num), d.textlength(u, font=f_unit)) for n, u in stats]
gap = 72
total = sum(b[2] + 14 + b[3] for b in blocks) + gap * 2
x = M if total <= AVAIL else (W - total) / 2
for i, (num, unit, nw, uw) in enumerate(blocks):
    d.text((x, sy), num, font=f_num, fill=WHITE)
    d.text((x + nw + 14, sy + (asc_n - asc_u)), unit, font=f_unit, fill=MIST)
    x += nw + 14 + uw
    if i < 2:
        x += gap
        d.line([(x - gap // 2, sy + 10), (x - gap // 2, sy + asc_n - 10)], fill=HAIR, width=2)

by = H - 386
d.rectangle([M, by, M + 224, by + 78], fill=ORANGE)
f_pill = fb(44)
d.text((M + (224 - d.textlength("免费试读", font=f_pill)) / 2, by + 16), "免费试读", font=f_pill, fill=WHITE)
d.text((M, by + 128), "微信小程序 · 搜索「总包AI顾问」", font=fr(38), fill=WHITE)
d.text((M, by + 190), "研究报告库 · 66 份深度报告 · 总序与完整目录免费试读", font=fr(28), fill=INK_SOFT)

out = r"E:\AI-Stationeport_platform\promoideosluebook_v1_cover.png"
img.save(out, format="PNG", optimize=True)
print("cover saved", out)
