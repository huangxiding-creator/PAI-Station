# -*- coding: utf-8 -*-
"""只读探针：线上正式版(release)页面表是否已含 pages/ask/ask。
check_path=true 由微信按 release 当前页面表校验——PNG=有此页(0.7.3已发布)，
errcode 41030=release 仍旧 1.0.7 老表(此刻切 release 会重演「页面不存在」)。
不落任何缓存、不改任何状态。"""
import io
import json
import sys

from curl_cffi import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

for page in ("pages/ask/ask", "pages/home/home"):
    r = requests.post(
        f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
        data=io.BytesIO(json.dumps({
            "page": page, "scene": "probe-rel",
            "check_path": True, "env_version": "release", "width": 280,
        }).encode("utf-8")),
        headers={"Content-Type": "application/json"},
        impersonate="chrome", timeout=60)
    b = r.content
    if b[:4] == b"\x89PNG":
        print(f"PROBE {page}: IN_RELEASE_TABLE (PNG {len(b)}B)")
    else:
        try:
            print(f"PROBE {page}: NOT_IN_TABLE {r.json()}")
        except Exception:
            print(f"PROBE {page}: RAW {b[:200]!r}")
