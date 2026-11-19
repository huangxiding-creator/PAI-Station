import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
for n in ['05','06','07','08']:
    lines = open(f'bank_ch{n}.md', encoding='utf-8', errors='replace').read().splitlines()
    cur = None
    print(f'=== ch{n} ===')
    for ln in lines:
        if ln.startswith('## P0'):
            cur = ln.split()[0].lstrip('#').strip()
        elif ln.startswith('路径:') and cur:
            print(cur, '|', ln[3:].strip())
            cur = None
