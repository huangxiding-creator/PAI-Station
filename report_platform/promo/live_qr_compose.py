# -*- coding: utf-8 -*-
"""live_qr_compose — 预约海报合成: 官方宣传海报 + 平台预约二维码 (1104).

每讲: 原海报底部上方放白底圆角卡 (二维码 + 「扫码预约本场直播」),
风格贴海报红金调. 产出 live_qr/poster_L{n}_reserve.jpg
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent
QR_DIR = PROMO / "live_qr"
SRC = Path(r"E:\AI-Station\07 任务\总包圈全国运营官\高登-抢抓“六张网”  突围“下行期”系列直播")

POSTERS = {  # n -> 文件名
    1: "微信图片_20261103163232_78_3738.jpg",
    2: "微信图片_20261103163237_79_3738.jpg",
    3: "微信图片_20261103163242_80_3738.jpg",
    4: "微信图片_20261103163247_81_3738.jpg",
    5: "微信图片_20261103163250_82_3738.jpg",
}

FONT = r"C:\Windows\Fonts\msyhbd.ttc"      # 微软雅黑 Bold


def main() -> int:
    from PIL import Image, ImageDraw, ImageFont

    for n, fname in POSTERS.items():
        poster = Image.open(SRC / fname).convert("RGB")
        qr = Image.open(QR_DIR / f"L{n}_qr.png").convert("RGB")
        W, H = poster.size
        # 尺寸: 卡片宽 = 海报宽 46%, QR = 卡片宽 74%
        card_w = int(W * 0.46)
        pad = int(card_w * 0.09)
        qr_w = card_w - pad * 2
        cap_h = int(card_w * 0.30)
        card_h = qr_w + pad * 2 + cap_h
        cx, cy = W // 2, H - int(H * 0.055) - card_h // 2   # 底部上方留 5.5%

        card = Image.new("RGB", (card_w, card_h), (255, 255, 255))
        d = ImageDraw.Draw(card)
        qr_r = qr.resize((qr_w, qr_w), Image.LANCZOS)
        card.paste(qr_r, (pad, pad))
        try:
            f_cap = ImageFont.truetype(FONT, int(cap_h * 0.52))
            f_sub = ImageFont.truetype(FONT, int(cap_h * 0.30))
        except Exception:
            f_cap = f_sub = ImageFont.load_default()
        d.text((card_w // 2, pad + qr_w + cap_h * 0.34),
               "扫码预约本场直播", font=f_cap, fill=(140, 20, 20),
               anchor="mm")
        d.text((card_w // 2, pad + qr_w + cap_h * 0.74),
               "微信识别 · 开播提醒", font=f_sub, fill=(120, 110, 100),
               anchor="mm")

        # 圆角遮罩贴到海报
        mask = Image.new("L", (card_w, card_h), 0)
        ImageDraw.Draw(mask).rounded_rectangle(
            [0, 0, card_w - 1, card_h - 1], radius=int(card_w * 0.10), fill=255)
        poster.paste(card, (cx - card_w // 2, cy - card_h // 2), mask)

        out = QR_DIR / f"poster_L{n}_reserve.jpg"
        poster.save(out, quality=92)
        print(f"✓ L{n}: {out.name} ({poster.size[0]}x{poster.size[1]})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
