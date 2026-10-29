# -*- coding: utf-8 -*-
"""Probe5: fetch free detail page from www.cnki.com.cn for full abstract."""
import requests, re, io, sys, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
urls = [
    "https://www.cnki.com.cn/Article/CJFDTOTAL-CWJC202620004.htm",
    "https://www.cnki.com.cn/Article/CJFDTOTAL-ZGSZ202605028.htm",
]
s = requests.Session()
s.headers.update({"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9"})
for u in urls:
    r = s.get(u, timeout=20)
    html = r.text
    print(u.split("/")[-1], r.status_code, "len", len(html))
    open("E:/AI-Station/逆向工程/cnki-reverse/captures/D1_" + u.split("/")[-1] + ".html", "w", encoding="utf-8").write(html)
    # abstract block
    m = re.search(r'<div class="summary"[^>]*>(.*?)</div>', html, re.S) or \
        re.search(r'【摘要】(.*?)(?:【|</p>|</div>)', html, re.S) or \
        re.search(r'摘要[:：]?\s*(.{30,400})', html, re.S)
    if m:
        text = re.sub(r"<[^>]+>", "", m.group(1))
        text = re.sub(r"\s+", " ", text).strip()
        print("ABSTRACT:", text[:250])
    else:
        print("ABSTRACT: NOT FOUND, try other pattern")
        mm = re.search(r'CatalogSpan|ChDivSummary|abstract', html)
        print("hint:", mm.group(0) if mm else "none")
    time.sleep(1.0)
