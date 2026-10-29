# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
# export table maps: find getPdfHost -> fid
m = re.search(r'getPdfHost:function\(\)\{return (\w+)\}', t71)
print('getPdfHost fid:', m.group(1) if m else None)
if m:
    fid = m.group(1)
    mm = re.search(r'[,;{]' + fid + r'=', t71)
    if mm:
        print(t71[mm.start():mm.start()+400])
print()
# tU definition
mm = re.search(r'[,;{]tU=function', t71)
print('== tU ==')
print(t71[mm.start():mm.start()+500] if mm else 'nf')
print()
mm = re.search(r'[,;{]tU=', t71)
print('== tU var ==')
print(t71[mm.start():mm.start()+500] if mm else 'nf')
