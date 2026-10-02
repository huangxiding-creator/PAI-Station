# -*- coding: utf-8 -*-
"""海报字体子集化（ECS 部署 B 方案）：NotoSansSC otf → GB2312+ASCII 子集。

背景：全量 pair 16.8MB 走 RunCommand 分片太慢；子集 ≈1-2MB/字重可承受。
覆盖面：GB2312 全集（6763 汉字 + 符号区）+ ASCII + 常用增补（破折/引号/序号/单位）。
用法: python tools/poster_font_subset.py   # 输出到 data/qianwen/fonts/subset/
"""
from __future__ import annotations

import sys
from pathlib import Path

from fontTools import subset

FONTS = Path("data/qianwen/fonts")
OUT = FONTS / "subset"


def char_set() -> set[int]:
    cps: set[int] = set(range(0x20, 0x7F))                    # ASCII 可见区
    for hi in range(0xA1, 0xF8):                              # GB2312 双字节全集
        for lo in range(0xA1, 0xFF):
            try:
                cps.add(ord(bytes([hi, lo]).decode("gb2312")))
            except UnicodeDecodeError:
                pass
    cps.update(ord(c) for c in
               "…—−·‘’“”„‰※†‡℃℉①②③④⑤⑥⑦⑧⑨⑩⑪⑫⒜"
               "㎡㎏㎜㎝㎞㎡㊣◎⊕⊙△▲▽▼◇◆□■★☆☺☻♠♥♦♣☑✓✔✘✕"
               "∠⊥∥∽≌≒≈≠≤≥±×÷∞∝√∮∑∏∈∵∴")
    return cps


def run() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    cps = sorted(char_set())
    print(f"charset: {len(cps)} codepoints")
    for name in ("Regular", "Bold"):
        src = FONTS / f"NotoSansSC-{name}.otf"
        dst = OUT / f"NotoSansSC-{name}.otf"
        opts = subset.Options()
        opts.name_IDs = ["*"]          # 保留字体名（PIL/FreeType 需）
        opts.name_legacy = True
        opts.name_languages = ["*"]
        opts.layout_features = ["*"]   # 保留默认特性（CJK 无 shaping 也无害）
        opts.glyph_names = False
        opts.notdef_outline = True
        font = subset.load_font(str(src), opts)
        ss = subset.Subsetter(options=opts)
        ss.populate(unicodes=cps)
        ss.subset(font)
        subset.save_font(font, str(dst), opts)
        print(f"{name}: {src.stat().st_size/1e6:.1f}MB -> {dst.stat().st_size/1e6:.2f}MB")


if __name__ == "__main__":
    sys.exit(run())
