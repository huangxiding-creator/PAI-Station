# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.new_tab('https://mp.weixin.qq.com/cgi-bin/frame?t=pluginnavigate/index&lang=zh_CN&token=1577852751')
tab.wait(3.0)
# 找侧栏含「支付」的链接
links = []
for a in tab.eles('tag:a'):
    try:
        txt = (a.text or '').strip()
        href = a.attr('href') or ''
    except Exception:
        continue
    if txt and ('支付' in txt or '道具' in txt):
        links.append(txt + ' => ' + href[:130])
print('\n'.join(links[:15]) if links else 'NO PAY LINKS; url=' + tab.url[:120])
tab.get_screenshot(path=r'E:\AI-Station\WeAppForge\work\vp_nav.png')
