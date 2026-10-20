import sys, json, re
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests
from urllib.parse import quote

def govt(q, t, n=12):
    url = ('https://sousuo.www.gov.cn/search-gov/data?t=' + t + '&q=' + quote(q) +
           '&timetype=timeqb&mintime=&maxtime=&sort=pubtime&sortType=&searchfield=&p=1&n=' + str(n) +
           '&inpro=&bmfl=&dup=&orpro=&timeCustom=')
    r = requests.get(url, impersonate='chrome', timeout=25)
    try:
        d = json.loads(r.content.decode('utf-8', errors='replace'))
    except Exception as e:
        print('JSONERR', e); return
    sv = d.get('searchVO') or {}
    cat = sv.get('catMap') or {}
    hits = 0
    for k, v in cat.items():
        for it in (v.get('listVO') or []):
            ti = re.sub(r'<[^>]+>', '', it.get('title', ''))
            sm = re.sub(r'<[^>]+>', '', it.get('summary', ''))[:110]
            print(k, '|', it.get('pubtimeStr', ''), '|', ti[:60], '|', sm)
            hits += 1
    if not hits:
        print('(no hits) totalCount=', sv.get('totalCount'))

if __name__ == '__main__':
    govt(sys.argv[1], sys.argv[2])
