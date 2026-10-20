import sys, re
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests
url, kw = sys.argv[1], sys.argv[2]
r = requests.get(url, impersonate='chrome', timeout=25)
t = r.content.decode('utf-8', errors='replace')
# find anchors whose inner text contains keyword (allow tags inside)
for m in re.finditer(r"""<a[^>]+href=["']([^"']+)["'][^>]*>(.{0,120}?)</a>""", t, flags=re.S):
    u, inner = m.group(1), m.group(2)
    if kw in re.sub(r'<[^>]+>', '', inner):
        print(u[:150])
