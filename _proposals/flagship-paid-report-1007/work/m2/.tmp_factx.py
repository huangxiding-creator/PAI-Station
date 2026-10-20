# -*- coding: utf-8 -*-
"""Extract candidate fact sentences (with numbers) from bank segments."""
import re, sys
def load_bank(path):
    segs={}; cur=None; buf=[]
    for line in open(path,encoding='utf-8'):
        m=re.match(r'## P(\d{6})',line)
        if m:
            if cur is not None: segs[cur]='\n'.join(buf)
            cur=int(m.group(1)); buf=[line]
        elif cur is not None: buf.append(line)
    if cur is not None: segs[cur]='\n'.join(buf)
    return segs
if __name__=='__main__':
    bank=load_bank(sys.argv[1])
    ids=sys.argv[2:]
    pat=re.compile(r'\d[\d,，.]*\s*(?:万|亿|元|天|日|％|%|个月|年)')
    for i in ids:
        sid='P'+i.zfill(6) if not i.startswith('P') else i
        key=int(sid[1:])
        seg=bank.get(key)
        if not seg: print(f'== {sid} MISSING =='); continue
        print(f'===== {sid} =====')
        seen=set()
        for s in re.split(r'[。；\n]',seg):
            if len(s)<8 or len(s)>220: continue
            hits=pat.findall(s)
            if not hits: continue
            s2=s.strip()
            if s2 in seen: continue
            seen.add(s2)
            print(' ·',s2[:200])
        print()
