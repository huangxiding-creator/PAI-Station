# -*- coding: utf-8 -*-
"""probe2 — /link?url= 跳转链解析 + mp 文章页抓取（共 2 GET，间隔 1.5s）

产出：captures/{link_resp.html, resolved_url.txt, article.html, probe2_log.json}
"""
import json, re, time
from pathlib import Path
from curl_cffi import requests

OUT = Path(r"E:\AI-Station\逆向工程\sogou-weixin-reverse\captures")
H = {"Accept-Language": "zh-CN,zh;q=0.9"}
log = {}
link_url = (OUT / "link1.txt").read_text(encoding="utf-8").strip()
search_url = "https://weixin.sogou.com/weixin?type=2&query=EPC%E6%80%BB%E6%89%BF%E5%8C%85"

s = requests.Session(impersonate="chrome")
# 与浏览器同构：warmup + search 先行（同一会话 cookie 链），但节流只做 2 个关键 GET
s.get("https://weixin.sogou.com/", headers=H, timeout=20)
time.sleep(1.2)

# 1) GET /link?url=... （不自动跟跳，看真实返回形态）
r = s.get(link_url, headers={**H, "Referer": search_url}, timeout=25, allow_redirects=False)
log["link"] = {
    "status": r.status_code,
    "location": r.headers.get("location", ""),
    "content_type": r.headers.get("content-type", ""),
    "len": len(r.content),
}
body = r.content.decode("utf-8", "replace")
(OUT / "link_resp.html").write_bytes(r.content)
print(f"[link] HTTP {r.status_code} len={len(r.content)} location={log['link']['location'][:80]}")

mp_url = r.headers.get("location", "")
if not mp_url:
    # 200 形态：页内 JS window.location.replace("...") 或 url var
    m = re.search(r'url\s*[\'"]?\s*[,=]\s*[\'"]?(https?://mp\.weixin\.qq\.com[^\'"]+)', body)
    if not m:
        m = re.search(r'(https?://mp\.weixin\.qq\.com/s[^\'"\\<>\s]+)', body)
    mp_url = m.group(1) if m else ""
log["resolved_mp_url"] = mp_url
print(f"[resolved] {mp_url[:120]}")

if mp_url:
    (OUT / "resolved_url.txt").write_text(mp_url, encoding="utf-8")
    time.sleep(1.5)
    r2 = s.get(mp_url, headers={**H, "Referer": link_url}, timeout=30)
    log["article"] = {
        "status": r2.status_code,
        "final_url": str(r2.url),
        "len": len(r2.content),
        "content_type": r2.headers.get("content-type", ""),
    }
    (OUT / "article.html").write_bytes(r2.content)
    art = r2.content.decode("utf-8", "replace")
    t = re.search(r"var\s+msg_title\s*=\s*'(.*?)'", art) or re.search(r'<meta property="og:title" content="([^"]+)"', art)
    nick = re.search(r"var\s+nickname\s*=\s*'(.*?)'", art) or re.search(r'<meta property="og:nickname" content="([^"]+)"', art)
    ct = re.search(r"var\s+createTime\s*=\s*'(.*?)'", art) or re.search(r'var\s+createTime\s*=\s*"([^"]+)"', art)
    js = re.search(r'<div[^>]*id="js_content"[^>]*>(.*?)</div>\s*<script', art, re.S)
    text_len = len(re.sub(r"<[^>]+>|\s", "", js.group(1))) if js else 0
    log["article_fields"] = {
        "msg_title": t.group(1) if t else "",
        "nickname": nick.group(1) if nick else "",
        "createTime": ct.group(1) if ct else "",
        "js_content_text_len": text_len,
    }
    print(f"[article] HTTP {r2.status_code} len={len(r2.content)}")
    print(f"[article] title={log['article_fields']['msg_title'][:40]}")
    print(f"[article] account={log['article_fields']['nickname']} time={log['article_fields']['createTime']} text_len={text_len}")
else:
    print("[resolved] 未从 link 页解析出 mp URL → 需浏览器实弹（antispider JS 形态）")

(OUT / "probe2_log.json").write_text(json.dumps(log, ensure_ascii=False, indent=1, default=str), encoding="utf-8")
print("[done] captures/probe2_log.json")
