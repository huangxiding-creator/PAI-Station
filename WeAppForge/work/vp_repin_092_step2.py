# -*- coding: utf-8 -*-
"""重钉体验版 0.9.2 step2: 点行内「选为体验版」→ 截图(确认弹窗坐标下一步)。"""
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

click(931, 299)  # 0.9.2 行 选为体验版
time.sleep(3)
print(shot('vp092_s5_confirm'), flush=True)
