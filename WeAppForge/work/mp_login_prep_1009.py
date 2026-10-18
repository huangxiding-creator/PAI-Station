# -*- coding: utf-8 -*-
"""控制台重登准备：导航 mp.weixin.qq.com 登录页 → 等二维码 → 截图（Read 视觉确认后叫用户扫）。"""
import base64
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")

tab.get("https://mp.weixin.qq.com/")
time.sleep(8)

r = tab.run_cdp("Page.captureScreenshot", format="png")
open("E:/AI-Station/WeAppForge/work/mp_login_qr_1009.png", "wb").write(
    base64.b64decode(r.get("data", "")))
print("SHOT mp_login_qr_1009.png URL:", (tab.url or "")[:100])

# 二维码元素探活（登录页 .login__type__container__scan / qrcode img）
found = []
for loc in ("tag:img@src:qrcode", "@class:login", "text:扫码登录", "text:使用帐号密码登录"):
    try:
        els = tab.eles(loc)
        if els:
            found.append((loc, len(els)))
    except Exception:
        pass
print("LOGIN_ELEMENTS", found)
