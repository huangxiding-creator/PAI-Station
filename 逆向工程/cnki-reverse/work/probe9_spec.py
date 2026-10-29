# -*- coding: utf-8 -*-
"""Spec probe: Title field search, Order variants, deep page."""
import sys, io
sys.path.insert(0, "E:/AI-Station/逆向工程/cnki-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
from cnki_api import CnkiApi, BASE
import requests, re
from urllib.parse import quote

api = CnkiApi(verbose=False)
api.warmup("EPC")

def raw_post(data):
    api._tick()
    return api.s.post(BASE + "/search/listresult", data=data,
        headers={"Referer": BASE + "/Search/Result?content=EPC", "Origin": BASE,
                 "X-Requested-With": "XMLHttpRequest"}, timeout=25)

# 1) Title field search
r = raw_post({"Title": "国际工程 EPC", "Order": 2, "Page": 1})
tot = re.search(r'html\("(\d+)"\)', r.text)
n_items = r.text.count('<div class="list-item">')
print("Title-field:", r.status_code, "items:", n_items, "total:", tot.group(1) if tot else "?")

# 2) Order variants
for o in (1, 3):
    r = raw_post({"Content": "国际工程 EPC", "Order": o, "Page": 1})
    t1 = re.search(r'title="([^"]{5,60})"', r.text)
    print(f"Order={o}:", r.status_code, "items:", r.text.count('<div class="list-item">'),
          "| first:", t1.group(1) if t1 else "?")

# 3) deep page
r = raw_post({"Content": "国际工程 EPC", "Order": 2, "Page": 10})
print("Page=10:", r.status_code, "items:", r.text.count('<div class="list-item">'))

# 4) Author field
r = raw_post({"Author": "杨丽元", "Order": 2, "Page": 1})
print("Author-field:", r.status_code, "items:", r.text.count('<div class="list-item">'))
