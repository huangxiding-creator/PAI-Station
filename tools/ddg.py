import sys, re, json
from urllib.parse import quote
from curl_cffi import requests as cr

q = sys.argv[1]
r = cr.get("https://html.duckduckgo.com/html/?q=" + quote(q), impersonate="chrome", timeout=25)
html = r.text
print("len:", len(html))
out=[]
for m in re.finditer(r'<a[^>]*class="result__a"[^>]*href="([^"]+)"[^>]*>(.*?)</a>', html, re.S):
    u = m.group(1)
    # ddg redirect: //duckduckgo.com/l/?uddg=<encoded>
    mm = re.search(r'uddg=([^&]+)', u)
    if mm:
        from urllib.parse import unquote
        u = unquote(mm.group(1))
    out.append({"t": re.sub(r"<[^>]+>","",m.group(2)).strip()[:90], "u": u})
print(json.dumps(out[:15], ensure_ascii=False, indent=1))
