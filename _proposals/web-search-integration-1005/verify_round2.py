# -*- coding: utf-8 -*-
"""轮2: 只重跑 repo 型条目 (补 gh-proxy api 镜像腿后的新码), 增量合并轮1结果.

轮1的 service/site/key_required/existing 结果与新码完全等价 (api 镜像补丁只
影响 verify_github_repo), 只_ids 重跑 repo 项即为全量最新 — 杜绝跑旧代码铁律。
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "ResearchFactory-Eng" / "EPC100" / "collectors"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from search_library import verify as V  # noqa: E402

repo_ids = [p["id"] for p in V.PROJECTS if p.get("ptype") == "repo"]
print(f"[round2] repo 条目 {len(repo_ids)} 项, 增量重跑 (api 镜像腿)", flush=True)
rep = V.verify_all(only_ids=repo_ids)
print(json.dumps(V.summary(rep), ensure_ascii=False))
