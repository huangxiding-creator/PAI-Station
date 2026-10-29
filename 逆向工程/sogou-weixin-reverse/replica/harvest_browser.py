# -*- coding: utf-8 -*-
"""harvest_browser — 挂 9371 专用实例收割过闸要素

1. 检索页 → Cookie 全集（weixin.sogou.com 域）
2. pkt listener 抓 /link 响应体原文（GBK HTML + JS 重定向计算）
3. 文章页 HTML 全文
产出: captures/{browser_cookies.json, link_body_raw.bin, link_body.txt, browser_article.html, harvest_log.json}
"""
import json, time
from pathlib import Path
from DrissionPage import ChromiumPage

OUT = Path(r"E:\AI-Station\逆向工程\sogou-weixin-reverse\captures")
log = {}
SEARCH = "https://weixin.sogou.com/weixin?type=2&query=EPC%E6%80%BB%E6%89%BF%E5%8C%85"

page = ChromiumPage(addr_or_opts="127.0.0.1:9371")

# 1) 检索页 + Cookie 全集
page.listen.start("weixin.sogou.com/link")
page.get(SEARCH)
time.sleep(3)
cks = page.cookies(all_domains=True, as_dict=False)
sogou_cks = [{"name": c.get("name"), "value": c.get("value"), "domain": c.get("domain"),
              "path": c.get("path"), "expires": c.get("expires")} for c in cks
             if "sogou" in (c.get("domain") or "")]
log["cookies_sogou"] = [(c["name"], (c["value"] or "")[:12] + "…") for c in sogou_cks]
(OUT / "browser_cookies.json").write_text(json.dumps(sogou_cks, ensure_ascii=False, indent=1), encoding="utf-8")
print("[cookies]", len(sogou_cks), "条 sogou 域:")
for n, v in log["cookies_sogou"]:
    print("   ", n, "=", v)

# 2) 第一条文章 /link 链接 → goto（listener 收 /link 响应体）
a = page.ele('xpath://a[contains(@uigs,"article_title_0")]')
href = a.attr("href")
from urllib.parse import urljoin
link_url = urljoin("https://weixin.sogou.com/", href)
log["link_url"] = link_url
print("[link]", link_url[:110])

page.get(link_url)
link_body = None
for pkt in page.listen.steps(timeout=15, count=1):
    if pkt.url.startswith("https://weixin.sogou.com/link"):
        link_body = pkt.body
        print("[pkt]", pkt.url[:80], "status=", pkt.target.status if hasattr(pkt, "target") else "?")
        break
if link_body is not None:
    raw = link_body if isinstance(link_body, (bytes, bytearray)) else str(link_body).encode("utf-8", "replace")
    (OUT / "link_body_raw.bin").write_bytes(raw)
    try:
        txt = raw.decode("gbk", "replace")
    except Exception:
        txt = raw.decode("utf-8", "replace")
    (OUT / "link_body.txt").write_text(txt, encoding="utf-8")
    print("[link-body]", len(raw), "bytes; 头400字符:")
    print(txt[:400])
else:
    print("[link-body] 未捕到（可能直接跳转无停留）")

# 3) 等跳转落地 → 文章页 HTML
time.sleep(4)
log["final_url"] = page.url
print("[final]", page.url[:130])
html = page.html
(OUT / "browser_article.html").write_text(html, encoding="utf-8")
import re
t = re.search(r"var\s+msg_title\s*=\s*'(.*?)'", html)
nick = re.search(r'property="og:nickname"\s+content="([^"]+)"', html) or re.search(r"var\s+nickname\s*=\s*htmlDecode\('(.*?)'\)", html)
ct = re.search(r"var\s+createTime\s*=\s*'(.*?)'", html)
js = re.search(r'<div[^>]*id="js_content"[^>]*>(.*?)</div>\s*<script', html, re.S)
text_len = len(re.sub(r"<[^>]+>|\s", "", js.group(1))) if js else 0
biz = re.search(r"var\s+__biz\s*=\s*'(.*?)'", html) or re.search(r'__biz=(M[A-Za-z0-9=]+)', page.url)
log["article"] = {"title": t.group(1) if t else "", "nickname": nick.group(1) if nick else "",
                  "createTime": ct.group(1) if ct else "", "text_len": text_len,
                  "url": page.url[:200]}
print(f"[article] title={log['article']['title'][:40]} account={log['article']['nickname']} time={log['article']['createTime']} text_len={text_len}")

page.listen.stop()
(OUT / "harvest_log.json").write_text(json.dumps(log, ensure_ascii=False, indent=1), encoding="utf-8")
print("[done] harvest_log.json")
