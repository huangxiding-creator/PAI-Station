# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()

def dump(anchor, n=900, label=''):
    m = re.search(anchor, t71)
    print(f'===== {label or anchor} =====')
    print(t71[m.start():m.start()+n] if m else 'NOT FOUND')
    print()

# ec.hD definition — search 'hD:' or 'hD=function' or 'hD('
for a in (r'\bhD=function[^,;]{0,300}', r'\bhD:\s*function[^,;]{0,300}', r'var\s+ec=\{[^}]{0,400}'):
    dump(a, 500, 'ec.hD')
# tK definition
for a in (r'\btK=function[^;]{0,500}', r'var\s+tK=[^;]{0,500}', r'\btK=\([^)]{0,60}\)=>'):
    dump(a, 600, 'tK')
# ey axios instance
for a in (r'ey=[a-zA-Z.$]{1,30}\.create\([^)]{0,400}', r'var\s+ey=[^;]{0,300}'):
    dump(a, 500, 'ey-axios')
