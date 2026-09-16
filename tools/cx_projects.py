# -*- coding: utf-8 -*-
"""域1 驱动：群业务线 + 会议项目 + 白龟湖 → 实体表 + 项目地图报告。

用法：python tools/cx_projects.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_projects import (  # noqa: E402
    calibrate_attributions,
    register_baiguihu,
    register_group_projects,
    register_meeting_projects,
)
from paistation.cx.ingest_wecom import parse_wecom_meeting_details  # noqa: E402

CACHE = REPO / "data/cx/collect_cache"
REPORT = REPO / "SELF_PROFILE/cx_项目地图_20260916.md"


def main() -> int:
    store = EntityStore(REPO / "data/cx/entities.db")

    edges = register_group_projects(store)
    print(f"group→业务线边新建: {edges}")

    det = CACHE / "wecom_meeting_details.json"
    subjects: list[str] = []
    if det.exists():
        subjects = [m["subject"] for m in parse_wecom_meeting_details(
            det.read_text(encoding="utf-8")) if m.get("subject")]
    created = register_meeting_projects(store, subjects)
    print(f"会议主题实体新建: {created}（主题 {len(subjects)} 场）")

    baigu = register_baiguihu(store)
    print(f"白龟湖线新建: {baigu}")

    calibrated = calibrate_attributions(store)
    print(f"落款校准 operated_by 边新建: {calibrated}")

    # git 来源代码项目 → 第三线"个人 AI 基建"挂 owned_by→本人
    conn = store._conn
    owned = 0
    for (eid, srcs) in conn.execute(
        "SELECT entity_id, sources FROM entities WHERE kind='project'"
    ).fetchall():
        if "git" in json.loads(srcs):
            owned += int(store.register_link(
                str(eid), "person/总包君", "owned_by", "git_scan"))
    store._conn.commit()
    print(f"git 项目 owned_by 边新建: {owned}")

    # 报告：project/topic 实体 + 各自 part_of 群数 + 归属（operated_by→机构 / owned_by→本人）
    projs = conn.execute(
        "SELECT entity_id, display_name FROM entities "
        "WHERE kind IN ('project','topic') ORDER BY kind, entity_id"
    ).fetchall()
    lines = [
        "# 项目地图（域1 非代码工作对象实体化）",
        "",
        "> 2026-09-16 · 群名业务线聚类 + 企微会议主题提取 + 白龟湖目录实勘",
        "> 归属：主业→黄河设计院（设计院总承包线）；副业→总包说(海南)（社群矩阵）",
        "",
        "| 实体 | 类型 | 挂靠群/子项 | 归属 |",
        "|---|---|---|---|",
    ]
    for eid, name in projs:
        parts = conn.execute(
            "SELECT COUNT(*) FROM entity_links WHERE to_id=? "
            "AND relation='part_of'", (eid,)
        ).fetchone()[0]
        owner = conn.execute(
            "SELECT to_id, relation FROM entity_links WHERE from_id=? "
            "AND relation IN ('operated_by','owned_by')", (eid,)
        ).fetchone()
        owner_name = owner[0].split("/", 1)[1] if owner else "—"
        lines.append(f"| {name} | {eid.split('/')[0]} | {parts} | {owner_name} |")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"project/topic 实体: {len(projs)} → {REPORT.name}")
    print(f"stats: {json.dumps(store.stats(), ensure_ascii=False)} | "
          f"{json.dumps(store.link_stats(), ensure_ascii=False)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
