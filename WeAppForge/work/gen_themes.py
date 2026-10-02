# -*- coding: utf-8 -*-
"""v0.7.3 周换装系统·调色板生成器。

34 个设计 token × 7 套主题。派生原则（设计系统式，非散点乱配）：
- 结构色（deep/navy1-3/raise/raise2/line）：同色相、饱和度随明度递减——保证层次感
- 墨色（ink 系）：随结构色相的冷调白，dim/faint 三档
- accent 家族（accent/soft/deep/ink/bg + amber 四档）：同一强调色相的明度阶梯
- stamp（红章）语义色：全主题恒定（「有用」红章的语义不换装）
- 黑白阴影恒定

输出：
  themes.json     —— 供 utils/theme.js 使用（写死进小程序，无运行时计算）
  bench_themes.html —— 设计台（Chrome 截图 + 视觉自审用）
"""
import colorsys
import json

def hsl(h, s, l):
    r, g, b = colorsys.hls_to_rgb((h % 360) / 360, l / 100, s / 100)
    return "#{:02x}{:02x}{:02x}".format(round(r * 255), round(g * 255), round(b * 255))

def rgb_of(h, s, l):
    r, g, b = colorsys.hls_to_rgb((h % 360) / 360, l / 100, s / 100)
    return "{},{},{}".format(round(r * 255), round(g * 255), round(b * 255))

# 每主题锚点：结构色相H/satMul、纸色相、强调色相、副色（制图蓝位）色相
THEMES = [
    dict(key="navy",     name="深海蓝图", weekday=1, H=217, sat=1.00, paper=43,  accent=29,  sec=216),
    dict(key="pine",     name="松烟制图", weekday=2, H=165, sat=0.95, paper=48,  accent=34,  sec=168),
    dict(key="obsidian", name="曜石鎏金", weekday=3, H=32,  sat=0.28, paper=42,  accent=42,  sec=28),
    dict(key="violet",   name="暮山紫电", weekday=4, H=262, sat=0.90, paper=268, accent=190, sec=262),
    dict(key="celadon",  name="青瓷官窑", weekday=5, H=190, sat=0.90, paper=120, accent=5,   sec=175),
    dict(key="forge",    name="熔炉信号", weekday=6, H=14,  sat=0.70, paper=35,  accent=45,  sec=25),
    dict(key="graphite", name="晨雾石墨", weekday=7, H=218, sat=0.35, paper=220, accent=16,  sec=212),
]

# token → (模式, 参数)。模式：S=绝对饱和度(乘 satMul)；L=绝对明度
# 校准自现行 v0.7.2 藏青主题，保证 navy 主题输出 ≈ 现网像素
SPEC = {
    # ── 结构（暗色画布）──
    "deep":   ("hsl", 67, 6.5),
    "navy1":  ("hsl", 79, 12.4),
    "navy2":  ("hsl", 70, 16.9),
    "navy3":  ("hsl", 62, 22.9),
    "raise":  ("hsl", 34, 20.8),
    "raise2": ("hsl", 30, 28.4),
    "line":   ("hsl", 26, 30.8),
    # ── 墨色（暗底文字）──
    "ink":        ("hsl_paperish", 100, 96.5),   # 用结构色相+214 校准
    "inkDim":     ("hsl", 30, 70),
    "inkDimHi":   ("hsl", 35, 80),
    "inkFaint":   ("hsl", 18, 55),
    # ── 蓝图辉光 / 制图副色 ──
    "glow":       ("sec+", 95, 69),
    "glowSoft":   ("sec+", 80, 82),
    "blue":       ("sec", 72, 46),
    "blueTint":   ("sec", 40, 92),
    # ── 纸面（亮色内容区）──
    "paper":      ("paper", 44, 95),
    "paperHi":    ("paper", 60, 98),
    "paperCool":  ("sec", 45, 96),
    "paperDim":   ("paper", 30, 89),
    "paperEdge":  ("paper", 25, 82),
    # ── 纸面墨色（正文/次级/弱化/发丝线；色相随结构色相走冷调，校准自现网）──
    "paperInk":   ("hsl", 34, 15.5),   # ≈ #1b2434
    "paperInk2":  ("hsl", 22, 28),     # ≈ #39445a
    "paperMuted": ("hsl", 12, 53),     # ≈ #7a8496
    "paperLine":  ("paper", 30, 86),   # ≈ #e6e1d2
    # ── 强调色阶梯 ──
    "accent":     ("accent", 100, 60),
    "accentSoft": ("accent", 100, 74),
    "accentDeep": ("accent", 95, 52),
    "accentInk":  ("accent", 80, 38),
    "accentBg":   ("accent", 80, 95),
    # ── 琥珀族（黄铜标注，随强调色相走暗一档）──
    "amberBg":    ("accent", 70, 94),
    "amberLine":  ("accent", 65, 83),
    "amberInk":   ("accent", 75, 39),
    "amberDeep":  ("accent", 60, 19),
    # ── 红章（语义色，全主题恒定族）──
    "stamp":    ("stamp", 64, 47),
    "stampHi":  ("stamp", 63, 59),
    "stampBg":  ("stamp", 55, 89),
    "stampMid": ("stamp", 50, 77),
    "stampDeep": ("stamp", 40, 28),
}

STAMP_H = 8  # 红章恒定色相

def build(t):
    out = {}
    for tok, (mode, s, l) in SPEC.items():
        if tok.startswith("ink"):
            # 墨色用结构色相的冷白（与 navy 主题 #eaf3ff 校准：H+~0 即同族）
            hue = t["H"]
            sat = s if tok == "ink" else s * t["sat"]
        elif mode == "hsl":
            hue, sat = t["H"], s * t["sat"]
        elif mode == "hsl_paperish":
            hue, sat = t["H"], s
        elif mode in ("sec", "sec+"):
            hue, sat = t["sec"], s
        elif mode == "paper":
            hue, sat = t["paper"], s
        elif mode == "accent":
            hue, sat = t["accent"], s
        elif mode == "stamp":
            hue, sat = STAMP_H, s
        out[tok] = hsl(hue, max(0, min(100, sat)), l)
    # rgb 三元组（供 rgba(var(--t-x-rgb), α) 用）
    def trip(hue, s, l):
        return rgb_of(hue, s, l)
    out["inkRgb"] = trip(t["H"], 100, 96.5)
    out["glowRgb"] = trip(t["sec"], 95, 69)
    out["blueRgb"] = trip(t["sec"], 72, 46)
    out["accentRgb"] = trip(t["accent"], 100, 60)
    out["accentDeepRgb"] = trip(t["accent"], 95, 52)
    out["accentInkRgb"] = trip(t["accent"], 80, 38)
    out["navy1Rgb"] = trip(t["H"], 79 * t["sat"], 12.4)
    out["navy2Rgb"] = trip(t["H"], 70 * t["sat"], 16.9)
    out["deepRgb"] = trip(t["H"], 67 * t["sat"], 6.5)
    out["raiseRgb"] = trip(t["H"], 34 * t["sat"], 20.8)
    out["gridRgb"] = trip(t["H"], 34 * t["sat"], 73)      # 网格线蓝灰
    out["grid2Rgb"] = trip(t["H"], 28 * t["sat"], 76)     # 网格线亮档
    out["inkDimRgb"] = trip(t["H"], 30 * t["sat"], 70)    # 蓝图注记灰（rgba 用）
    out["paperInkRgb"] = trip(t["H"], 34, 15.5)           # 纸面墨（投影 rgba 用）
    out["meta"] = {"key": t["key"], "name": t["name"], "weekday": t["weekday"]}
    return out

palettes = [build(t) for t in THEMES]

# 校准检查：navy 主题应≈现网关键色
CALIB = {"deep": "#060d1c", "navy1": "#081a36", "navy2": "#0d2547", "navy3": "#16355f",
         "raise": "#232f47", "ink": "#eaf3ff", "accent": "#ff9432", "blue": "#1d6fd0",
         "paper": "#f7f4ec", "stamp": "#c8452b"}
print("== 校准（navy vs 现网）==")
for k, v in CALIB.items():
    got = palettes[0][k]
    print(f"  {k:8s} {v} -> {got} {'OK' if got.lower() == v else 'Δ'}")

with open("themes.json", "w", encoding="utf-8") as f:
    json.dump(palettes, f, ensure_ascii=False, indent=1)
print("themes.json written,", len(palettes), "themes,", len(palettes[0]) - 1, "tokens each")
