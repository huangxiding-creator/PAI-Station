# -*- coding: utf-8 -*-
"""几何探针：数值验证海报无重叠/溢出（比目测更硬的判据）。"""
import sys
sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")
from qianwen_engine import poster as P
from PIL import Image, ImageDraw

# 用真实字体测量文本宽度，复现 build 的关键断言
img = Image.new("RGB", (P.W, P.H))
d = ImageDraw.Draw(img)
fr, fb = P._font_pair()
f_cta = fb(42); f_cta_sub = fr(23); f_cap = fr(20); f_num = fb(30); f_unit = fr(23); f_q = fb(46); f_label = fr(21)

bad = []
def assert_le(name, val, lim):
    if val > lim:
        bad.append(f"{name}: {val:.0f} > {lim}")

# 1) 行动卡左栏文字（x=104）不得越过二维码白板左缘 452-16=436
for name, s, f in [("CTA", "扫码读完整解答", f_cta),
                   ("sub1", "每天 6 次免费提问", f_cta_sub),
                   ("sub2", "支持继续追问 · 同样免费", f_cta_sub),
                   ("AI行", "内容由 AI 生成 · 仅供参考", f_cap)]:
    assert_le(f"卡左栏[{name}]右缘", 104 + d.textlength(s, font=f), 436)
# 2) 「长按识别」caption 底缘在卡内（cy0=1016, 卡底 1268）
cy0 = 1016; py = cy0 + 16
assert_le("长按识别底缘", py + P._QR_SIZE + 38 + 26, cy0 + 252)
# 3) 码白板右缘在卡右缘内（卡 56..694）
assert_le("码白板右缘", 452 + P._QR_SIZE + 24, 694 - 20)
# 4) 页脚不压图纸框（框底 1310）
assert_le("页脚底缘", 1282 + 26, 1310)
# 5) 数据行总宽不越版心（M=72, W-M=678）
x = 72
for num, unit in (("3,842", " 字全文"), ("6", " 条依据"), ("免费", "继续追问")):
    x += d.textlength(num, font=f_num) + 4 + d.textlength(unit, font=f_unit) + 36
assert_le("数据行右缘", x - 36, 678)
# 6) 栏目标签右缘
x = 72 + 26
for ch in "工程咨询 · CONSULTATION":
    x += d.textlength(ch, font=f_label) + 5
assert_le("栏目标签右缘", x, 678)
# 7) 最坏情形：4行问题→q_end=226+4*66=490；要点 y_key=max(490+52,520)=542
#    3条双行要点 y=542+46 起步，每条 2行*46+16 → 3*(92+16)=324 → 尾 y=588+324=912
#    y_meta=min(max(912+30,946),976)=976 → 数据行底 976+30=1006 < 卡顶 1016 ✓
q_end = 226 + 4 * 66
y_key = max(q_end + 52, 520)
y_bul = y_key + 46 + 3 * (2 * 46 + 16)
y_meta = min(max(y_bul + 30, 946), 976)
assert_le("最坏情形数据行底缘", y_meta + 30, 1016 - 8)
print("q_end", q_end, "y_key", y_key, "bullets_end", y_bul, "y_meta", y_meta)

if bad:
    print("GEO-FAIL:")
    for b in bad:
        print("  -", b)
    sys.exit(1)
print("GEO-PROBE: ALL PASS")
