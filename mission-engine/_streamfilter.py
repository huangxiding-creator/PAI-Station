# -*- coding: utf-8 -*-
import sys, json
for ln in sys.stdin:
    ln = ln.strip()
    if not ln:
        continue
    try:
        d = json.loads(ln)
    except Exception:
        continue
    t = d.get("type", "")
    if t == "assistant":
        for x in d.get("message", {}).get("content", []):
            if x.get("type") == "text":
                print(x.get("text", "")[:200]); sys.stdout.flush()
            elif x.get("type") == "tool_use":
                print("[tool] " + x.get("name", "")); sys.stdout.flush()
    elif t == "result":
        print("=== RESULT ==="); print(str(d.get("result", ""))[:500]); sys.stdout.flush()
