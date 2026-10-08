# -*- coding: utf-8 -*-
"""mp_modify_domain.py — /wxa/modify_domain 给 wx5cee 加 downloadFile 合法域名
（报告商城 PDF：wx.downloadFile 直连 ai.epcschool.top）。
用法: python mp_modify_domain.py [dry]   dry=只查现状不改
"""
import io
import json
import sys

import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SECRET = "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret"

sec = dict(l.strip().split("=", 1) for l in io.open(SECRET, encoding="utf-8")
           if "=" in l and not l.startswith("#"))
DRY = len(sys.argv) > 1 and sys.argv[1] == "dry"
HOST = "ai.epcschool.top"

# 坑：生产引擎同 appsecret 轮换 token，cgi-bin/token 新票会即时挤掉旧票——
# 取票后立刻调用，40014 就换票重试（有界梯）
import time


def call(payload, tries=8):
    last = {}
    for i in range(tries):
        r = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                         params={"grant_type": "client_credential",
                                 "appid": sec["appid"].strip(),
                                 "secret": sec["appsecret"].strip()},
                         timeout=20).json()
        token = r.get("access_token")
        if not token:
            print("token FAIL:", json.dumps(r, ensure_ascii=False)[:200])
            time.sleep(2)
            continue
        last = requests.post(
            "https://api.weixin.qq.com/wxa/modify_domain",
            params={"access_token": token},
            json=payload, timeout=20).json()
        if last.get("errcode") != 40014:
            return last
        print(f"retry {i + 1}: token raced (40014)")
        time.sleep(1.5)
    return last


cur = call({"action": "get"})
print("current:", json.dumps(cur, ensure_ascii=False)[:600])
dl = cur.get("downloadfilelist") or []
if DRY:
    raise SystemExit(0)
if HOST in dl:
    print("already in downloadFile list")
    raise SystemExit(0)

# 官方键名：downloaddomain（请求）/ downloadfilelist（响应）
r2 = call({"action": "add", "downloaddomain": ["https://" + HOST]})
print("add:", json.dumps(r2, ensure_ascii=False)[:600])

cur2 = call({"action": "get"})
dl2 = cur2.get("downloadfilelist") or []
print("verify downloadfilelist:", dl2)
print("OK" if HOST in dl2 else "NOT_IN_LIST")
