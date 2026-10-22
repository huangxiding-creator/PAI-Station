# -*- coding: utf-8 -*-
"""T19 破壁试验D：httpx 首页→抽真实文档链接（离线解析；1 请求）。"""
import json
import re

import httpx

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

facts = {}
with httpx.Client(timeout=30.0, headers={"User-Agent": UA,
                                         "Referer": "https://max.book118.com/"}) as c:
    r = c.get("https://max.book118.com/")
    facts["status"] = r.status_code
    facts["len"] = len(r.text)
    html = r.text
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_home.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    # 全部链接形态统计（含文档链接）
    links = re.findall(r'href="([^"]+)"', html)
    facts["link_count"] = len(links)
    doc_like = sorted({l for l in links if re.search(r"/html/\d{4}/\d{4}/\d+\.shtml?", l)})
    facts["html_shtm_links"] = doc_like[:20]
    other = sorted({l for l in links if re.search(r"\d{12,}", l) and l not in doc_like})[:15]
    facts["other_numeric_links"] = other

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step9.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1)[:2000])
