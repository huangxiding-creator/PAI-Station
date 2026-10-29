# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t41 = open(BD + 'chunks_41209-754bcda72ad917b3.js', encoding='utf-8', errors='replace').read()
# full RSA public key: "-----BEGIN PUBLIC KEY-----...END..."
m = re.search(r'BEGIN PUBLIC KEY[^"\x27]{50,}', t41)
print('KEY:', m.group(0)[:520] if m else 'not found')
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
print('len 71409:', len(t71))
# find function defs t0=, t1=, cj=, cK= as top-level assignments
for name in ('t0', 't1', 'cj', 'cK', 'cz'):
    # match  name=function... or var name=function or name=(...) e.g. t0=function(){...}
    for m in re.finditer(r'[,;{]' + name + r'=function[^;]{0,400}', t71):
        print(f'== {name} ==')
        print(m.group(0)[:430]); print()
        break
