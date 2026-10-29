# -*- coding: utf-8 -*-
"""GB 免费全文 PDF 收割（官方 std.samr/openstd 免登录链，try_native_pdf 直下）。
节流：请求间隔>=2.2s，单线程；如实计数，禁凑数。"""
import sys, time, json, re, os, importlib.util
RAW = r'E:\AI-Station\kb_factory\seeds\gb\_raw'
os.makedirs(RAW, exist_ok=True)
spec = importlib.util.spec_from_file_location('samr_lib', r'E:\AI-Station\逆向工程\std-samr\samr_lib.py')
samr = importlib.util.module_from_spec(spec); spec.loader.exec_module(samr)
c = samr.SamrClient(delay=(1.2, 2.0))
KEYWORDS = ['混凝土', '水利水电', '施工质量验收', '工程测量', '建筑与市政', '灌溉', '堤防', '水电站']
MAX_PDF = 35
manifest = open(os.path.join(RAW, 'manifest.jsonl'), 'a', encoding='utf-8')
def log(**kw):
    kw['ts'] = time.strftime('%H:%M:%S')
    manifest.write(json.dumps(kw, ensure_ascii=False) + '\n'); manifest.flush()
    print('EV', json.dumps(kw, ensure_ascii=False)[:220], flush=True)
def nap(): time.sleep(2.2)
cand, seen = [], set()
for kw in KEYWORDS:
    try:
        d = c.search(kw, states=('现行',), page_size=40)
        rows = d.get('rows') or []
        for r in rows:
            code = (r.get('C_STD_CODE') or '').strip()
            if not code.startswith('GB'): continue
            if code in seen: continue
            seen.add(code)
            name = re.sub(r'<[^>]+>', '', r.get('C_C_NAME') or '').strip()
            cand.append({'kw': kw, 'id': r['id'], 'code': code, 'name': name,
                         'nature': r.get('STD_NATURE'), 'state': r.get('STATE'),
                         'issue': r.get('ISSUE_DATE'), 'act': r.get('ACT_DATE')})
        print('EV search', kw, len(rows), 'cum_cand', len(cand), flush=True)
    except Exception as e:
        print('EV search_err', kw, str(e)[:120], flush=True)
    nap()
cand.sort(key=lambda x: (0 if x['nature'] == '强制性' else 1, x['issue'] or ''), reverse=False)
cand = [x for x in cand if x['nature'] == '强制性'] + sorted(
    [x for x in cand if x['nature'] != '强制性'], key=lambda x: x['issue'] or '', reverse=True)
got, tries = [], 0
for x in cand:
    if len(got) >= MAX_PDF: break
    if tries >= 75: break
    tries += 1
    try:
        nap(); det = c.detail(x['id'])
        x['hcno'] = det.get('hcno')
        if not x['hcno']:
            log(action='detail', code=x['code'], result='no_hcno'); continue
        nap(); pdf = c.try_native_pdf(x['hcno'])
        if pdf and pdf[:4] == b'%PDF':
            safe = re.sub(r'[^0-9A-Za-z]+', '_', x['code'])
            p = os.path.join(RAW, safe + '.pdf')
            open(p, 'wb').write(pdf)
            x['pdf'] = p; x['bytes'] = len(pdf); got.append(x)
            log(action='download', code=x['code'], name=x['name'][:40], kw=x['kw'],
                kb=round(len(pdf)/1024), result='ok', n=len(got))
        else:
            log(action='download', code=x['code'], result='native_unavailable')
    except Exception as e:
        log(action='error', code=x['code'], err=str(e)[:100])
print('EV SUMMARY tries=%d got=%d cand=%d' % (tries, len(got), len(cand)), flush=True)
json.dump(got, open(os.path.join(RAW, '_harvest_result.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
print('HARVEST DONE', flush=True)
