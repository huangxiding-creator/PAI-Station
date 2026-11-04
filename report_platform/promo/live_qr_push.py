# -*- coding: utf-8 -*-
"""live_qr_push — 六张网直播宣传文直推公众号草稿箱 (1104, 复刻 push_article 管线).

差异点: 除 {{QRCODE}} 分号归因码外, 注入 {{QRL1}}..{{QRL5}} 五个直播预约二维码
(源: 总包说视频号后台「邀请他人推广」弹窗提取, 平台原生预约码).

用法:
  python -X utf8 live_qr_push.py ../promo/2026-11-04_zbzs_live_gd6net.md \
      --account 总包之声 [--dry-run]
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

PROMO = Path(__file__).resolve().parent
QR_DIR = PROMO / "live_qr"
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
SKU = "LIVE-GD6NET"


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
    ns = ap.parse_args()

    md_path = Path(ns.md)
    md = md_path.read_text(encoding="utf-8")
    html = render_md_to_wechat_html(md, theme_name="中式水墨")

    title_m = re.search(r"^#\s*(.+)$", md, re.M)
    title = title_m.group(1).strip()[:64]
    raw2 = (md.split("\n", 2)[1] or "").strip()
    digest_line = re.sub(r"^[>#\s]+", "", raw2).strip()
    digest = re.sub(r"\s+", " ", digest_line or title)[:110]

    ok, reasons = promo_guard.check(md, html, title, ns.account, SKU)
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

    # 5 个直播预约码
    for n in range(1, 6):
        ph = f"{{{{QRL{n}}}}}"
        if ph not in html:
            print(f"[push] ✗ 缺 {ph} 占位")
            return 1
        qr_file = QR_DIR / f"L{n}_qr.png"
        url = upload_content_image(token, qr_file, s)
        cap = f"长按识别 · 预约第{n}讲直播（开播自动提醒）"
        html = html.replace(ph, qr_html(url, cap))

    # 分号归因码
    qr_name = QR_BY_ACCOUNT.get(ns.account, "platform_qr.png")
    qr = PROMO / qr_name
    src = SRC_BY_QR.get(qr_name, "")
    if "{{QRCODE}}" in html:
        qr_url = upload_content_image(token, qr, s)
        html = html.replace(
            "{{QRCODE}}",
            qr_html(qr_url, "长按识别 · 总包智库报告平台（试读免费）",
                    width="70%"))
    for ph in ("{{QRCODE}}",) + tuple(f"{{{{QRL{n}}}}}" for n in range(1, 6)):
        if ph in html:
            print(f"[push] ✗ {ph} 注入失败")
            return 1
    print(f"[push] 6码注入完成, HTML={len(html)}字符 "
          f"(<=18000: {len(html) <= 18000})")

    r = push_draft(title, html, thumb, digest=digest,
                   mode="dry_run" if ns.dry_run else "publish",
                   account_name=ns.account)
    if not ns.dry_run and r.get("ok"):
        promo_guard.record(title, ns.account, SKU, src,
                           media_id=str(r.get("media_id", "")))
        print("[ledger] 过账 promo_ledger.jsonl")
    (md_path.parent / (md_path.stem + f"_{ns.account}_push_result.json")).write_text(
        json.dumps(r, ensure_ascii=False, indent=2), encoding="utf-8")
    print("[push]", r.get("mode"), "ok=", r.get("ok"),
          "media_id=", r.get("media_id", r.get("thumb_media_id", "")))
    return 0 if r.get("ok") else 1


if __name__ == "__main__":
    sys.exit(main())
