# -*- coding: utf-8 -*-
"""probe3 — 纯 HTTP 全链验证（零浏览器）

理论链（据 F-1/F-2/F-6 差分）:
  warmup(ABTEST+SUID) → search(Set-Cookie SNUID + 页面内嵌 token=hex+SNUID+hex)
  → GET /link(同会话+Referer) → 200 GBK 页含签名 mp URL → GET 文章 → 全文
共 4 GET，间隔 1.5s。产出: captures/{probe3_log.json, p3_link_body.txt, p3_article.html}
"""
import html as htm, json, re, time
from pathlib import Path
from urllib.parse import quote_plus, urljoin
from curl_cffi import requests

OUT = Path(r"E:\AI-Station\逆向工程\sogou-weixin-reverse\captures")
Q = "EPC总承包"
log = {"query": Q}
s = requests.Session(impersonate="chrome")
H = {"Accept-Language": "zh-CN,zh;q=0.9"}

# 1) warmup
r0 = s.get("https://weixin.sogou.com/", headers=H, timeout=20)
log["c1_warmup"] = {"status": r0.status_code, "cookies": [c.name for c in s.cookies.jar]}
time.sleep(1.5)

# 2) search → SNUID 落地 + 结果锚点
search_url = f"https://weixin.sogou.com/weixin?type=2&query={quote_plus(Q)}"
r1 = s.get(search_url, headers={**H, "Referer": "https://weixin.sogou.com/"}, timeout=25)
jar = {c.name: c.value for c in s.cookies.jar}
log["c2_search"] = {"status": r1.status_code, "cookies": list(jar), "snuid": jar.get("SNUID", "")[:20] + "…"}
items = re.findall(r'<a[^>]*href="([^"]+)"[^>]*uigs="article_title_\d+"[^>]*>(.*?)</a>', r1.text, re.S)
links = [(htm.unescape(urljoin("https://weixin.sogou.com/", h)), re.sub(r"<[^>]+>|\s+", "", t)) for h, t in items]
log["result_count"] = len(links)
print(f"[search] {r1.status_code} SNUID={'YES' if jar.get('SNUID') else 'NO'} results={len(links)}")
assert links, "无结果"
link_url, title = links[0]
log["link_url"] = link_url
m = re.search(r"[?&]token=([0-9A-F]+)", link_url)
log["token"] = m.group(1) if m else ""
snuid = jar.get("SNUID", "")
log["token_embeds_snuid"] = (snuid in log["token"]) if (m and snuid) else False
print(f"[token] {log['token'][:60]}… embeds_SNUID={log['token_embeds_snuid']}")
time.sleep(1.5)

# 3) GET /link（同会话 + Referer=检索页）
r2 = s.get(link_url, headers={**H, "Referer": search_url}, timeout=25, allow_redirects=False)
log["c3_link"] = {"status": r2.status_code, "location": r2.headers.get("location", "")[:150],
                  "ct": r2.headers.get("content-type", ""), "len": len(r2.content)}
body_raw = r2.content
txt = body_raw.decode("gbk", "replace") if "GBK" in r2.headers.get("content-type", "").upper() or r2.status_code == 200 else ""
(OUT / "p3_link_body.txt").write_text(txt, encoding="utf-8")
print(f"[link] HTTP {r2.status_code} len={len(body_raw)} ct={log['c3_link']['ct']}")
mp_url = ""
if r2.status_code in (301, 302, 303, 307, 308):
    mp_url = r2.headers.get("location", "")
else:
    for pat in (r"url\s*[\'\"]?\s*[,=]\s*[\'\"]?(https?://mp\.weixin\.qq\.com[^\'\"<>\\]+)",
                r'window\.location\.replace\([\'"](https?://mp\.weixin\.qq\.com[^\'"]+)[\'"]\)',
                r'(https?://mp\.weixin\.qq\.com/s[^\'"<>\\ ]+)'):
        mm = re.search(pat, txt)
        if mm:
            mp_url = htm.unescape(mm.group(1))
            break
log["resolved_mp_url"] = mp_url
print(f"[resolved] {mp_url[:130]}")

if mp_url.startswith("http") and "mp.weixin.qq.com" in mp_url:
    time.sleep(1.5)
    r3 = s.get(mp_url, headers={**H, "Referer": link_url}, timeout=30)
    (OUT / "p3_article.html").write_bytes(r3.content)
    art = r3.content.decode("utf-8", "replace")
    t = re.search(r"var\s+msg_title\s*=\s*'(.*?)'", art)
    nick = re.search(r'property="og:nickname"\s+content="([^"]+)"', art)
    ct = re.search(r"var\s+createTime\s*=\s*'(.*?)'", art)
    js = re.search(r'<div[^>]*id="js_content"[^>]*>(.*?)</div>\s*<script', art, re.S)
    text_len = len(re.sub(r"<[^>]+>|\s", "", js.group(1))) if js else 0
    biz = re.search(r'__biz=(M[A-Za-z0-9=]+)', art) or re.search(r"var\s+msg_link[^;]*__biz=(M[A-Za-z0-9=]+)", art)
    mid = re.search(r"[?&]mid=(\d+)", mp_url) or re.search(r'var\s+msg_mid[^;]*?(\d{9,})', art)
    log["c4_article"] = {"status": r3.status_code, "len": len(r3.content),
                         "title": t.group(1) if t else "", "nickname": nick.group(1) if nick else "",
                         "createTime": ct.group(1) if ct else "", "text_len": text_len}
    print(f"[article] HTTP {r3.status_code} len={len(r3.content)}")
    print(f"[article] title={log['c4_article']['title'][:44]}")
    print(f"[article] account={log['c4_article']['nickname']} time={log['c4_article']['createTime']} 正文纯文本={text_len}字")
    print("[VERDICT] 纯HTTP全链贯通" if text_len > 500 else "[VERDICT] 文章页到了但正文薄/被拦，需复检")
else:
    print("[VERDICT] /link 未过闸 → 上浏览器差分(harvest_browser.py)")

(OUT / "probe3_log.json").write_text(json.dumps(log, ensure_ascii=False, indent=1, default=str), encoding="utf-8")
print("[done] captures/probe3_log.json")
