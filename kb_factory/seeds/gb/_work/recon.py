import os, glob
def head(p, n=4000):
    try:
        t = open(p, encoding='utf-8', errors='replace').read()
        print(f'--- {p} ({len(t)} ch) ---')
        lines=[l for l in t.splitlines()]
        out=[]; blank=0
        for l in lines:
            if l.strip(): out.append(l); blank=0
            else:
                blank+=1
                if blank==1: out.append('')
        print('\n'.join(out[:200]))
    except Exception as e:
        print('ERR', p, e)
B=r'E:\AI-Station\kb_factory'
print('### 1 base.py contract (head)')
head(B+r'\channel_adapters\base.py', 1)
print('### 2 seeds tree')
S=B+r'\seeds'
for root,dirs,files in os.walk(S):
    lvl=root[len(S):].count(os.sep)
    if lvl<=2: print(root[len(S):] or '.', '|D:', dirs[:10], '|F:', files[:12])
print('### 3 sample seed files content')
for pat in [S+r'\**\*.json', S+r'\**\*.jsonl', S+r'\**\*.md', S+r'\**\*.txt']:
    for f in glob.glob(pat, recursive=True)[:6]:
        head(f, 0)
        print('~~~')
print('### 4 std-samr-gb skill')
K=r'C:\Users\91216\.claude\skills\std-samr-gb'
for root,dirs,files in os.walk(K):
    print(root[len(K):] or '.', '|F:', files[:25])
head(K+r'\SKILL.md', 1)
print('### 5 std-samr elsewhere in workspace')
for base in [r'E:\AI-Station\逆向工程', r'E:\AI-Station\.claude\skills', r'E:\AI-Station\kb_factory']:
    if os.path.isdir(base):
        for root,dirs,files in os.walk(base):
            dirs[:]=[d for d in dirs if d not in ('node_modules','.git','__pycache__','_raw')]
            if 'samr' in root.lower() or any('samr' in f.lower() or 'ebiaozhun' in f.lower() for f in files):
                print(root, '|F:', [f for f in files if 'samr' in f.lower() or 'ebiaozhun' in f.lower() or 'gb' in f.lower()][:12])
print('### DONE')
