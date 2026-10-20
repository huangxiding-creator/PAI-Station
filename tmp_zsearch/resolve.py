# -*- coding: utf-8 -*-
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests
for u in sys.argv[1:]:
    try:
        r = requests.get(u, impersonate='chrome', headers={'Accept-Language':'zh-CN,zh;q=0.9','Referer':'https://weixin.sogou.com/'}, timeout=25, allow_redirects=True)
        print(r.status_code, r.url)
    except Exception as e:
        print('ERR', u[:60], repr(e)[:120])
