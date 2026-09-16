# -*- coding: utf-8 -*-
"""CX 域2 飞书：会话列表 → person/org 实体 + associate_of/member_of 边。"""

from __future__ import annotations

import json

from paistation.cx.entities import EntityStore
from paistation.cx.ingest_feishu import (
    parse_lark_chats,
    parse_lark_members,
    register_lark_chats,
    register_lark_members,
)

SAMPLE_CHATS = {
    "data": {
        "chats": [
            {"chat_id": "oc_1", "chat_mode": "p2p", "name": "江涛",
             "p2p_target_id": "ou_jt"},
            {"chat_id": "oc_2", "chat_mode": "p2p", "name": "云文档助手",
             "p2p_target_id": "ou_doc"},  # 系统助手也入表（活跃度后续加权）
            {"chat_id": "oc_3", "chat_mode": "group", "name": "总包知识库"},
            {"chat_id": "oc_4", "chat_mode": "group", "name": ""},
        ]
    }
}

SAMPLE_MEMBERS = {
    "data": {
        "users": [
            {"member_id": "ou_owner", "name": "黄细丁"},
            {"member_id": "ou_m1", "name": "江涛"},
        ],
        "bots": [{"member_id": "ou_bot", "name": "总包Claw（腾讯）"}],
    }
}


class TestParse:
    def test_chats_split_p2p_groups(self):
        p2p, groups = parse_lark_chats(json.dumps(SAMPLE_CHATS, ensure_ascii=False))
        assert [c["name"] for c in p2p] == ["江涛", "云文档助手"]
        assert p2p[0]["open_id"] == "ou_jt"
        assert [g["name"] for g in groups] == ["总包知识库"]  # 空名群跳过

    def test_bad_payload(self):
        assert parse_lark_chats("{}") == ([], [])

    def test_members_parse(self):
        rows = parse_lark_members(json.dumps(SAMPLE_MEMBERS, ensure_ascii=False))
        assert rows == [
            {"open_id": "ou_owner", "name": "黄细丁"},
            {"open_id": "ou_m1", "name": "江涛"},
            {"open_id": "ou_bot", "name": "总包Claw（腾讯）"},
        ]


class TestRegister:
    def test_p2p_persons_and_associate_edges(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        p2p, groups = parse_lark_chats(json.dumps(SAMPLE_CHATS, ensure_ascii=False))
        eids, stats = register_lark_chats(st, p2p, groups, owner_eid="person/总包君")
        assert stats["persons_created"] == 2 and st.count("person") == 2
        assert stats["groups_created"] == 1 and st.count("org") == 1
        assert st.link_stats() == {"associate_of": 2}  # p2p 双方沟通关系
        # 幂等
        _, stats2 = register_lark_chats(st, p2p, groups, owner_eid="person/总包君")
        assert stats2["persons_created"] == 0 and stats2["links"] == 0

    def test_group_members(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        rows = parse_lark_members(json.dumps(SAMPLE_MEMBERS, ensure_ascii=False))
        stats = register_lark_members(st, "org/总包知识库", rows)
        assert stats == {"members": 3, "links": 3}
        assert st.link_stats() == {"member_of": 3}
        stats2 = register_lark_members(st, "org/总包知识库", rows)
        assert stats2["links"] == 0
