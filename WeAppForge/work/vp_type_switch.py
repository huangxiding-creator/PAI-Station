# -*- coding: utf-8 -*-
"""export_once 道具类型 消耗型→永久型:逐步实证。
step1 点开下拉(650,237) -> 截图 vp_t1
step2 从 vp_t1 由人读选项位置后再点(本脚本只做 step1,附带裁剪件)"""
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

# 对话框应该还开着(道具类型=消耗型)。先点开下拉:
click(650, 237, 'open type dd')
time.sleep(1.0)
print(shot('vp_t1_dd_open'), flush=True)
