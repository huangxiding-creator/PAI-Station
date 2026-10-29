# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
B = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js"
s = open(B, encoding="utf-8", errors="replace").read()
for kw in ["getHttpUrl(t", "getHttpUrl(e", "production", "apiBase", "defaultEnv"]:
    idx = 0
    cnt = 0
    for m in re.finditer(re.escape(kw), s):
        seg = s[max(0,m.start()-120):m.end()+380]
        if ("http" in seg and ("shiflow" in seg or "115" in seg)):
            print(f"[{kw}]\n{seg}\n---")
            cnt += 1
            if cnt >= 2: break
