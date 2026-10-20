# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ''):
            return t
gt = find_tab('getcodepage')
if not gt:
    # 无 getcodepage —— 用任一 mp tab 导航过去（token 可能已换）
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if 'mp.weixin.qq.com' in (t.url or ''):
            gt = t; break
    import re
    m = re.search(r'token=(\d+)', gt.url or '')
    tok = m.group(1) if m else ''
    gt.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=%s&lang=zh_CN'" % tok)
    time.sleep(8)
    gt = find_tab('getcodepage')
body = gt.run_js("return (document.body.innerText||'').replace(/\s+/g,' ').slice(0,300)")
print('body:', body[:250])
