# -*- coding: utf-8 -*-
"""overseas_web_sweep — web国别矩阵腿 (1023 重建版, 原tmp_zsearch件被清).
搜狗+360 双引擎 → 抓正文 → data/rss_harvest/articles/overseas_sweep/"""
import html as H
import random
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote_plus
from curl_cffi import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = Path(r"E:\AI-Station\data\rss_harvest\articles\overseas_sweep")
OUT.mkdir(parents=True, exist_ok=True)
HDR = {"Accept-Language": "zh-CN,zh;q=0.9"}
COUNTRIES = ["印尼", "越南", "沙特", "阿联酋", "巴基斯坦", "哈萨克斯坦",
             "土耳其", "孟加拉", "肯尼亚", "巴西", "菲律宾", "中亚五国"]
PATTERNS = ["中资电力EPC {c} 项目 中标 市场准入",
            "中国电建 {c} 电站 总承包 一带一路 项目",
            "{c} 电力工程 国际招标 中国企业 FIDIC 合同"]

def sogou(q):
    try:
        r = requests.get("https://www.sogou.com/web?query=" + quote_plus(q),
                         impersonate="chrome", timeout=25,
                         headers={**HDR, "Referer": "https://www.sogou.com/"})
    except Exception:
        return []
    if "验证码" in r.text or "antispider" in r.url:
        return []
    out = []
    for m in re.finditer(r'<h3[^>]*>\s*<a[^>]+href="(/link\?url=[^"]+|https?://[^"]+)"[^>]*>(.*?)</a>', r.text, re.S):
        t = re.sub(r"<[^>]+>", "", m.group(2)).strip()
        u2 = m.group(1)
        if u2.startswith("/link"):
            u2 = "https://www.sogou.com" + u2
        if t:
            out.append((t, H.unescape(u2)))
    return out

def so(q):
    try:
        r = requests.get("https://www.so.com/s?q=" + quote_plus(q),
                         impersonate="chrome", headers=HDR, timeout=25)
    except Exception:
        return []
    if "验证码" in r.text:
        return []
    return [(re.sub(r"<[^>]+>", "", m.group(2)).strip(), m.group(1))
            for m in re.finditer(r'<a[^>]+data-mdurl="([^"]+)"[^>]*>(.*?)</a>', r.text, re.S)
            if re.sub(r"<[^>]+>", "", m.group(2)).strip()]

def grab(url):
    try:
        r = requests.get(url, impersonate="chrome", headers=HDR, timeout=30)
    except Exception:
        return None
    if r.status_code != 200 or len(r.text) < 1500:
        return None
    txt = re.sub(r"<script.*?</script>", "", r.text, flags=re.S)
    txt = re.sub(r"<style.*?</style>", "", txt, flags=re.S)
    txt = re.sub(r"<[^>]+>", " ", txt)
    return H.unescape(re.sub(r"\s+", " ", txt))

n_ok = 0
for ci, c in enumerate(COUNTRIES):
    for pi, pat in enumerate(PATTERNS):
        q = pat.format(c=c)
        hits = []
        for eng in (sogou, so):
            hits += eng(q)
            time.sleep(random.uniform(4, 7))
            if len(hits) >= 4:
                break
        taken = 0
        for title, url in hits:
            if taken >= 2:
                break
            body = grab(url)
            time.sleep(random.uniform(2, 4))
            if not body or len(body) < 1200:
                continue
            fn = OUT / f"ovs_{ci:02d}{pi}_{n_ok:03d}.md"
            fn.write_text(f"# {title}\n\n> 查询: {q}\n> 来源: {url}\n\n{body[:30000]}\n", encoding="utf-8")
            n_ok += 1
            taken += 1
        print(f"[{ci+1}/{len(COUNTRIES)}] {c} 型{pi}: 命中{len(hits)} 抓{taken} 累计{n_ok}", flush=True)
print(f"== 完成: {n_ok} 件")
