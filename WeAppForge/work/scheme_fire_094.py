# -*- coding: utf-8 -*-
"""0.9.4 体验码（码内显式 page=pages/ask/ask + check_path=false，免疫线上老表）。"""
import io
import json as _json
from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=io.BytesIO(b'{"page":"pages/ask/ask","scene":"v094","check_path":false,"env_version":"trial","width":430}'),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_trial_094.{kind}"
    io.open(out, "wb").write(b)
    print("QR_OK", out, len(b), "bytes")
else:
    print("QR_FAIL", b[:200])
