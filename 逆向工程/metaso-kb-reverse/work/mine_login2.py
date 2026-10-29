# -*- coding: utf-8 -*-
import os, re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
# find loginByAccount / loginByPhone definitions across all bundles
for fn in sorted(os.listdir(BD)):
    t = open(BD + fn, encoding='utf-8', errors='replace').read()
    for name in ('loginByAccount', 'loginByPhone', 'loginByWechat'):
        for m in re.finditer(re.escape(name), t):
            s = max(0, m.start() - 260)
            seg = t[s:m.start() + 300].replace('\n', ' ')
            print(f'== {fn} :: {name}')
            print(seg[:560])
            print()
