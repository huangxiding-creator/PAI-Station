# -*- coding: utf-8 -*-
"""从 workflow journal 抽取扫荡结果 → sweep_raw.json (幂等, 重复跑合并审计增量)."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

JOURNAL = Path(r"C:/Users/91216/.claude/projects/e--AI-Station/15b96a09-2b98-4d40-b560-7df0735e373f/subagents/workflows/wf_abb92547-7fe/journal.jsonl")
OUT = Path(__file__).parent / "sweep_raw.json"

started = {}          # agentId -> label
results = {}          # agentId -> result obj

for line in JOURNAL.read_text(encoding="utf-8").splitlines():
    line = line.strip()
    if not line:
        continue
    try:
        j = json.loads(line)
    except Exception:
        continue
    if j.get("type") == "started":
        started[j["agentId"]] = j.get("label", "")
    elif j.get("type") == "result":
        results[j["agentId"]] = j.get("result")

raw = []
audit = None
for aid, res in results.items():
    label = started.get(aid, aid)
    if label.startswith("sweep:") and isinstance(res, dict):
        for f in res.get("findings", []):
            f["angle"] = label[len("sweep:"):]
            raw.append(f)
    elif label.startswith("audit:") and isinstance(res, dict):
        audit = res

doc = {"sweeps_done": sorted({l for l in started.values()
                              if l.startswith("sweep:") and l[6:] and
                              l[6:] in [r.get("angle", "") for r in []]}),
       "raw": raw}
# 简化: 不推 angle 派生, 直接记完成 sweep 数
sweep_labels_done = sorted({started[a] for a in results
                            if started.get(a, "").startswith("sweep:")})
doc["sweeps_done"] = sweep_labels_done
if audit:
    doc["audit"] = audit

OUT.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"sweep results: {len([a for a in results if started.get(a,'').startswith('sweep:')])}/8")
print(f"raw findings: {len(raw)}")
if audit:
    print(f"audit: suspect={len(audit.get('suspect', []))} "
          f"missing={len(audit.get('missing_angles', []))} "
          f"extra={len(audit.get('extra_suggestions', []))}")
else:
    print("audit: (未回)")
angles = {}
for f in raw:
    angles[f["angle"]] = angles.get(f["angle"], 0) + 1
for k, v in angles.items():
    print(f"  {k}: {v}")
