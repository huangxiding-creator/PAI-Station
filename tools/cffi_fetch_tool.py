import sys, re, html as H
from curl_cffi import requests
url = sys.argv[1]; dst = sys.argv[2]
r = requests.get(url, impersonate="chrome", timeout=40, headers={"Referer":"https://www.bing.com/"})
print("status", r.status_code, "bytes", len(r.content))
open(dst, "wb").write(r.content)
if "html" in r.headers.get("content-type","").lower() or r.content[:1] == b"<":
    h = r.content.decode("utf-8", errors="ignore")
    h = re.sub(r"<script[\s\S]*?</script>|<style[\s\S]*?</style>", "", h)
    t = re.sub(r"<br\s*/?>", "\n", h); t = re.sub(r"</p>", "\n", t); t = re.sub(r"<[^>]+>", "", t)
    t = H.unescape(t); t = re.sub(r"\n{3,}", "\n\n", t); t = re.sub(r"[ \t]+", " ", t)
    open(dst + ".txt", "w", encoding="utf-8").write(t)
    print("text chars", len(t))
