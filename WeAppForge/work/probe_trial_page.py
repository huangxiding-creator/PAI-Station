# -*- coding: utf-8 -*-
"""体验版包体检：getwxacodeunlimit(env_version=trial, check_path=True, page=pages/ask/ask)
微信服务端对 trial 真实包校验页面 → 41030=页面不在包里 / 出图=包健康且码可用。"""
import io, sys
from curl_cffi import requests as cr

API = "https://api.weixin.qq.com"
sec = {}
for line in io.open("E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8"):
    if "=" in line:
        k, _, v = line.strip().partition("=")
        sec[k] = v
appid, appsecret = sec["appid"], sec["appsecret"]

r = cr.get(f"{API}/cgi-bin/token", params={"grant_type": "client_credential",
           "appid": appid, "secret": appsecret}, impersonate="chrome", timeout=15)
tok = r.json().get("access_token")
print("token:", "OK" if tok else r.json())

for env in ("trial", "develop"):
    r = cr.post(f"{API}/wxa/getwxacodeunlimit", params={"access_token": tok},
                json={"scene": "src=probe", "page": "pages/ask/ask", "check_path": True,
                      "env_version": env, "width": 430},
                impersonate="chrome", timeout=20)
    ctype = r.headers.get("content-type", "")
    if "json" in ctype:
        d = r.json()
        print(f"[{env}] FAIL errcode={d.get('errcode')} errmsg={d.get('errmsg')}")
    else:
        path = f"E:/AI-Station/WeAppForge/work/qianwen_{env}_qr.png"
        open(path, "wb").write(r.content)
        print(f"[{env}] PASS png={len(r.content)}B -> {path}")
