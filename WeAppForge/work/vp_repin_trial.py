# -*- coding: utf-8 -*-
"""体验版重钉 0.9.0 -> 0.9.1:版本管理页 + 安全定位(版本号锚定块内找按钮)。"""
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

def ev(js):
    r = tab.run_cdp('Runtime.evaluate', expression=js, returnByValue=True)
    return (r.get('result') or {}).get('value')

print('current url:', tab.url[:90], flush=True)
# 直达版本管理(带token);失败则从首页点
tab.get('https://mp.weixin.qq.com/wxamp/wacodepage/code_index?token=1577852751&lang=zh_CN')
time.sleep(5)
print(shot('vp_pin1_codepage'), flush=True)
