# -*- coding: utf-8 -*-
"""capture_real_login5.py — 精确定位 #desktop-login-account 的真实登录抓包 (真相件)"""
import json, sys, time, tempfile, shutil
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
sec = json.load(open(r'E:/AI-Station/data/secrets/metaso_kb.secret', encoding='utf-8'))
phone, pwd = sec['phone'], sec['password']

prof = tempfile.mkdtemp(prefix='metaso_cap5_')
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
    const n = document.querySelector('#desktop-login-account');
    const p = document.querySelector('#desktop-login-pwd');
    if (!n || !p) return 'inputs-missing';
    n.focus(); setv(n, phone);
    p.focus(); setv(p, pwd);
    return JSON.stringify({acctLen: n.value.length, pwdLen: p.value.length});
    """
    print('fill:', tab.run_js(fill, phone, pwd, timeout=20))
    # policy: #desktop-login-policy checkbox
    st = 'no-attempt'
    for attempt in range(5):
        st = tab.run_js("""
        var c = document.querySelector('#desktop-login-policy');
        return c ? ('checked=' + c.checked) : 'no-checkbox';
        """, timeout=10)
        if 'checked=true' in str(st):
            break
        try:
            tab.ele('css:#desktop-login-policy', timeout=2).click()
        except Exception:
            pass
        time.sleep(0.8)
    print('policy:', st)
    time.sleep(2)
    # click the real submit: button[type=submit] with testid SubmitButton
    clicked = tab.run_js("""
    const btn = document.querySelector('button[type=submit][data-testid^="SubmitButton"]');
    if (!btn) return 'no-submit-btn';
    btn.click();
    return 'clicked:' + btn.textContent.trim();
    """, timeout=15)
    print('submit:', clicked)
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
               'req_headers': {k: mask(v)[:240] for k, v in list(rh.items())[:16]},
               'req_body': (mask(p.get('req_body')) if p.get('req_body') else None),
               'status': p.get('status'),
               'resp_body': (mask(p.get('resp_body'))[:500] if p.get('resp_body') else None)}
        out.append(row)
        if '/login' in u or 'cloudflare' in u:
            print('>>', row['method'], u[:110], row['status'])
            print('   REQ-H:', json.dumps({k: v[:70] for k, v in row['req_headers'].items()}, ensure_ascii=False)[:600])
            print('   BODY :', str(row['req_body'])[:800])
            print('   RESP :', str(row['resp_body'])[:400])
    json.dump(out, open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_login_capture5.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
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
    tab.get_screenshot(path=CAP, name='real5_after', full_page=False)
    if mi and '"errCode":0' in str(mi):
        ck = []
        for c in b.cookies():
            ck.append({'name': c.get('name'), 'value': c.get('value'),
                       'domain': c.get('domain'), 'path': c.get('path')})
        stt = {'cookies': ck, 'saved_at': time.strftime('%Y-%m-%d %H:%M:%S'),
               'sid': '8673582927558737920', 'source': 'browser-harvest capture_real_login5'}
        json.dump(stt, open(r'E:/AI-Station/data/secrets/metaso_kb_state.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
        print('STATE SAVED:', len(ck), 'cookies -> data/secrets/metaso_kb_state.json')
finally:
    try:
        b.quit()
    except Exception:
        pass
    shutil.rmtree(prof, ignore_errors=True)
print('pkts:', len(pkts))
