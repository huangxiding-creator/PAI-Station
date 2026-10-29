# -*- coding: utf-8 -*-
"""Differential probe: anonymous vs Bearer on each endpoint (read-only GET)."""
import json, sys
from curl_cffi import requests as creq
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE = "https://api.djyanbao.com/api"
ls = json.load(open(r"E:/AI-Station/逆向工程/djyanbao-reverse/captures/profile_localstorage.json", encoding="utf-8"))
TOK = ls["token"]; UUID = ls["uuid"]

def hdrs(auth):
    h = {"Content-Type": "application/json", "client-ver": "v2.0.14",
         "client-type": "pc", "client-id": UUID, "Origin": "https://www.djyanbao.com",
         "Referer": "https://www.djyanbao.com/"}
    if auth: h["Authorization"] = f"Bearer {TOK}"
    return h

cases = [
    ("list /api/report",        "GET", "/report?page=1&limit=3&q=%E5%9B%BD%E9%99%85%E5%B7%A5%E7%A8%8B&sort=publish_at&order=DESC&matchPhrase=false", False),
    ("detail /api/report/{id}", "GET", "/report/4522142", False),
    ("ai-analysis",             "GET", "/report/4522142/report-ai-analysis?all=true", False),
    ("download/info view",      "GET", "/report/4522142/download/info?action=view&format=pdf", False),
]
for name, method, path, _ in cases:
    for auth in (False, True):
        s = creq.Session(impersonate="chrome")
        r = s.request(method, BASE + path, headers=hdrs(auth), timeout=15)
        tag = "AUTH " if auth else "ANON "
        body = r.text
        note = ""
        if r.status_code == 200:
            try:
                j = json.loads(body)
                note = f"code={j.get('code')} msg={str(j.get('message'))[:30]} data_keys={list(j['data'].keys()) if isinstance(j.get('data'), dict) else type(j.get('data')).__name__}"
                note += f" len={len(body)}"
            except Exception:
                note = f"non-json len={len(body)}"
        print(f"{tag} {name:26s} -> HTTP {r.status_code} {note}")
        s.close()
