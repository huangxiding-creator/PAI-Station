# -*- coding: utf-8 -*-
"""提取 panhunter-synthesis 工作流 journal 里的 V3/Red 终审"""
import io, json, sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
P = (r"C:\Users\91216\.claude\projects\e--AI-Station\4ce49cdd-2f77-4fa6-aa2e-26683263ba34"
     r"\subagents\workflows\wf_4a29e0c1-39d\journal.jsonl")
results = []
for line in io.open(P, encoding="utf-8", errors="replace"):
    try:
        o = json.loads(line)
    except Exception:
        continue
    r = o.get("result")
    if isinstance(r, dict) and "verdict" in r:
        results.append((o.get("label", o.get("key", "?")), r))

for label, r in results:
    print(f"== [{label}] verdict={r['verdict']}")
    ev = r.get("evidence") or r.get("amendments") or ""
    if isinstance(ev, list):
        for a in ev:
            print("  -", str(a)[:220])
    else:
        print("  ", str(ev)[:650])
    for k in r.get("kill_attempts", []) or []:
        print(f"  kill[{k['survived']}] {k['angle']}: {k['argument'][:160]}")
    print()
