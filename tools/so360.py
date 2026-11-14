import sys, re, json
from urllib.parse import quote
from curl_cffi import requests as cr

q = sys.argv[1]
r = cr.get("https://www.so.com/s?q=" + quote(q), impersonate="chrome", timeout=25)
html = r.text
print("len:", len(html))
out = []
for m in re.finditer(r'data-mdurl="([^"]+)"', html):
    out.append(m.group(1))
if not out:
    for m in re.finditer(r'<a[^>]*href="(https?://[^"]+)"[^>]*class="[^"]*result[^"]*"', html):
        out.append(m.group(1))
seen=set(); res=[]
for u in out:
    if u not in seen:
        seen.add(u); res.append(u)
print(json.dumps(res[:20], ensure_ascii=False, indent=1))
