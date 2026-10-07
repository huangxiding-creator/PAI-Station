# -*- coding: utf-8 -*-
"""push_article — 平台引流文直推公众号草稿箱 (F5b 三号参数化版).

吃 promo/*.md → render_md_to_wechat_html → 注入分号归因二维码 →
promo_guard 七门守门 → push_draft 入草稿箱 (发表权统一归 autopub,
平台侧永不 API 发表 — 单写者红线).

用法:
  python -X utf8 promo/push_article.py promo/xxx.md \
      --account 总包说 --sku ENT-05 --qr qr_zbshuo.png [--dry-run]
默认账号=总包之声 + 通用码 platform_qr.png (向后兼容旧调用).
复用 ResearchFactory-Eng promotion 生产实证件, 不重写.
"""
from __future__ import annotations

import argparse
import io
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\scripts")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

from research_studio.promotion.wechat_publisher import (  # noqa: E402
    get_access_token, load_account, push_draft, upload_content_image,
    upload_cover, _session)
from research_studio.promotion.md_renderer import render_md_to_wechat_html  # noqa: E402

sys.path.insert(0, str(Path(__file__).resolve().parent))
import promo_guard  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
COVER = Path(r"E:\AI-Station\ResearchFactory-Eng\05 研报宣传"
             r"\研究报告公众号宣传文章封面.jpg")

# 账号 → 默认归因二维码 (分号漏斗分桶键)
QR_BY_ACCOUNT = {
    "总包之声": "qr_zbzs.png",
    "总包说": "qr_zbshuo.png",
    "工程行业大脑": "qr_dt.png",
}
# 二维码文件名 → src (与 gen_qr_accounts.CHANNELS 一致)
SRC_BY_QR = {
    "platform_qr.png": "",
    "qr_zbzs.png": "gzh-zbzs",
    "qr_zbshuo.png": "gzh-zbshuo",
    "qr_dt.png": "gzh-dt",
    "qr_sph.png": "sph-manual",
    "qr_bb.png": "bb-preheat",
}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("md", help="promo/*.md 文章源")
    ap.add_argument("--account", default="总包之声",
                    help="公众号名 (default 总包之声)")
    ap.add_argument("--sku", default="", help="报告 SKU (SKU 7 天冷却键)")
    ap.add_argument("--qr", default="", help="二维码文件名 (promo/ 下; "
                    "默认按账号自动选分号码)")
    ap.add_argument("--dry-run", action="store_true", help="构建载荷不入箱")
    ns = ap.parse_args()

    md_path = Path(ns.md)
    md = md_path.read_text(encoding="utf-8")
    qr_name = ns.qr or QR_BY_ACCOUNT.get(ns.account, "platform_qr.png")
    qr = ROOT / "promo" / qr_name
    src = SRC_BY_QR.get(qr_name, "")

    if "{{QRCODE}}" not in md:
        md += "\n\n{{QRCODE}}\n"
    html = render_md_to_wechat_html(md, theme_name="中式水墨")

    title_m = re.search(r"^#\s*(.+)$", md, re.M)
    title = title_m.group(1).strip()[:64]
    # digest = md 第 2 行 (剥掉 blockquote/标题标记, 防止 "> " 前缀泄漏到摘要卡)
    raw2 = (md.split("\n", 2)[1] or "").strip()
    digest_line = re.sub(r"^[>#\s]+", "", raw2).strip()
    digest = re.sub(r"\s+", " ", digest_line or title)[:110]

    # ---- promo_guard 七门守门 (推前) ----
    ok, reasons = promo_guard.check(md, html, title, ns.account, ns.sku)
    if not ok:
        print("[guard] 拒推 —")
        for r in reasons:
            print("        ", r)
        return 1
    print(f"[guard] 七门全过 ({ns.account} / {ns.sku or '无SKU'} / "
          f"src={src or '通用'} / {len(html)}字符)")

    s = _session()
    account = load_account(ns.account)
    token = get_access_token(account, s)
    thumb = upload_cover(token, COVER, s)
    qr_url = upload_content_image(token, qr, s)
    html = html.replace("{{QRCODE}}",
                        f'<p style="text-align:center"><img src="{qr_url}" '
                        'style="width:70%"/></p><p style="text-align:center;'
                        'font-size:14px;color:#888">长按识别 · 总包智库报告平台'
                        "（试读免费）</p>")
    if "{{QRCODE}}" in html:
        print("[push] 二维码注入失败")
        return 1

    r = push_draft(title, html, thumb, digest=digest,
                   mode="dry_run" if ns.dry_run else "publish",
                   account_name=ns.account)
    if not ns.dry_run and r.get("ok"):
        promo_guard.record(title, ns.account, ns.sku, src,
                           media_id=str(r.get("media_id", "")))
        print("[ledger] 过账 promo_ledger.jsonl")
    (md_path.parent / (md_path.stem + "_push_result.json")).write_text(
        json.dumps(r, ensure_ascii=False, indent=2), encoding="utf-8")
    print("[push]", r.get("mode"), "ok=", r.get("ok"),
          "media_id=", r.get("media_id", r.get("thumb_media_id", "")))
    return 0 if r.get("ok") else 1


if __name__ == "__main__":
    sys.exit(main())
