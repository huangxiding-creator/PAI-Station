# -*- coding: utf-8 -*-
"""0.9.2 重钉体验版文字级验证：穿 wujie shadow/iframe 提版本管理行文本，确认 0.9.2 行带「体验版」徽标。
（截图视觉路在本环境被 CDN 化，改走 DOM 文本=零造假判据。）
"""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")

JS = r"""
(() => {
  const texts = [];
  const visit = (doc) => {
    if (!doc) return;
    try { texts.push(doc.body ? doc.body.innerText : ''); } catch (e) {}
    try {
      doc.querySelectorAll('iframe').forEach(f => { try { visit(f.contentDocument); } catch (e) {} });
      doc.querySelectorAll('*').forEach(el => { if (el.shadowRoot) visit(el.shadowRoot); });
    } catch (e) {}
  };
  visit(document);
  return texts.join('\n<<<FRAME>>>\n');
})()
"""

txt = tab.run_js(JS, as_expr=True) or ""
# 只输出与版本行相关的片段
lines = [l.strip() for l in txt.splitlines() if l.strip()]
hits, keep = [], False
for l in lines:
    if any(k in l for k in ("0.9.", "体验版", "开发者版本", "审核版本", "线上版本", "提交审核", "选为体验版")):
        hits.append(l)
print("VERSION_LINES %d" % len(hits))
for h in hits[:80]:
    print("|", h)
# 判据：0.9.2 与 体验版 出现在同一行（徽标与版本号同行）
ok = any(("0.9.2" in h and "体验版" in h) for h in hits)
print("PIN_092_WITH_TRIAL_BADGE =", "YES" if ok else "CHECK_ABOVE")
