# -*- coding: utf-8 -*-
"""djyanbao_click_probe — 卡片真实点击目标探测 (改版适配 3).

点击卡内各候选元素 (标题 div/整卡/按钮), 观察导航/新tab, 输出哪个真进详情.
"""
from __future__ import annotations

import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402

PROFILE = Path(__file__).resolve().parents[1] / "data" / "harvest" / "_djyanbao_profile"


def main() -> int:
    q = sys.argv[1] if len(sys.argv) > 1 else "电子招投标"
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(9533)
    page = ChromiumPage(co)
    page.get(f"https://www.djyanbao.com/search?q={quote(q)}", timeout=25)
    time.sleep(7)
    rows = page.eles(
        'xpath://div[contains(@class,"py-3") and contains(@class,"border-b")]')
    card = next(r for r in rows
                if "页" in (r.text or "") and "·" in (r.text or ""))
    print(f"[click] 卡片: {(card.text or '')[:60].replace(chr(10), ' ')}")
    # 候选点击目标解剖
    for desc, xpath in (
        ("标题按钮", './/button[contains(@class,"font-semibold")]'),
        ("标题span", './/button//span'),
        ("整卡", "."),
    ):
        try:
            el = card.ele(f"xpath:{xpath}", timeout=3)
        except Exception:
            print(f"[click] {desc}: 定位失败")
            continue
        url0, tabs0 = page.url, page.tabs_count
        try:
            el.click()
        except Exception as e:
            print(f"[click] {desc}: 点击异常 {str(e)[:50]}")
            continue
        time.sleep(4)
        url1, tabs1 = page.url, page.tabs_count
        print(f"[click] {desc}: url {url0[-24:]} → {url1[-40:]} | tabs {tabs0}→{tabs1}")
        if url1 != url0 or tabs1 > tabs0:
            tgt = page.get_tab(page.tab_ids[-1]) if tabs1 > tabs0 else page
            print(f"[click]   ✅ 导航成功 title={((tgt.ele('tag:h1', timeout=3).text) or '')[:50] if tgt.ele('tag:h1', timeout=3) else '(无h1)'}")
            print(f"[click]   body 头: {(tgt.ele('tag:body').text or '')[:100].replace(chr(10), ' | ')}")
            if tabs1 > tabs0:
                page.get_tab(page.tab_ids[-1]).close()
            else:
                page.back()
                time.sleep(2)
            return 0
        # 无导航 → 试下一个候选
    print("[click] 全候选无导航 — 需键盘/JS 路线")
    return 2


if __name__ == "__main__":
    sys.exit(main())
