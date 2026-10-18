# -*- coding: utf-8 -*-
"""基础配置 tab + export_once 编辑框实证：找「体验版对应价格」来源。"""
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

# 1) 基础配置 tab（vp_pub_final.png：displayed x~740 y~252 → CSS 370,126）
click(370, 126, 'tab 基础配置')
time.sleep(2.0)
print(shot('vp_basic_cfg'), flush=True)
# 2) 回道具管理
click(310, 126, 'tab 道具管理')
time.sleep(2.0)
# 3) export_once 编辑（第5行 displayed y~610 → CSS 305）
click(850, 305, 'edit export_once')
time.sleep(1.5)
print(shot('vp_edit_export'), flush=True)
