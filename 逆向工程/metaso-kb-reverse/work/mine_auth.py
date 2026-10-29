# -*- coding: utf-8 -*-
import os, re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles'
pats = ['login', 'sms', 'password', 'passport', 'signin', 'sign-in', 'verif']
for fn in sorted(os.listdir(BD)):
    t = open(os.path.join(BD, fn), encoding='utf-8', errors='replace').read()
    hits = []
    for p in pats:
        n = len(re.findall(p, t, re.I))
        if n: hits.append(f'{p}={n}')
    if hits:
        print(fn, ' '.join(hits))
