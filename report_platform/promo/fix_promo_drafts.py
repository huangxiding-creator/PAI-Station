# -*- coding: utf-8 -*-
"""fix_promo_drafts — 1124 复盘整改: 三稿重建 (draft/add 通道).

历史账 (教训在案):
  - 原 push (18:44): 标题被 clip_title(64B) 截题 + digest 错挂「出品」行 + 6处事实错误
  - 改用 draft/update 两轮实测把三件草稿异步摧毁 (json=存\\uXXXX字面量 / 裸UTF-8双重编码
    / err=0 返回后稿仍消失, 三件全 40007) — draft/update 通道判死
  - 唯一可靠通道 = draft/add (pub.push_draft: S27 编码纪律 + 3次重试, 全系列生产实证)

本件按修正后的 md 重建三稿: 全称标题≤64B (launch 去《》保「发布| 全名称」铁律)、
blockquote digest≤120B、6 处「法院认定vs原诉称」混用已修、QR 注入照 push_article 同款。
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\report_platform\promo")
sys.path.insert(0, str(PROMO))
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\scripts\research_studio\promotion")

import wechat_publisher as pub  # noqa: E402
from push_article import render_md_to_wechat_html  # noqa: E402

FIXES = [
    ("总包之声", "2026-11-24_zbzs_synergy_launch.md"),
    ("总包说", "2026-11-24_zbshuo_synergy_guiyi.md"),
    ("工程行业大脑", "2026-11-24_gchyd_synergy_jiemoshi.md"),
]

COVER = Path(r"E:\AI-Station\ResearchFactory-Eng\05 研报宣传\研究报告公众号宣传文章封面.jpg")
QR_BY_ACCOUNT = {"总包之声": "qr_zbzs.png", "总包说": "qr_zbshuo.png",
                 "工程行业大脑": "qr_dt.png"}


def main() -> int:
    s = pub._session()
    okn = 0
    for account, md_name in FIXES:
        md = (PROMO / md_name).read_text(encoding="utf-8")
        title = re.search(r"^#\s*(.+)$", md, re.M).group(1).strip()
        tb = title.encode("utf-8")
        if len(tb) > 64:
            print(f"[FAIL] {account} 标题 {len(tb)}B 超64B — 先压 md")
            continue
        digest_src = ""
        for ln in md.splitlines()[:8]:
            t = ln.strip()
            if t.startswith(">"):
                digest_src = t.lstrip("> ").strip()
                break
        raw = re.sub(r"\s+", " ", digest_src or title)
        db = raw.encode("utf-8")
        digest = raw if len(db) <= 120 else db[:120].decode("utf-8", errors="ignore")

        token = pub.get_access_token(pub.load_account(account), s)
        thumb = pub.upload_cover(token, COVER, s)
        qr = PROMO / QR_BY_ACCOUNT.get(account, "platform_qr.png")
        qr_url = pub.upload_content_image(token, qr, s)
        html = render_md_to_wechat_html(md, theme_name="中式水墨").replace(
            "{{QRCODE}}",
            f'<p style="text-align:center"><img src="{qr_url}" '
            'style="width:70%"/></p><p style="text-align:center;'
            'font-size:14px;color:#888">长按识别 · 总包智库报告平台'
            "（试读免费）</p>")
        if "{{QRCODE}}" in html:
            print(f"[FAIL] {account} 二维码注入失败")
            continue

        r = pub.push_draft(title, html, thumb, digest=digest,
                           account_name=account, mode="publish")
        ok = bool(r.get("ok"))
        new_mid = str(r.get("media_id", ""))
        print(f"[{'OK' if ok else 'FAIL'}] {account} | title {len(title)}字/{len(tb)}B "
              f"| digest {len(digest.encode('utf-8'))}B | media_id={new_mid[:24]}…")
        if ok:
            (PROMO / (Path(md_name).stem + "_push_result.json")).write_text(
                json.dumps({**r, "article": {"title": title, "digest": digest},
                            "recreate_of": "1124复盘整改: 标题保全称/digest真实导语/6处事实修正"},
                           ensure_ascii=False, indent=2),
                encoding="utf-8")
            okn += 1
    print(f"[done] 重建 {okn}/3")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
