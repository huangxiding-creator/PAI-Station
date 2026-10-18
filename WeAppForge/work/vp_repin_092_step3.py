# -*- coding: utf-8 -*-
"""重钉体验版 0.9.2 step3: 确认弹窗「确定」→ 截验证图。"""
import sys, time, base64
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'mp.weixin.qq.com' in (t.url or ''):
        tab = t
        break
if tab is None:
    raise SystemExit('no mp tab')

def shot(name):
    r = tab.run_cdp('Page.captureScreenshot', format='png')
    p = 'E:/AI-Station/WeAppForge/work/%s.png' % name
    open(p, 'wb').write(base64.b64decode(r.get('data', '')))
    return p

def click(x, y):
    tab.run_cdp('Input.dispatchMouseEvent', type='mousePressed', x=x, y=y, button='left', clickCount=1)
    tab.run_cdp('Input.dispatchMouseEvent', type='mouseReleased', x=x, y=y, button='left', clickCount=1)

click(620, 432)  # 确认弹窗「确定」
time.sleep(4)
print(shot('vp092_s7_after'), flush=True)
