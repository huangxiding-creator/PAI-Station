# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
fn = 'chunks_app__pages___menu-attached__subject-v2__desktop__page___5Bid_5D_manage_page-9a7c088b7174a112.js'
t = open(BD + fn, encoding='utf-8', errors='replace').read()
print('len', len(t))
# api calls
for m in sorted(set(re.findall(r'["\x27](/api/[A-Za-z0-9_\-/${}.]+)["\x27]', t))):
    print('API:', m)
# imported api-layer function names
for m in sorted(set(re.findall(r'knowledgeSearch\w+|listFiles\w*|getFileDetail\w*|downloadFile\w*|batchDownload\w*|getKnowledgeDetail\w*', t))):
    print('FN:', m)
# search usage
for kw in ('topicId', 'searchFiles', 'fileSearch'):
    print(kw, 'hits:', len(re.findall(kw, t)))
