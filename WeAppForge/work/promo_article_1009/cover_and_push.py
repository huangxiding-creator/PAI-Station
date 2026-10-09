# -*- coding: utf-8 -*-
"""任务③ 收口腿：① PIL 封面 900×383 编辑部风 → ② add_material 封面 → ③ draft/add 草稿箱。
通道=EPC100 wechat_publisher（r50 实证 publish 模式，钉总包之声）。
防封第一：只入草稿箱，群发由用户人工执行。
"""
import json
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\WeAppForge\work\promo_article_1009")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\scripts\research_studio\promotion")

# 科技深蓝族配色（正文主题同源）
NAVY_TOP = (18, 34, 64)
NAVY_BOT = (26, 58, 107)
ACCENT = (78, 124, 255)
WHITE = (245, 248, 255)
MUTED = (159, 184, 230)

F_BOLD = r"C:/Windows/Fonts/msyhbd.ttc"
F_REG = r"C:/Windows/Fonts/msyh.ttc"


def font(path: str, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(path, size, encoding="utf-8")


def make_cover(out: Path) -> None:
    w, h = 900, 383
    img = Image.new("RGB", (w, h), NAVY_TOP)
    dr = ImageDraw.Draw(img)
    # 纵向渐变
    for y in range(h):
        t = y / h
        c = tuple(int(NAVY_TOP[i] + (NAVY_BOT[i] - NAVY_TOP[i]) * t) for i in range(3))
        dr.line([(0, y), (w, y)], fill=c)
    # 蓝图网格（细线低透明，rgba 覆盖层合成）
    grid = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    gd = ImageDraw.Draw(grid)
    for x in range(0, w, 64):
        gd.line([(x, 0), (x, h)], fill=(255, 255, 255, 7), width=1)
    for y in range(0, h, 64):
        gd.line([(0, y), (w, y)], fill=(255, 255, 255, 7), width=1)
    img = Image.alpha_composite(img.convert("RGBA"), grid).convert("RGB")
    dr = ImageDraw.Draw(img)

    x0 = 64
    # eyebrow
    dr.text((x0, 52), "写给工程人 · 微信小程序", font=font(F_REG, 26), fill=ACCENT)
    # 主标题
    dr.text((x0, 96), "总包AI顾问", font=font(F_BOLD, 104), fill=WHITE)
    # 副标题双色
    sub = font(F_BOLD, 50)
    dr.text((x0, 232), "7×24小时 ", font=sub, fill=WHITE)
    xw = dr.textlength("7×24小时 ", font=sub)
    dr.text((x0 + xw, 232), "免费咨询", font=sub, fill=ACCENT)
    # 底行场景词
    dr.text((x0, 318), "招投标 · 索赔 · 变更 · 结算 · 审计 · 合同实务", font=font(F_REG, 26), fill=MUTED)

    # 右侧徽章（克制单枚）
    bx1, by1, bx2, by2 = 660, 96, 836, 200
    dr.rounded_rectangle([bx1, by1, bx2, by2], radius=14, outline=ACCENT, width=3)
    t1, t2 = "每天免费 6 次", "加赠不封顶"
    f1, f2 = font(F_BOLD, 30), font(F_REG, 24)
    w1 = dr.textlength(t1, font=f1)
    w2 = dr.textlength(t2, font=f2)
    cx = (bx1 + bx2) / 2
    dr.text((cx - w1 / 2, by1 + 20), t1, font=f1, fill=WHITE)
    dr.text((cx - w2 / 2, by1 + 66), t2, font=f2, fill=MUTED)

    img.save(out, "JPEG", quality=92)
    print(f"cover -> {out.name} {out.stat().st_size}B")


def main() -> None:
    import wechat_publisher as wp

    cover = PROMO / "cover_900x383.jpg"
    make_cover(cover)

    html = (PROMO / "article_full.html").read_text(encoding="utf-8")
    assert len(html) < 20000 and len(html) > 10000, f"html size suspect: {len(html)}"

    title = "总包AI顾问：7×24小时免费咨询！"
    digest = "工程问题免费问：每天6次打底，点赞写意见共享再攒，上不封顶。回答附依据可查证。"
    assert len(digest.encode("utf-8")) <= 120, "digest over 120B"

    s = wp._session()
    acc = wp.load_account()          # 钉 总包之声（用户令）
    token = wp.get_access_token(acc, s)
    thumb = wp.upload_cover(token, cover, s)
    print(f"thumb_media_id = {thumb}")

    res = wp.push_draft(title=title, html=html, thumb_media_id=thumb,
                        digest=digest, mode="publish")
    (PROMO / "push_result.json").write_text(
        json.dumps({"title": title, "digest": digest, "html_chars": len(html),
                    "thumb": thumb, "media_id": res.get("media_id"),
                    "cover": cover.name}, ensure_ascii=False, indent=2),
        encoding="utf-8")
    print(f"\nDRAFT IN BOX: media_id={res.get('media_id')}")
    print("群发留给用户人工执行（防封红线）。")


if __name__ == "__main__":
    main()
