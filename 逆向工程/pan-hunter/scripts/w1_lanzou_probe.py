# -*- coding: utf-8 -*-
"""W1 蓝奏 68 候选普查：parse() 逐链试，找「列出文件且含 ≥10MB 项」的活链。"""
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from adapters import ADAPTERS                     # noqa: E402
from adapters.base import PanError, extract_pwd   # noqa: E402

extra = json.loads((ROOT / "analysis" / "w1_gate_extra.json").read_text(encoding="utf-8"))
ad = ADAPTERS["lanzou"]
alive = []
for u in extra["lanzou"]:
    base, pwd = extract_pwd(u)
    if base.rstrip("/").endswith("/u"):     # 用户主页非分享
        continue
    try:
        entries = ad.parse(base, pwd)
        big = [e for e in entries if not e.is_dir and e.size >= 10 * 1048576]
        ok = f"{len(entries)}项, ≥10MB×{len(big)}"
        if big:
            alive.append({"url": u, "file": big[0].name, "size": big[0].size})
        print(f"OK   {u[:60]:62s} {ok}")
    except PanError as e:
        print(f"FAIL {u[:60]:62s} {str(e)[:60]}")
    except Exception as e:
        print(f"ERR  {u[:60]:62s} {type(e).__name__} {str(e)[:40]}")
    time.sleep(0.7)

print(f"\n活链(含≥10MB): {len(alive)}")
for a in alive:
    print("  ", a["url"], "->", a["file"], a["size"])
(ROOT / "analysis" / "w1_lanzou_alive.json").write_text(
    json.dumps(alive, ensure_ascii=False, indent=1), encoding="utf-8")
