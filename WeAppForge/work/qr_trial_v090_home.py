# -*- coding: utf-8 -*-
"""qr_trial_v090_home.py — v0.9.0 复发诊断码：永不404配方(home/home 双表命中)。
判定矩阵：
  进新版(蓝导航,有研究tab) → 钉位/包都好,根因=提审锁定回落(已撤审即愈)
  进老版(红导航,老标讯)    → 体验通道回落 release=1.0.7(钉位未生效/锁定)
  仍「页面不存在」          → home 都缺=更深包级问题(模拟器复现)
"""
import io
import sys

import requests  # 微信 API 一律原生 requests（1007 教训：curl_cffi 被 TLS 掐）

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SCENE = "v090t"

sec = dict(l.strip().split("=", 1) for l in io.open(
    "E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
at = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                  params={"grant_type": "client_credential",
                          "appid": sec["appid"], "secret": sec["appsecret"]},
                  timeout=30).json()["access_token"]

payload = ('{"page":"pages/home/home","scene":"%s","check_path":false,'
           '"env_version":"trial","width":430}' % SCENE).encode("utf-8")
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=payload, headers={"Content-Type": "application/json"}, timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if kind:
    out = f"E:/AI-Station/WeAppForge/work/qr_trial_{SCENE}_home.{kind}"
    io.open(out, "wb").write(b)
    print("QR_OK", out, len(b), kind)
else:
    print("QR_FAIL:", b[:200])
