# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t = open(BD + 'chunks_7060-8de434957ce13d9e.js', encoding='utf-8', errors='replace').read()
print('len', len(t))
# api-layer function names invoked: patterns like (0,X.funcName)(
fns = sorted(set(re.findall(r'\(\d,\w\.((?:get|list|download|batch|search|fetch|query)\w{2,40})\)', t)))
print('called api fns:', len(fns))
for f in fns: print(' ', f)
