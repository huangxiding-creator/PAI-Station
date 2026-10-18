# -*- coding: utf-8 -*-
"""点选 永久型 (实测坐标 714,311) 并验证字段变化。"""
import sys, time, base64
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or ''):
        tab = t
        break

def shot(name):
    r = tab.run_cdp('Page.captureScreenshot', format='png')
    p = 'E:/AI-Station/WeAppForge/work/%s.png' % name
    open(p, 'wb').write(base64.b64decode(r.get('data', '')))
    return p

def click(x, y, tag=''):
    for typ in ('mousePressed', 'mouseReleased'):
        tab.run_cdp('Input.dispatchMouseEvent', type=typ, x=x, y=y,
                    button='left', clickCount=1,
                    buttons=1 if typ == 'mousePressed' else 0)
    print('clicked', tag, x, y, flush=True)

click(714, 311, 'pick 永久型')
time.sleep(1.2)
print(shot('vp_t2_picked'), flush=True)
