# -*- coding: utf-8 -*-
import sys, io, json
sys.path.insert(0, "E:/AI-Station/逆向工程/cnki-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
from cnki_api import CnkiApi

api = CnkiApi()
data = json.load(open("E:/AI-Station/逆向工程/cnki-reverse/captures/F1_run1.json", encoding="utf-8"))
urls = [r["detail_url"] for r in data["records"][:6]]
for u in urls:
    api._tick()
    r = api.s.get(u, timeout=25, headers={"Referer": "https://search.cnki.com.cn/"})
    has = "【摘要】" in r.text
    print(r.status_code, len(r.content), "HAS_ABS" if has else "NO_ABS", u[:95])
