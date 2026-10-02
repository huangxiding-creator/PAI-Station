# -*- coding: utf-8 -*-
"""总包说科技 v1.1.0 开发版二维码（appid wxd096fc6994ef6f48）
env_version=develop → 直开最新开发版（刚传的 v1.1.0，无钉位依赖）
page=pages/index/index 显式 + check_path=false（永不404配方）"""
import io
import json

from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_mp_wxd096.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

payload = json.dumps({"page": "pages/index/index", "scene": "zbsdev110",
                      "check_path": False, "env_version": "develop",
                      "width": 430}).encode("utf-8")
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=io.BytesIO(payload),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_dev_zbs_v110.{kind}"
    io.open(out, "wb").write(b)
    print("QR_OK", out, len(b), kind)
else:
    print("QR_FAIL", b[:200])
