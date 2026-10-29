# -*- coding: utf-8 -*-
"""probe_preview.py — 真实文件 preview 流测试 (公开阅读面)"""
import re, sys, uuid, json, time
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
SID = '8673582927558737920'
docs = json.load(open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_files_sample.json', encoding='utf-8'))
s = cr.Session(impersonate='chrome')
s.cookies.set('tid', str(uuid.uuid4()), domain='.metaso.cn', path='/')
s.cookies.set('_nb_ioWEgULi', '', domain='.metaso.cn', path='/')
r = s.get('https://metaso.cn/', timeout=30)
token = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text).group(1)
H = {'token': token, 'origin': 'https://metaso.cn', 'referer': f'https://metaso.cn/subject-v2/{SID}',
     'accept': 'application/json, text/plain, */*'}
doc = docs[0]
fid, name = doc['id'], doc['fileName']
print('target:', fid, name[:50], 'size', doc.get('size'))
for url in (f'https://metaso.cn/api/file/{fid}/preview',
            f'https://files.metaso.cn/api/file/{fid}/preview'):
    try:
        rp = s.get(url, headers={**H, 'accept': '*/*'}, timeout=60)
        ct = rp.headers.get('content-type', '')
        print(url[:60], '->', rp.status_code, ct[:50], 'len', len(rp.content), rp.content[:12])
    except Exception as e:
        print(url[:60], 'ERR', str(e)[:100])
# pdf/status
try:
    rs = s.get(f'https://metaso.cn/api/file/{fid}/pdf/status', headers=H, timeout=30)
    print('pdf/status:', rs.text[:200])
except Exception as e:
    print('pdf/status ERR', str(e)[:80])
# meta
rm = s.get(f'https://metaso.cn/api/file/{fid}/meta', headers=H, timeout=30)
print('meta:', rm.text[:260])
