# -*- coding: utf-8 -*-
"""钉位验证 v2b：DOMSnapshot strings 全量扫（strings 含全部节点名与文本，字段最稳）。"""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")
print("TAB_URL", (tab.url or "")[:120])

r = tab.run_cdp("DOMSnapshot.captureSnapshot", computedStyles=[], includeDOMRects=False,
                includePaintOrder=False)
allstr = []
for doc in r.get("documents", []):
    allstr.extend(doc.get("strings", []))
print("DOCS", len(r.get("documents", [])), "STRINGS", len(allstr))

KEYS = ("0.9.", "体验版", "开发者版本", "线上版本", "审核", "提交", "上传", "robot", "发布", "版本")
hits = [s for s in allstr if any(k in s for k in KEYS)]
for h in hits[:150]:
    print("|", h[:170])
print("HAS_092 =", any("0.9.2" in s for s in allstr))
print("PIN_092_WITH_TRIAL_BADGE =", "YES" if any("0.9.2" in s and "体验版" in s for s in allstr) else "CHECK_ABOVE")
