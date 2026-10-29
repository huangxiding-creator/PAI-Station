# -*- coding: utf-8 -*-
"""probe_login_browser.py — DrissionPage 实弹UI登录判别 (凭据读secret, 输出掩码)
目的: HTTP 1003 是否=凭据本身错。抓浏览器真实 /login 请求体+响应做对照。"""
import json, sys, time, uuid, tempfile, os
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']
print(f'cred: 158****{phone[-4:]} / {pwd[:3]}****')

prof = tempfile.mkdtemp(prefix='metaso_probe_')
co = ChromiumOptions()
co.set_user_data_path(prof)
co.set_argument('--start-minimized')
co.set_argument('--window-position=32000,32000')
co.auto_port()
b = Chromium(co)
tab = b.latest_tab
try:
    tab.listen.start('metaso.cn/login')
    tab.get('https://metaso.cn')
    time.sleep(3)
    # open login modal
    ok = False
    for sel in ('text:登录', 'xpath://button[contains(.,"登录")]', 'xpath://div[contains(.,"登录")]'):
        try:
            e = tab.ele(sel, timeout=3)
            if e:
                e.click(); ok = True; break
        except Exception:
            pass
    print('modal open:', ok)
    time.sleep(2)
    # switch to 账号密码 tab
    try:
        tab.ele('text:账号密码', timeout=6).click()
        print('tab 账号密码 clicked')
    except Exception as e:
        print('tab 账号密码 NOT FOUND:', str(e)[:100])
        print('page text sample:', (tab.html or '')[:0])
    time.sleep(1)
    num = tab.ele('css:input[type=number]', timeout=4) or tab.ele('css:input[type=tel]', timeout=4)
    num.clear(); num.input(phone)
    pw = tab.ele('css:input[type=password]', timeout=4)
    pw.clear(); pw.input(pwd)
    tab.run_js('var c=document.querySelector(\'input[name="policy-checkbox"]\');if(c){c.closest(\'.MuiCheckbox-root, label, span\')?.click();c.click();}')
    time.sleep(0.6)
    for label in ('登 录', '登　录', '登录'):
        btn = tab.ele(f'text={label}', timeout=2)
        if btn:
            btn.click(); print('submit clicked:', label); break
    time.sleep(5)
    # capture packets
    for p in tab.listen.steps(timeout=15, count=2):
        try:
            body = p.request.postData if hasattr(p.request, 'postData') else ''
            body = (body or '').replace(phone, '158****2899')
            print('== XHR', p.url[:80], '| method', p.method)
            print('req body:', body[:300])
            resp = p.response.body
            resp = str(resp).replace(phone, '158****2899')[:300]
            print('resp:', resp)
        except Exception as e:
            print('pkt err', str(e)[:80])
    # login state check via in-page API
    js = """
    return (async () => {
        try {
            const meta = document.querySelector('meta[id="meta-token"]');
            const token = meta ? meta.content : '';
            const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': token}});
            const data = await resp.json();
            return JSON.stringify({errCode: data.errCode, hasUser: !!(data.data && (data.data.name || data.data.phone))});
        } catch(e) { return 'js-err ' + e.message; }
    })();
    """
    print('my-info check:', tab.run_js(js, timeout=30))
    # toast text if any
    for t_ in ('账号或密码不正确', '密码错误', '验证'):
        if t_ in (tab.html or ''):
            print('TOAST/UI contains:', t_)
finally:
    try:
        b.quit()
    except Exception:
        pass
    import shutil
    try: shutil.rmtree(prof, ignore_errors=True)
    except Exception: pass
print('done')
