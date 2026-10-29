# -*- coding: utf-8 -*-
"""诊断: 详情页摘要腿为何 1/3 命中。"""
import sys, io, json, time
sys.path.insert(0, "E:/AI-Station/逆向工程/cnki-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
import requests
from cnki_api import CnkiApi

api = CnkiApi()
res = api.search("国际工程 EPC", page=1)
data = json.load(open("E:/AI-Station/逆向工程/cnki-reverse/captures/F1_run1.json", encoding="utf-8"))
urls = [r["detail_url"] for r in data["records"][:6]]
for u in urls:
    api._tick()
    r = api.s.get(u, timeout=25, headers={"Referer": "https://search.cnki.com.cn/"})
    has = "【摘要】" in r.text
    print(r.status_code, len(r.content), "has摘要" if has else "NO摘要", u[:90])
PYEOF
"E:/AI-Station/.venv/Scripts/python.exe" "E:/AI-Station/逆向工程/cnki-reverse/work/probe7_detail_diag.py" 2>&1 | tail -8
