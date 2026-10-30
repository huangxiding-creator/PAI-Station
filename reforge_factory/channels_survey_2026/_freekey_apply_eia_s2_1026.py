# -*- coding: utf-8 -*-
"""_freekey_apply_eia_s2_1026 — EIA提交 + S2 HubSpot表单获取&提交 + FIRMS/UKCH精查."""
from __future__ import annotations
import json, re, sys
import requests
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.9"}
MAIL = "51817@qq.com"
REASON = "Academic research on construction cost estimation and engineering economy benchmarks"
PROXY = {"http": "http://127.0.0.1:7890", "https": "http://127.0.0.1:7890"}

# ---- 1. EIA submit ----
try:
    r = requests.post("https://www.eia.gov/opendata/register.php",
        data={"firstName": "Zongbao", "lastName": "Research", "email": MAIL,
              "sector": "Research/Consulting", "reason_for_use": REASON, "tos1": "1"},
        headers={**UA, "Referer": "https://www.eia.gov/opendata/register.php", "Origin": "https://www.eia.gov"},
        timeout=30, allow_redirects=True)
    body = re.sub(r'<[^>]+>', ' ', r.text); body = re.sub(r'\s+', ' ', body)
    kw = [k for k in ["success", "thank", "error", "invalid", "already"] if k in body.lower()]
    print("EIA.submit:", r.status_code, "|kw:", kw, "|", body[:220])
except Exception as e:
    print("EIA.submit FAIL:", type(e).__name__, str(e)[:120])

# ---- 2. S2 HubSpot form definition ----
FORM_URL_DEF = "https://forms.hsforms.com/embed/v3/form/5910970/105f3885-cfd8-4b57-a570-6174c5c1650a/json"
def hs_def(via):
    p = PROXY if via else None
    return requests.get(FORM_URL_DEF, headers=UA, timeout=25, proxies=p)
r2 = None
for via in (False, True):
    try:
        r2 = hs_def(via); tag = "proxy" if via else "direct"
        if r2.status_code == 200: break
    except Exception as e:
        print("S2.def %s FAIL:" % ("proxy" if via else "direct"), type(e).__name__)
if r2 is not None and r2.status_code == 200:
    d = r2.json()
    fields = [(f.get("name"), f.get("label"), f.get("type"), f.get("required")) for f in d.get("fields", [])]
    print("S2.hs_fields:", json.dumps(fields, ensure_ascii=False))
    print("S2.hs_meta:", {k: d.get(k) for k in ("portalId", "formId", "guid", "name", "submitButtonField") if d.get(k)})
    json.dump(d, open(r"E:/AI-Station/reforge_factory/channels_survey_2026/_s2_hsform_def_1026.json", "w", encoding="utf-8"))
else:
    print("S2.def status:", r2.status_code if r2 is not None else "none", (r2.text[:150] if r2 is not None else ""))

# ---- 3. FIRMS: form container ----
h3 = requests.get("https://firms.modaps.eosdis.nasa.gov/api/map_key/", headers=UA, timeout=25).text
k = h3.find("The key will be sent")
print("FIRMS.ctx:", json.dumps(h3[k:k+1800]) if k >= 0 else "N/A")

# ---- 4. UKCH: all links on get-started ----
h4 = requests.get("https://developer.company-information.service.gov.uk/get-started", headers=UA, timeout=25).text
hrefs = sorted(set(re.findall(r'href=["\'](/[^"\']+)["\']', h4)))
print("UKCH.links:", json.dumps([x for x in hrefs if not x.endswith(('.css','.js','.ico','.png','.svg'))][:25]))
