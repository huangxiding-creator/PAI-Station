# -*- coding: utf-8 -*-
"""gen_og_card — 生成分享卡品牌图 content/og_card.png (1200x630).

编辑风对齐 template.CSS: 墨蓝底 × 铜金圆环 × 纸白宋体大字; 零随机.
确定性口径 = 同机同字库版本重跑字节级一致 (跨机/跨 Windows 版本字体文件有差);
仓内 content/og_card.png 是 canonical 工件, 本脚本只在其需要重制时运行.
用法: python -X utf8 tools/gen_og_card.py
"""
from __future__ import annotations

import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "content" / "og_card.png"
W, H = 1200, 630

INK = (15, 42, 67)        # #0F2A43
INK2 = (22, 56, 92)       # #16385C
BRASS = (176, 141, 87)    # #B08D57
BRASS2 = (201, 168, 118)  # #C9A876
PALE = (200, 212, 224)    # #C8D4E0
WHITE = (250, 247, 242)   # #FAF7F2 纸白

F_SERIF = r"C:\Windows\Fonts\simsun.ttc"
F_YH = r"C:\Windows\Fonts\msyh.ttc"
F_YHBD = r"C:\Windows\Fonts\msyhbd.ttc"


def _font(cands: list[str], size: int, role: str):
    """带回退链的字体装载 — 缺字体时报清角色与候选, 不裸崩 (评审 MEDIUM)."""
    for p in cands:
        try:
            return ImageFont.truetype(p, size)
        except OSError:
            continue
    raise SystemExit(f"[og_card] {role} 字体缺席: {cands} — "
                     "仓内 og_card.png 为 canonical, 补装字体后才可重生成")


def spaced(d: ImageDraw.ImageDraw, xy, text, font, fill, ls: int):
    """字距绘制 (letter-spacing)."""
    x, y = xy
    for ch in text:
        d.text((x, y), ch, font=font, fill=fill)
        x += d.textlength(ch, font=font) + ls
    return x


def main() -> int:
    img = Image.new("RGB", (W, H), INK)
    d = ImageDraw.Draw(img, "RGBA")

    # 下半微亮渐层 (手绘 60 条 1px 带代替 gradient)
    for i in range(H // 2, H):
        t = (i - H // 2) / (H // 2)
        band = tuple(int(INK[c] + (INK2[c] - INK[c]) * t) for c in range(3))
        d.line([(0, i), (W, i)], fill=band)

    # 铜金圆环 (hero 同款双环, 右上角出血)
    d.ellipse([W - 300, -260, W + 140, 180], outline=(*BRASS, 90), width=2)
    d.ellipse([W - 220, -180, W + 60, 100], outline=(*BRASS, 51), width=2)
    d.ellipse([-140, H - 200, 120, H + 60], outline=(*BRASS, 40), width=2)

    f_brand = _font([F_YH, F_SERIF], 26, "正文黑体")
    f_title = _font([F_SERIF, F_YH], 172, "主标题宋体")
    f_sub = _font([F_YHBD, F_YH, F_SERIF], 52, "副题粗黑")
    f_line = _font([F_YH, F_SERIF], 34, "一行说明")
    f_dom = _font([F_YH, F_SERIF], 30, "域名")

    # 顶部品牌行 (字距 0.35em ≈ 9px)
    brand = "TONGBAO RESEARCH · 总包智库编辑部"
    bw = sum(d.textlength(c, font=f_brand) + 9 for c in brand) - 9
    spaced(d, ((W - bw) / 2, 76), brand, f_brand, BRASS2, 9)

    # 主标题 (宋体描边加重量)
    title = "总包智库"
    tw = d.textlength(title, font=f_title)
    d.text(((W - tw) / 2, 148), title, font=f_title, fill=WHITE,
           stroke_width=3, stroke_fill=WHITE)

    # 铜金短线
    d.line([(W / 2 - 150, 388), (W / 2 + 150, 388)], fill=BRASS, width=3)

    d.text((W / 2 - d.textlength("工程总承包研究报告平台",
                                 font=f_sub) / 2, 420),
           "工程总承包研究报告平台", font=f_sub, fill=PALE)

    line = "企业拆解 · 省份市场 · 专题实战 · 全部免费试读"
    d.text((W / 2 - d.textlength(line, font=f_line) / 2, 508),
           line, font=f_line, fill=(*PALE, 200))

    d.text((W / 2 - d.textlength("yrecepc.cn", font=f_dom) / 2, 566),
           "yrecepc.cn", font=f_dom, fill=BRASS2)

    OUT.parent.mkdir(parents=True, exist_ok=True)
    img.save(OUT, "PNG", optimize=True)
    print(f"[og_card] {OUT} {OUT.stat().st_size} bytes {W}x{H}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
