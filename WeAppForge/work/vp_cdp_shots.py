# -*- coding: utf-8 -*-
import sys, base64
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tabs = [t for t in page.get_tabs() if 'skit/manage/goods' in (t.url or '')]
for i, t in enumerate(tabs):
    r = t.run_cdp('Page.captureScreenshot', format='png')
    data = r.get('data')
    if not data:
        print(i, 'no data')
        continue
    path = 'E:/AI-Station/WeAppForge/work/vp_cdp%d.png' % i
    open(path, 'wb').write(base64.b64decode(data))
    print(i, 'saved', path, ((t.url or '')[:60]))
