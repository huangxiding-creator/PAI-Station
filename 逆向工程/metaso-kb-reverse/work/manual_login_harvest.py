# -*- coding: utf-8 -*-
"""manual_login_harvest.py — 用户手动登录收割器 (可见窗, 5分钟轮询, 凭据零接触)
弹可见 metaso.cn 登录窗, 等用户亲自输入账密登录; 检测到登录态即收割 cookie →
data/secrets/metaso_kb_state.json (点亮纯HTTP下载面)。超时自动关闭如实上报。"""
import json, sys, time
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions

sec_dir = r'E:/AI-Station/data/secrets'
prof = r'E:/AI-Station/逆向工程/metaso-kb-reverse/work/_manual_profile'
import os
os.makedirs(prof, exist_ok=True)
co = ChromiumOptions()
co.set_user_data_path(prof)
co.set_argument('--window-size=520,760')
co.set_argument('--window-position=200,80')
co.auto_port()
b = Chromium(co)
tab = b.latest_tab
ok = False
try:
    tab.get('https://metaso.cn')
    print('[manual-login] 可见窗口已开, 等待用户登录 (最长300s)...', flush=True)
    js = """
    return (async () => {
        const meta = document.querySelector('meta[id="meta-token"]');
        const resp = await fetch('/api/my-info', {credentials: 'include', headers: {'token': meta ? meta.content : ''}});
        const j = await resp.json();
        return JSON.stringify({errCode: j.errCode, name: j.data ? j.data.name : null});
    })();
    """
    t0 = time.time()
    while time.time() - t0 < 300:
        try:
            mi = tab.run_js(js, timeout=20)
            if mi and '"errCode":0' in str(mi):
                ok = True
                print('[manual-login] 登录成功!', str(mi)[:120], flush=True)
                break
        except Exception:
            pass
        time.sleep(10)
    if ok:
        ck = []
        for c in b.cookies():
            ck.append({'name': c.get('name'), 'value': c.get('value'),
                       'domain': c.get('domain'), 'path': c.get('path')})
        stt = {'cookies': ck, 'saved_at': time.strftime('%Y-%m-%d %H:%M:%S'),
               'sid': '8673582927558737920', 'source': 'manual-login-harvest'}
        json.dump(stt, open(sec_dir + r'/metaso_kb_state.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
        print('[manual-login] STATE SAVED:', len(ck), 'cookies (不打印值)', flush=True)
        # 顺手实证owner下载面: my-info 名字
        print('[manual-login] 会话已落 secret 位, 可关闭窗口', flush=True)
        time.sleep(3)
    else:
        print('[manual-login] 300s 超时未登录, 关闭如实上报', flush=True)
finally:
    try:
        b.quit()
    except Exception:
        pass
print('RESULT:', 'OK' if ok else 'TIMEOUT')
