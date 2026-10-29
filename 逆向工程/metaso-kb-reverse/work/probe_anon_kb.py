# -*- coding: utf-8 -*-
"""probe_anon_kb.py — 匿名面探subject: 公开页/搜索/分享详情"""
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
# 1) anonymous knowledge search
r1 = s.get(f'https://metaso.cn/api/knowledge/{SID}/search',
           params={'s': 'EPC', 'parentId': '', 'pageSize': 5, 'pageIndex': 0}, headers=H, timeout=30)
print('anon search:', r1.status_code, r1.text[:300])
# 2) topic share detail
r2 = s.get(f'https://metaso.cn/api/topic/{SID}/share', headers=H, timeout=30)
print('share:', r2.status_code, r2.text[:300])
# 3) knowledge simple detail
r3 = s.get(f'https://metaso.cn/api/getTopicSimpleDetail?id={SID}', headers=H, timeout=30)
print('simpleDetail:', r3.status_code, r3.text[:300])
# 4) public subject page
r4 = s.get(f'https://metaso.cn/subject-v2/{SID}', timeout=30)
m = re.search(r'<title>([^<]*)</title>', r4.text)
print('public page:', r4.status_code, 'title:', m.group(1) if m else None, 'len', len(r4.text))
open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/subject_public_anon.html', 'w', encoding='utf-8', errors='replace').write(r4.text)
