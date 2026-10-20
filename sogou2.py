import sys, re, json
from urllib.parse import quote
from curl_cffi import requests as cr

q = sys.argv[1]
r = cr.get("https://www.sogou.com/web?query=" + quote(q), impersonate="chrome", timeout=25)
html = r.text
open("sogou_last.html","w",encoding="utf-8").write(html)
print("len:", len(html), "| captcha:", ("验证" in html or "antispider" in html))
# dump all hrefs in h3 or vrTitle
for m in re.finditer(r'href="(https?://[^"]+|/link\?url=[^"]+)"', html):
    u = m.group(1)
    if "gov.cn" in u or u.startswith("/link"):
        print(u[:160])
