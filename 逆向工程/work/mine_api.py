# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
B = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js"
b = open(B, encoding="utf-8", errors="replace").read()
# find fetch/request URL construction near keywords
for kw in ['vip', 'point', 'pay', 'plan', 'package', 'credit', 'accounts/settings', 'order']:
    for m in re.finditer(kw, b):
        seg = b[max(0,m.start()-150):m.end()+150]
        if ('/v' in seg or 'url' in seg.lower() or 'path' in seg.lower() or 'GET' in seg or 'POST' in seg) and ('shiflow' in seg or '/v' in seg):
            print(f"[{kw}] {seg}\n---")
            break
