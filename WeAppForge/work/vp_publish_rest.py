# -*- coding: utf-8 -*-
"""等用户扫码 → 自动上架剩余 5 道具（自底向上：已上架跳顶，剩余行坐标不动）。
QR 检测走主文档 qrcheck-caas-dialog（对话窗外壳在主 BODY，可 JS 读）。"""
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

# ── 1) 等扫码（最多 6 分钟）──
deadline = time.time() + 360
while time.time() < deadline:
    st = qr_state()
    if st != 'QR-VISIBLE':
        print('QR state ->', st, '(scan done or absent), proceed', flush=True)
        break
    time.sleep(10)
else:
    print('TIMEOUT waiting scan; QR still visible', flush=True)
    sys.exit(2)
time.sleep(2.5)
print(shot('vp_after_scan'), flush=True)

# ── 2) 自底向上发布剩余 5 个（坐标=当前表：498已上架在顶，剩五行 222..332）──
REST = [  # (名称, 编辑按钮 CSS y)  自底向上
    ('unlock_once', 332),
    ('export_once', 305),
    ('report_598', 277),
    ('report_698', 250),
    ('report_1999', 222),
]
for i, (name, y) in enumerate(REST):
    if qr_state() == 'QR-VISIBLE':
        print('ABORT: QR re-appeared before', name, flush=True)
        sys.exit(3)
    click(850, y, 'edit ' + name); time.sleep(1.3)
    click(650, 321, 'status dd'); time.sleep(0.9)
    click(650, 332, 'pick 已上架'); time.sleep(0.7)
    click(827, 552, 'save'); time.sleep(2.2)
    if qr_state() == 'QR-VISIBLE':
        print('QR re-triggered after save', name, '— STOP', flush=True)
        print(shot('vp_qr_retrigger'), flush=True)
        sys.exit(4)
    print(shot('vp_pub_%02d_%s' % (i, name)), flush=True)

print(shot('vp_pub_final'), flush=True)
print('ALL DONE', flush=True)
