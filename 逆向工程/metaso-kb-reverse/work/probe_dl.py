# -*- coding: utf-8 -*-
"""probe_dl.py — 匿名下载链测试: search→fileId→ticket→stream-download"""
import re, sys, uuid, json
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
r = s.get(f'https://metaso.cn/api/knowledge/{SID}/search',
          params={'s': 'EPC', 'parentId': '', 'pageSize': 20, 'pageIndex': 0}, headers=H, timeout=30)
j = r.json()
items = j['data']['content']
print('search hits:', len(items), 'total:', j['data'].get('totalElements'), 'totalPages:', j['data'].get('totalPages'))
for it in items[:8]:
    print(' -', it.get('fileName'), '| id', it.get('id'), '| type', repr(it.get('contentType')), '| keys:', [k for k in it.keys()][:18])
open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/search_EPC_anon.json', 'w', encoding='utf-8').write(json.dumps(j, ensure_ascii=False, indent=1))
# pick first file item
cand = [it for it in items if it.get('contentType') not in ('', None, 'folder') and str(it.get('fileName','')).count('.') ]
fid = cand[0]['id'] if cand else items[0]['id']
fname = (cand[0] if cand else items[0]).get('fileName')
print('probe fileId:', fid, fname)
# ticket
rt = s.get(f'https://metaso.cn/api/file/{fid}/ticket', headers=H, timeout=30)
print('ticket:', rt.status_code, rt.text[:200])
# check-download-size
rc = s.get(f'https://metaso.cn/api/file/{fid}/check-download-size', headers=H, timeout=30)
print('check-size:', rc.status_code, rc.text[:200])
# stream-download on metaso.cn (HEAD)
rs = s.get(f'https://metaso.cn/api/file/{fid}/stream-download', headers={**H, 'accept': '*/*'}, timeout=60)
ct = rs.headers.get('content-type'); cl = rs.headers.get('content-length')
print('stream metaso.cn:', rs.status_code, ct, cl, 'first bytes:', rs.content[:16])
# stream-download on files.metaso.cn
try:
    rs2 = s.get(f'https://files.metaso.cn/api/file/{fid}/stream-download', headers={**H, 'accept': '*/*', 'referer': 'https://metaso.cn/'}, timeout=60)
    print('stream files.metaso.cn:', rs2.status_code, rs2.headers.get('content-type'), rs2.headers.get('content-length'), 'first bytes:', rs2.content[:16])
except Exception as e:
    print('files host err:', str(e)[:120])
