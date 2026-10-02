# -*- coding: utf-8 -*-
"""桌面自测台·协议链生成（诊断用途，故意不走 scheme_fire 的健康闸——就是要看坏态真容）。
用法: python work/bench_scheme.py [bare|path]  → 打印 openlink（bare=trial 无path / path=带release合法页）"""
import io
import json as _json
import sys
from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

mode = sys.argv[1] if len(sys.argv) > 1 else "bare"
jump = {"env_version": "trial" if mode in ("bare", "path") else mode}
if mode == "path":
    # path 须为 release 1.0.7 已发布页面（服务端校验），先探出的合法页再填
    jump["path"] = sys.argv[2] if len(sys.argv) > 2 else "pages/index/index"
if mode == "devpath":
    jump["env_version"] = "develop"
    jump["path"] = sys.argv[2] if len(sys.argv) > 2 else "pages/ask/ask"
r = requests.post(f"https://api.weixin.qq.com/wxa/generatescheme?access_token={at}",
                  data=_json.dumps({"jump_wxa": jump, "is_expire": False}).encode("utf-8"),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=40).json()
print("SCHEME_RESP:", _json.dumps(r, ensure_ascii=False))
if r.get("openlink"):
    io.open("E:/AI-Station/WeAppForge/work/bench_link.txt", "w").write(r["openlink"])
    print("LINK_SAVED", r["openlink"])
