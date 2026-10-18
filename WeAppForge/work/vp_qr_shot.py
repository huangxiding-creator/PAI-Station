# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or ''):
        tab = t
        break
if tab is None:
    raise SystemExit('no wrapper tab')
tab.set.activate()
tab.wait(1.0)
tab.get_screenshot(path='E:/AI-Station/WeAppForge/work/vp_qr_now.png', full_page=False)
print('shot saved')
