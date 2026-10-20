import sys, re
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests
url = sys.argv[1]
r = requests.get(url, impersonate='chrome', timeout=25)
t = r.content.decode('utf-8', errors='replace')
seen = set()
for m in re.finditer(r"""<a[^>]+href=["']([^"']+)["'][^>]*>(.{0,60}?)</a>""", t, flags=re.S):
    u, inner = m.group(1), re.sub(r'<[^>]+>', '', m.group(2)).strip()
    if '.po' in u or 'List' in u:
        key = (u.split(';')[0], inner)
        if key not in seen:
            seen.add(key)
            print(inner[:30], '=>', u.split(';')[0][:100])
