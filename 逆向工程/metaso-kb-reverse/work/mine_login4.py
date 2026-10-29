# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
t41 = open(BD + 'chunks_41209-754bcda72ad917b3.js', encoding='utf-8', errors='replace').read()
# full t1
m = re.search(r',t1=function\(e\)\{[^;]{0,700}', t71)
print('== t1 (loginByPhone) ==')
print(m.group(0)[:720] if m else 'nf')
print()
# full cj (knowledgeSearchFile)
m = re.search(r',cj=function\(e\)[^;]{0,900}', t71)
print('== cj (knowledgeSearchFile) ==')
print(m.group(0)[:920] if m else 'nf')
print()
m = re.search(r',cK=function\(e\)[^;]{0,900}', t71)
print('== cK (knowledgeSearchFileSimple) ==')
print(m.group(0)[:920] if m else 'nf')
print()
# RSA key in 41209: search base64 chunk before IDAQAB
m = re.search(r'["\x27]([A-Za-z0-9+/]{100,}IDAQAB)["\x27]', t41)
print('RSA KEY FULL:', m.group(1) if m else 'nf')
