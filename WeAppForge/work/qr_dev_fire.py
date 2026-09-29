# -*- coding: utf-8 -*-
"""开发版码（免钉位通道）：env=develop + 显式 page + check_path=false（新解析，不查老表）。
指向最新开发版本（当前 0.5.1 robot5）。管理员/项目成员微信扫码即开，体验版钉位无关。
用法：python qr_dev_fire.py [scene]  → 默认 v051，输出 qr_dev_<scene>.<png|jpg>"""
import io
import sys

from curl_cffi import requests

SCENE = (sys.argv[1] if len(sys.argv) > 1 else "v051").strip() or "v051"

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

payload = ('{"page":"pages/ask/ask","scene":"%s","check_path":false,'
           '"env_version":"develop","width":430}' % SCENE).encode("utf-8")
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=io.BytesIO(payload),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_dev_{SCENE}.{kind}"
    io.open(out, "wb").write(b)
    print("QR_OK", out, len(b), kind)
else:
    print("QR_FAIL:", b[:200])
