# -*- coding: utf-8 -*-
"""T19 网络诊断：Chromium 代理旁路形态对照（direct:// vs --no-proxy-server vs 缺省）。"""
from playwright.sync_api import sync_playwright

CASES = {
    "default": {},
    "direct": {"proxy": {"server": "direct://"}},
    "noproxy_args": {"args": ["--no-proxy-server"]},
}
for name, kw in CASES.items():
    try:
        with sync_playwright() as pw:
            b = pw.chromium.launch(headless=True, **kw)
            pg = b.new_page()
            try:
                r = pg.goto("https://www.baidu.com/", timeout=15000)
                print(name, "->", r.status if r else None)
            except Exception as e:
                print(name, "GOTO FAIL", str(e)[:110])
            b.close()
    except Exception as e:
        print(name, "LAUNCH FAIL", str(e)[:110])
