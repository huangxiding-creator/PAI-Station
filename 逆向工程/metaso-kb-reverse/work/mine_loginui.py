# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t = open(BD + 'chunks_41209-754bcda72ad917b3.js', encoding='utf-8', errors='replace').read()
# placeholders / labels around account input
for kw in ('placeholder', '请输入', '账号', '手机号', '邮箱'):
    for m in list(re.finditer(kw, t))[:6]:
        s = t[max(0,m.start()-160):m.start()+160].replace('\n',' ')
        print(f'[{kw}] ...{s[:320]}')
    print()
