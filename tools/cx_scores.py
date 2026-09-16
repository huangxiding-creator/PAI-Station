# -*- coding: utf-8 -*-
"""域2 活跃度驱动：会话新鲜度+会议同场+群活跃展开 → interaction_scores + 报告。

派生层：每次全量重算（scores.db REPLACE），登记层只读。
用法：python tools/cx_scores.py
"""
from __future__ import annotations

import json
import sqlite3
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.scoring import (  # noqa: E402
    score_from_sessions,
    score_from_wecom_meetings,
)

CACHE = REPO / "data/cx/collect_cache"
SCORES_DB = REPO / "data/cx/scores.db"
REPORT = REPO / "SELF_PROFILE/cx_高频协作人_20260916.md"

OWNER_EID = "person/总包君"
GROUP_SHARE_CAP = 30  # 群摊派封顶：真实直连信号（会话/会议）必须压过群辐射

_SCHEMA = """
DROP TABLE IF EXISTS interaction_scores;
CREATE TABLE interaction_scores (
    entity_id TEXT PRIMARY KEY,
    name      TEXT NOT NULL,
    score     INTEGER NOT NULL,
    components TEXT NOT NULL
);
"""


def main() -> int:
    store = EntityStore(REPO / "data/cx/entities.db")
    now = time.time()
    merged: dict[str, dict[str, int]] = {}

    def add(scores: dict) -> None:
        for eid, comps in scores.items():
            bucket = merged.setdefault(eid, {})
            for k, v in comps.items():
                bucket[k] = bucket.get(k, 0) + v

    sess = CACHE / "wechat_sessions.json"
    if sess.exists():
        add(score_from_sessions(store, sess.read_text(encoding="utf-8"), now=now))

    owner_userid = None
    owner_json = REPO / "data/cx/owner.json"
    if owner_json.exists():
        try:
            owner_userid = json.loads(owner_json.read_text(encoding="utf-8")).get("wecom_userid")
        except ValueError:
            pass
    det = CACHE / "wecom_meeting_details.json"
    if det.exists():
        add(score_from_wecom_meetings(store, det.read_text(encoding="utf-8"), owner_userid))

    # 群活跃展开：org 的 group_recency ×0.2 摊给成员（弱权重）
    for eid, comps in list(merged.items()):
        g = comps.get("group_recency", 0)
        if not g or not eid.startswith("org/"):
            continue
        rows = store._conn.execute(
            "SELECT from_id FROM entity_links WHERE to_id=? AND relation='member_of'",
            (eid,),
        ).fetchall()
        share = int(g * 0.2)
        for (mid,) in rows:
            if mid in merged or True:
                bucket = merged.setdefault(mid, {})
                bucket["group_share"] = bucket.get("group_share", 0) + share

    # 榜单排除主人自身与 AI 分身（alter_ego_of 边挂靠者）
    excluded = {OWNER_EID}
    for (fid,) in store._conn.execute(
        "SELECT from_id FROM entity_links WHERE relation='alter_ego_of'"
    ).fetchall():
        excluded.add(str(fid))

    # 落 scores.db（全量重算）
    conn = sqlite3.connect(str(SCORES_DB))
    conn.executescript(_SCHEMA)
    name_by_id = {
        r[0]: r[1] for r in store._conn.execute(
            "SELECT entity_id, display_name FROM entities"
        )
    }
    for eid, comps in merged.items():
        if "group_share" in comps:
            comps["group_share"] = min(comps["group_share"], GROUP_SHARE_CAP)
        total = sum(comps.values())
        if total <= 0 or eid in excluded:
            continue
        conn.execute(
            "INSERT INTO interaction_scores VALUES (?,?,?,?)",
            (eid, name_by_id.get(eid, eid), total,
             json.dumps(comps, ensure_ascii=False)),
        )
    conn.commit()
    top = conn.execute(
        "SELECT name, score, components FROM interaction_scores "
        "WHERE entity_id LIKE 'person/%' ORDER BY score DESC LIMIT 30"
    ).fetchall()
    n_person = conn.execute(
        "SELECT COUNT(*) FROM interaction_scores WHERE entity_id LIKE 'person/%'"
    ).fetchone()[0]
    conn.close()
    store.close()

    lines = [
        "# 高频协作人（互动活跃度 v1）",
        "",
        f"> 2026-09-16 · 派生层首版：微信会话新鲜度(7/30/90天梯)+企微会议同场(20/场)"
        f"+群活跃摊派(×0.2) · 记分实体 {n_person} 人",
        "",
        "| # | 人物 | 总分 | 构成 |",
        "|---|---|---|---|",
    ]
    for i, (name, score, comps) in enumerate(top, 1):
        lines.append(f"| {i} | {name} | {score} | {comps} |")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"scored persons: {n_person} → {REPORT.name}")
    for name, score, comps in top[:10]:
        print(f"  {score:>4}  {name}  {comps}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
