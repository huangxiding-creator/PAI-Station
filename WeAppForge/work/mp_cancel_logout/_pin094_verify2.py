# -*- coding: utf-8 -*-
import json, sys
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
txt = (tab.run_js("return document.body.innerText;") or "")
hits = []
start = 0
while True:
    i = txt.find("体验版", start)
    if i < 0: break
    hits.append(txt[i:i+150].replace("\n", " "))
    start = i + 3
print(json.dumps({"n_hits": len(hits), "windows": hits[:6], "pinned": any("0.9.4" in h for h in hits)}, ensure_ascii=False))
