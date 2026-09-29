# -*- coding: utf-8 -*-
"""体验版码：码内显式 page + check_path=false = 新解析，免疫线上 1.0.7 老表。
v0.5.1 起包内含 home/home 兼容跳板页：即便无路径入口走老表解析到 home/home 也能进。
用法：python qr_trial_fire.py [scene]  → 默认 v051，输出 qr_trial_<scene>.<png|jpg>
钉位状态 API 不可读：交付后以引擎雷达（answers 表新流量）复核。"""
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
           '"env_version":"trial","width":430}' % SCENE).encode("utf-8")
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=io.BytesIO(payload),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_trial_{SCENE}.{kind}"
    io.open(out, "wb").write(b)
    print("QR_OK", out, len(b), kind)
else:
    print("QR_FAIL:", b[:200])
