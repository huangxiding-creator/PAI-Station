# -*- coding: utf-8 -*-
"""visa_draft_enrich v3 — 稿箱三更新: ①标题+(26.6万字) ②QR→海报 ③详细目录 (全箱深搜)."""
import json
import re
import sys
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ACC = json.load(open(r"F:\We-AIPO\data\wechat_accounts.json", encoding="utf-8"))
SCHED = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\visa\sched")
POSTER = Path(r"E:\AI-Station\report_platform\promo\posters\VISA-2026.png")
TITLES = ["工程签证与变更索赔", "签了算不算数", "停窝工损失怎么算"]
WC = "26.6万字"


def build_toc() -> str:
    items = []
    for nn in [f"{i:02d}" for i in range(1, 13)]:
        t = (SCHED / f"_ch{nn}_final.md").read_text(encoding="utf-8", errors="replace")
        ch_m = re.search(r"^# 第\d+章\s*(.+)$", t, flags=re.M)
        secs = re.findall(r"^## \d+\.(\d+)\s+(.+)$", t, flags=re.M)
        items.append((int(nn), ch_m.group(1).strip() if ch_m else "", secs[:8]))
    h = ['<section style="margin:24px 0;padding:18px 20px;background:#F7F9FB;'
         'border-left:4px solid #1F3A5F;border-radius:0 8px 8px 0;">',
         '<p style="font-size:16px;font-weight:bold;color:#1F3A5F;'
         'margin:0 0 12px;">📖 本书详细目录</p>']
    for no, ct, secs in items:
        h.append(f'<p style="font-size:14px;font-weight:bold;color:#1F3A5F;'
                 f'margin:12px 0 4px;">第{no}章 {ct}</p>')
        for m, st in secs:
            h.append(f'<p style="font-size:12.5px;color:#555;margin:2px 0;'
                     f'padding-left:14px;">{no}.{m} {st}</p>')
    h.append("</section>")
    return "".join(h)


def get_token(appid, secret):
    u = (f"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential"
         f"&appid={appid}&secret={secret}")
    with urllib.request.urlopen(u, timeout=20) as r:
        return json.loads(r.read().decode()).get("access_token", "")


def api(token, path, payload=None):
    req = urllib.request.Request(
        f"https://api.weixin.qq.com/cgi-bin/{path}?access_token={token}",
        data=json.dumps(payload, ensure_ascii=False).encode("utf-8") if payload else b"",
        headers={"Content-Type": "application/json"}, method="POST")
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


def uploadimg(token):
    b = "----PAIStationForm7d4a"
    body = (f"--{b}\r\n"
            f'Content-Disposition: form-data; name="media"; filename="poster.png"\r\n'
            f"Content-Type: image/png\r\n\r\n").encode() + POSTER.read_bytes() + \
        f"\r\n--{b}--\r\n".encode()
    req = urllib.request.Request(
        f"https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token={token}",
        data=body, headers={"Content-Type": f"multipart/form-data; boundary={b}"},
        method="POST")
    with urllib.request.urlopen(req, timeout=120) as r:
        return json.loads(r.read().decode("utf-8", "replace")).get("url", "")


def main() -> int:
    toc = build_toc()
    for a in ACC:
        if not a.get("enabled"):
            continue
        name = a["name"]
        tok = get_token(a["appid"], a["appsecret"])
        if not tok:
            print(f"[{name}] token失败")
            continue
        # 全箱深搜 (轻量)
        found = []
        offset = 0
        total = 1
        while offset < total:
            idx = api(tok, "draft/batchget",
                      {"offset": offset, "count": 20, "no_content": 1})
            total = int(idx.get("total_count", 0))
            for it in idx.get("item", []):
                for k, art in enumerate(it.get("content", {}).get("news_item", [])):
                    if any(t in art.get("title", "") for t in TITLES):
                        found.append((it["media_id"], k, art["title"]))
            offset += 20
        if not found:
            print(f"[{name}] 全箱{total}件未命中")
            continue
        purl = ""
        for mid, k, title in found:
            full = api(tok, "draft/get", {"media_id": mid})
            arts = full.get("news_item", [])
            if not arts or k >= len(arts):
                continue
            art = arts[k]
            html = art.get("content", "")
            swaps = 0
            if "qpic.cn" in html and not purl:
                purl = uploadimg(tok)
            if purl:
                for q in re.findall(r'src="(https?://[^"]*qpic\.cn[^"]*)"', html):
                    html = html.replace(q, purl)
                    swaps += 1
                html = html.replace("长按识别 · 总包智库报告平台（试读免费）",
                                    "长按识别海报中小程序码 · 免费试读")
            if "本书详细目录" not in html:
                anchor = html.rfind("<p")
                html = (html[:anchor] + toc + html[anchor:]) if anchor > 0 else html + toc
            new_title = title if WC in title else f"{title}（{WC}）"
            payload = {
                "media_id": mid, "index": k,
                "articles": {
                    "title": new_title,
                    "author": art.get("author", ""),
                    "digest": art.get("digest", ""),
                    "content": html,
                    "content_source_url": art.get("content_source_url", ""),
                    "thumb_media_id": art.get("thumb_media_id", ""),
                    "need_open_comment": art.get("need_open_comment", 1),
                    "only_fans_can_comment": art.get("only_fans_can_comment", 0),
                },
            }
            r = api(tok, "draft/update", payload)
            ec = r.get("errcode", -1)
            print(f"[{name}] 《{new_title[:30]}》 换图{swaps}+目录+字数: "
                  f"{'✓' if ec == 0 else r}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
