# -*- coding: utf-8 -*-
"""对照实验：学园 trial（用户手机已实开）同法探测——校 probe 方法学是否可靠。"""
import io
from curl_cffi import requests as cr
API = "https://api.weixin.qq.com"
sec = {}
for line in io.open("E:/AI-Station/data/secrets/xueyuan_mp.secret", encoding="utf-8"):
    if "=" in line:
        k, _, v = line.strip().partition("=")
        sec[k] = v
r = cr.get(f"{API}/cgi-bin/token", params={"grant_type": "client_credential",
           "appid": sec["appid"], "secret": sec["appsecret"]},
           impersonate="chrome", timeout=15)
tok = r.json().get("access_token")
print("token:", "OK" if tok else r.json())
for env in ("trial", "develop"):
    for page in ("pages/index/index", "pages/rank/rank"):
        r = cr.post(f"{API}/wxa/getwxacodeunlimit", params={"access_token": tok},
                    json={"scene": "src=probe", "page": page, "check_path": True,
                          "env_version": env, "width": 430},
                    impersonate="chrome", timeout=20)
        ctype = r.headers.get("content-type", "")
        if "json" in ctype:
            d = r.json()
            print(f"[{env}] {page} FAIL errcode={d.get('errcode')} {d.get('errmsg')}")
        else:
            print(f"[{env}] {page} PASS png={len(r.content)}B")
