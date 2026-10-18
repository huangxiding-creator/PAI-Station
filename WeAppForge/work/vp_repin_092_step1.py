# -*- coding: utf-8 -*-
"""重钉体验版 0.9.2 step1: 到达版本管理页(左侧菜单坐标流) + 截图。"""
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

print('tab url:', (tab.url or '')[:100], flush=True)
# 先回控制台首页(token 存活则直接进;死则换 token 手段)
tab.get('https://mp.weixin.qq.com/wxamp/basicframe/index#inner-navigate:/%2Fhome%2Findex%3Ftoken%3D1577852751%26lang%3Dzh_CN')
time.sleep(5)
print(shot('vp092_s1_home'), flush=True)
# 左侧菜单「版本管理」(实证坐标)
click(140, 499)
time.sleep(5)
print(shot('vp092_s2_version'), flush=True)
