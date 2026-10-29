# -*- coding: utf-8 -*-
"""probe_tree.py — 匿名文件夹树遍历找真实文件"""
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

def folder(fid):
    r = s.get(f'https://metaso.cn/api/file/{fid}/folder', headers=H, timeout=30)
    return r.status_code, r.text[:400]

# root: try subject id itself
for fid in (SID, '0', '8676459173145354240'):
    sc, tx = folder(fid)
    print(f'folder({fid[:24]}):', sc, tx[:220])
    print()
