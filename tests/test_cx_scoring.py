# -*- coding: utf-8 -*-
"""CX 域2 活跃度加权：会话新鲜度+会议同场+群活跃 → 互动分。"""

from __future__ import annotations

import json
import time

from paistation.cx.entities import EntityStore
from paistation.cx.scoring import (
    recency_score,
    score_from_sessions,
    score_from_wecom_meetings,
)

NOW = 1789600000  # 固定基准，避免夹具时钟陷阱

SESSIONS = {
    "data": {"sessions": [
        {"username": "wxid_a", "display_name": "甲", "last_timestamp": NOW - 3 * 86400},
        {"username": "wxid_b", "display_name": "乙", "last_timestamp": NOW - 400 * 86400},
        {"username": "123@chatroom", "display_name": "G", "last_timestamp": NOW - 10 * 86400},
    ]}
}

DETAIL = [
    {"meetings": [
        {"meeting_id": "mt1", "subject": "s", "begin_time": "2026-08-17 10:30:00",
         "end_time": "2026-08-17 11:30:00",
         "attendees": [{"userid": "wo_owner", "name": "总包君"},
                       {"userid": "wo_liu", "name": "刘君"}]},
    ]},
]


def _store(tmp_path):
    st = EntityStore(tmp_path / "e.db")
    st.register("person", "甲", aliases=["wxid_a"], source="wechat")
    st.register("person", "乙", aliases=["wxid_b"], source="wechat")
    st.register("person", "刘君", aliases=["wo_liu"], source="wecom")
    st.register("org", "G", aliases=["123@chatroom"], source="wechat_group")
    return st


class TestScoring:
    def test_recency_buckets(self):
        day = 86400
        assert recency_score(NOW, NOW - 3 * day) == 50
        assert recency_score(NOW, NOW - 20 * day) == 30
        assert recency_score(NOW, NOW - 60 * day) == 15
        assert recency_score(NOW, NOW - 400 * day) == 5
        assert recency_score(NOW, None) == 0

    def test_sessions_p2p_and_group(self, tmp_path):
        st = _store(tmp_path)
        scores = score_from_sessions(st, json.dumps(SESSIONS, ensure_ascii=False), now=NOW)
        assert scores["person/甲"] == {"wechat_recency": 50}
        assert scores["person/乙"] == {"wechat_recency": 5}
        assert scores["org/G"] == {"group_recency": 30}  # 群聚合在 org 上

    def test_wecom_meetings(self, tmp_path):
        st = _store(tmp_path)
        text = json.dumps(DETAIL, ensure_ascii=False)
        scores = score_from_wecom_meetings(st, text, owner_userid="wo_owner")
        assert scores["person/刘君"] == {"wecom_meetings": 20}

    def test_unmapped_entities_skipped(self, tmp_path):
        st = _store(tmp_path)
        scores = score_from_sessions(
            st, json.dumps({"data": {"sessions": [
                {"username": "wxid_ghost", "display_name": "幽灵",
                 "last_timestamp": NOW}]}}), now=NOW
        )
        assert scores == {}
