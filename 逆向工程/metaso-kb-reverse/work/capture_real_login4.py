# -*- coding: utf-8 -*-
"""capture_real_login4.py — 弹窗DOM诊断 + form.requestSubmit 强提交"""
import json, sys, time, tempfile, shutil
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']

prof = tempfile.mkdtemp(prefix='metaso_cap4_')
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
    for attempt in range(5):
        st = tab.run_js("""
        var c = document.querySelector('input[name="policy-checkbox"], #desktop-login-policy input, .MuiCheckbox-input');
        return c ? ('checked=' + c.checked) : 'no-checkbox';
        """, timeout=10)
        if 'checked=true' in str(st):
            break
        try:
            el = (tab.ele('css:input[name="policy-checkbox"]', timeout=2) or
                  tab.ele('css:#desktop-login-policy input', timeout=2) or
                  tab.ele('css:.MuiCheckbox-input', timeout=2))
            el.click()
        except Exception:
            pass
        time.sleep(0.8)
    print('policy:', st)
    # DOM diagnostic
    diag = tab.run_js("""
    const inputs = [...document.querySelectorAll('input')].map(i => ({
      id: i.id || null, type: i.type, name: i.name || null,
      len: (i.value || '').length, disabled: i.disabled}));
    const btns = [...document.querySelectorAll('button')].filter(b => /登|log/i.test(b.textContent||''))
      .map(b => ({text: (b.textContent||'').trim().slice(0,16), type: b.type,
                  disabled: b.disabled, testid: b.getAttribute('data-testid')||null}));
    const forms = [...document.querySelectorAll('form')].map(f => ({len: f.innerHTML.length}));
    return JSON.stringify({inputs, btns, forms});
    """, timeout=15)
    print('DIAG:', diag[:900])
    time.sleep(2)
    # force submit via native form.requestSubmit (triggers React onSubmit regardless of button)
    fr = tab.run_js("""
    const n = document.querySelector('input[type=number], input[type=tel], #desktop-login-account');
    const form = n ? n.closest('form') : null;
    if (!form) return 'no-form';
    if (form.requestSubmit) { form.requestSubmit(); return 'requestSubmit-called'; }
    form.dispatchEvent(new Event('submit', {bubbles: true, cancelable: true}));
    return 'submit-event-dispatched';
    """, timeout=15)
    print('force submit:', fr)
    t0 = time.time(); login_seen = False
    while time.time() - t0 < 30:
        for p in tab.listen.steps(timeout=2, count=12):
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
            if time.time() - t0 > 12:
                break
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
               'req_headers': {k: mask(v)[:220] for k, v in list(rh.items())[:16]},
               'req_body': (mask(p.get('req_body')) if p.get('req_body') else None),
               'status': p.get('status'),
               'resp_body': (mask(p.get('resp_body'))[:400] if p.get('resp_body') else None)}
        out.append(row)
        if '/login' in u or 'cloudflare' in u:
            print('>>', row['method'], u[:110], row['status'])
            print('   REQ-H:', json.dumps({k: v[:70] for k, v in row['req_headers'].items()}, ensure_ascii=False)[:500])
            print('   BODY :', str(row['req_body'])[:700])
            print('   RESP :', str(row['resp_body'])[:300])
    json.dump(out, open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_login_capture4.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    js = """
    return (async () => {
        const meta = document.querySelector('meta[id="meta-token"]');
        const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': meta ? meta.content : ''}});
        const j = await resp.json();
        return JSON.stringify({errCode: j.errCode, name: j.data ? j.data.name : null});
    })();
    """
    mi = tab.run_js(js, timeout=30)
    print('my-info:', str(mi)[:160])
    tab.get_screenshot(path=CAP, name='real4_after', full_page=False)
    if mi and '"errCode":0' in str(mi):
        ck = []
        for c in b.cookies():
            ck.append({'name': c.get('name'), 'value': c.get('value'),
                       'domain': c.get('domain'), 'path': c.get('path')})
        stt = {'cookies': ck, 'saved_at': time.strftime('%Y-%m-%d %H:%M:%S'),
               'sid': '8673582927558737920', 'source': 'browser-harvest capture_real_login4'}
        json.dump(stt, open(r'E:/AI-Station/data/secrets/metaso_kb_state.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
        print('STATE SAVED:', len(ck), 'cookies -> data/secrets/metaso_kb_state.json')
finally:
    try:
        b.quit()
    except Exception:
        pass
    shutil.rmtree(prof, ignore_errors=True)
print('pkts:', len(pkts))
