# -*- coding: utf-8 -*-
"""解析搜狗公号搜索结果页 → 公号名/微信号/简介"""
import re
import sys

t = sys.stdin.buffer.read().decode("utf-8", errors="replace")
cards = re.split(r'<div[^>]+class="gzh-box', t)[1:]
if not cards:
    # 兜底: 找所有锚文本
    for a in re.findall(r"<a[^>]*>([^<]{2,30})</a>", t):
        a = a.strip()
        if a and ("工程" in a or "石化" in a):
            print("锚文本:", a)
    sys.exit(0)
for c in cards:
    name = re.search(r'uigs="account_name_\d+"[^>]*>\s*([^<]+)</a>', c) \
        or re.search(r"<a[^>]*>([^<]{2,40})</a>", c)
    wxh = re.search(r"微信号[:：]?\s*</(?:span|label|em)>\s*([A-Za-z0-9_-]+)",
                    c) or re.search(r"微信号[:：]\s*([A-Za-z0-9_-]+)", c)
    desc = re.search(r"<dd[^>]*>(.*?)</dd>", c, re.S)
    d = re.sub(r"<[^>]+>", "", desc.group(1)).strip() if desc else ""
    print("公号:", (name.group(1).strip() if name else "?"),
          "| 微信号:", (wxh.group(1) if wxh else "?"),
          "| 简介:", d[:60])
