# -*- coding: utf-8 -*-
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
BD = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/js_bundles/'
t = open(BD + 'chunks_7060-8de434957ce13d9e.js', encoding='utf-8', errors='replace').read()
for kw in ('getDownloadTicket', 'downloadFilePdfUrl', 'stream-download', 'batch-download'):
    idxs = [m.start() for m in re.finditer(re.escape(kw), t)]
    print(f'### {kw}: {len(idxs)} hits')
    for i in idxs[:3]:
        s = t[max(0,i-350):i+350].replace('\n',' ')
        print('  ...', s[:700]); print()
