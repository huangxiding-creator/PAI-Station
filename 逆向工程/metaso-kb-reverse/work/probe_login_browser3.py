# -*- coding: utf-8 -*-
"""probe_login_browser3.py — React原生setter灌值版UI登录 (最终判别)"""
import json, sys, time, tempfile, shutil
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']

prof = tempfile.mkdtemp(prefix='metaso_probe3_')
co = ChromiumOptions()
co.set_user_data_path(prof)
co.set_argument('--start-minimized')
co.set_argument('--window-position=32000,32000')
co.auto_port()
b = Chromium(co)
tab = b.latest_tab
try:
    tab.listen.start('metaso.cn')
    tab.get('https://metaso.cn')
    time.sleep(4)
    tab.ele('text:登录', timeout=6).click(); time.sleep(2)
    tab.ele('text:账号密码', timeout=6).click(); time.sleep(1.5)
    fill_js = """
    (phone, pwd) => {
      const setv = (el, v) => {
        const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
        setter.call(el, v);
        el.dispatchEvent(new Event('input', {bubbles: true}));
        el.dispatchEvent(new Event('change', {bubbles: true}));
      };
      const n = document.querySelector('input[type=number], input[type=tel]');
      const p = document.querySelector('input[type=password]');
      if (!n || !p) return 'inputs-missing';
      n.focus(); setv(n, phone);
      p.focus(); setv(p, pwd);
      return JSON.stringify({numLen: n.value.length, pwdLen: p.value.length});
    }
    """
    r = tab.run_js(fill_js, phone, pwd)
    print('fill result:', r)
    tab.run_js('var c=document.querySelector(\'input[name="policy-checkbox"]\');if(c){c.closest(\'.MuiCheckbox-root, label, span\')?.click();c.click();}')
    time.sleep(0.8)
    tab.get_screenshot(path=CAP, name='ui3_login_filled', full_page=False)
    submitted = False
    for label in ('登 录', '登　录', '登录'):
        btn = tab.ele(f'text={label}', timeout=2)
        if btn:
            btn.click(); submitted = True; print('submit clicked:', label); break
    t0 = time.time(); login_xhr = []
    while time.time() - t0 < 14:
        for p in tab.listen.steps(timeout=2, count=8):
            u = p.url or ''
            if any(k in u for k in ('/login', 'my-info', 'captcha', 'cloudflare')):
                try: rb = (p.request.postData or '').replace(phone, '158****2899')
                except Exception: rb = '(nobody)'
                try: rsp = str(p.response.body)[:260].replace(phone, '158****2899')
                except Exception: rsp = '(noresp)'
                line = f'{u[:80]} | {rb[:150]} => {rsp[:150]}'
                if line not in login_xhr: login_xhr.append(line)
        time.sleep(1)
    for l in login_xhr: print('>>', l)
    time.sleep(2)
    tab.get_screenshot(path=CAP, name='ui3_login_after', full_page=False)
    js = """
    return (async () => {
        const meta = document.querySelector('meta[id="meta-token"]');
        const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': meta ? meta.content : ''}});
        const j = await resp.json();
        return JSON.stringify({errCode: j.errCode, data: j.data ? {name: j.data.name, phone: (j.data.phone||'').replace(/(\d{3})\d{4}(\d{4})/, '$1****$2')} : null});
    })();
    """
    print('my-info:', tab.run_js(js, timeout=30))
    html = tab.html or ''
    for t_ in ('账号或密码不正确', '密码错误', '验证'):
        if t_ in html: print('UI text hit:', t_)
finally:
    try: b.quit()
    except Exception: pass
    shutil.rmtree(prof, ignore_errors=True)
print('done')
