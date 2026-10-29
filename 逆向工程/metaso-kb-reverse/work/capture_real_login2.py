# -*- coding: utf-8 -*-
"""capture_real_login2.py — 可见小窗真实登录抓包 (Turnstile 需正常渲染; 用户在场)"""
import json, sys, time, tempfile, shutil
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']

prof = tempfile.mkdtemp(prefix='metaso_cap2_')
co = ChromiumOptions()
co.set_user_data_path(prof)
co.set_argument('--window-size=460,720')
co.set_argument('--window-position=40,40')
co.auto_port()
b = Chromium(co)
tab = b.latest_tab
pkts = []
try:
    tab.listen.start('metaso.cn')
    tab.get('https://metaso.cn')
    time.sleep(5)
    tab.ele('text:登录', timeout=8).click(); time.sleep(3)
    tab.ele('text:账号密码', timeout=8).click(); time.sleep(2)
    fill = """
    var phone = arguments[0], pwd = arguments[1];
    const setv = (el, v) => {
      const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
      setter.call(el, v);
      el.dispatchEvent(new Event('input', {bubbles: true}));
      el.dispatchEvent(new Event('change', {bubbles: true}));
    };
    const n = document.querySelector('input[type=number], input[type=tel], #desktop-login-account');
    const p = document.querySelector('input[type=password], #desktop-login-pwd');
    if (!n || !p) return 'inputs-missing';
    n.focus(); setv(n, phone);
    p.focus(); setv(p, pwd);
    return JSON.stringify({numLen: n.value.length, pwdLen: p.value.length});
    """
    print('fill:', tab.run_js(fill, phone, pwd, timeout=20))
    print('policy:', tab.run_js("""
    var c = document.querySelector('input[name="policy-checkbox"], #desktop-login-policy input, input[type=checkbox]');
    if (!c) return 'no-checkbox';
    if (!c.checked) { c.closest('.MuiCheckbox-root, label, span')?.click(); c.click(); }
    return 'checked=' + c.checked;
    """, timeout=10))
    time.sleep(1)
    # let turnstile render + auto-run; probe its state
    time.sleep(4)
    gate = tab.run_js("""
    const ifr = document.querySelector('iframe[src*="turnstile"], iframe[src*="challenges.cloudflare.com"]');
    const w = document.querySelector('[class*=turnstile], #turnstile-container, .cf-turnstile');
    return JSON.stringify({iframe: ifr ? ifr.src.slice(0, 90) : null,
                           widget: !!w,
                           turnstileObj: typeof window.turnstile !== 'undefined'});
    """, timeout=10)
    print('turnstile gate:', gate)
    tab.get_screenshot(path=CAP, name='real2_before_submit', full_page=False)
    clicked = None
    for label in ('登 录', '登　录', '登录'):
        btn = tab.ele(f'text={label}', timeout=2)
        if btn:
            btn.click(); clicked = label; break
    print('submit clicked:', clicked)
    t0 = time.time()
    login_seen = False
    while time.time() - t0 < 30:
        for p in tab.listen.steps(timeout=2, count=10):
            try:
                pkts.append({'url': p.url, 'method': p.method,
                             'req_headers': dict(p.request.headers) if p.request else {},
                             'req_body': p.request.postData if p.request else None,
                             'status': p.response.status if p.response else None,
                             'resp_body': (p.response.body if p.response else None)})
            except Exception as e:
                pkts.append({'url': str(getattr(p, 'url', '?')), 'err': str(e)[:80]})
        if any('/login' in str(x.get('url', '')) and x.get('method') == 'POST' for x in pkts):
            login_seen = True
            if time.time() - t0 > 12: break
        time.sleep(1)
    print('login XHR seen:', login_seen)
    def mask(s):
        return str(s).replace(phone, '158****2899')
    out = []
    for p in pkts:
        u = str(p.get('url', ''))
        if any(k in u for k in ('.js', '.css', '.png', '.svg', '.woff', '.ico', 'static-1', '/_next/', '_rsc=')):
            continue
        rh = p.get('req_headers') or {}
        row = {'url': u[:130], 'method': p.get('method'),
               'req_headers': {k: mask(v)[:200] for k, v in list(rh.items())[:16]},
               'req_body': (mask(p.get('req_body')) if p.get('req_body') else None),
               'status': p.get('status'),
               'resp_body': (mask(p.get('resp_body'))[:400] if p.get('resp_body') else None)}
        out.append(row)
        print('>>', row['method'], u[:110], row['status'])
        if '/login' in u or 'cloudflare' in u:
            print('   REQ-H:', json.dumps({k: v[:60] for k, v in row['req_headers'].items()}, ensure_ascii=False)[:400])
            print('   BODY :', str(row['req_body'])[:500])
            print('   RESP :', str(row['resp_body'])[:250])
    json.dump(out, open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_login_capture2.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    js = """
    return (async () => {
        const meta = document.querySelector('meta[id="meta-token"]');
        const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': meta ? meta.content : ''}});
        const j = await resp.json();
        return JSON.stringify({errCode: j.errCode, name: j.data ? j.data.name : null});
    })();
    """
    print('my-info:', tab.run_js(js, timeout=30))
    tab.get_screenshot(path=CAP, name='real2_after', full_page=False)
    # dump cookies if logged in
    if '"errCode":0' in str(tab.run_js(js, timeout=30) or ''):
        cookies = tab.run_js("return document.cookie", timeout=10)
        # save FULL cookie jar to secret state (not printed)
        allc = []
        try:
            import sqlite3
        except Exception:
            pass
        print('cookie keys:', sorted(c.split('=')[0] for c in (cookies or '').split('; ')))
finally:
    try: b.quit()
    except Exception: pass
    shutil.rmtree(prof, ignore_errors=True)
print('pkts:', len(pkts))
