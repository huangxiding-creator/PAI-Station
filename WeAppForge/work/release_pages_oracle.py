# -*- coding: utf-8 -*-
"""线上版页面表神谕：getwxacodeunlimit env=release + check_path=True。
41030=页面不存在于线上版；生成成功=页面真实存在于 1.0.7 老包。"""
import io
from curl_cffi import requests

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  impersonate="chrome", timeout=30).json()["access_token"]

CANDIDATES = [
    "pages/index/index", "pages/index", "pages/home/home", "pages/home/index",
    "pages/biaoxun/index", "pages/biaoxun/biaoxun", "pages/biaoxun/home",
    "pages/list/index", "pages/list/list", "pages/search/index",
    "pages/detail/index", "pages/login/login", "pages/login/index",
    "pages/mine/mine", "pages/mine/index", "pages/my/my", "pages/my/index",
    "pages/logs/logs", "pages/ask/ask", "pages/answer/answer",
]

for p in CANDIDATES:
    body = ('{"page":"%s","scene":"oracle","check_path":true,"env_version":"release","width":280}' % p).encode("utf-8")
    r = requests.post(
        f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
        data=io.BytesIO(body),
        headers={"Content-Type": "application/json"},
        impersonate="chrome", timeout=40)
    b = r.content
    if b[:1] == b"{":  # JSON = 错误
        try:
            e = r.json()
            verdict = f"err{e.get('errcode')}"
        except Exception:
            verdict = "err?"
    else:
        verdict = "PAGE_EXISTS(%dB %s)" % (len(b), "png" if b[:4] == b"\x89PNG" else "img")
    print(f"{p}: {verdict}")
