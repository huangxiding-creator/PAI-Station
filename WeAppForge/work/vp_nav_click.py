# -*- coding: utf-8 -*-
"""左侧菜单 DOM 直点「版本管理」+ 截图。"""
import sys, time, base64
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'mp.weixin.qq.com' in (t.url or ''):
        tab = t
        break

def shot(name):
    r = tab.run_cdp('Page.captureScreenshot', format='png')
    p = 'E:/AI-Station/WeAppForge/work/%s.png' % name
    open(p, 'wb').write(base64.b64decode(r.get('data', '')))
    return p

def ev(js):
    r = tab.run_cdp('Runtime.evaluate', expression=js, returnByValue=True)
    return (r.get('result') or {}).get('value')

# 找所有含「版本管理」的叶子元素
r = ev("""
(() => {
  const hits = [];
  for (const el of document.querySelectorAll('a, span, div, li')) {
    if (el.children.length === 0) {
      const t = (el.textContent || '').trim();
      if (t === '版本管理' || t === '开发管理' || t === '管理') {
        const rc = el.getBoundingClientRect();
        hits.push({tag: el.tagName, text: t, x: Math.round(rc.x + rc.width/2), y: Math.round(rc.y + rc.height/2)});
      }
    }
  }
  return JSON.stringify(hits);
})()
""")
print('menu items:', r, flush=True)
