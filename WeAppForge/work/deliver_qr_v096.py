# -*- coding: utf-8 -*-
"""0.9.6 体验版验收码：永不404配方 page=home/home（新老包页面表双命中，落地 reLaunch 咨询首页），
env_version=trial 直开钉位版 + check_path=false。交付=桌面打开+会话留档。"""
import io
import json
import subprocess

from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

r = requests.post(
    f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
    data=io.BytesIO(json.dumps({
        "page": "pages/home/home", "scene": "v096",
        "check_path": False, "env_version": "trial", "width": 430,
    }).encode("utf-8")),
    headers={"Content-Type": "application/json"},
    impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if not kind:
    raise SystemExit("QR_FAIL: " + repr(b[:200]))
out = f"E:/AI-Station/WeAppForge/work/qr_trial_096.{kind}"
io.open(out, "wb").write(b)
print("QR_OK", out, len(b), kind)

# 桌面打开（PowerShell Start-Process；jpg 直开报错 → explorer.exe 参数形态最稳）
subprocess.run(["powershell", "-NoProfile", "Start-Process", "explorer.exe", out], check=False)
print("OPENED_ON_DESKTOP")
