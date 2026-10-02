# -*- coding: utf-8 -*-
"""0.7.1 页面不存在 复发诊断双码：
  qr_trial_v071home = env_version=trial   → 打开当前钉的体验版（钉位+包 联合检验）
  qr_dev_v071home   = env_version=develop → 打开最新开发版=0.7.1 包（纯包检验，零钉位依赖）
两码都 page=pages/home/home + check_path=false（永不404配方：新老包/新老表必命中）。
判读：trial败+develop开=钉位没落 0.7.1；两码都败=包问题（darkmode/lazyCodeLoading 嫌疑）；
两码都开=旧入口/缓存码问题+网络死（0.7.1 域名 BASE_URL 备案前不通）。"""
import io
import json

from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

JOBS = [("v071h", "trial", "qr_trial_v071home"),
        ("v071d", "develop", "qr_dev_v071home")]
for scene, env, name in JOBS:
    payload = json.dumps({"page": "pages/home/home", "scene": scene,
                          "check_path": False, "env_version": env,
                          "width": 430}).encode("utf-8")
    r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                      data=io.BytesIO(payload),
                      headers={"Content-Type": "application/json"},
                      impersonate="chrome", timeout=60)
    b = r.content
    kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
    if kind:
        out = f"E:/AI-Station/WeAppForge/work/{name}.{kind}"
        io.open(out, "wb").write(b)
        print("QR_OK", out, len(b), kind, env)
    else:
        print("QR_FAIL", env, b[:200])
