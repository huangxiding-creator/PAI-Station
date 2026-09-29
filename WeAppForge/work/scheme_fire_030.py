# -*- coding: utf-8 -*-
"""生成体验码（码内显式 page + check_path=false = 新解析，免疫线上版 1.0.7 老表）。
0929晚 语义修正（教训级）：check_path=true 只按线上版已发布页面表校验（#19实证：钉位健康时
真页面也 41030）→ API 层无法预读钉位状态，原「出码前硬闸」恒假阴性已废。真判据=用户手机
扫码（码内带页，钉位健康即开）+ 引擎雷达（answers 表新流量）复核。"""
import io
import json as _json
from curl_cffi import requests

print("NOTE: 本码码内显式 page=pages/ask/ask + check_path=false（新解析，免疫老表）。")
print("NOTE: 钉位状态 API 不可读，交付后以引擎雷达复核。")

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]


def post_json(path, body):
    return requests.post(f"https://api.weixin.qq.com{path}?access_token={at}",
                         data=_json.dumps(body).encode("utf-8"),
                         headers={"Content-Type": "application/json"},
                         impersonate="chrome", timeout=40).json()


# 1) trial 协议链（桌面拉起）
print("scheme:", _json.dumps(post_json("/wxa/generatescheme",
      {"jump_wxa": {"env_version": "trial"}}), ensure_ascii=False))

# 2) 体验码：显式 page（0.3.0 真身页）
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=io.BytesIO(b'{"page":"pages/ask/ask","scene":"v042","check_path":false,"env_version":"trial","width":430}'),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_trial_042.{kind}"
    io.open(out, "wb").write(b)
    print("QR_OK", out, len(b), kind)
else:
    print("QR_FAIL:", b[:200])
