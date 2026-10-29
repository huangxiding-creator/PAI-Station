# -*- coding: utf-8 -*-
"""P6: 候选源可及性+表格完整度验证"""
import sys, io, json, re, time
sys.path.insert(0, "E:/AI-Station/逆向工程/chinca-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as cr

s = cr.Session(impersonate="chrome", timeout=25)
CANDS = [
    ("cnpp", "https://www.cnpp.cn/focus/3511268.html"),
    ("maigoo", "https://www.maigoo.com/news/724862.html"),
    ("sohu_876711130", "https://www.sohu.com/a/876711130_122019281"),
    ("sohu_822070923", "https://www.sohu.com/a/822070923_121123700"),
    ("thepaper", "https://www.thepaper.cn/newsDetail_forward_19646118"),
]
for name, u in CANDS:
    t0=time.time()
    try:
        r = s.get(u)
        body = r.text or ""
        # 表格行/营收数密度
        rows = len(re.findall(r"<tr", body, re.I))
        # 数字排名样例: 找"1 中国建筑"或序号列
        rev_hits = len(re.findall(r"\d{2,4}(\.\d+)?\s*亿美元|\$\d|USD ?\d", body))
        title = ""
        m = re.search(r"<title>(.*?)</title>", body, re.S)
        if m: title = re.sub(r"\s+", " ", m.group(1)).strip()[:80]
        print(f"[{name}] {r.status_code} size={len(body)} tr={rows} 营收词={rev_hits} {round(time.time()-t0,1)}s")
        print(f"   title: {title}")
        open(f"E:/AI-Station/逆向工程/enr-reverse/captures/p6_{name}.html", "w", encoding="utf-8", errors="replace").write(body)
    except Exception as e:
        print(f"[{name}] ERR {type(e).__name__}: {str(e)[:90]}")
    time.sleep(1)

# chinca 文章走自家复刻件
print("\n[chinca-article] 走 chinca_api 复刻件")
try:
    from chinca_api import ChincaClient
    c = ChincaClient()
    art = c.get_article("/CICA/info/24091410422111")
    print("  title:", art["title"], "| date:", art["date"], "| content_len:", art["content_len"])
    print("  head:", art["content"][:300].replace("\n", " / "))
    open("E:/AI-Station/逆向工程/enr-reverse/captures/p6_chinca_article.txt", "w", encoding="utf-8").write(art["content"])
except Exception as e:
    print("  ERR", type(e).__name__, str(e)[:120])
