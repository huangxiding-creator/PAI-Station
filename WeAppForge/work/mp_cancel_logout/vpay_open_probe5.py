# -*- coding: utf-8 -*-
"""vpay_open_probe5 — 实弹切换：总包AI顾问 → 总包科技(wxfdb)。

1) 首页 2) 开顶右账号菜单(开器=菜单父链上可点元素,逐一试)
3) 菜单可见后点「切换账号」 4) dump 账号选择面(找总包科技) 5) 点它 6) 验证新身份
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p5.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p5_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


def try_click(tab, sel, timeout=2.5):
    try:
        el = tab.ele(sel, timeout=timeout)
        if el and el.states.is_displayed:
            el.click()
            time.sleep(2)
            return True
    except Exception:
        pass
    return False


def menu_visible(tab):
    try:
        el = tab.ele('xpath://div[@title="切换账号"]', timeout=1.5)
        return bool(el and el.states.is_displayed)
    except Exception:
        return False


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    m = re.search(r"token=(\d{8,})", tab.url or "")
    if not m:
        for t in page.get_tabs():
            mm = re.search(r"token=(\d{8,})", t.url or "")
            if mm:
                m = mm
                break
    if not m:
        log({"state": "NO_TOKEN"})
        return 1
    token = m.group(1)
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
    time.sleep(3.5)

    # 先剖 menu_box 父链：找开器候选 class
    html = tab.html or ""
    i = html.find('menu_box_account')
    log({"menu_ctx_head": html[max(0, i - 2600):i][:1200] if i >= 0 else "none"})

    # 1) 开账号菜单：候选开器
    opened = False
    for sel in ("css:[class*=account_head]", "css:[class*=account_box]",
                "css:[class*=menu_box_head]", "css:[class*=header_account]",
                "css:[class*=account_entry]", "css:[class*=user_info]",
                "xpath://img[contains(@src,'logo')][1]"):
        if try_click(tab, sel):
            if menu_visible(tab):
                log({"step": "menu_opened_via", "sel": sel})
                opened = True
                break
            else:
                log({"step": "clicked_but_menu_hidden", "sel": sel})
    if not opened:
        # 兜底：点顶右可见的「总包AI顾问」文本(可见实例)
        els = tab.eles('text=总包AI顾问')
        for el in els:
            try:
                if el.states.is_displayed:
                    el.click()
                    time.sleep(2)
                    if menu_visible(tab):
                        log({"step": "menu_opened_via_text"})
                        opened = True
                        break
            except Exception:
                continue
    log({"step": "menu_open", "ok": opened, "shot": shot(tab, "menu")})
    if not opened:
        return 2

    # 2) 点「切换账号」
    clicked = try_click(tab, 'xpath://div[@title="切换账号"]', timeout=3)
    log({"step": "click_switch", "ok": clicked})
    if not clicked:
        # 隐藏态兜底：JS click
        try:
            tab.run_js('document.querySelector(\'div[title="切换账号"]\').click()')
            clicked = True
            log({"step": "click_switch_js", "ok": True})
        except Exception as e:
            log({"step": "click_switch_js_err", "err": str(e)[:200]})
    time.sleep(4)
    url2 = tab.url or ""
    html2 = tab.html or ""
    log({"step": "after_switch_click", "url": url2[:120],
         "total_tech_hits": html2.count("总包科技"), "shot": shot(tab, "swpage")})

    # 3) 找总包科技并点
    tgt = None
    for sel in ("text=总包科技", "xpath://*[contains(text(),'总包科技')]",
                "xpath://div[contains(.,'总包科技')][contains(@class,'account')]"):
        try:
            el = tab.ele(sel, timeout=3)
            if el:
                tgt = el
                log({"step": "target_via", "sel": sel})
                break
        except Exception:
            continue
    if not tgt:
        log({"state": "NO_TARGET", "hits": {"总包科技": (tab.html or "").count("总包科技")},
             "shot": shot(tab, "notgt")})
        return 3
    try:
        if tgt.states.is_displayed:
            tgt.click()
        else:
            tgt.parent(3).click() if hasattr(tgt, "parent") else tgt.click()
    except Exception as e:
        log({"step": "click_target_err", "err": str(e)[:200]})
        try:
            tgt.parent().click()
        except Exception as e2:
            log({"step": "click_target_err2", "err": str(e2)[:200]})
    time.sleep(7)

    # 4) 验证
    url3 = tab.url or ""
    html3 = tab.html or ""
    m3 = re.search(r"token=(\d{8,})", url3)
    am = re.search(r"(wx[0-9a-f]{16})", html3)
    log({"step": "after_target", "url": url3[:130], "token": m3.group(1) if m3 else "",
         "hits": {"AI顾问": html3.count("总包AI顾问"), "总包科技": html3.count("总包科技")},
         "appid_hint": am.group(1) if am else "", "shot": shot(tab, "after")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
