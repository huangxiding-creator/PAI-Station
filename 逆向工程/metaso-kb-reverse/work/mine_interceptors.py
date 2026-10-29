# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
for m in re.finditer(r'\.interceptors\.request\.use', t71):
    s = t71[m.start()-80:m.start()+1200]
    print('== interceptor ==')
    print(s[:1300]); print()
