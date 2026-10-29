# -*- coding: utf-8 -*-
import sys, io, json
sys.path.insert(0, "E:/AI-Station/逆向工程/cnki-reverse/replica")
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
from cnki_api import CnkiApi

api = CnkiApi()
data = json.load(open("E:/AI-Station/逆向工程/cnki-reverse/captures/F1_run1.json", encoding="utf-8"))
from cnki_api import Record
hit = 0
for r in data["records"][:8]:
    rec = Record(title=r["title"], detail_url=r["detail_url"])
    a = api.fetch_abstract(rec)
    hit += 1 if a else 0
    print(("OK " if a else "MISS") , len(a), r["title"][:32], "|", (a[:60] if a else ""))
print(f"\nabstract hit: {hit}/8")
