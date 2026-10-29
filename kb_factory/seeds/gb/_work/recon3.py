import os, glob, json
B=r'E:\AI-Station\kb_factory'
print('### catalog_engine py files')
for root,dirs,files in os.walk(B+r'\catalog_engine'):
    dirs[:]=[d for d in dirs if d not in ('__pycache__',)]
    for f in sorted(files):
        if f.endswith('.py'): print(os.path.relpath(os.path.join(root,f),B), os.path.getsize(os.path.join(root,f)))
print('### document/structure seed interface')
for f in glob.glob(B+r'\catalog_engine\**\*.py', recursive=True)+glob.glob(B+r'\kb_factory\*.py'):
    pass
import re
targets=[]
for f in glob.glob(B+r'\catalog_engine\**\*.py', recursive=True):
    t=open(f,encoding='utf-8',errors='replace').read()
    if re.search(r'document_engine|structure_miner|seeds', t, re.I):
        targets.append(f)
for f in targets:
    t=open(f,encoding='utf-8',errors='replace').read()
    print('===', os.path.relpath(f,B))
    for i,l in enumerate(t.splitlines()):
        if re.search(r'def |seed|document_engine|structure_miner|seeds', l, re.I) and ('def ' in l or 'seed' in l.lower()):
            print(i+1, l.rstrip()[:160])
print('### tests referencing seeds/gb')
for f in glob.glob(B+r'\tests\**\*.py', recursive=True)+glob.glob(B+r'\**\test*.py', recursive=True):
    if '_work' in f or '_raw' in f: continue
    t=open(f,encoding='utf-8',errors='replace').read()
    if 'seeds' in t and ('gb' in t or 'seed' in t.lower()):
        print('===', os.path.relpath(f,B))
        for i,l in enumerate(t.splitlines()):
            if 'seed' in l.lower() or 'gb' in l.lower(): print(i+1, l.rstrip()[:160])
