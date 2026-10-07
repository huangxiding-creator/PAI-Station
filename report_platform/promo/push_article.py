# -*- coding: utf-8 -*-
"""push_article — 平台引流文直推「总包之声」草稿箱.

吃 promo/*.md → render_md_to_wechat_html → 注入平台二维码 → push_draft(publish).
复用 ResearchFactory-Eng promotion 生产实证件, 不重写.

用法: python -X utf8 promo/push_article.py promo/r50_article.md [--dry-run]
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\scripts")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from research_studio.promotion.wechat_publisher import (  # noqa: E402
    get_access_token, load_account, push_draft, upload_content_image,
    upload_cover, _session)
from research_studio.promotion.md_renderer import render_md_to_wechat_html  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
COVER = Path(r"E:\AI-Station\ResearchFactory-Eng\05 研报宣传"
             r"\研究报告公众号宣传文章封面.jpg")
QR = ROOT / "promo" / "platform_qr.png"


def main() -> int:
    md_path = Path(sys.argv[1])
    dry = "--dry-run" in sys.argv
    md = md_path.read_text(encoding="utf-8")
    if "{{QRCODE}}" not in md:
        md += "\n\n{{QRCODE}}\n"
    html = render_md_to_wechat_html(md, theme_name="中式水墨")

    s = _session()
    account = load_account()
    token = get_access_token(account, s)
    thumb = upload_cover(token, COVER, s)
    qr_url = upload_content_image(token, QR, s)
    html = html.replace("{{QRCODE}}",
                        f'<p style="text-align:center"><img src="{qr_url}" '
                        'style="width:70%"/></p><p style="text-align:center;'
                        'font-size:14px;color:#888">长按识别 · 总包智库报告平台'
                        "（试读免费）</p>")
    if "{{QRCODE}}" in html:
        print("[push] 二维码注入失败")
        return 1

    title_m = re.search(r"^#\s*(.+)$", md, re.M)
    title = title_m.group(1).strip()[:64]
    digest = re.sub(r"\s+", " ", md.split("\n", 2)[1] or title)[:110]
    r = push_draft(title, html, thumb, digest=digest,
                   mode="dry_run" if dry else "publish")
    (md_path.parent / (md_path.stem + "_push_result.json")).write_text(
        __import__("json").dumps(r, ensure_ascii=False, indent=2),
        encoding="utf-8")
    print("[push]", r.get("mode"), "ok=", r.get("ok"),
          "media_id=", r.get("media_id", r.get("thumb_media_id", "")))
    return 0


if __name__ == "__main__":
    sys.exit(main())
