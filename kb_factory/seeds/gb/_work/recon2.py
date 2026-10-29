import os, glob, json
B=r'E:\AI-Station\kb_factory'
print('### summary.json')
try:
    t=open(B+r'\seeds\_summary.json',encoding='utf-8').read()
    print(t[:1500])
except Exception as e: print('ERR',e)
print('### catalog_engine files')
for root,dirs,files in os.walk(B+r'\catalog_engine'):
    dirs[:]=[d for d in dirs if d not in ('__pycache__',)]
    for f in files:
        if f.endswith('.py'): print(os.path.join(root,f).replace(B,''), os.path.getsize(os.path.join(root,f)))
print('### document_engine seed loading refs')
import re
for f in glob.glob(B+r'\catalog_engine\**\*.py', recursive=True):
    t=open(f,encoding='utf-8',errors='replace').read()
    if 'seed' in t.lower():
        print('---',f.replace(B,''))
        for i,l in enumerate(t.splitlines()):
            if 'seed' in l.lower(): print(i,l[:150])
