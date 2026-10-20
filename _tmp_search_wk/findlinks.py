import sys, re
sys.stdout.reconfigure(encoding='utf-8')
from curl_cffi import requests
url = sys.argv[1]
pats = sys.argv[2].split(',')
r = requests.get(url, impersonate='chrome', timeout=25)
t = r.content.decode('utf-8', errors='replace')
links = set()
for m in re.finditer(r"""(?:href|src)=["']([^"']+)["']""", t):
    u = m.group(1)
    if any(p.lower() in u.lower() for p in pats):
        links.add(u)
for u in sorted(links):
    print(u[:150])
