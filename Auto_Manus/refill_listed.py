# -*- coding: utf-8 -*-
"""listed_accounts 回填 (幂等) — 防旧进程回写抹掉跨文件跳过标记."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
p = Path("harvest_sessions/manifest.json")
m = json.loads(p.read_text(encoding="utf-8"))
done = set(m.get("accounts", {}).keys())
have = set(m.get("listed_accounts", []))
merged = sorted(done | have)
m["listed_accounts"] = merged
p.write_text(json.dumps(m, ensure_ascii=False), encoding="utf-8")
print(f"[refill] listed_accounts={len(merged)} (+{len(done - have)} 回填)")
