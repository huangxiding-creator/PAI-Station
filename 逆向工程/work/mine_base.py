# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
B = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js"
s = open(B, encoding="utf-8", errors="replace").read()
i = s.find("function apiRequest")
if i < 0: i = s.find("apiRequest=")
print(s[max(0,i-100):i+900] if i>=0 else "apiRequest def not found; search async")
if i < 0:
    for m in re.finditer(r'apiRequest', s):
        print(s[max(0,m.start()-200):m.start()+300]); print('---'); break
