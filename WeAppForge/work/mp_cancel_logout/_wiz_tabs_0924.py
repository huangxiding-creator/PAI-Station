# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
# DrissionPage: 列出同浏览器全部标签
try:
    tabs = page.browser.tab_ids
    print('tabs:', len(tabs))
    for tid in tabs:
        t = page.browser.get_tab(tid)
        print('-', (t.url or '')[:110])
except Exception as e:
    print('tab err:', e)
    print('cur url:', page.url[:120])
