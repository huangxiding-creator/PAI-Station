# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
J = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\renderer\assets\target-window-selection-ipc-BNoPqbgj.js"
s = open(J, encoding="utf-8", errors="replace").read()
i = s.find('¥199')
print("== ¥199 键名上下文 ==")
print(s[max(0,i-450):i+450])
print("\n== vip/point 请求路径 ==")
for m in re.finditer(r'.{120}(vip|point)["\']?\s*[:,].{160}', s):
    t = m.group(0)
    if '/v1/' in t or 'http' in t or 'credit' in t: print(t, "\n---")
B = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js"
b = open(B, encoding="utf-8", errors="replace").read()
print("== biz api paths ==")
print(sorted(set(re.findall(r'["\x27](/v[12]/[a-zA-Z0-9/_-]+)["\x27]', b)))[:40])
print("== biz domains ==")
print(sorted(set(re.findall(r'https?://[a-zA-Z0-9.-]+', b)))[:20])
