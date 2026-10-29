# 探针：读六库49分组定义（只读，探明后即弃）
import json, sys
sys.path.insert(0, "E:/AI-Station/kb_factory")
from catalog_engine import taxonomy
sd = taxonomy.SIX_DOMAINS
print("TYPE", type(sd).__name__, "LEN", len(sd))
items = sd.items() if isinstance(sd, dict) else [(i, v) for i, v in enumerate(sd)]
total = 0
for k, v in items:
    groups = v.get("groups", []) if isinstance(v, dict) else []
    total += len(groups)
    name = v.get("name", "?") if isinstance(v, dict) else "?"
    print("LIB", k, name, "NG", len(groups))
    print("  GROUPS", json.dumps(groups, ensure_ascii=False))
print("TOTAL_GROUPS", total)
print("ALL_NAMES", [v.get("name") if isinstance(v, dict) else str(v) for _, v in items])
