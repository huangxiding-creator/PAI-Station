# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
B = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js"
s = open(B, encoding="utf-8", errors="replace").read()
for pat in [r'getHttpUrl\([^)]*\)\s*\{', r'getHttpUrl\(t,e\)\s*\{']:
    for m in re.finditer(pat, s):
        print(s[m.start():m.start()+500]); print("---"); break
# also how apiRequest callers pass apiScope for pay settings
for m in re.finditer(r'pay/settings', s):
    print("CTX:", s[max(0,m.start()-320):m.end()+120]); print("===")
