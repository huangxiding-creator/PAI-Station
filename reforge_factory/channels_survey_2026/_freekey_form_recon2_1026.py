# -*- coding: utf-8 -*-
"""_freekey_form_recon2_1026 — 表单细节侦察第2轮 (字段选项/注册URL/嵌入表单)."""
from __future__ import annotations
import json, re, sys
import requests
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
PP = [None, {"http":"http://127.0.0.1:7890","https":"http://127.0.0.1:7890"},
      {"http":"http://127.0.0.1:7891","https":"http://127.0.0.1:7891"},
      {"http":"http://127.0.0.1:7893","https":"http://127.0.0.1:7893"}]

def get(url, note=""):
    for i, p in enumerate(PP):
        try:
            r = requests.get(url, headers=UA, timeout=20, proxies=p)
            tag = "direct" if p is None else ("proxy789%d" % (7890 if 7890 in (p or {}) and str(p).find("7890")>=0 else 0))
            tag = "direct" if p is None else list(p.values())[0].rsplit(":",1)[-1]
            return r, tag
        except Exception:
            continue
    return None, "all-fail"

# 1. EIA form chunk
r,_ = get("https://www.eia.gov/opendata/register.php")
if r:
    h = r.text
    m = re.search(r'<form[^>]*>.{0,6000}?name="email".{0,4000}?</form>', h, re.S)
    seg = m.group(0) if m else h[:6000]
    opts = re.findall(r'<option[^>]*value=["\']([^"\']*)["\'][^>]*>', seg)
    print("EIA.sector_options:", json.dumps(opts[:12], ensure_ascii=False))
    t = re.search(r'name="tos1"[^>]*>', seg)
    print("EIA.tos1_tag:", t.group(0) if t else "N/A")
    act = re.search(r'<form[^>]*action=["\']?([^"\'> ]*)', h)
    print("EIA.form_action:", act.group(1) if act else "(empty=post self)")

# 2. Census form chunk
r,_ = get("https://api.census.gov/data/key_signup.html")
if r:
    m = re.search(r'<form[^>]*>.*?</form>', r.text, re.S)
    print("CENSUS.form:", re.sub(r'\s+', ' ', m.group(0))[:600] if m else "N/A")

# 3. NASA FIRMS page: dump text around form/map_key
r,_ = get("https://firms.modaps.eosdis.nasa.gov/api/map_key/")
if r:
    h = r.text
    i = h.lower().find("<form")
    print("FIRMS.form_idx:", i, "html_head:", json.dumps(h[:400]))
    if i >= 0:
        print("FIRMS.form:", re.sub(r'\s+',' ', h[i:i+1200]))

# 4. UK CH get-started: links
r,_ = get("https://developer.company-information.service.gov.uk/get-started")
if r:
    for href in set(re.findall(r'href=["\']([^"\']*(?:register|sign-up|signup|create)[^"\']*)["\']', r.text, re.I)):
        print("UKCH.link:", href)

# 5. OpenCorporates api page: links to accounts/signup
r,_ = get("https://opencorporates.com/api")
if r:
    print("OC.api_status:", r.status_code)
    for href in sorted(set(re.findall(r'href=["\']([^"\']*(?:account|signup|sign-up|register|api-key|apply)[^"\']*)["\']', r.text, re.I)))[:12]:
        print("OC.link:", href)

# 6. S2 page: anchors/iframe around api-key-form
r,_ = get("https://www.semanticscholar.org/product/api")
if r:
    h = r.text
    for kw in ["api-key-form", "docs.google.com/forms", "typeform", "airtable", "forms.gle"]:
        j = h.find(kw)
        if j >= 0:
            print("S2.ctx[%s]:" % kw, json.dumps(h[max(0,j-150):j+250]))
            break

# 7. FRED retries
for port in [7890, 7891, 7893]:
    try:
        r = requests.get("https://fred.stlouisfed.org/docs/api/api_key.html", headers=UA, timeout=15,
                         proxies={"http":f"http://127.0.0.1:{port}","https":f"http://127.0.0.1:{port}"})
        print("FRED.proxy%d:" % port, r.status_code, len(r.text))
        if r.status_code == 200:
            m = re.search(r'<form[^>]*>.*?</form>', r.text, re.S)
            print("FRED.form:", re.sub(r'\s+',' ',m.group(0))[:500] if m else "N/A(no form)")
            break
    except Exception as e:
        print("FRED.proxy%d:" % port, "FAIL", type(e).__name__)
