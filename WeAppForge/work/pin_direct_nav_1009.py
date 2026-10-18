# -*- coding: utf-8 -*-
"""钉 0.9.3：直接导航版本管理真路由 → 截图+DOM行双验（不再依赖侧栏坐标）。"""
import base64
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")

tab.get("https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=1577852751&lang=zh_CN")
time.sleep(8)

r = tab.run_cdp("Page.captureScreenshot", format="png")
open("E:/AI-Station/WeAppForge/work/vp093_s4_direct.png", "wb").write(base64.b64decode(r.get("data", "")))
print("SHOT vp093_s4_direct.png", "URL:", (tab.url or "")[:130])

JS = r"""
(() => {
  const out = [];
  const visit = (doc, d) => {
    if (!doc || d > 5) return;
    try {
      (doc.body ? doc.body.innerText : '').split('\n').forEach(l => {
        l = l.trim();
        if (l && /0\.9\.|体验版|开发者版本|线上版本|选为|robot|提交审核|驳回|审核中/.test(l)) out.push(l.slice(0, 140));
      });
    } catch (e) {}
    try {
      doc.querySelectorAll('iframe').forEach(f => { try { visit(f.contentDocument, d + 1); } catch (e) {} });
      doc.querySelectorAll('*').forEach(el => { if (el.shadowRoot) visit(el.shadowRoot, d + 1); });
    } catch (e) {}
  };
  visit(document, 0);
  return Array.from(new Set(out)).join('\n');
})()
"""
txt = tab.run_js(JS, as_expr=True) or ""
lines = [l for l in txt.splitlines() if l.strip()]
print("VERSION_LINES", len(lines))
for l in lines[:80]:
    print("|", l)
