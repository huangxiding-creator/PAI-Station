# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage
page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'skit/manage/goods' in (t.url or ''): tab = t; break
r = tab.run_cdp('Runtime.evaluate', expression='1+1', returnByValue=True)
print('sanity:', json.dumps(r)[:300])
r2 = tab.run_cdp('Runtime.evaluate',
    expression='document.querySelectorAll("iframe").length + "|" + (document.body ? document.body.innerText.length : -1)',
    returnByValue=True)
print('probe:', json.dumps(r2)[:300])
