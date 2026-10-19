# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
nt = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'wasysnotify' in (t.url or ''):
        nt = t; break
body = nt.run_js("return (document.body.innerText||'').replace(/\s+/g,' ').slice(0,2500)")
print(body[:2300])
