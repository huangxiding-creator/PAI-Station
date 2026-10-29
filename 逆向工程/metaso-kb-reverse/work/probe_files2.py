# -*- coding: utf-8 -*-
"""probe_files2.py — 搜索结果里筛真实文件(size>0/pages>0)并测下载"""
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
def search(q, idx=0, ps=50, sort='relevance'):
    r = s.get(f'https://metaso.cn/api/knowledge/{SID}/search',
              params={'s': q, 'parentId': '', 'pageSize': ps, 'pageIndex': idx, 'sort': sort, 'sortDirection': 'desc'},
              headers=H, timeout=30)
    return r.json()['data']
found = []
for q in ('EPC 合同 案例', '研报 2025', '可行性研究'):
    d = search(q)
    for it in d['content']:
        if (it.get('size') or 0) > 0:
            found.append(it)
    if found: break
    time.sleep(1)
print('real files found:', len(found))
for it in found[:6]:
    print(' -', it['fileName'][:60], '| size', it.get('size'), '| pages', it.get('pages'), '| ct', repr(it.get('contentType')))
if found:
    json.dump(found[:10], open(r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures/real_files_sample.json','w',encoding='utf-8'), ensure_ascii=False, indent=1)
    doc = found[0]
    fid = doc['id']
    rt = s.get(f'https://metaso.cn/api/file/{fid}/ticket', headers=H, timeout=30)
    print('ticket:', rt.text[:150])
    rs = s.get(f'https://files.metaso.cn/api/file/{fid}/stream-download', headers={**H,'accept':'*/*','referer':'https://metaso.cn/'}, timeout=90)
    print('stream:', rs.status_code, rs.headers.get('content-type'), len(rs.content), rs.content[:20])
