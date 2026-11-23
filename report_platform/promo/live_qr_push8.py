# -*- coding: utf-8 -*-
"""live_qr_push8 — 8码版直播宣传文推送 (1123 EPC八讲, 复刻 live_qr_push)."""
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

PROMO = Path(__file__).resolve().parent
QR_DIR = PROMO / "live_qr_1123"
ROOT = PROMO.parent
COVER = Path(r"E:\AI-Station\ResearchFactory-Eng\05 研报宣传"
             r"\研究报告公众号宣传文章封面.jpg")

QR_BY_ACCOUNT = {
    "总包之声": "qr_zbzs.png",
    "总包说": "qr_zbshuo.png",
    "工程行业大脑": "qr_dt.png",
}
SRC_BY_QR = {"qr_zbzs.png": "gzh-zbzs", "qr_zbshuo.png": "gzh-zbshuo",
             "qr_dt.png": "gzh-dt"}
SKU = "LIVE-EPC8DEC"  # --sku 可覆盖
QRCOUNT = 8


def qr_html(url: str, caption: str, width: str = "44%") -> str:
    return (f'<p style="text-align:center"><img src="{url}" '
            f'style="width:{width}"/></p>'
            f'<p style="text-align:center;font-size:14px;color:#888">'
            f"{caption}</p>")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("md")
    ap.add_argument("--account", default="总包之声")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--sku", default="")
    ns = ap.parse_args()

    md_path = Path(ns.md)
    md = md_path.read_text(encoding="utf-8")
    html = render_md_to_wechat_html(md, theme_name="中式水墨")

    title_m = re.search(r"^#\s*(.+)$", md, re.M)
    title = title_m.group(1).strip()[:64]
    raw2 = (md.split("\n", 2)[1] or "").strip()
    digest_line = re.sub(r"^[>#\s]+", "", raw2).strip()
    digest = re.sub(r"\s+", " ", digest_line or title)[:110]

    sku = ns.sku or SKU
    ok, reasons = promo_guard.check(md, html, title, ns.account, sku)
    if not ok:
        print("[guard] 拒推 —")
        for r in reasons:
            print("        ", r)
        return 1
    print(f"[guard] 七门全过 ({ns.account} / {SKU} / {len(html)}字符)")

    s = _session()
    account = load_account(ns.account)
    token = get_access_token(account, s)
    thumb = upload_cover(token, COVER, s)

    for n in range(1, QRCOUNT + 1):
        ph = f"{{{{QRL{n}}}}}"
        if ph not in html:
            print(f"[push] ✗ 缺 {ph} 占位")
            return 1
        qr_file = QR_DIR / f"L{n}_qr.jpg"
        url = upload_content_image(token, qr_file, s)
        cap = f"长按识别 · 预约第{n}讲直播（开播自动提醒）"
        html = html.replace(ph, qr_html(url, cap))

    qr_name = QR_BY_ACCOUNT.get(ns.account, "platform_qr.png")
    qr = PROMO / qr_name
    src = SRC_BY_QR.get(qr_name, "")
    if "{{QRCODE}}" in html:
        qr_url = upload_content_image(token, qr, s)
        html = html.replace(
            "{{QRCODE}}",
            qr_html(qr_url, "长按识别 · 总包智库报告平台（试读免费）",
                    width="70%"))
    for ph in ("{{QRCODE}}",) + tuple(f"{{{{QRL{n}}}}}" for n in range(1, QRCOUNT + 1)):
        if ph in html:
            print(f"[push] ✗ {ph} 注入失败")
            return 1
    print(f"[push] {QRCOUNT + 1}码注入完成, HTML={len(html)}字符 "
          f"(<=18000: {len(html) <= 18000})")

    r = push_draft(title, html, thumb, digest=digest,
                   mode="dry_run" if ns.dry_run else "publish",
                   account_name=ns.account)
    if not ns.dry_run and r.get("ok"):
        promo_guard.record(title, ns.account, sku, src,
                           media_id=str(r.get("media_id", "")))
        print("[ledger] 过账 promo_ledger.jsonl")
    (md_path.parent / (md_path.stem + f"_{ns.account}_push_result.json")).write_text(
        json.dumps(r, ensure_ascii=False, indent=2), encoding="utf-8")
    print("[push]", r.get("mode"), "ok=", r.get("ok"),
          "media_id=", r.get("media_id", r.get("thumb_media_id", "")))
    return 0 if r.get("ok") else 1


if __name__ == "__main__":
    sys.exit(main())
