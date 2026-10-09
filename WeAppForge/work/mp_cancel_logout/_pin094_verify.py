# -*- coding: utf-8 -*-
import json, re, sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
txt = (tab.run_js("return document.body.innerText;") or "")
i = txt.find("体验版本")
seg = txt[max(0,i-40): i+200].replace("\n", " ")
print(json.dumps({"trial_card_ctx": seg, "pinned_094": "0.9.4" in seg}, ensure_ascii=False))
