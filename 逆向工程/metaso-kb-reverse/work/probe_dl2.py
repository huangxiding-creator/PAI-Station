# -*- coding: utf-8 -*-
"""probe_dl2.py — 找真实文档测试 preview/public-file 下载面"""
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

def search(q, ps=30):
    r = s.get(f'https://metaso.cn/api/knowledge/{SID}/search',
              params={'s': q, 'parentId': '', 'pageSize': ps, 'pageIndex': 0}, headers=H, timeout=30)
    return r.json()['data']['content']

# files usually have size>0 and pages>=0; folders often size==0? sample and print all fields of a few
items = search('合同')
print('sample fields of first 3:')
for it in items[:3]:
    print(json.dumps(it, ensure_ascii=False)[:420]); print()
doc = None
for it in items:
    if it.get('pages') or (it.get('size') and it['size'] < 500*1024*1024):
        doc = it; break
if not doc: doc = items[0]
fid, name = doc['id'], doc['fileName']
print('DOC:', fid, name, 'size', doc.get('size'), 'pages', doc.get('pages'), 'origUrl', str(doc.get('originalUrl'))[:80])
# public-file
for path in (f'https://metaso.cn/api/public-file/{fid}',
             f'https://metaso.cn/api/public-file/{fid}?fileName=probe',
             f'https://temporary-cache.metaso.cn/{fid}?name=probe'):
    try:
        rp = s.get(path, headers={**H, 'referer': 'https://metaso.cn/'}, timeout=30)
        ct = rp.headers.get('content-type', '')
        print('PUB', path[:70], rp.status_code, ct[:40], rp.content[:60])
    except Exception as e:
        print('PUB', path[:70], 'ERR', str(e)[:80])
# preview
rp2 = s.get(f'https://metaso.cn/api/file/{fid}/preview', headers={**H, 'accept': '*/*'}, timeout=40)
print('preview:', rp2.status_code, rp2.headers.get('content-type'), rp2.content[:60])
# ticket again on doc
rt = s.get(f'https://metaso.cn/api/file/{fid}/ticket', headers=H, timeout=30)
print('ticket on doc:', rt.text[:150])
rs = s.get(f'https://files.metaso.cn/api/file/{fid}/stream-download', headers={**H, 'accept': '*/*', 'referer': 'https://metaso.cn/'}, timeout=60)
print('stream on doc:', rs.status_code, rs.headers.get('content-type'), rs.content[:60])
