# -*- coding: utf-8 -*-
"""GB probe: lib health + native PDF text-layer check (throttled, single-thread)."""
import sys, time, importlib.util, json
sys.path.insert(0, r'E:\AI-Station\逆向工程\std-samr')
spec = importlib.util.spec_from_file_location('samr_lib', r'E:\AI-Station\逆向工程\std-samr\samr_lib.py')
samr = importlib.util.module_from_spec(spec); spec.loader.exec_module(samr)
print('lib ok:', [n for n in dir(samr) if not n.startswith('_')][:20])
c = samr.SamrClient(delay=(1.0, 2.0))
print('STEP search 混凝土')
rows = c.search('混凝土', page_size=20)
print('search type', type(rows), 'len', len(rows) if hasattr(rows,'__len__') else '?')
if isinstance(rows, dict): print('keys', list(rows)[:10]); rows = rows.get('rows') or rows.get('data') or []
if rows:
    r0 = rows[0]
    print('row0 keys:', list(r0.keys()) if isinstance(r0, dict) else r0)
    for r in rows[:5]:
        print(' *', {k: str(v)[:40] for k, v in list(r.items())[:8]} if isinstance(r, dict) else str(r)[:120])
    print('STEP detail first')
    time.sleep(2.2)
    d = c.detail(r0.get('id') or r0.get('std_id'))
    print('detail type', type(d))
    print(str(d)[:500])
    hc = None
    if isinstance(d, dict):
        for k in ('hcno','hcNo','reader_id'):
            if d.get(k): hc = d[k]; break
        if not hc:
            import re
            m = re.search(r'hcno=([0-9A-F]+)', str(d))
            if m: hc = m.group(1)
    print('hcno =', hc)
    if hc:
        print('STEP native pdf')
        time.sleep(2.2)
        pdf = c.try_native_pdf(hc)
        print('native bytes:', len(pdf) if pdf else None, 'head:', pdf[:8] if pdf else None)
        if pdf:
            p = r'E:\AI-Station\kb_factory\seeds\gb\_raw\_probe_native.pdf'
            open(p, 'wb').write(pdf)
            print('saved', p)
            for mod in ('pypdf', 'pdfplumber', 'fitz', 'pdfminer'):
                try:
                    __import__(mod); print('lib', mod, 'OK')
                except Exception as e:
                    print('lib', mod, 'MISSING')
            try:
                from pypdf import PdfReader
                rd = PdfReader(p)
                t = ''.join((pg.extract_text() or '') for pg in rd.pages[:5])
                print('pypdf pages', len(rd.pages), 'text_chars_first5', len(t), 'sample', t[:120].replace('\n', ' '))
            except Exception as e:
                print('pypdf extract err', e)
print('PROBE DONE')
