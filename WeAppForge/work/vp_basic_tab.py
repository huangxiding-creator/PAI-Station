# -*- coding: utf-8 -*-
"""基础配置 tab 实证：找『体验版对应价格 1000』的配置源。
文本提取器已修：剔除 style/script 再取 textContent。"""
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

CLEAN_TEXT = """
(() => {
  const app = document.querySelector('wujie-app');
  if (!app || !app.shadowRoot) return 'no-shadow';
  const root = app.shadowRoot.cloneNode(true);
  root.querySelectorAll('style,script').forEach(e => e.remove());
  return (root.textContent || '').replace(/[ \\t\\n]+/g, ' ').replace(/ {2,}/g, ' ').trim().slice(0, 4000);
})()
"""

def sh_text():
    return ev(CLEAN_TEXT)

def click_text(txt):
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

# ── 0) 当前页全文（错误弹窗应还在）──
print('NOW:', str(sh_text())[:800], flush=True)

# ── 1) 关错误弹窗（确定/我知道了之类）──
for btn in ('确 定', '确定', '我知道了', '知道了'):
    r = click_text(btn)
    if r == 'clicked':
        print('closed-modal-via:', btn, flush=True)
        break
else:
    print('no-modal-button-found', flush=True)
time.sleep(1.0)

# ── 2) 开基础配置 tab ──
r = click_text('基础配置')
print('click 基础配置:', r, flush=True)
time.sleep(2.2)
print('BASIC-CFG:', str(sh_text())[:3500], flush=True)
print(shot('vp_basic_cfg2'), flush=True)
