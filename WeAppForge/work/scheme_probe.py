# -*- coding: utf-8 -*-
"""scheme/urllink 变体电池：找可直呼微信协议的链接 + 用 40165 探线上版页面表。"""
import io
import json as _json
from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]


def post_json(path, body):
    r = requests.post(f"https://api.weixin.qq.com{path}?access_token={at}",
                      data=_json.dumps(body).encode("utf-8"),
                      headers={"Content-Type": "application/json"},
                      impersonate="chrome", timeout=40)
    try:
        return r.json()
    except Exception:
        return {"_raw": r.text[:120]}


# 1) scheme 最小变体（release 对照 + trial 目标）
for tag, body in [
    ("release-bare", {"jump_wxa": {}}),
    ("trial-bare", {"jump_wxa": {"env_version": "trial"}}),
]:
    print(f"scheme[{tag}]:", _json.dumps(post_json("/wxa/generatescheme", body), ensure_ascii=False)[:220])

# 2) urllink trial 无 path（页面解析走哪张表=实验判据）
print("urllink[trial-nopath]:", _json.dumps(
    post_json("/wxa/generate_urllink", {"env_version": "trial"}), ensure_ascii=False)[:220])

# 3) 40165 页面表探测：猜线上版 1.0.7（老标讯演示版）的页面
for p in ["pages/index/index", "pages/biaoxun/index", "pages/home/index",
          "pages/ask/ask", "pages/login/index", "pages/list/index"]:
    res = post_json("/wxa/generate_urllink", {"path": p, "env_version": "release"})
    verdict = "EXISTS_IN_RELEASE" if res.get("errcode") == 0 else res.get("errcode")
    print(f"probe[{p}]:", verdict)
