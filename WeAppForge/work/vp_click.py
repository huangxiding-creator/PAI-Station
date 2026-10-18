# -*- coding: utf-8 -*-
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

def click(css_x, css_y, tag=''):
    for typ, btn in (('mousePressed', 0), ('mouseReleased', 0)):
        tab.run_cdp('Input.dispatchMouseEvent', type=typ, x=css_x, y=css_y, button='left', clickCount=1, buttons=1 if typ == 'mousePressed' else 0)
    print('clicked', tag, css_x, css_y)
    time.sleep(1.2)

# 下拉选项「已上架」（vp_status_dd.png：displayed x~1300 y~665 → CSS 650,332）
click(650, 332, 'pick 已上架')
print(shot('vp_picked'))
time.sleep(0.6)
# 保存（displayed x~1655 y~1105 → CSS 827,552）
click(827, 552, 'save')
print(shot('vp_saved'))
