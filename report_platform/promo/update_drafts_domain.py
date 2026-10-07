# -*- coding: utf-8 -*-
"""update_drafts_domain — 平台域名上线后: 重生成 platform_qr.png (http://yrecepc.cn/)
+ 草稿箱两篇引流文的二维码/内容整体更新 (draft/update, 群发仍留给用户).

用法: python -X utf8 promo/update_drafts_domain.py [--dry-run]
"""
from __future__ import annotations

import io
import json
import re
import sys
import time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\scripts")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

from research_studio.promotion.wechat_publisher import (  # noqa: E402
    get_access_token, load_account, upload_content_image, upload_cover,
    _session)
from research_studio.promotion.md_renderer import render_md_to_wechat_html  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
QR = ROOT / "promo" / "platform_qr.png"
COVER = Path(r"E:\AI-Station\ResearchFactory-Eng\05 研报宣传"
             r"\研究报告公众号宣传文章封面.jpg")
PLATFORM_URL = "http://yrecepc.cn/"
MD_SOURCES = [ROOT / "promo" / "r50_article.md",
              ROOT / "promo" / "shelf65_article.md"]
_API = "https://api.weixin.qq.com/cgi-bin"


def regen_qr() -> None:
    import qrcode
    img = qrcode.make(PLATFORM_URL, box_size=10, border=2)
    img.save(QR)
    print("[qr] regenerated ->", PLATFORM_URL, QR.stat().st_size, "bytes")


def post_json(s, token, path, payload: dict) -> dict:
    body = json.dumps(payload, ensure_ascii=False).encode("utf-8")
    r = s.post(f"{_API}/{path}", params={"access_token": token},
               data=body,
               headers={"Content-Type": "application/json; charset=utf-8"},
               timeout=30)
    return json.loads(r.content.decode("utf-8"))


def list_drafts(s, token) -> list:
    r = s.post(f"{_API}/draft/batchget",
               params={"access_token": token},
               data=json.dumps({"offset": 0, "count": 10, "no_content": 1},
                               ensure_ascii=False).encode("utf-8"),
               headers={"Content-Type": "application/json; charset=utf-8"},
               timeout=30)
    d = json.loads(r.content.decode("utf-8"))
    items = (d.get("item") or [])
    out = []
    for it in items:
        for art in ((it.get("content") or {}).get("news_item") or []):
            out.append({"media_id": it.get("media_id"),
                        "title": art.get("title", ""),
                        "url": art.get("url", "")})
    return out


def main() -> int:
    dry = "--dry-run" in sys.argv
    regen_qr()

    s = _session()
    account = load_account()
    token = get_access_token(account, s)
    drafts = list_drafts(s, token)
    print("[drafts]", len(drafts))
    for d in drafts:
        print("   -", d["title"][:40], d["media_id"])

    thumb = upload_cover(token, COVER, s)
    qr_url = upload_content_image(token, QR, s)
    print("[qr-url]", qr_url[:80])

    ok_n = 0
    for md_path in MD_SOURCES:
        md = md_path.read_text(encoding="utf-8")
        m = re.search(r"^#\s*(.+)$", md, re.M)
        title = m.group(1).strip()
        if "{{QRCODE}}" not in md:
            md += "\n\n{{QRCODE}}\n"
        html = render_md_to_wechat_html(md, theme_name="中式水墨")
        html = html.replace("{{QRCODE}}",
                            f'<p style="text-align:center"><img src="{qr_url}" '
                            'style="width:70%"/></p><p style="text-align:center;'
                            'font-size:14px;color:#888">长按识别 · 总包智库报告平台'
                            "（试读免费）</p>")
        digest = re.sub(r"\s+", " ", md.split("\n", 2)[1] or title)[:110]
        target = next((d for d in drafts
                       if d["title"][:20] == title[:20]), None)
        if not target:
            print("[skip] no draft matches:", title[:30])
            continue
        article = {"title": title[:64], "content": html,
                   "thumb_media_id": thumb, "digest": digest[:120],
                   "need_open_comment": 1, "only_fans_can_comment": 0}
        if dry:
            print("[dry] would update:", target["media_id"], title[:30])
            ok_n += 1
            continue
        d = post_json(s, token, "draft/update",
                      {"media_id": target["media_id"], "index": 0,
                       "articles": article})
        print("[update]", title[:30], "->", d)
        if d.get("errcode", 0) == 0:
            ok_n += 1
        time.sleep(2)
    print("DONE ok=%d/%d" % (ok_n, len(MD_SOURCES)))
    return 0 if ok_n == len(MD_SOURCES) else 1


if __name__ == "__main__":
    sys.exit(main())
