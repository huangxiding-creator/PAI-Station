# -*- coding: utf-8 -*-
import io, sys, re, os
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
BASE = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources"
targets = []
for root, dirs, fs in os.walk(BASE):
    for fn in fs:
        if fn.endswith((".js", ".html", ".json")) and "node_modules" not in root:
            targets.append(os.path.join(root, fn))
targets.append(r"E:\AI-Station\逆向工程\work\shiflow_asar_js\out__main__index.js")
pat = re.compile(r'.{0,80}(¥\s*\d+|￥\s*\d+|\d+\s*元/月|\d+\s*元/年|每月.{0,8}元|定价|标准版|专业版|旗舰版|高级版|会员月卡|会员年卡|积分包).{0,90}')
seen = set()
for t in targets:
    try: s = open(t, encoding="utf-8", errors="replace").read()
    except: continue
    for m in pat.finditer(s):
        frag = m.group(0).strip()
        key = frag[:60]
        if key in seen: continue
        seen.add(key)
        print(os.path.basename(t), ">>", frag)
