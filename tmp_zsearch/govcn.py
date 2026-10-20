# -*- coding: utf-8 -*-
import sys, io, json
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests
from urllib.parse import quote_plus
q = sys.argv[1]
n = sys.argv[2] if len(sys.argv)>2 else '10'
u=f'https://sousuo.www.gov.cn/search-gov/data?t=zhengcelibrary&q={quote_plus(q)}&timetype=timeqb&sort=score&sortType=1&p=1&n={n}&searchfield=content'
r=requests.get(u,impersonate='chrome',headers={'Accept-Language':'zh-CN,zh;q=0.9'},timeout=25)
j=r.json()
sv=j.get('searchVO') or {}
cats = sv.get('catMap') or {}
if not cats:
    print('no results', r.text[:200]); sys.exit()
for cname, arr in cats.items():
    try: items = arr.get('listVO', arr if isinstance(arr,list) else [])
    except: items=[]
    print(f'== {cname} ({len(items)})')
    for it in items[:int(n)]:
        print('-', it.get('pubtimeStr',''),'|',it.get('pcode',''),'|',(it.get('title') or '')[:70],'|',it.get('url','')[:120])
