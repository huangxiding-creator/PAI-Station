# -*- coding: utf-8 -*-
"""实体登记表驱动：git 作者（邮箱锚点）+ 项目实体 → data/cx/entities.db。

统一身份图谱的地基：graphiti/splink 接入前先把强标识符种下去。
用法：python tools/cx_entities.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore, collect_git_authors  # noqa: E402
from paistation.cx.ingest_sources import find_git_repos  # noqa: E402

DB = REPO / "data/cx/entities.db"


def main() -> int:
    repos = find_git_repos(["E:/", "D:/"])
    store = EntityStore(DB)
    before = store.count()

    # 项目实体
    for r in repos:
        store.register("project", Path(r).name, source="git", seen_at=None)

    # 人物实体（git 作者，邮箱为强标识符别名）
    authors = collect_git_authors(repos)
    multi_repo = []
    for a in authors:
        store.register(
            "person", a["name"],
            aliases=[a["email"]] if a["email"] else None,
            source="git",
        )
        if len(a["repos"]) > 1:
            multi_repo.append((a["name"], len(a["repos"])))

    total = store.count()
    print(f"entities: {before} -> {total} (+{total - before})")
    print("by kind:", json.dumps(store.stats(), ensure_ascii=False))
    print(f"git authors: {len(authors)}；跨仓作者 {len(multi_repo)} 名："
          f"{sorted(multi_repo, key=lambda x: -x[1])[:5]}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
