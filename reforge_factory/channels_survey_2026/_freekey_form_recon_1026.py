# -*- coding: utf-8 -*-
"""_freekey_form_recon_1026 — B级免费钥申领波·表单侦察 (只读GET, 判形态/验证码)."""
from __future__ import annotations
import json, re, sys
import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language": "en-US,en;q=0.9"}
PROXIES = {"http": "http://127.0.0.1:7890", "https": "http://127.0.0.1:7890"}

PAGES = [
    ("nasa_firms",   "https://firms.modaps.eosdis.nasa.gov/api/map_key/"),
    ("eia",          "https://www.eia.gov/opendata/register.php"),
    ("fred",         "https://fred.stlouisfed.org/docs/api/api_key.html"),
    ("us_census",    "https://api.census.gov/data/key_signup.html"),
    ("metager",      "https://metager.de/keys"),
    ("s2",           "https://www.semanticscholar.org/product/api"),
    ("opencorp",     "https://opencorporates.com/api/accounts"),
    ("gnews",        "https://gnews.io/register"),
    ("newsapi",      "https://newsapi.org/register"),
    ("tavily",       "https://app.tavily.com/"),
    ("exa",          "https://dashboard.exa.ai/"),
    ("serpapi",      "https://serpapi.com/manage-api-key"),
    ("brave",        "https://api.search.brave.com/app/register"),
    ("uk_ch",        "https://developer.company-information.service.gov.uk/get-started"),
    ("kaggle",       "https://www.kaggle.com/settings"),
]

def recon(name, url):
    out = {"ch": name, "url": url, "via": "direct"}
    try:
        r = requests.get(url, headers=UA, timeout=25, allow_redirects=True)
    except Exception as e:
        out["via"] = "direct-fail:" + type(e).__name__
        try:
            r = requests.get(url, headers=UA, timeout=25, allow_redirects=True, proxies=PROXIES)
            out["via"] = "proxy7890"
        except Exception as e2:
            out["net"] = "FAIL:" + type(e2).__name__
            return out
    out["status"] = r.status_code
    out["final_url"] = r.url[:120]
    h = r.text or ""
    caps = []
    for pat in ["recaptcha", "hcaptcha", "turnstile", "cf-chl", "challenge-platform", "px-captcha", "data-sitekey"]:
        if pat.lower() in h.lower():
            caps.append(pat)
    out["captcha"] = ",".join(caps) if caps else "-"
    forms = []
    for m in re.finditer(r"<form[^>]*>", h, re.I):
        tag = m.group(0)
        action = re.search(r'action=["\']([^"\']*)["\']', tag, re.I)
        method = re.search(r'method=["\']([^"\']*)["\']', tag, re.I)
        seg = h[m.end():m.end()+3000]
        inputs = re.findall(r"<(?:input|select|textarea)[^>]*?(?:name=[\"']([^\"']+)[\"'])[^>]*>", seg, re.I)
        forms.append({"action": (action.group(1) if action else "")[:100],
                      "method": method.group(1) if method else "?",
                      "fields": inputs[:14]})
    out["forms"] = forms[:4]
    out["html_len"] = len(h)
    return out

for n, u in PAGES:
    try:
        print(json.dumps(recon(n, u), ensure_ascii=False), flush=True)
    except Exception as e:
        print(json.dumps({"ch": n, "err": repr(e)[:120]}), flush=True)
