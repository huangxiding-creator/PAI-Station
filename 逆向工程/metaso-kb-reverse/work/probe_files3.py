# -*- coding: utf-8 -*-
"""probe_files3.py — 无sort参数翻页找真实文件(size>0)"""
import re, sys, uuid, json, time
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
SID = '8673582927558737920'
s = cr.Session(impersonate='chrome')
s.cookies.set('tid', str(uuid.uuid4()), domain='.metaso.cn', path='/')
s.cookies.set('_nb_ioWEgULi', '', domain='.metaso.cn', path='/')
r = s.get('https://metaso.cn/', timeout=30)
token = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text).group(1)
H = {'token': token, 'origin': 'https://metaso.cn', 'referer': f'https://metaso.cn/subject-v2/{SID}',
     'accept': 'application/json, text/plain, */*'}
found = []
for q in ('研报', '可研', 'pdf'):
    for idx in range(0, 4):
        r = s.get(f'https://metaso.cn/api/knowledge/{SID}/search',
                  params={'s': q, 'parentId': '', 'pageSize': 50, 'pageIndex': idx}, headers=H, timeout=30)
        j = r.json()
        d = j.get('data') or {}
        for it in d.get('content', []):
            if (it.get('size') or 0) > 0:
                found.append(it)
        time.sleep(0.8)
    if found: break
print('real files:', len(found))
for it in found[:8]:
    print(' -', it['fileName'][:60], '| size', it.get('size'), '| pages', it.get('pages'), '| origUrl', str(it.get('originalUrl'))[:60])
if found:
    json.dump(found[:10], open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_files_sample.json','w',encoding='utf-8'), ensure_ascii=False, indent=1)
    doc = found[0]; fid = doc['id']
    rt = s.get(f'https://metaso.cn/api/file/{fid}/ticket', headers=H, timeout=30)
    print('ticket:', rt.text[:160])
    rs = s.get(f'https://files.metaso.cn/api/file/{fid}/stream-download',
               headers={**H, 'accept': '*/*', 'referer': 'https://metaso.cn/'}, timeout=90)
    ct = rs.headers.get('content-type','')
    print('stream:', rs.status_code, ct[:40], 'len', len(rs.content), rs.content[:20])
