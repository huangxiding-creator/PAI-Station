# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
# tU used as tU(...) and tU(...); find its assignment any form
for pat in (r'\btU\s*=\s*', ):
    for m in re.finditer(pat, t71):
        ctx = t71[m.start():m.start()+360]
        print('AT', m.start(), '::', ctx.replace('\n',' ')[:360])
        print()
