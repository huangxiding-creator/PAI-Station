# -*- coding: utf-8 -*-
import sys, io, json
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests
url = sys.argv[1]
r = requests.get(url, impersonate='chrome', headers={'Accept-Language':'zh-CN,zh;q=0.9','Referer':'https://so.news.cn/'}, timeout=30)
print('status', r.status_code)
t = r.text
print(t[:6000])
