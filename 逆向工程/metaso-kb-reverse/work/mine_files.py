# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
# find all ey.get/post call sites containing /file or public-file
for m in re.finditer(r'ey\.(get|post|put|delete)\([^)]{0,200}(file|download)[^)]{0,200}\)', t71, re.I):
    print(m.group(0)[:260]); print('---')
