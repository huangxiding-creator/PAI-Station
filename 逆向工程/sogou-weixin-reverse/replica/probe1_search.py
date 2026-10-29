# -*- coding: utf-8 -*-
"""probe1 — 搜狗微信检索面纯HTTP探测（无浏览器基线）

节流纪律：共 2 个 GET（首页预热 + 单发检索），间隔 1.5s。
产出：captures/{warmup_home.html, search_page.html, probe1_log.json, link1.txt}
"""
import sys, json, re, time
from pathlib import Path
from urllib.parse import quote_plus, urljoin
from curl_cffi import requests

OUT = Path(r"E:\AI-Station\逆向工程\sogou-weixin-reverse\captures")
OUT.mkdir(parents=True, exist_ok=True)
H = {"Accept-Language": "zh-CN,zh;q=0.9", "Referer": "https://weixin.sogou.com/"}
Q = sys.argv[1] if len(sys.argv) > 1 else "EPC总承包"
log = {"query": Q}

s = requests.Session(impersonate="chrome")

# 1) 首页预热：观察 Set-Cookie（SUID/SUV/ABTEST 家族）
r0 = s.get("https://weixin.sogou.com/", headers=H, timeout=20)
log["warmup"] = {
    "status": r0.status_code,
    "final_url": str(r0.url),
    "set_cookie": r0.headers.get("set-cookie", ""),
    "len": len(r0.text),
}
jar = {c.name: c.value for c in s.cookies.jar}
print(f"[warmup] HTTP {r0.status_code} len={len(r0.text)} cookies={list(jar)}")
(OUT / "warmup_home.html").write_bytes(r0.content)

time.sleep(1.5)

# 2) 检索面 type=2（公众号文章）
url = f"https://weixin.sogou.com/weixin?type=2&query={quote_plus(Q)}"
r1 = s.get(url, headers=H, timeout=25)
jar2 = {c.name: c.value for c in s.cookies.jar}
log["search"] = {
    "status": r1.status_code,
    "final_url": str(r1.url),
    "set_cookie": r1.headers.get("set-cookie", ""),
    "len": len(r1.text),
    "cookies_after": list(jar2),
}
(OUT / "search_page.html").write_bytes(r1.content)
blocked = ("antispider" in str(r1.url)) or ("antispider" in r1.text[:3000]) or ("seccodeImage" in r1.text)
log["search"]["antispider"] = blocked
print(f"[search] HTTP {r1.status_code} len={len(r1.text)} antispider={blocked}")
print(f"[search] final_url={str(r1.url)[:100]}")

# 3) 结果锚点解析（zh-search-pro 实锤的 uigs 属性序）
items = re.findall(r'<a[^>]*href="([^"]+)"[^>]*uigs="article_title_\d+"[^>]*>(.*?)</a>', r1.text, re.S)
links = []
for h, t in items:
    title = re.sub(r"<[^>]+>|\s+", "", t)
    links.append((urljoin("https://weixin.sogou.com/", h), title))
log["result_count"] = len(links)
print(f"[results] {len(links)} 条")
for i, (u, t) in enumerate(links[:3]):
    print(f"  [{i}] {t[:36]} -> {u[:96]}")

if links:
    (OUT / "link1.txt").write_text(links[0][0], encoding="utf-8")
    (OUT / "titles.json").write_text(
        json.dumps([{"url": u, "title": t} for u, t in links], ensure_ascii=False, indent=1),
        encoding="utf-8")
    print("[saved] captures/link1.txt + titles.json")

(OUT / "probe1_log.json").write_text(json.dumps(log, ensure_ascii=False, indent=1, default=str), encoding="utf-8")
print("[done] captures/probe1_log.json")
