import sys, re
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests
from urllib.parse import quote
base, kw = sys.argv[1], sys.argv[2]
for path in ['/search/index.html?q=', '/so/s?qt=', '/searchSite.po?qt=']:
    try:
        r = requests.get(base + path + quote(kw), impersonate='chrome', timeout=20)
        t = r.content.decode('utf-8', errors='replace')
        if r.status_code == 200 and len(t) > 3000 and '验证' not in t[:2000]:
            print('=== ', base + path)
            text = re.sub(r'<[^>]+>', ' ', t)
            text = re.sub(r'\s+', ' ', text)
            print(text[:1200])
            break
    except Exception as e:
        pass
