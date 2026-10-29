# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t71 = open(BD + 'chunks_71409-ebb2687604f3c700.js', encoding='utf-8', errors='replace').read()
# 1) map exportName -> local fn id
exp = {}
for m in re.finditer(r'(\w{2,40}):function\(\)\{return (\w{1,6})\}', t71):
    exp[m.group(1)] = m.group(2)
for name in ('downloadFile', 'downloadFilePdfUrl', 'getDownloadTicket', 'getFolderFiles',
             'getFileParents', 'getKnowledgeDetailByRootId', 'getPublicFilePreviewBase',
             'getTopicAdmin', 'getFileMetaInfo', 'getTopicFailedFiles', 'batchDownloadFiles',
             'checkDownloadSize', 'getSimpleKnowledgeTopic'):
    fid = exp.get(name)
    if not fid:
        print(f'## {name}: NOT IN EXPORT TABLE'); continue
    m = re.search(r'[,;{]' + fid + r'=function[^{]*\{', t71)
    if m:
        print(f'## {name} -> {fid}')
        print(t71[m.start()+1:m.start()+700])
        print()
    else:
        print(f'## {name} -> {fid}: def not matched')
