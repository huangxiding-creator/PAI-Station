# -*- coding: utf-8 -*-
"""CX 企微：会议详情解析 + 参与人实体 + 会议事件。"""

from __future__ import annotations

import json

from paistation.cx.entities import EntityStore
from paistation.cx.timeline import TimelineStore
from paistation.cx.ingest_wecom import (
    collect_wecom_events,
    parse_wecom_meeting_details,
    register_wecom_attendees,
)

DETAIL = [
    {"meetings": [
        {"meeting_id": "mt1", "subject": "江巷灌区视频监控方案讨论",
         "begin_time": "2026-08-17 10:30:00", "end_time": "2026-08-17 11:30:00",
         "attendees": [
             {"userid": "wo_owner", "name": "总包君(总包君)", "is_attended": True},
             {"userid": "wo_liu", "name": "刘君(刘工)", "is_attended": True},
         ]},
        {"meeting_id": "mt2", "subject": "无主人场", "begin_time": "2026-08-01 09:00:00",
         "end_time": "2026-08-01 10:00:00",
         "attendees": [{"userid": "wo_x", "name": "路人", "is_attended": True}]},
    ]},
    {"meetings": [
        {"meeting_id": "mt3", "subject": "空 begin", "begin_time": "",
         "attendees": [{"userid": "wo_owner", "name": "总包君"}]},
    ]},
]


class TestParse:
    def test_flatten_and_clean(self):
        ms = parse_wecom_meeting_details(json.dumps(DETAIL, ensure_ascii=False))
        assert len(ms) == 3
        assert ms[0]["attendees"][0] == {"userid": "wo_owner", "name": "总包君"}
        assert ms[0]["attendees"][1] == {"userid": "wo_liu", "name": "刘君", "alias": "刘工"}

    def test_bad_payload(self):
        assert parse_wecom_meeting_details("not json") == []


class TestRegisterAndEvents:
    def test_attendees_and_edges(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        ms = parse_wecom_meeting_details(json.dumps(DETAIL, ensure_ascii=False))
        stats = register_wecom_attendees(st, ms, owner_userid="wo_owner")
        assert stats["persons_created"] == 3  # 总包君/刘君/路人（mt3 总包君重名合并）
        assert st.link_stats() == {"associate_of": 2}  # 刘君+路人→主人，自环跳过
        stats2 = register_wecom_attendees(st, ms, owner_userid="wo_owner")
        assert stats2 == {"persons_created": 0, "links": 0}

    def test_events_only_owner_present(self, tmp_path):
        ms = parse_wecom_meeting_details(json.dumps(DETAIL, ensure_ascii=False))
        evs = collect_wecom_events(ms, owner_userid="wo_owner")
        assert len(evs) == 1  # mt1（mt2 无主人、mt3 无 begin）
        assert evs[0].type == "meeting.attend" and evs[0].source_id == "mt1"
        assert evs[0].payload["attendee_count"] == 2
        tl = TimelineStore(tmp_path / "t.db")
        assert tl.ingest(evs) == (1, 0)
