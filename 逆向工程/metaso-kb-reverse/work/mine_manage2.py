# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
fn = 'chunks_app__pages___menu-attached__subject-v2__desktop__page___5Bid_5D_manage_page-9a7c088b7174a112.js'
t = open(BD + fn, encoding='utf-8', errors='replace').read()
for m in re.finditer(r'topicId', t):
    s = t[max(0,m.start()-300):m.start()+200].replace('\n',' ')
    print('==', s[:480]); print()
