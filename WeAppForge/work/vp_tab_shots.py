# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
subs = [t for t in page.get_tabs() if 'subApp/skit/manage/goods' in (t.url or '')]
for i, t in enumerate(subs):
    t.get_screenshot(path='E:/AI-Station/WeAppForge/work/vp_tab%d.png' % i, full_page=False)
    print('shot tab', i, 'saved')
