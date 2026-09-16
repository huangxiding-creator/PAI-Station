# -*- coding: utf-8 -*-
"""一次性身份簇手术：主人分身归并（铁证标识符驱动）。

- aliases 命中 owner.json identifiers 的 person 实体 → merge 进 person/总包君，
  边重指（UPDATE OR IGNORE 合并重复边），吸收后的空壳行删除
  （信息已被 merge 全量吸收，删除不丢信息——登记层运行时 API 仍只增不删，
  本脚本是维护手术）
- real_name 实体（黄细丁）同理并入
- alter_egos（总包侠/AI总包侠/总包妞/总包GPT 等 AI 分身）不并实体，
  只挂 alter_ego_of 边（同人不同身，语义独立）
- 用法：python tools/cx_owner_merge.py
"""
from __future__ import annotations

import json
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402

OWNER = json.loads((REPO / "data/cx/owner.json").read_text(encoding="utf-8"))
TARGET = f"person/{OWNER['name']}"
IDS = set(OWNER.get("identifiers", []))
REAL = OWNER.get("real_name")
ALTER_EGOS = OWNER.get("alter_egos", [])


def main() -> int:
    store = EntityStore(REPO / "data/cx/entities.db")
    conn = store._conn

    # 1) 铁证标识符命中的分身实体
    victims = []
    for (eid,) in conn.execute(
        "SELECT entity_id FROM entities WHERE kind='person'"
    ).fetchall():
        if eid == TARGET:
            continue
        aliases = set(json.loads(conn.execute(
            "SELECT aliases FROM entities WHERE entity_id=?", (eid,)
        ).fetchone()[0]))
        if aliases & IDS:
            victims.append((eid, sorted(aliases & IDS)))
    # 真名实体并入（黄细丁=总包君，git 邮箱拼音+税务群实名双证）
    real_eid = f"person/{REAL}" if REAL else None
    if real_eid and real_eid != TARGET and conn.execute(
        "SELECT 1 FROM entities WHERE entity_id=?", (real_eid,)
    ).fetchone():
        victims.append((real_eid, [REAL + "(real_name)"]))

    print(f"merge victims: {len(victims)}")
    for vid, ev in victims:
        print(f"  {vid}  ←证据 {ev}")
        store.merge(TARGET, vid)
        for col in ("from_id", "to_id"):
            conn.execute(
                f"UPDATE OR IGNORE entity_links SET {col}=? WHERE {col}=?",
                (TARGET, vid),
            )
        # merge 后吸收完的空壳（display 已加‖标记）删除；信息无损
        conn.execute("DELETE FROM entities WHERE entity_id=?", (vid,))

    # 2) AI 分身族挂边（不并实体）
    edges = 0
    for nm in ALTER_EGOS:
        row = conn.execute(
            "SELECT entity_id FROM entities WHERE kind='person' AND display_name=?",
            (nm,),
        ).fetchone()
        if row:
            edges += int(store.register_link(row[0], TARGET, "alter_ego_of", "identity"))
    conn.commit()

    print(f"alter_ego_of edges: {edges}")
    print(f"owner aliases now: {conn.execute('SELECT aliases FROM entities WHERE entity_id=?', (TARGET,)).fetchone()[0]}")
    print(f"entities: {store.count()} | {json.dumps(store.stats(), ensure_ascii=False)}")
    print(f"links: {json.dumps(store.link_stats(), ensure_ascii=False)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
