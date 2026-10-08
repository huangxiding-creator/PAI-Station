# -*- coding: utf-8 -*-
"""vpay_open_probe2 — 找账号切换器，列出同管小程序清单（目标：总包学园 wxfdb）。

动作：1) 落控制台首页 /wxamp/index 2) 读首页账号线索
      3) 点右上角账号切换器（当前昵称「总包AI顾问」附近下拉）4) dump 下拉条目
仅此两步，不动其他任何按钮。
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p2.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def name_hits(html):
    return {nm: html.count(nm) for nm in ("总包AI顾问", "总包学园", "总包说", "总包之声")}


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    m = re.search(r"token=(\d{8,})", tab.url or "")
    token = m.group(1) if m else ""
    if not token:  # 从任一 tab 找
        for t in page.get_tabs():
            m = re.search(r"token=(\d{8,})", t.url or "")
            if m:
                token = m.group(1)
                break
    log({"step": "token", "token_ok": bool(token)})
    if not token:
        log({"state": "NO_TOKEN"})
        return 1

    # 1) 落控制台首页
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
    time.sleep(3.5)
    html = tab.html or ""
    log({"step": "home", "hits": name_hits(html), "url": (tab.url or "")[:90]})

    # 2) 账号切换器：常见容器 .weui-desktop_account / 顶部昵称
    clicked = False
    for sel in ("css:.weui-desktop_account", "css:.account_meta_weapp_name",
                "xpath://div[contains(@class,'account')][contains(.,'总包AI顾问')]"):
        try:
            el = tab.ele(sel, timeout=3)
            if el and el.states.is_displayed:
                el.click()
                time.sleep(2)
                clicked = True
                log({"step": "switcher_click", "via": sel})
                break
        except Exception:
            continue
    if not clicked:
        log({"step": "switcher_click", "result": "not_found_no_click"})

    # 3) dump 切换器下拉（若弹出）
    html2 = tab.html or ""
    hits2 = name_hits(html2)
    # 下拉条目常见结构：包含 nickname 的链接块
    items = []
    for m2 in re.finditer(r'(总包(?:AI顾问|学园|说|之声))', html2):
        if m2.group(1) not in items:
            items.append(m2.group(1))
    log({"step": "dropdown_dump", "hits": hits2, "unique_names": items,
         "shot": shot(tab)})
    return 0


def shot(tab):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p2_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


if __name__ == "__main__":
    sys.exit(main())
