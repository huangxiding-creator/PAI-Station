# -*- coding: utf-8 -*-
import re, os, sys, time
from curl_cffi import requests as cr
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
SRC = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
OUT = os.path.join(SRC, 'js_bundles')
os.makedirs(OUT, exist_ok=True)
txt = open(os.path.join(SRC,'subject_manage_anon.html'), encoding='utf-8', errors='replace').read()
js = sorted(set(re.findall(r'https?://static-\d+\.metaso\.cn/_next/static/[^"\'\s]+?\.js', txt)))
s = cr.Session(impersonate='chrome')
ok = fail = 0
for u in js:
    name = re.sub(r'[^A-Za-z0-9._-]', '_', u.split('/_next/static/')[1])
    p = os.path.join(OUT, name)
    if os.path.exists(p) and os.path.getsize(p) > 0:
        ok += 1; continue
    try:
        r = s.get(u, timeout=40)
        if r.status_code == 200:
            open(p, 'wb').write(r.content); ok += 1
        else:
            print('HTTP', r.status_code, u); fail += 1
    except Exception as e:
        print('ERR', u, str(e)[:80]); fail += 1
    time.sleep(0.3)
print(f'done ok={ok} fail={fail} total={len(js)}')
