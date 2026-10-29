# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
B = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js"
s = open(B, encoding="utf-8", errors="replace").read()
for fn in ["getShiflowV1Url", "getShiflowV2Url", "getApiUrl"]:
    for m in re.finditer(re.escape(fn) + r"\s*[=(]", s):
        seg = s[m.start():m.start()+420]
        print(f"== {fn} ==\n{seg}\n")
        break
