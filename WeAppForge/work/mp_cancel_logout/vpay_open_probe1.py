# -*- coding: utf-8 -*-
"""vpay_open_probe1 — wxfdb 虚拟支付开通战役·第一探针（只读，零点击）。

目的：确认 9336 专属控制台浏览器的登录态与当前管理的小程序身份，
为「自行开通 wxfdb 虚拟支付」定通道形态（同管多号可切换 / 须换码重登）。

输出 JSON: {state: QR_WAIT|LOGGED_IN|ERROR, current_name, appid_hint, token_ok, tabs}
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch, MP_ROOT  # noqa: E402


def main():
    try:
        page = attach_or_launch()
    except Exception as e:
        print(json.dumps({"state": "ERROR", "msg": str(e)[:300]}))
        return 1
    tab = page.latest_tab
    url = tab.url or ""
    title = tab.title or ""
    tabs_info = [{"url": (t.url or "")[:120], "title": (t.title or "")[:40]} for t in page.get_tabs()]

    if "mp.weixin.qq.com" not in url:
        tab.get(MP_ROOT)
        time.sleep(2)
        url, title = tab.url, tab.title

    if url.rstrip("/") == MP_ROOT.rstrip("/") or "scanlogin" in url or title == "微信公众平台":
        stale = ("已失效" in (tab.html or "")) or ("点击刷新" in (tab.html or ""))
        print(json.dumps({"state": "QR_WAIT", "qr_stale": stale, "tabs": tabs_info}, ensure_ascii=False))
        return 0

    # 已登录：提取 live token + 身份线索
    m = re.search(r"token=(\d{8,})", url)
    token_ok = bool(m)
    html = tab.html or ""
    names = {}
    for nm in ("总包AI顾问", "总包学园", "总包说", "标讯"):
        names[nm] = html.count(nm)
    # 当前账号昵称：控制台首页顶部/侧栏通常含当前小程序名
    current_name = next((k for k, v in names.items() if v > 0), None)
    # appid 线索：页面源码偶有 appid 出现
    am = re.search(r"(wx[0-9a-f]{16})", html)
    appid_hint = am.group(1) if am else ""
    print(json.dumps({
        "state": "LOGGED_IN", "current_name": current_name, "name_hits": names,
        "appid_hint": appid_hint, "token_ok": token_ok,
        "url_head": url[:110], "tabs": tabs_info[:6],
    }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
