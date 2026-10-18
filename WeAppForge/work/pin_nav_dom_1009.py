# -*- coding: utf-8 -*-
"""钉位验证 v5：DOM 定位侧栏「版本管理」菜单项→点击→截图（后续 Read 视觉核验）。"""
import base64
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")

# 多定位策略找「版本管理」菜单项（DrissionPage 自动穿 iframe）
cands = []
for loc in ("text=版本管理", "text:版本管理", "@title=版本管理", "@aria-label=版本管理"):
    try:
        els = tab.eles(loc)
        if els:
            for e in els[:3]:
                try:
                    cands.append((loc, e.rect.midpoint, (e.text or "")[:20]))
                except Exception:
                    pass
    except Exception as err:
        print("LOC_FAIL", loc, str(err)[:80])
print("CANDIDATES", cands[:6])

if not cands:
    raise SystemExit("NO_MENU_ITEM_FOUND")

x, y = cands[0][1]
print("CLICK", x, y)
tab.run_cdp("Input.dispatchMouseEvent", type="mousePressed", x=x, y=y, button="left", clickCount=1)
tab.run_cdp("Input.dispatchMouseEvent", type="mouseReleased", x=x, y=y, button="left", clickCount=1)
time.sleep(6)

r = tab.run_cdp("Page.captureScreenshot", format="png")
open("E:/AI-Station/WeAppForge/work/vp092_s11_versionpage.png", "wb").write(
    base64.b64decode(r.get("data", "")))
print("SHOT vp092_s11_versionpage.png")
