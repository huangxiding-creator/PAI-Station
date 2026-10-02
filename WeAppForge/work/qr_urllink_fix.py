# -*- coding: utf-8 -*-
"""体验版码修复：显式 page + 尝试 urllink（桌面微信自测通道）。"""
import io
from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
r = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                 params={"grant_type": "client_credential",
                         "appid": sec["appid"], "secret": sec["appsecret"]},
                 impersonate="chrome", timeout=30)
at = r.json()["access_token"]

# 1) 体验版小程序码：显式 page（0.2.7 真实存在的页面），杜绝按线上版1.0.7老首页解析
resp = requests.post(
    f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
    json={"scene": "fix1", "page": "pages/ask/ask", "check_path": False,
          "env_version": "trial", "width": 430},
    impersonate="chrome", timeout=60)
data = resp.content
kind = "png" if data[:4] == b"\x89PNG" else ("jpg" if data[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_trial_fix1.{kind}"
    io.open(out, "wb").write(data)
    print("QR_OK", out, len(data), "bytes", kind)
else:
    print("QR_FAIL:", data[:200])

import json as _json

def post_json(url, body):
    return requests.post(url, data=_json.dumps(body).encode("utf-8"),
                         headers={"Content-Type": "application/json"},
                         impersonate="chrome", timeout=40)

# 2) URL Link 变体电池：显式 body + 最小变体对照
for tag, body in [
    ("full", {"path": "pages/ask/ask", "query": "t=fix1",
              "env_version": "trial", "is_expire": False}),
    ("minimal", {"path": "pages/ask/ask"}),
    ("bare", {}),
]:
    t = post_json(f"https://api.weixin.qq.com/wxa/generate_urllink?access_token={at}", body).text
    print(f"urllink[{tag}]:", t[:200])

# 3) URL Scheme（备选通道）
t = post_json(f"https://api.weixin.qq.com/wxa/generatescheme?access_token={at}",
              {"jump_wxa": {"path": "/pages/ask/ask?src=scheme", "env_version": "trial"}}).text
print("scheme:", t[:200])
