# -*- coding: utf-8 -*-
"""钉 0.9.3 step1：回版本管理页 → 截图（视觉定位 0.9.3 行与「选为体验版」按钮坐标，下一步才点）。"""
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
open("E:/AI-Station/WeAppForge/work/vp093_s1_locate.png", "wb").write(base64.b64decode(r.get("data", "")))
print("SHOT vp093_s1_locate.png")

# 同步抓 DOM 文本（版本行信息）
JS = r"""
(() => {
  const out = [];
  const visit = (doc, d) => {
    if (!doc || d > 4) return;
    try {
      (doc.body ? doc.body.innerText : '').split('\n').forEach(l => {
        l = l.trim();
        if (l && /0\.9\.|体验版|开发者版本|线上版本|选为|robot|提交审核/.test(l)) out.push(l.slice(0, 120));
      });
    } catch (e) {}
    try {
      doc.querySelectorAll('iframe').forEach(f => { try { visit(f.contentDocument, d + 1); } catch (e) {} });
      doc.querySelectorAll('*').forEach(el => { if (el.shadowRoot) visit(el.shadowRoot, d + 1); });
    } catch (e) {}
  };
  visit(document, 0);
  return out.join('\n');
})()
"""
txt = tab.run_js(JS, as_expr=True) or ""
lines = [l for l in txt.splitlines() if l.strip()]
print("VERSION_LINES", len(lines))
for l in lines[:60]:
    print("|", l)
