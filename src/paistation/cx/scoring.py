# -*- coding: utf-8 -*-
"""CX 派生层：互动活跃度加权（谁是与主人真正高频协作的人）。

登记层（entities/links）只增不删；本层是可重算的派生指标：
- 微信 p2p 会话最近消息时间 → wechat_recency 分（7/30/90 天梯）
- 群会话活跃 → group_recency 分（记在 org 上，成员共享弱权重由 driver 展开可选）
- 企微会议与主人同场 → wecom_meetings 分（每场 20）
模型刻意简单可解释（v1）；后续可换行为流/消息量加权。
"""

from __future__ import annotations

import json
import time as _time

_DAY = 86400


def recency_score(now: float, ts: float | int | None) -> int:
    """最近互动时间 → 新鲜度分。ts 为 unix 秒。"""
    if not ts:
        return 0
    days = (now - float(ts)) / _DAY
    if days <= 7:
        return 50
    if days <= 30:
        return 30
    if days <= 90:
        return 15
    return 5


def score_from_sessions(store, sessions_json: str, now: float | None = None) -> dict:
    """rion sessions 导出 → {entity_id: {component: score}}。

    p2p 会话按 username(wxid) 反查 person；群按 chatroom id 反查 org。
    反查不上的（非好友/系统号）静默跳过。
    """
    now = now if now is not None else _time.time()
    try:
        rows = json.loads(sessions_json).get("data", {}).get("sessions", [])
    except ValueError:
        return {}
    out: dict[str, dict[str, int]] = {}
    for s in rows:
        username = (s.get("username") or "").strip()
        if not username:
            continue
        eid = store.lookup_by_alias(username)
        if not eid:
            continue
        key = "group_recency" if username.endswith("@chatroom") else "wechat_recency"
        sc = recency_score(now, s.get("last_timestamp"))
        if sc:
            bucket = out.setdefault(eid, {})
            bucket[key] = max(bucket.get(key, 0), sc)
    return out


def score_from_wecom_meetings(
    store, details_json: str, owner_userid: str | None, per_meeting: int = 20
) -> dict:
    """企微会议详情 → 同场参与人与主人各加分。

    参与人优先按 userid 反查，回退按 display_name 精确匹配（同名容忍 v1）。
    """
    from paistation.cx.ingest_wecom import parse_wecom_meeting_details

    meetings = parse_wecom_meeting_details(details_json)
    out: dict[str, dict[str, int]] = {}
    for m in meetings:
        if owner_userid and not any(a["userid"] == owner_userid for a in m["attendees"]):
            continue
        for a in m["attendees"]:
            if owner_userid and a["userid"] == owner_userid:
                continue
            eid = store.lookup_by_alias(a["userid"]) if a["userid"] else None
            if not eid and a["name"]:
                row = store._conn.execute(
                    "SELECT entity_id FROM entities WHERE kind='person' AND display_name=?",
                    (a["name"],),
                ).fetchone()
                eid = str(row[0]) if row else None
            if not eid:
                continue
            bucket = out.setdefault(eid, {})
            bucket["wecom_meetings"] = bucket.get("wecom_meetings", 0) + per_meeting
    return out
