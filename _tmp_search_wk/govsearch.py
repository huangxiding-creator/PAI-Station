import sys, json, re
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests
from urllib.parse import quote

def govt(q, t='zhengcelibrary_gw_bm_rd', n=12, field='title'):
    url = ('https://sousuo.www.gov.cn/search-gov/data?t=' + t + '&q=' + quote(q) +
           '&timetype=timeqb&mintime=&maxtime=&sort=score&sortType=1&searchfield=' + field +
           '&p=1&n=' + str(n) + '&inpro=&bmfl=&dup=&orpro=')
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
            print(k, '|', it.get('pubtimeStr', ''), '|', ti[:70], '|', it.get('url', '')[:115])
            hits += 1
    if not hits:
        print('(no hits) totalCount=', sv.get('totalCount'))

if __name__ == '__main__':
    q = sys.argv[1]
    t = sys.argv[2] if len(sys.argv) > 2 else 'zhengcelibrary_gw_bm_rd'
    govt(q, t)
