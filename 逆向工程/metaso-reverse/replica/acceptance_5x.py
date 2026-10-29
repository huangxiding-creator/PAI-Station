# -*- coding: utf-8 -*-
"""acceptance_5x.py — 5次独立会话贯通验收 (每run=新进程=新cookie/token/tid).
判据: answer>200字 且 sources>=3。间隔10s。"""
import json, subprocess, sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

RUNS = [
    ("中资EPC出海", "web"),
    ("海外电力投资", "scholar"),
    ("国际工程风险", "web"),
    ("一带一路基础设施融资", "scholar"),
    ("中国企业海外并购法律风险", "web"),
]
results = []
for i, (q, scope) in enumerate(RUNS, 1):
    p = subprocess.run(
        [sys.executable, "-X", "utf8", "metaso_api.py", q, "--scope", scope,
         "--json", f"accept_{i}.json", "--quiet"],
        capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=200)
    line = (p.stdout or "").strip().splitlines()
    summary = line[-1] if line else f"rc={p.returncode} stderr={(p.stderr or '')[-200:]}"
    try:
        j = json.load(open(f"accept_{i}.json", encoding="utf-8"))
        ok = len(j["answer"]) > 200 and len(j["sources"]) >= 3
    except Exception as e:
        j, ok = {}, False
    results.append(ok)
    print(f"[{i}/5] {q}({scope}): ok={ok} {summary}")
    if i < len(RUNS):
        time.sleep(10)
print(f"\n=== acceptance: {sum(results)}/{len(results)} 贯通 ===")
sys.exit(0 if all(results) else 1)
