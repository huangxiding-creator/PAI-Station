# -*- coding: utf-8 -*-
import io, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions()
co.set_address('127.0.0.1:9334')
co.headless(False)
co.auto_port(False)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
tab.get('https://mp.weixin.qq.com/')
tab.wait(3.0)
url = tab.url
html = tab.html or ''
out = []
out.append('URL: ' + url[:120])
out.append('LOGIN_QR: ' + str('登录' in html and '二维码' in html))
out.append('HAS_HOME: ' + str('小程序' in html or 'appmsg' in html or 'home' in url))
# 控制台首页若已登录，通常跳到 /cgi-bin/home 或带 token 的页面
tab.get_screenshot(path=r'E:\AI-Station\WeAppForge\work\vp_recon_home.png')
io.open(r'E:\AI-Station\WeAppForge\work\vp_recon.txt', 'w', encoding='utf-8').write('\n'.join(out))
print('\n'.join(out))
