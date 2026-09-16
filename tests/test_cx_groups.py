# -*- coding: utf-8 -*-
"""CX 域2 群成员：微信群 → org 实体 + member_of 关系边。"""

from __future__ import annotations

import json

from paistation.cx.entities import EntityStore
from paistation.cx.ingest_contacts import (
    parse_rion_contact_rows,
    parse_rion_group_sessions,
    register_group_members,
    register_wechat_groups,
)

SAMPLE_SESSIONS = {
    "data": {
        "sessions": [
            {"username": "123@chatroom", "display_name": "总包公号情报群",
             "last_timestamp": 1789550607},
            {"username": "456@chatroom", "display_name": "", "last_timestamp": 1},  # 无名群
            {"username": "wxid_a", "display_name": "好友甲", "last_timestamp": 2},  # 非群
        ]
    }
}

SAMPLE_MEMBERS = [
    {"username": "wxid_owner", "nick_name": "总包君 @总包圈", "remark": "", "alias": "ZongBaoJ01"},
    {"username": "wxid_x", "nick_name": "成员乙", "remark": "", "alias": ""},
    {"username": "gh_ad", "nick_name": "群内公众号", "remark": "", "alias": ""},  # 滤除
]


class TestParseGroups:
    def test_parse_sessions_filters(self):
        gs = parse_rion_group_sessions(json.dumps(SAMPLE_SESSIONS, ensure_ascii=False))
        assert gs == [
            {"chatroom_id": "123@chatroom", "name": "总包公号情报群", "last_ts": 1789550607}
        ]

    def test_bad_payload(self):
        assert parse_rion_group_sessions("{}") == []

    def test_member_rows_reuse_contact_normalization(self):
        ms = parse_rion_contact_rows(SAMPLE_MEMBERS)
        assert [m["name"] for m in ms] == ["总包君 @总包圈", "成员乙"]
        assert ms[0]["aliases"] == ["ZongBaoJ01", "wxid_owner"]


class TestRegisterGroups:
    def test_groups_and_member_links(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        gs = parse_rion_group_sessions(json.dumps(SAMPLE_SESSIONS, ensure_ascii=False))
        eids, created = register_wechat_groups(st, gs)
        assert created == 1 and st.count("org") == 1
        members = parse_rion_contact_rows(SAMPLE_MEMBERS)
        stats = register_group_members(st, eids["123@chatroom"], members)
        assert stats == {"members": 2, "links": 2}  # 含主人自身（他在哪些群=工作事实）
        assert st.link_stats() == {"member_of": 2}

    def test_idempotent_rerun(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        gs = parse_rion_group_sessions(json.dumps(SAMPLE_SESSIONS, ensure_ascii=False))
        eids, _ = register_wechat_groups(st, gs)
        members = parse_rion_contact_rows(SAMPLE_MEMBERS)
        register_group_members(st, eids["123@chatroom"], members)
        stats2 = register_group_members(st, eids["123@chatroom"], members)
        assert stats2 == {"members": 2, "links": 0}
        assert st.link_stats() == {"member_of": 2}
