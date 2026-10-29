# -*- coding: utf-8 -*-
"""PPT 图表 — matplotlib 调色板着色（契约: 图表不用生成图, 用调色板色）
两个图: 成本对比(市场价值页) / 知识资产规模(壁垒页)。数值以核验官 verifiedFacts 为准。
"""
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from pathlib import Path

MEDIA = Path(__file__).resolve().parent / "media"
INK, PRIMARY, SUPPORT, ACCENT, MUTED, PAPER = "#EAF4FB", "#1878D8", "#48C0D8", "#F0A878", "#7FA3BD", "#061A2E"
plt.rcParams.update({
    "font.family": "Microsoft YaHei", "text.color": INK,
    "axes.edgecolor": MUTED, "axes.labelcolor": INK,
    "xtick.color": MUTED, "ytick.color": INK, "figure.facecolor": PAPER, "axes.facecolor": PAPER,
})

# ---- 图1: 单台成本颠覆 (传统大样本训练方案 vs 本产品) ----
fig, ax = plt.subplots(figsize=(7.0, 4.2), dpi=200)
cats = ["传统视觉方案", "水利安全AI眼镜"]
vals = [16000, 3299]
bars = ax.barh(cats, vals, height=0.52, color=[MUTED, SUPPORT])
bars[1].set_color(SUPPORT)
bars[0].set_color("#33526D")
ax.set_xlim(0, 19500)
ax.invert_yaxis()
for b, v, lab in zip(bars, vals, ["约 16,000 元/场景", "3,299 元/台（验收实价）"]):
    ax.text(v + 400, b.get_y() + b.get_height() / 2, lab, va="center", fontsize=15, color=INK, fontweight="bold")
ax.text(3299 + 400, 1 - 0.42, "降幅约 80%", fontsize=11.5, color=ACCENT)
ax.spines[["top", "right", "left"]].set_visible(False)
ax.tick_params(axis="y", labelsize=14)
ax.set_xticks([])
ax.set_title("单台成本（元）", fontsize=13, color=MUTED, loc="left", pad=10)
fig.tight_layout()
fig.savefig(MEDIA / "chart_cost.png", facecolor=PAPER)
plt.close(fig)

# ---- 图2: 知识与工程化资产规模 (对数感不用对数轴, 用横条+标注) ----
fig, ax = plt.subplots(figsize=(7.0, 4.2), dpi=200)
cats2 = ["专业文档知识库", "法规标准库", "量化阈值规则"]
vals2 = [10200, 1300, 72]
colors2 = [PRIMARY, SUPPORT, ACCENT]
bars2 = ax.barh(cats2[::-1], vals2[::-1], height=0.52, color=colors2[::-1])
ax.set_xlim(0, 12000)
for b, v in zip(bars2, vals2[::-1]):
    ax.text(v + 180, b.get_y() + b.get_height() / 2, f"{v:,}+", va="center", fontsize=14, color=INK, fontweight="bold")
ax.spines[["top", "right", "left"]].set_visible(False)
ax.tick_params(axis="y", labelsize=13.5)
ax.set_xticks([])
ax.set_title("十年功夫，一副眼镜随身携带", fontsize=13, color=MUTED, loc="left", pad=10)
fig.tight_layout()
fig.savefig(MEDIA / "chart_knowledge.png", facecolor=PAPER)
plt.close(fig)
print("charts done:", MEDIA / "chart_cost.png", MEDIA / "chart_knowledge.png")
