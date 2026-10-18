# -*- coding: utf-8 -*-
"""export_once 对话框(已=永久型):状态 下拉→已上架,截图验证(先不保存)。"""
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

click(650, 321, 'status dd')
time.sleep(0.9)
print(shot('vp_t3_dd'), flush=True)
click(650, 332, 'pick 已上架')
time.sleep(0.9)
print(shot('vp_t3_status'), flush=True)
