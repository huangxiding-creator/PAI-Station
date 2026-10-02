# -*- coding: utf-8 -*-
"""合法域名白名单只读探测：/wxa/modify_domain?action=get（纯读，不变更）。
发布硬门槛：request 合法域名必须含 api.yrecepc.cn。"""
import io
import json
from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

r = requests.post(f"https://api.weixin.qq.com/wxa/modify_domain?access_token={at}",
                  data=json.dumps({"action": "get"}).encode("utf-8"),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=30)
print(json.dumps(r.json(), ensure_ascii=False, indent=1))
