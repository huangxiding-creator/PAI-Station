# -*- coding: utf-8 -*-
"""_freekey_form_recon3_1026 — EIA/S2/FIRMS表单精查 + UKCH/register探针 + Census首提."""
from __future__ import annotations
import json, re, sys
import requests
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.9"}
MAIL = "51817@qq.com"

def g(url, **kw):
    return requests.get(url, headers=UA, timeout=25, **kw)

# 1. EIA 精查
h = g("https://www.eia.gov/opendata/register.php").text
i = h.find('name="firstName"')
seg = h[max(0,i-2500):i+2500]
opts = re.findall(r'<option[^>]*>([^<]*)</option>', seg)
print("EIA.options:", json.dumps(opts[:15], ensure_ascii=False))
hid = re.findall(r'<input[^>]*type=["\']hidden["\'][^>]*>', seg)
print("EIA.hidden:", [re.sub(r'\s+',' ',x)[:120] for x in hid[:5]])
sel = re.search(r'<select[^>]*name=["\']sector["\'][^>]*>(.*?)</select>', h, re.S)
print("EIA.sector_sel:", re.sub(r'\s+',' ',sel.group(1))[:300] if sel else "N/A")

# 2. S2 id="api-key-form" 上下文
h2 = g("https://www.semanticscholar.org/product/api").text
j = h2.find('id="api-key-form"')
print("S2.idx:", j)
if j >= 0:
    print("S2.ctx:", json.dumps(h2[max(0,j-200):j+1500]))

# 3. FIRMS 页内找申请入口
h3 = g("https://firms.modaps.eosdis.nasa.gov/api/map_key/").text
for kw in ["MAP_KEY", "map key", "e-mail", "email", "Earthdata", "register"]:
    k = h3.lower().find(kw.lower())
    if k >= 0:
        txt = re.sub(r'<[^>]+>', ' ', h3[k-100:k+400]); txt = re.sub(r'\s+',' ', txt)
        print("FIRMS[%s]:" % kw, txt[:260]); break
lf = sorted(set(re.findall(r'href=["\']([^"\']*(?:urs|earthdata|laads|register|form)[^"\']*)["\']', h3, re.I)))[:8]
print("FIRMS.links:", lf)

# 4. UK CH /register
try:
    r4 = g("https://developer.company-information.service.gov.uk/register")
    print("UKCH.register:", r4.status_code, r4.url[:100])
    m = re.search(r'<form[^>]*>.*?</form>', r4.text, re.S)
    if m: print("UKCH.form:", re.sub(r'\s+',' ',m.group(0))[:700])
except Exception as e:
    print("UKCH.register FAIL:", type(e).__name__)

# 5. OpenCorporates /api 再试
try:
    r5 = g("https://opencorporates.com/api")
    print("OC.api:", r5.status_code, len(r5.text))
    for href in sorted(set(re.findall(r'href=["\']([^"\']*(?:account|signup|apply)[^"\']*)["\']', r5.text, re.I)))[:10]:
        print("OC.link:", href)
except Exception as e:
    print("OC.api FAIL:", type(e).__name__)

# 6. Census 提交 (首申领)
r6 = requests.post("https://api.census.gov/data/KeySignup",
    data={"org": "Independent Research", "email": MAIL, "terms": "1"},
    headers={**UA, "Referer": "https://api.census.gov/data/key_signup.html", "Origin": "https://api.census.gov"},
    timeout=25, allow_redirects=True)
body = re.sub(r'<[^>]+>', ' ', r6.text); body = re.sub(r'\s+', ' ', body)
print("CENSUS.submit:", r6.status_code, "|", body[:300])
