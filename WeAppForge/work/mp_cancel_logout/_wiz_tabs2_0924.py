# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    print('-', (t.url or '')[:120])
