# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t = open(BD + 'chunks_41209-754bcda72ad917b3.js', encoding='utf-8', errors='replace').read()
print('len', len(t))
# all quoted literals containing login
for m in sorted(set(re.findall(r'["\x27]([^"\x27]{0,80}[Ll]ogin[^"\x27]{0,80})["\x27]', t))):
    print('LIT:', m)
print('--- password literals ---')
for m in sorted(set(re.findall(r'["\x27]([^"\x27]{0,60}[Pp]assword[^"\x27]{0,60})["\x27]', t))):
    print('PW:', m)
