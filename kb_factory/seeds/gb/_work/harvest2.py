# -*- coding: utf-8 -*-
"""GB 免费全文 PDF 收割 v2：修复=每个 hcno 用全新 SamrClient（_warm 每 hcno 触发一次）。
节流 >=2.2s 单线程；如实计数；沿用 _raw/manifest.jsonl 追加审计。"""
import sys, time, json, re, os, importlib.util
RAW = r'E:\AI-Station\kb_factory\seeds\gb\_raw'
os.makedirs(RAW, exist_ok=True)
spec = importlib.util.spec_from_file_location('samr_lib', r'E:\AI-Station\逆向工程\std-samr\samr_lib.py')
samr = importlib.util.module_from_spec(spec); spec.loader.exec_module(samr)
KEYWORDS = ['混凝土', '水利水电', '验收', '工程测量', '市政', '灌溉', '堤防', '水电站', '水利工程']
MAX_PDF = 30
manifest = open(os.path.join(RAW, 'manifest.jsonl'), 'a', encoding='utf-8')
def log(**kw):
    kw['ts'] = time.strftime('%H:%M:%S'); manifest.write(json.dumps(kw, ensure_ascii=False) + '\n'); manifest.flush()
def ev(*a):
    print('EV', *a, flush=True)
def nap(): time.sleep(2.2)
c = samr.SamrClient(delay=(1.2, 2.0))
cand, seen = [], set()
for kw in KEYWORDS:
    try:
        rows = (c.search(kw, states=('现行',), page_size=40) or {}).get('rows') or []
        for r in rows:
            code = (r.get('C_STD_CODE') or '').strip()
            if not code.startswith('GB') or code in seen: continue
            seen.add(code)
            cand.append({'kw': kw, 'id': r['id'], 'code': code,
                         'name': re.sub(r'<[^>]+>', '', r.get('C_C_NAME') or '').strip(),
                         'nature': r.get('STD_NATURE'), 'state': r.get('STATE'),
                         'issue': r.get('ISSUE_DATE'), 'act': r.get('ACT_DATE')})
        ev('search', kw, len(rows), 'cum', len(cand))
    except Exception as e:
        ev('search_err', kw, str(e)[:100])
    nap()
cand = ([x for x in cand if x['nature'] == '强制性'] +
        sorted([x for x in cand if x['nature'] != '强制性'], key=lambda x: x['issue'] or '', reverse=True))
got, tries, fails = [], 0, 0
for x in cand:
    if len(got) >= MAX_PDF or tries >= 60 or fails >= 30: break
    tries += 1
    try:
        nap(); det = c.detail(x['id'])
        hc = det.get('hcno')
        if not hc:
            log(action='detail', code=x['code'], result='no_hcno'); ev('no_hcno', x['code']); continue
        x['hcno'] = hc
        dl = samr.SamrClient(delay=(1.2, 2.0))
        nap(); pdf = dl.try_native_pdf(hc)
        if pdf and pdf[:4] == b'%PDF':
            p = os.path.join(RAW, re.sub(r'[^0-9A-Za-z]+', '_', x['code']) + '.pdf')
            open(p, 'wb').write(pdf)
            x['pdf'] = p; x['bytes'] = len(pdf); got.append(x)
            log(action='download', code=x['code'], kb=round(len(pdf) / 1024), result='ok', n=len(got))
            ev('OK', x['code'], x['kw'], round(len(pdf) / 1024), 'KB', 'n=' + str(len(got))); fails = 0
        else:
            fails += 1
            log(action='download', code=x['code'], result='native_unavailable_v2')
            ev('miss', x['code'])
    except Exception as e:
        fails += 1
        log(action='error', code=x['code'], err=str(e)[:100]); ev('err', x['code'], str(e)[:80])
ev('SUMMARY', 'tries=%d got=%d cand=%d fails=%d' % (tries, len(got), len(cand), fails))
json.dump(got, open(os.path.join(RAW, '_harvest_result.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
ev('HARVEST2 DONE')
