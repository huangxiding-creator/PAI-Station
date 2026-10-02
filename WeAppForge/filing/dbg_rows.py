# -*- coding: utf-8 -*-
import time
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
rows = tab.eles('css:tr')
cnt = 0
for r in rows:
    try:
        t = r.text or ''
    except Exception:
        continue
    t2 = t.replace('\n', ' | ')
    if 'epcschool' in t2 or t2.startswith('ai') or '_dnsauth' in t2 or '_cloudbase' in t2:
        print('ROW:', t2[:150])
        cnt += 1
print('matched rows:', cnt)
