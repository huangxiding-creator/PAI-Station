# -*- coding: utf-8 -*-
import sys, time, json
from curl_cffi import requests
s = requests.Session(impersonate="chrome")
def q(kw, n=12):
    r = s.get('https://www.nea.gov.cn/was5/web/conwebsite/getNewsFromAllData',
              params={'keyword': kw, 'pageNo': 1, 'pageSize': n, 'siteId': 11200,
                      'isInclude': 1, 'orderby': 1, 'callback': 'jsonpCallback', '_': int(time.time()*1000)},
              headers={'Referer': 'https://www.nea.gov.cn/search.htm', 'X-Requested-With': 'XMLHttpRequest'},
              timeout=25)
    t = r.text.strip()
    i, j = t.find('('), t.rfind(')')
    d = json.loads(t[i+1:j])
    res = d.get('content', {}).get('result', []) or []
    print(f"### KW: {kw} | hits: {len(res)}")
    for it in res:
        ou = it.get('originUrl') or []
        u = ou[0] if ou else ''
        print(it.get('title', '')[:70], '|', it.get('releaseDate', '')[:10], '|', u)
    print()
for kw in sys.argv[1:]:
    try:
        q(kw)
    except Exception as e:
        print('ERR', kw, repr(e)[:120])
    time.sleep(1.2)
