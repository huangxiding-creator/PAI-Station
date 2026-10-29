# -*- coding: utf-8 -*-
import json
lines = open("ledger/signals.jsonl", encoding="utf-8").read().strip().splitlines()
real = [json.loads(x) for x in lines if "signal" in x]
print("真实信号数:", len(real))
for d in real[-2:]:
    s = d["signal"]
    print(s["source_type"], "|", s["payload"]["title"][:40], "|", s["payload"].get("overview", "")[:50])
