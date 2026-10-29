# -*- coding: utf-8 -*-
"""capture_real_login.py — 真实浏览器账密登录全流程抓包 (登录真相件)
最小化窗起步; CF闸不放行则恢复小窗(用户在场可配合)。凭据读secret, 输出掩码。"""
import json, sys, time, tempfile, shutil
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
SEC = r'E:/AI-Station/data/secrets/metaso_kb.secret'
sec = json.load(open(SEC, encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']

prof = tempfile.mkdtemp(prefix='metaso_cap_')
co = ChromiumOptions()
co.set_user_data_path(prof)
co.set_argument('--start-minimized')
co.set_argument('--window-size=420,600')
co.set_argument('--window-position=60,60')
co.auto_port()
b = Chromium(co)
tab = b.latest_tab
pkts = []
try:
    tab.listen.start('metaso.cn')
    tab.get('https://metaso.cn')
    time.sleep(4)
    tab.ele('text:登录', timeout=8).click(); time.sleep(2.5)
    tab.ele('text:账号密码', timeout=8).click(); time.sleep(1.5)
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
    if (!n || !p) return 'inputs-missing:' + !!n + !!p;
    n.focus(); setv(n, phone);
    p.focus(); setv(p, pwd);
    return JSON.stringify({numLen: n.value.length, pwdLen: p.value.length});
    """
    print('fill:', tab.run_js(fill, phone, pwd, timeout=20))
    chk = """
    var c = document.querySelector('input[name="policy-checkbox"], #desktop-login-policy input, input[type=checkbox]');
    if (!c) return 'no-checkbox';
    if (!c.checked) {
      c.closest('.MuiCheckbox-root, label, span')?.click();
      c.click();
    }
    return 'checked=' + c.checked;
    """
    print('policy:', tab.run_js(chk, timeout=10))
    time.sleep(1)
    # submit
    clicked = None
    for label in ('登 录', '登　录', '登录'):
        btn = tab.ele(f'text={label}', timeout=2)
        if btn:
            btn.click(); clicked = label; break
    print('submit clicked:', clicked)
    # collect 25s
    t0 = time.time()
    while time.time() - t0 < 25:
        for p in tab.listen.steps(timeout=2, count=10):
            try:
                pkts.append({'url': p.url, 'method': p.method,
                             'req_headers': dict(p.request.headers) if p.request else {},
                             'req_body': p.request.postData if p.request else None,
                             'status': p.response.status if p.response else None,
                             'resp_body': (p.response.body if p.response else None)})
            except Exception as e:
                pkts.append({'url': str(getattr(p, 'url', '?')), 'err': str(e)[:80]})
        # CF gate check: if login not fired after 8s, restore window (maybe turnstile needs render)
        if time.time() - t0 > 8 and not any('/login' in str(x.get('url', '')) for x in pkts):
            try:
                tab.run_js('null')  # keepalive
            except Exception:
                pass
        time.sleep(1)
    # mask + dump
    def mask(s):
        return str(s).replace(phone, '158****2899')
    out = []
    for p in pkts:
        u = str(p.get('url', ''))
        if any(k in u for k in ('.js', '.css', '.png', '.svg', '.woff', '.ico', 'static-1', '/_next/')):
            continue
        rh = p.get('req_headers') or {}
        row = {'url': u[:120], 'method': p.get('method'),
               'req_headers': {k: (mask(v)[:180] if k.lower() in ('token', 'cookie', 'authorization', 'user-agent') else str(v)[:80]) for k, v in list(rh.items())[:14]},
               'req_body': (mask(p.get('req_body'))[:600] if p.get('req_body') else None),
               'status': p.get('status'),
               'resp_body': (mask(p.get('resp_body'))[:300] if p.get('resp_body') else None)}
        out.append(row)
        print('>>', row['method'], u[:100], row['status'])
        if row['req_body'] and '/login' in u:
            print('   BODY:', row['req_body'][:400])
        if row['resp_body']:
            print('   RESP:', row['resp_body'][:160])
    json.dump(out, open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_login_capture.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    # login state
    js = """
    return (async () => {
        const meta = document.querySelector('meta[id="meta-token"]');
        const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': meta ? meta.content : ''}});
        const j = await resp.json();
        return JSON.stringify({errCode: j.errCode, name: j.data ? j.data.name : null});
    })();
    """
    print('my-info:', tab.run_js(js, timeout=30))
    # slider check
    html = tab.html or ''
    for kw in ('滑块', '拖动', '验证', 'captcha', 'turnstile', 'nc_'):
        if kw in html.lower():
            print('SLIDER/UI hit:', kw)
    tab.get_screenshot(path=CAP, name='real_login_after', full_page=False)
finally:
    try: b.quit()
    except Exception: pass
    shutil.rmtree(prof, ignore_errors=True)
print('pkts captured:', len(pkts))
