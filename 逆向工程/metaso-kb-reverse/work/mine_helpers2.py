# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
# es = axios config
m = re.search(r'es=\{[^}]{0,800}\}', t71)
print('== es (axios cfg) ==')
print(m.group(0) if m else 'nf')
print()
# ec module: find py and hD near each other — search "function s" builder with metaso.cn/api prefix
m = re.search(r'[a-z]\.hD\)\("/login"\)', t71)
print('login call site at', m.start() if m else None)
# find ec module import id and its definition elsewhere (module exports {hD:...})
for m in re.finditer(r'hD:\s*(?:function\(\)\{return [a-z]\}|[a-z_$]{1,4})[,}]', t71):
    s = t71[max(0,m.start()-500):m.start()+200]
    print('== hD export context ==')
    print(s); print()
    break
