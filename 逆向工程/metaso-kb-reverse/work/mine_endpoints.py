# -*- coding: utf-8 -*-
import os, re, sys, collections
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles'
out = collections.defaultdict(set)
for fn in os.listdir(BD):
    t = open(os.path.join(BD, fn), encoding='utf-8', errors='replace').read()
    for m in re.finditer(r'["\x27]((?:/)?api/[A-Za-z0-9_\-/.${}]+)["\x27]', t):
        out[m.group(1)].add(fn)
    # template-literal api paths with ${...}
    for m in re.finditer(r'`((?:/)?api/[A-Za-z0-9_\-/.]+`\$\{[^`]*?\}`[A-Za-z0-9_\-/.]*)`', t):
        out[m.group(1)].add(fn)
apis = dict(sorted(out.items()))
print('total unique api literals:', len(apis))
kw = sys.argv[1] if len(sys.argv) > 1 else ''
for k, v in apis.items():
    if kw and kw not in k: continue
    src = ','.join(sorted(x.split('-')[0] for x in v))
    print(f'{k}   [{src}]')
