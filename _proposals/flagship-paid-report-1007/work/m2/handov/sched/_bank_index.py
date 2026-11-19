# -*- coding: utf-8 -*-
"""Parse bank_chNN.md into anchors; keyword search with bounded context output."""
import sys, io, re, json

def load_bank(path):
    text = open(path, encoding='utf-8', errors='replace').read()
    lines = text.splitlines()
    anchors = []
    cur = None
    for i, ln in enumerate(lines):
        if ln.startswith('## P0'):
            if cur: cur['end'] = i - 1; anchors.append(cur)
            pid = ln.split()[1]
            cur = {'id': pid, 'start': i, 'end': None, 'path': '', 'lines': []}
        elif cur is not None:
            if ln.startswith('路径') and not cur['path']:
                cur['path'] = ln[3:].strip()
            cur['lines'].append(ln)
    if cur: cur['end'] = len(lines) - 1; anchors.append(cur)
    return anchors

def search(bank_file, kws, max_hits=200, ctx=180):
    anchors = load_bank(bank_file)
    hits = []
    for a in anchors:
        body = '\n'.join(a['lines'])
        for kw in kws:
            for m in re.finditer(re.escape(kw), body):
                s = max(0, m.start() - ctx)
                e = min(len(body), m.end() + ctx)
                frag = body[s:e].replace('\n', ' ')
                hits.append((a['id'], a['path'], kw, frag))
                if len(hits) >= max_hits:
                    return hits
    return hits

if __name__ == '__main__':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    mode = sys.argv[1]
    if mode == 'index':
        for a in load_bank(sys.argv[2]):
            print(a['id'], len('\n'.join(a['lines'])), a['path'])
    elif mode == 'dump':
        # dump anchor bodies: dump bank_file P1,P2,...
        want = set(sys.argv[3].split(','))
        import os
        os.makedirs('_ex', exist_ok=True)
        for a in load_bank(sys.argv[2]):
            if a['id'] in want:
                fn = '_ex/%s.txt' % a['id']
                open(fn, 'w', encoding='utf-8').write('# %s | %s\n\n' % (a['id'], a['path']) + '\n'.join(a['lines']))
                print('dumped', fn, len('\n'.join(a['lines'])))
    elif mode == 'find':
        kws = sys.argv[3].split(',')
        hits = search(sys.argv[2], kws, max_hits=int(sys.argv[4]) if len(sys.argv) > 4 else 50)
        for pid, path, kw, frag in hits:
            print('[%s|%s|%s] %s' % (pid, path[:30], kw, frag))
            print('-' * 40)
