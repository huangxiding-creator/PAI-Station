# -*- coding: utf-8 -*-
"""保存 export_once(永久型+已上架)并验证:可能弹QR、可能报错,全截图。"""
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

QR_JS = ("(() => { const w = document.getElementById('qrcheck-caas-dialog');"
         " if (!w) return 'no-el';"
         " const img = w.querySelector('.weui-desktop-qrcheck__img');"
         " const vis = getComputedStyle(w).display !== 'none';"
         " return (vis && img && img.src) ? 'QR-VISIBLE' : 'hidden'; })()")

def qr_state():
    try:
        r = tab.run_cdp('Runtime.evaluate', expression=QR_JS, returnByValue=True)
        return (r.get('result') or {}).get('value', 'err')
    except Exception as e:  # noqa: BLE001
        return 'eval-err:' + str(e)[:60]

print('QR before save:', qr_state(), flush=True)
click(827, 552, 'save')
time.sleep(2.8)
print('QR after save:', qr_state(), flush=True)
print(shot('vp_t4_saved'), flush=True)
