# -*- coding: utf-8 -*-
"""T19 破壁试验L：page>1 诊断——page=2/7 原文+callback 变体（3 请求，间隔≥1.2s）。"""
import json
import time

import httpx

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
REFERER = "https://max.book118.com/html/2022/0414/5110103104004213.shtm"
PARAMS = {"project_id": 1, "aid": 458293028, "t": "55e7ca585863afca4c85b22898726b81",
          "view_token": "wfZV4VXfSSBLwX9PNXmmdBXRXeRC2XTAESreymXodihoe9_y5a@cmhIs41pkqgDZZVE="}

facts = {}
with httpx.Client(timeout=30.0, headers={"User-Agent": UA, "Referer": REFERER}) as c:
    for label, pg, extra in (("p2", 2, {}), ("p7", 7, {}),
                             ("p7_cb", 7, {"callback": "jsonpReturn"})):
        time.sleep(1.2)
        r = c.get("https://openapi.book118.com/getPreview.html",
                  params={**PARAMS, "page": pg, **extra})
        facts[label] = {"http": r.status_code, "body": r.text[:500]}
        print(label, r.status_code, r.text[:300])

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step17.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
