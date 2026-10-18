# -*- coding: utf-8 -*-
"""export_once 上架实证 + wujie shadow DOM 文本直读。
关键修正：之前『export_once 会撞 1000 规则』是推测（当时错误弹窗吞了点击，
编辑框从未打开过）。现在对话框字段已见（体验版道具未勾），直接试存。"""
import sys, time, base64, json
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

def ev(js):
    r = tab.run_cdp('Runtime.evaluate', expression=js, returnByValue=True)
    return (r.get('result') or {}).get('value')

def click_text(txt):
    """shadow DOM 里点最深一层文本恰好等于 txt 的元素（tab/按钮通用）。"""
    return ev("""
    (() => {
      const app = document.querySelector('wujie-app');
      if (!app || !app.shadowRoot) return 'no-shadow';
      const all = app.shadowRoot.querySelectorAll('*');
      let best = null;
      for (const el of all) {
        if (el.children.length === 0 && (el.textContent || '').trim() === %s) best = el;
      }
      if (!best) return 'not-found';
      best.click();
      return 'clicked';
    })()
    """ % json.dumps(txt))

def sh_text():
    """shadow DOM 全文（压空白），直读页面状态/错误弹窗。"""
    return ev("""
    (() => {
      const app = document.querySelector('wujie-app');
      if (!app || !app.shadowRoot) return 'no-shadow';
      return (app.shadowRoot.textContent || '').replace(/\\s+/g, ' ').slice(0, 3000);
    })()
    """)

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
        return (tab.run_cdp('Runtime.evaluate', expression=QR_JS, returnByValue=True)
                .get('result', {}).get('value', 'err'))
    except Exception as e:  # noqa: BLE001
        return 'eval-err:' + str(e)[:60]

# ── 0) 探 shadow DOM ──
print('QR:', qr_state(), flush=True)
print('SH-PROBE:', str(sh_text())[:500], flush=True)

# ── 1) 若编辑对话框还开着：点「取消」关掉 ──
r = click_text('取 消')
if r == 'not-found':
    r = click_text('取消')
print('cancel-dialog:', r, flush=True)
time.sleep(1.2)

# ── 2) 重开 export_once 编辑（第5行 y≈305；坐标实证过）──
click(850, 305, 'edit export_once')
time.sleep(1.6)
print('dialog-open-text:', str(sh_text())[:1200], flush=True)
print(shot('vp_export_edit2'), flush=True)

# ── 3) 状态下拉 → 已上架 ──
click(650, 321, 'status dd'); time.sleep(0.9)
click(650, 332, 'pick 已上架'); time.sleep(0.8)
print(shot('vp_export_picked'), flush=True)

# ── 4) 保存 → 读结果（DOM 文本直取，错误弹窗原文全量落袋）──
click(827, 552, 'save'); time.sleep(2.5)
after = str(sh_text())
print('AFTER-SAVE:', after[:1500], flush=True)
print(shot('vp_export_saved'), flush=True)
print('QR:', qr_state(), flush=True)
