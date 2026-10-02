# -*- coding: utf-8 -*-
"""补账 probe2 Enter 单 (sid=hK84sZvhJyQ9haOZiMypqL): 诊断直发也是真派发,
账本三件 (tree2 问题态 + dispatch_ledger + corps_log) 与 corps 同构落账."""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
TREE2 = BATTLE / "_pipeline" / "epc50_topic_tree_v2.json"
LEDGER = Path("data/dispatch_ledger.json")
CORPS_LOG = Path("data/epc50_corps_log.jsonl")

SID = "hK84sZvhJyQ9haOZiMypqL"
EMAIL = "o2rtdwehyb@manus.edu.kg"
Q_KEY = "业务板块结构"

tree = json.loads(TREE2.read_text(encoding="utf-8"))
hit_tp = hit_q = None
for tp in tree["topics"]:
    for q in tp["questions"]:
        if Q_KEY in q["text"] and q["status"] == "pending":
            hit_tp, hit_q = tp, q
            break
    if hit_q:
        break
if not hit_q:   # 已 dispatched 则找同题已派记录 (幂等防重)
    print(f"[backfill] 无 pending 的「{Q_KEY}」问题 — 查是否已派:")
    for tp in tree["topics"]:
        for q in tp["questions"]:
            if Q_KEY in q["text"]:
                print(f"  {q['id']} status={q['status']} sid={q.get('sid')}")
    sys.exit(1)

hit_q["status"] = "dispatched"
hit_q["sid"] = SID
hit_q["account"] = EMAIL
TREE2.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                 encoding="utf-8")
print(f"[backfill] tree2: {hit_q['id']} → dispatched {SID}")

day = time.strftime("%Y-%m-%d")
led = (json.loads(LEDGER.read_text(encoding="utf-8"))
       if LEDGER.is_file() else {"day": day, "dispatched": {}})
if led.get("day") != day:
    led = {"day": day, "dispatched": {}}
led["dispatched"][EMAIL] = led["dispatched"].get(EMAIL, 0) + 1
LEDGER.write_text(json.dumps(led, ensure_ascii=False, indent=1),
                  encoding="utf-8")
print(f"[backfill] ledger: {EMAIL} → {led['dispatched'][EMAIL]}/日帽")

with CORPS_LOG.open("a", encoding="utf-8") as f:
    f.write(json.dumps({
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "email": EMAIL,
        "sid": SID, "topic": hit_tp["id"], "round": 1,
        "q": hit_q["id"], "title": hit_q["text"][:60],
        "use": "collect"}, ensure_ascii=False) + "\n")
print(f"[backfill] corps_log ✓ (今日军团首单入账)")
