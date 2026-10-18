# -*- coding: utf-8 -*-
"""钉位验证 v3：菜单坐标回「版本管理」→ CDP DOMSnapshot strings 全量扫版本行。"""
import base64
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")


def click(x, y):
    tab.run_cdp("Input.dispatchMouseEvent", type="mousePressed", x=x, y=y, button="left", clickCount=1)
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseReleased", x=x, y=y, button="left", clickCount=1)


click(140, 499)  # 左侧菜单「版本管理」（已实证坐标）
time.sleep(6)

r = tab.run_cdp("Page.captureScreenshot", format="png")
open("E:/AI-Station/WeAppForge/work/vp092_s10_versionpage.png", "wb").write(
    base64.b64decode(r.get("data", "")))
print("SHOT vp092_s10_versionpage.png")

r = tab.run_cdp("DOMSnapshot.captureSnapshot", computedStyles=[], includeDOMRects=False,
                includePaintOrder=False)
allstr = []
for doc in r.get("documents", []):
    allstr.extend(doc.get("strings", []))
print("DOCS", len(r.get("documents", [])), "STRINGS", len(allstr))
print("KEYS_SAMPLE", sorted(set(list(r.keys())))[:10] if isinstance(r, dict) else type(r))

KEYS = ("0.9.", "体验版", "开发者版本", "线上版本", "审核", "提交", "上传", "robot", "发布", "版本")
hits = [s for s in allstr if any(k in s for k in KEYS)]
for h in hits[:150]:
    print("|", h[:170])
print("HAS_092 =", any("0.9.2" in s for s in allstr))
print("PIN_092_WITH_TRIAL_BADGE =", "YES" if any("0.9.2" in s and "体验版" in s for s in allstr) else "CHECK_ABOVE")
