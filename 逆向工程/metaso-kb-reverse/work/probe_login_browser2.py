# -*- coding: utf-8 -*-
"""probe_login_browser2.py — 严谨版UI登录判别: 输入值JS核验+截图+全量监听"""
import json, sys, time, tempfile, shutil
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']
print(f'cred: 158****{phone[-4:]}')

prof = tempfile.mkdtemp(prefix='metaso_probe2_')
co = ChromiumOptions()
co.set_user_data_path(prof)
co.set_argument('--start-minimized')
co.set_argument('--window-position=32000,32000')
co.auto_port()
b = Chromium(co)
tab = b.latest_tab
shot = lambda n: tab.get_screenshot(path=CAP, name=n, full_page=False)
try:
    tab.listen.start('metaso.cn')  # broad
    tab.get('https://metaso.cn')
    time.sleep(4)
    tab.ele('text:登录', timeout=6).click()
    time.sleep(2)
    tab.ele('text:账号密码', timeout=6).click()
    time.sleep(1.5)
    num = tab.ele('css:input[type=number]', timeout=5) or tab.ele('css:input[type=tel]', timeout=5)
    num.clear(); num.input(phone)
    pw = tab.ele('css:input[type=password]', timeout=5)
    pw.clear(); pw.input(pwd)
    time.sleep(0.5)
    vals = tab.run_js("""
    const n = document.querySelector('input[type=number], input[type=tel]');
    const p = document.querySelector('input[type=password]');
    return JSON.stringify({num: n ? (n.value||'').replace(/(\d{3})\d{4}(\d{4})/, '$1****$2') : null,
                           numLen: n ? n.value.length : 0, pwdLen: p ? p.value.length : 0});
    """)
    print('input check:', vals)
    tab.run_js('var c=document.querySelector(\'input[name="policy-checkbox"]\');if(c){c.closest(\'.MuiCheckbox-root, label, span\')?.click();c.click();}')
    time.sleep(0.8)
    shot('ui_login_filled')
    for label in ('登 录', '登　录', '登录'):
        btn = tab.ele(f'text={label}', timeout=2)
        if btn:
            btn.click(); print('submit clicked:', label); break
    # collect packets for 12s
    seen_login = False
    t0 = time.time()
    while time.time() - t0 < 12:
        for p in tab.listen.steps(timeout=2, count=5):
            u = p.url or ''
            if any(k in u for k in ('login', 'my-info', 'captcha', 'verify')):
                seen_login = seen_login or ('/login' in u)
                try:
                    rb = (p.request.postData or '').replace(phone, '158****2899')
                except Exception:
                    rb = '(no body)'
                try:
                    rsp = str(p.response.body)[:220].replace(phone, '158****2899')
                except Exception:
                    rsp = '(no resp yet)'
                print(f'>> {u[:90]}')
                print('   body:', rb[:260])
                print('   resp:', rsp)
        time.sleep(1)
    print('login XHR fired:', seen_login)
    time.sleep(2)
    shot('ui_login_after')
    js = """
    return (async () => {
        const meta = document.querySelector('meta[id="meta-token"]');
        const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': meta ? meta.content : ''}});
        return JSON.stringify(await resp.json()).slice(0, 200);
    })();
    """
    print('my-info:', tab.run_js(js, timeout=30))
    html = tab.html or ''
    for t_ in ('账号或密码不正确', '密码错误', '验证码', '滑块', '拖动'):
        if t_ in html: print('UI text hit:', t_)
finally:
    try: b.quit()
    except Exception: pass
    shutil.rmtree(prof, ignore_errors=True)
print('done')
