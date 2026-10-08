# -*- coding: utf-8 -*-
"""video_factory — 视频号竖屏金句卡 MP4 生产器 (F5b 视频腿 v1).

PIL 产 1080×1920 竖屏卡帧 (墨蓝×铜金 品牌色) → imageio-ffmpeg 合成
H.264/yuv420p MP4 (微信视频号兼容). 免费依赖 (不占 NB 配额/不用付费API).

用法:
  python -X utf8 promo/video_factory.py make --slug cnnec_v1
  python -X utf8 promo/video_factory.py list      # 内置选题卡
"""
from __future__ import annotations

import argparse
import sys
import tempfile
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "promo" / "videos"

W, H = 1080, 1920
INK = (15, 42, 67)
INK2 = (22, 56, 92)
BRASS = (201, 168, 118)
PAPER = (250, 247, 242)
MUT = (154, 154, 154)

# 内置选题: slug → 卡帧文案 (标题另配 — 爆款配方: 具体数字/大案要案/避坑止损)
CARDS: dict[str, dict] = {
    "cnnec_v1": {
        # 1008 用户令: 短标题要简洁 (21字超上限→发表键锁灰, r6实锤);
        # 长文案全挪 desc (描述字段容量大)
        "title": "全国唯一能总承包核电站的公司",
        "desc": ("全国唯一能总承包整座核电站的工程公司，凭什么？"
                 "设计·采购·施工·调试四项能力全部拉满，华龙一号首堆"
                 "就是这么干成的。1600份资料·15.6万字，我们把它拆成了"
                 "14章。深度研报全文，公众号可试读。"),
        "desc_tags": ["EPC", "核电", "工程总承包", "华龙一号"],
        "frames": [
            ("全国只有一家", "能总承包整座核电站的工程公司"),
            ("设计 · 采购 · 施工 · 调试", "四项能力全部拉满"),
            ("1600份资料 · 15.6万字", "我们把它拆成了14章"),
            ("华龙一号首堆怎么干成的", "报告里全拆了 · 公众号可试读"),
        ],
    },
    "fengcheng_v1": {
        "title": "73人遇难，拆出三个安全黑洞",
        "desc": ("73人遇难、1.02亿损失——丰城电厂11·24冷却塔事故复盘。"
                 "不是意外，是模式的基因缺陷：责任碎片化，人人都负责="
                 "没人负责。30章沉思录深度拆解，公众号可试读。"),
        "desc_tags": ["工程安全", "EPC", "丰城电厂", "事故复盘"],
        "frames": [
            ("73人遇难 · 1.02亿损失", "丰城电厂11·24事故"),
            ("不是意外", "是模式的基因缺陷"),
            ("责任碎片化", "人人都负责 = 没人负责"),
            ("最弱势的人敢不敢说停", "30章沉思录 · 公众号可试读"),
        ],
    },
    # 1008 用户令: 最新研报 R50 (r50_article.md 同调钩子, 数字全来自
    # report.json badges — 零造假)
    "r50_snei_v1": {
        "title": "中石化南京工程怎么干EPC",
        "desc": ("设计+施工合并了，为什么还是干不好EPC？我们用867份"
                 "研究底稿、1294万字资料，拆解国内炼化EPC第一梯队——"
                 "中石化南京工程的30年总承包打法：923处来源引注、关键"
                 "结论最多9源交叉印证、15章10万字成稿。报告全文首发价"
                 "¥1999，免费试读：report.yrecepc.cn"),
        "desc_tags": ["EPC", "炼化", "中石化南京工程", "研究报告"],
        "frames": [
            ("合并了", "还是干不好EPC"),
            ("交付基因", "组织合并解决不了的东西"),
            ("867份底稿 · 923处引注", "1294万字消化成10万字"),
            ("拆成15章", "30年打法全复盘 · 免费试读"),
        ],
    },
}


def _font(size: int, bold: bool = False):
    from PIL import ImageFont
    cands = [
        r"C:\Windows\Fonts\msyhbd.ttc" if bold else r"C:\Windows\Fonts\msyh.ttc",
        r"C:\Windows\Fonts\msyh.ttf",
        r"C:\Windows\Fonts\simhei.ttf",
    ]
    for c in cands:
        if Path(c).exists():
            return ImageFont.truetype(c, size)
    return ImageFont.load_default()


def _wrap(draw, text: str, font, max_w: int) -> list[str]:
    lines, cur = [], ""
    for ch in text:
        if draw.textlength(cur + ch, font=font) <= max_w:
            cur += ch
        else:
            lines.append(cur)
            cur = ch
    if cur:
        lines.append(cur)
    return lines


def _card(head: str, sub: str) -> "Image":
    from PIL import Image, ImageDraw
    img = Image.new("RGB", (W, H), INK)
    d = ImageDraw.Draw(img)
    # 装饰圆环 (品牌视觉)
    d.ellipse([W - 320, -320, W + 240, 240], outline=BRASS, width=2)
    d.ellipse([W - 200, -200, W + 120, 120], outline=(176, 141, 87), width=2)
    # 头部品牌条
    f_brand = _font(44)
    d.text((80, 150), "总 包 智 库", font=f_brand, fill=BRASS)
    # 主文案
    f_head = _font(96, bold=True)
    f_sub = _font(60)
    y = 700
    for ln in _wrap(d, head, f_head, W - 160):
        d.text((80, y), ln, font=f_head, fill=PAPER)
        y += 130
    y += 90
    for ln in _wrap(d, sub, f_sub, W - 160):
        d.text((80, y), ln, font=f_sub, fill=(200, 212, 224))
        y += 92
    # 底部提示
    f_tip = _font(42)
    d.text((80, H - 220), "深度研报 · 免费试读", font=f_tip, fill=MUT)
    return img


def make(slug: str, hold_sec: float = 3.2) -> Path:
    import imageio.v2 as iio
    spec = CARDS[slug]
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    out = OUT_DIR / f"{slug}.mp4"
    frames = [_card(h, s) for h, s in spec["frames"]]
    fps = 24
    n_per = int(hold_sec * fps)
    tmp = Path(tempfile.mkdtemp(prefix="vf_"))
    tmp_files = []
    for i, f in enumerate(frames):
        p = tmp / f"f{i}.png"
        f.save(p)
        tmp_files.append(p)
    wr = iio.get_writer(out, fps=fps, codec="libx264",
                        pixelformat="yuv420p", macro_block_size=2)
    # 首帧前加 0.4s 黑场淡入感 (直接重复首帧即可, 简单可靠)
    for i, p in enumerate(tmp_files):
        img = iio.imread(p)
        for _ in range(n_per):
            wr.append_data(img)
    wr.close()
    for p in tmp_files:
        p.unlink()
    tmp.rmdir()
    # 伴生 meta (uploader 消费)
    import json
    meta = OUT_DIR / f"{slug}.json"
    meta.write_text(json.dumps(
        {"title": spec["title"], "desc": spec.get("desc", ""),
         "tags": spec["desc_tags"],
         "video": out.name}, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[video] {out} ({out.stat().st_size//1024}KB, "
          f"{len(frames)}卡×{hold_sec}s) + meta {meta.name}")
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["make", "list"])
    ap.add_argument("--slug", default="")
    ap.add_argument("--hold", type=float, default=3.2)
    ns = ap.parse_args()
    if ns.cmd == "list":
        for k, v in CARDS.items():
            print(f"{k}: {v['title'][:40]} ({len(v['frames'])}卡)")
        return 0
    make(ns.slug or "cnnec_v1", ns.hold)
    return 0


if __name__ == "__main__":
    sys.exit(main())
