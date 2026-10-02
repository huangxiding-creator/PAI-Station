# -*- coding: utf-8 -*-
"""诊断: attach 9333 → 开登录页 → 抓真实 DOM (找 #email 失配根因)"""
import sys, time
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
import manus_lib as lib

page = lib.make_page()
lib.ensure_network(page)
print("browser ok, current url:", page.url)
page.set.cookies.clear()
page.get("https://manus.im/login?type=signIn")
for t in (3, 6, 10, 15):
    time.sleep(t if t == 3 else t - (t-3 if t==6 else (3+6 if t==10 else 3+6+10-15+15-15)) )
print("--- after ~34s ---")
print("url:", page.url)
print("title:", page.title)
email = page.ele("#email", timeout=2)
print("#email found:", bool(email))
pw = page.ele("css:input[type='password']", timeout=2)
print("password input:", bool(pw))
html = page.html or ""
print("html len:", len(html))
# 找所有 input
import re
inputs = re.findall(r'<input[^>]{0,200}>', html)
print("inputs:", len(inputs))
for i in inputs[:8]:
    print("  INPUT:", i[:160])
# body 文本前 300 字
txt = page.ele("tag:body").text if page.ele("tag:body", timeout=2) else ""
print("body text[:300]:", txt[:300].replace("\n", " | "))
