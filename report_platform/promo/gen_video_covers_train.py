# -*- coding: utf-8 -*-
"""gen_video_covers — BID26 视频号封面 (顶级审美·品牌视觉·便于传播).

设计语言 (承接站内 og_card/artmotion 既定品牌): 墨蓝夜空底 × 铜金点线 ×
纸白宋黑标题 — 竖屏 1080×1920, 大字报级可读 (信息流 3 秒抓住):
  - 顶部品牌徽记「总包智库·研究」+ 细金线
  - 主标题两行大字 (报告核心词), 数字对比锚点 (83亿/12章/5801万)
  - 底部行动条: 报告全名 + 小程序指引
确定性 PIL 渲染, 产物 promo/videos/<slug>_cover.png。

用法: py -X utf8 report_platform/promo/gen_video_covers.py
"""
from __future__ import annotations

import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(__file__).resolve().parent
FONTS = Path(r"E:\AI-Station\data\qianwen\fonts")

INK = (16, 24, 44)            # 墨蓝夜空
INK2 = (24, 35, 62)           # 层次蓝
GOLD = (201, 160, 90)         # 铜金
GOLD_BRIGHT = (226, 192, 128)
PAPER = (245, 243, 237)       # 纸白
MUTED = (148, 158, 178)

W, H = 1080, 1920


def font(name: str, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(str(FONTS / name), size)


def cover(slug: str, kicker: str, lines: list[str], stat: str,
          stat_label: str) -> Path:
    img = Image.new("RGB", (W, H), INK)
    d = ImageDraw.Draw(img)
    # 底部渐层层次 (手工条带, 确定性)
    for i in range(H // 8):
        y = i * 8
        t = y / H
        c = tuple(int(INK[k] + (INK2[k] - INK[k]) * t) for k in range(3))
        d.rectangle([0, y, W, y + 8], fill=c)
    f_kick = font("NotoSansSC-Bold.otf", 44)
    f_big = font("NotoSansSC-Bold.otf", 118)
    f_stat = font("NotoSansSC-Bold.otf", 148)
    f_small = font("NotoSansSC-Regular.otf", 40)
    f_foot = font("NotoSansSC-Regular.otf", 34)
    # 顶部徽记
    d.rectangle([90, 120, 158, 128], fill=GOLD)
    d.text((180, 96), kicker, font=f_kick, fill=GOLD)
    d.line([90, 210, W - 90, 210], fill=GOLD, width=3)
    # 主标题 (每行 92 间距起点, 大字居左)
    y = 380
    for ln in lines:
        d.text((90, y), ln, font=f_big, fill=PAPER)
        y += 168
    # 数字锚点 (铜金大数 + 灰标签)
    d.line([90, y + 60, W - 90, y + 60], fill=(60, 74, 106), width=2)
    d.text((90, y + 120), stat, font=f_stat, fill=GOLD_BRIGHT)
    d.text((90, y + 300), stat_label, font=f_small, fill=MUTED)
    # 底部行动条
    d.rectangle([0, H - 200, W, H], fill=(10, 15, 30))
    d.text((90, H - 150), "《企业EPC培训市场深度洞察（2026版）》",
           font=f_foot, fill=PAPER)
    d.text((90, H - 95), "总包AI顾问小程序 · 报告商城 ¥598 · 免费试读",
           font=f_foot, fill=GOLD)
    out = PROMO / "videos" / f"{slug}_cover.png"
    img.save(out)
    return out


def main() -> int:
    jobs = [
        ("train_v1_h3", "总包智库 · 研究发布",
         ["培训市场底账", "今日上架"], "1169万",
         "调研弹药 · 培训市场全洞察"),
        ("train_v2_am", "企业培训的真相",
         ["钱花了人没变", "怎么办"], "87%",
         "完课率之痛 · 采购避坑指南"),
        ("train_v3_am", "培训机构生死簿",
         ["跑路与退费", "风险档案"], "83亿",
         "预收费监管 · 判例档案"),
    ]
    for slug, kicker, lines, stat, label in jobs:
        p = cover(slug, kicker, lines, stat, label)
        print(f"[cover] {p.name} {p.stat().st_size // 1024}KB")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
