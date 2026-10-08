# -*- coding: utf-8 -*-
"""vpay_open_probe3 — 账号切换：总包AI顾问 → 总包科技(wxfdb，已改名)。

步骤：1) 落首页 2) 点顶右账号块(总包AI顾问/biaoxun)开下拉
      3) dump 下拉(找「总包科技」) 4) 点总包科技条目 5) 验证切换后身份+token
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p3.log"
NAMES = ("总包AI顾问", "总包科技", "总包学园", "总包说", "biaoxun")


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def hits(html):
    return {nm: html.count(nm) for nm in NAMES}


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p3_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


def click_first(tab, anchors, label):
    """anchors: list of DrissionPage locator strings; 点第一个可见元素。"""
    for sel in anchors:
        try:
            el = tab.ele(sel, timeout=2.5)
            if el and el.states.is_displayed:
                el.click()
                time.sleep(2.2)
                log({"step": label, "clicked_via": sel})
                return True
        except Exception:
            continue
    log({"step": label, "result": "no_click"})
    return False


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    m = re.search(r"token=(\d{8,})", tab.url or "")
    if not m:
        for t in page.get_tabs():
            m = re.search(r"token=(\d{8,})", t.url or "")
            if m:
                break
    if not m:
        log({"state": "NO_TOKEN"})
        return 1
    token = m.group(1)
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
    time.sleep(3)

    # 1) 账号块：顶右「总包AI顾问/biaoxun」整块或昵称
    ok = click_first(tab, [
        "xpath://div[contains(@class,'header')]//div[.//text()='总包AI顾问']",
        "xpath://*[@class and text()='总包AI顾问']/..",
        "text=总包AI顾问",
        "text=biaoxun",
        "css:.weui-desktop_name",
        "css:.account_meta_weapp_name",
    ], "open_switcher")
    html = tab.html or ""
    log({"step": "after_switcher", "hits": hits(html), "shot": shot(tab, "sw")})

    # 2) 找「总包科技」条目（下拉 li/a 或含链接）
    target = None
    try:
        target = tab.ele("text=总包科技", timeout=3) or tab.ele("xpath://*[contains(text(),'总包科技')]", timeout=2)
    except Exception:
        pass
    log({"step": "target_found", "found": bool(target)})
    if not target:
        # 下拉可能懒加载：再等一拍重找
        time.sleep(2)
        try:
            target = tab.ele("text=总包科技", timeout=3)
        except Exception:
            target = None
        log({"step": "target_retry", "found": bool(target), "hits": hits(tab.html or "")})
    if not target:
        log({"state": "NO_TARGET_STOP", "shot": shot(tab, "notgt")})
        return 2

    # 3) 点击总包科技（若条目是文本节点，点上层可点容器）
    try:
        if target.states.is_displayed:
            target.click()
        else:
            target.parent().click()
    except Exception as e:
        log({"step": "click_target_err", "err": str(e)[:200]})
        try:
            target.parent().click()
        except Exception as e2:
            log({"step": "click_parent_err", "err": str(e2)[:200]})
    time.sleep(6)  # 切号整页刷新

    # 4) 验证：新身份/token/appid
    url2 = tab.url or ""
    m2 = re.search(r"token=(\d{8,})", url2)
    html2 = tab.html or ""
    am = re.search(r"(wx[0-9a-f]{16})", html2)
    log({"step": "after_switch", "url_head": url2[:110], "token": m2.group(1) if m2 else "",
         "hits": hits(html2), "appid_hint": am.group(1) if am else "",
         "shot": shot(tab, "after")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
