# -*- coding: utf-8 -*-
"""从 workflow 任务输出文件提取 {raw, audit} JSON 体 → 落盘 v1 文件。"""
import json
import sys

src = sys.argv[1]
env = json.load(open(src, encoding="utf-8", errors="replace"))
res = env.get("result") or env.get("returnValue") or env
if not isinstance(res, dict) or "raw" not in res:
    # 信封内可能是字符串化的 JSON
    for k in ("result", "returnValue", "value"):
        v = env.get(k)
        if isinstance(v, str) and '"raw"' in v:
            res = json.loads(v)
            break
if not isinstance(res, dict) or "raw" not in res:
    print("ENVELOPE KEYS:", list(env.keys()))
    sys.exit(1)
raw = res["raw"]
audit = res.get("audit", {})
print("raw_count:", res.get("raw_count"), "len(raw):", len(raw))
print("angles_ok:", res.get("angles_ok"))
print("audit keys:", list(audit.keys()) if isinstance(audit, dict) else type(audit))
if isinstance(audit, dict):
    print("suspect:", len(audit.get("suspect", [])))
    print("missing_angles:", audit.get("missing_angles"))
    print("extra_suggestions:", len(audit.get("extra_suggestions", [])))
    for s in audit.get("extra_suggestions", [])[:40]:
        print("  +", s.get("name"), s.get("url"), s.get("quality", ""))
out_dir = r"E:/AI-Station/_proposals/channel-integration-1004/ebook_research"
json.dump(raw, open(out_dir + "/sweep_raw_v1.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
json.dump(audit, open(out_dir + "/sweep_audit_v1.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print("saved v1")
