# -*- coding: utf-8 -*-
import sys, json, time, base64
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or '') and 'xframe' not in (t.url or ''):
        tab = t
        break

# 关掉多余的同页标签（留这一个干净的）
subs = [t for t in page.get_tabs() if 'subApp/skit/manage/goods' in (t.url or '')]
for extra in subs[1:]:
    try:
        extra.close()
    except Exception:
        pass
try:
    for t in page.get_tabs():
        if 'xframe/skit/manage/goods' in (t.url or ''):
            t.close()
except Exception:
    pass
print('tabs now:', len([t for t in page.get_tabs() if 'skit' in (t.url or '')]))

# 重载
tab.run_cdp('Page.reload', ignoreCache=True)
time.sleep(6)

# 状态三查：截图 + qrcheck dialog 显隐 + QR img src
r = tab.run_cdp('Page.captureScreenshot', format='png')
open('E:/AI-Station/WeAppForge/work/vp_reload1.png', 'wb').write(base64.b64decode(r.get('data', '')))
print('shot saved')

JS = r"""
(function(){
  var d = document.getElementById('qrcheck-caas-dialog');
  var st = d ? (d.getAttribute('style') || '') : 'NO-DIALOG';
  var img = document.querySelector('.weui-desktop-qrcheck__img');
  var src = img ? (img.getAttribute('src') || '') : 'NO-IMG';
  src = src.startsWith('data:') ? ('data:...' + src.length + 'chars') : src.slice(0, 120);
  var mask = document.querySelector('.little_menu_unclick_mask');
  return 'dialog=' + st + ' | qr_src=' + src + ' | mask=' + (mask ? 'YES' : 'no');
})()
"""
rr = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print(str(rr.get('result', {}).get('value', '')))
