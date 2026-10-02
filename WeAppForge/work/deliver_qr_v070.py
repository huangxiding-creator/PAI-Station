# -*- coding: utf-8 -*-
"""0.7.0 开发版验收码：env_version=develop 直开最新上传（robot7 的 0.7.0），
投递到微信桥出站发件箱（文字+图片）。查重：先列出 spool 现存未发项。"""
import datetime
import io
import json
from pathlib import Path

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
        "page": "pages/ask/ask", "scene": "v070",
        "check_path": False, "env_version": "develop", "width": 430,
    }).encode("utf-8")),
    headers={"Content-Type": "application/json"},
    impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
if not kind:
    raise SystemExit("QR_FAIL: " + repr(b[:200]))
out = f"E:/AI-Station/WeAppForge/work/qr_dev_070.{kind}"
io.open(out, "wb").write(b)
print("QR_OK", out, len(b), kind)

# 查重：spool 里现存未发项
SPOOL = Path.home() / ".wechat-claude-code" / "outbound-spool"
SPOOL.mkdir(parents=True, exist_ok=True)
pending = sorted(p.name for p in SPOOL.glob("*.json"))
print("SPOOL_PENDING:", pending if pending else "(空，桥已清)")

item = SPOOL / ("mp-qr-v070-" + datetime.datetime.now().strftime("%H%M%S") + ".json")
item.write_text(json.dumps({
    "text": ("【总包AI顾问 0.7.0 验收码】这张码打开的是刚上传的 0.7.0 开发版（您是项目"
             "成员，扫码直接开）。本轮升级：页面全面精修+深色模式、回答打字机式逐字显示、"
             "付费墙全拆（公益免费）、共享入锅圈得1次咨询、锅圈预览200字、依据点开看法条"
             "全文、海报精修+提示扫码免费看全文。若扫码打不开：小程序后台「版本管理→开发"
             "版本」里把 0.7.0（robot7 上传）设为体验版即可。正式发布前有一件事需要您拍板，"
             "我这边马上问您。"),
    "file": out,
    "created_at": datetime.datetime.now().isoformat(timespec="seconds"),
}, ensure_ascii=False, indent=2), encoding="utf-8")
print("SPOOLED", item)
