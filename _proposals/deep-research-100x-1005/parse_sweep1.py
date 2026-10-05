# -*- coding: utf-8 -*-
"""从任务日志提取 Workflow 返回 JSON, 落盘 sweep1_result.json."""
import json
import sys
from pathlib import Path

SRC = Path(r"C:\Users\91216\AppData\Local\Temp\claude\e--AI-Station"
           r"\15b96a09-2b98-4d40-b560-7df0735e373f\tasks\w7oyi29hs.output")
DST = Path(r"E:\AI-Station\_proposals\deep-research-100x-1005\sweep1_result.json")

raw = json.loads(SRC.read_text(encoding="utf-8", errors="replace"))
d = raw["result"]
DST.parent.mkdir(parents=True, exist_ok=True)
json.dump({"pool": d["full_pool"], "verified": d["verified"]},
          DST.open("w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("raw:", d["raw_count"], "unique:", d["unique_count"],
      "pool saved:", len(d["full_pool"]), "verified:", len(d["verified"]))
for x in d["verified"]:
    print(f"{x.get('verdict', '?'):>10} | {x.get('stars', 0):>7} | "
          f"{x.get('name', '?')[:42]:42} | "
          f"{str(x.get('search_capability_summary', ''))[:58]}")
