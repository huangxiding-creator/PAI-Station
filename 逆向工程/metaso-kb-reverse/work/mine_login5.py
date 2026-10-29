# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
for name, anchor in [('t0(loginByAccount)', r',t0=function\(e,t\)\{'),
                     ('t1(loginByPhone)', r',t1=function\(e\)\{'),
                     ('cj(knowledgeSearchFile)', r',cj=function\(e\)\{'),
                     ('cK(knowledgeSearchFileSimple)', r',cK=function\(e\)\{'),
                     ('cz(videoAudio)', r',cz=function\(e\)\{')]:
    m = re.search(anchor, t71)
    if not m:
        print(name, 'NOT FOUND'); continue
    print(f'===== {name} =====')
    print(t71[m.start():m.start()+1100])
    print()
