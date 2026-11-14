# -*- coding: utf-8 -*-
"""visa_poster_swap — 稿箱文末二维码→VISA海报 自动换图 (1114用户令).
流程: 找3篇VISA稿(draft/batchget含content) → uploadimg传海报 → 替换QR img → draft/update回写.
"""
import json
import re
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ACC = json.load(open(r"F:\We-AIPO\data\wechat_accounts.json", encoding="utf-8"))
POSTER = Path(r"E:\AI-Station\report_platform\promo\posters\VISA-2026.png")
TITLES = ["发布| 《工程签证与变更索赔实战研究报告》",
          "签了算不算数", "停窝工损失怎么算"]


def call_post(token, api, payload=None, raw=None, ctype="application/json"):
    data = raw if raw is not None else json.dumps(payload).encode()
    req = urllib.request.Request(
        f"https://api.weixin.qq.com/cgi-bin/{api}?access_token={token}",
        data=data, headers={"Content-Type": ctype}, method="POST")
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


def get_token(appid, secret):
    u = (f"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential"
         f"&appid={appid}&secret={secret}")
    with urllib.request.urlopen(u, timeout=20) as r:
        return json.loads(r.read().decode()).get("access_token", "")


def uploadimg(token):
    """海报→正文图片URL (uploadimg, 永久有效)."""
    boundary = "----PAIStationForm7d4a"
    body = (f"--{boundary}\r\n"
            f'Content-Disposition: form-data; name="media"; '
            f'filename="poster.png"\r\n'
            f"Content-Type: image/png\r\n\r\n").encode() + POSTER.read_bytes() + \
        f"\r\n--{boundary}--\r\n".encode()
    req = urllib.request.Request(
        f"https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token={token}",
        data=body,
        headers={"Content-Type": f"multipart/form-data; boundary={boundary}"},
        method="POST")
    with urllib.request.urlopen(req, timeout=120) as r:
        d = json.loads(r.read().decode("utf-8", "replace"))
    return d.get("url", "")


def main() -> int:
    for a in ACC:
        if not a.get("enabled"):
            continue
        name = a["name"]
        tok = get_token(a["appid"], a["appsecret"])
        if not tok:
            print(f"[{name}] token失败")
            continue
        # 找VISA稿 (含content)
        items, offset = [], 0
        while True:
            req = urllib.request.Request(
                f"https://api.weixin.qq.com/cgi-bin/draft/batchget?access_token={tok}",
                data=json.dumps({"offset": offset, "count": 5,
                                 "no_content": 0}).encode(),
                headers={"Content-Type": "application/json"}, method="POST")
            d = json.loads(urllib.request.urlopen(req, timeout=30).read().decode())
            batch = d.get("item", [])
            items += batch
            offset += len(batch)
            if not batch or offset >= 30:
                break
        target = None
        for it in items:
            arts = it.get("content", {}).get("news_item", [])
            if not arts:
                continue
            t = arts[0].get("title", "")
            if any(k in t for k in TITLES):
                target = it
                break
        if not target:
            print(f"[{name}] 未找到VISA稿")
            continue
        art = target["content"]["news_item"][0]
        title = art["title"]
        html = art["content"]
        # 找QR img (推送器注入的qpic.cn图, 含长按识别说明)
        qr_imgs = re.findall(r'<img[^>]+src="(https?://[^"]*qpic\.cn[^"]*)"[^>]*>', html)
        # 或末尾任意img
        if not qr_imgs:
            qr_imgs = re.findall(r'<img[^>]+src="(https?://[^"]+)"[^>]*>', html)
        if not qr_imgs:
            print(f"[{name}] 《{title[:20]}》无img可换")
            continue
        qr_url = qr_imgs[-1]  # 末尾那张=归因QR
        purl = uploadimg(tok)
        if not purl:
            print(f"[{name}] 海报上传失败")
            continue
        new_html = html.replace(qr_url, purl)
        # 替换说明行
        new_html = new_html.replace("长按识别 · 总包智库报告平台（试读免费）",
                                    "长按识别海报中小程序码 · 免费试读")
        payload = {
            "media_id": target["media_id"],
            "index": 0,
            "articles": [{
                "title": title,
                "author": art.get("author", ""),
                "digest": art.get("digest", ""),
                "content": new_html,
                "thumb_media_id": art.get("thumb_media_id", ""),
                "need_open_comment": art.get("need_open_comment", 1),
                "only_fans_can_comment": art.get("only_fans_can_comment", 0),
            }],
        }
        r = call_post(tok, "draft/update", payload)
        print(f"[{name}] 《{title[:24]}》QR→海报: {'✓' if r.get('errcode') == 0 else r}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
