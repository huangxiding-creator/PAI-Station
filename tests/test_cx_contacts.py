# -*- coding: utf-8 -*-
"""CX 域2 工作人际：微信联系人 → 实体登记表 + friend_of 关系边。"""

from __future__ import annotations

import json

from paistation.cx.entities import EntityStore
from paistation.cx.ingest_contacts import parse_rion_contacts, register_wechat_contacts


def _payload(contacts: list[dict]) -> str:
    return json.dumps({"data": {"contacts": contacts}}, ensure_ascii=False)


SAMPLE = [
    {"username": "wxid_owner", "nick_name": "总包君 @总包圈", "remark": "", "alias": "ZongBaoJ01"},
    {"username": "medianote", "nick_name": "语音记事本", "remark": "", "alias": ""},  # 系统号
    {"username": "gh_xxx", "nick_name": "某公众号", "remark": "", "alias": ""},       # 公众号
    {"username": "wxid_a", "nick_name": "阿飞", "remark": "陈飞", "alias": "cf123"},
    {"username": "wxid_b", "nick_name": "无备注者", "remark": "", "alias": ""},
]


class TestParse:
    def test_filters_and_names(self):
        cs = parse_rion_contacts(_payload(SAMPLE))
        assert [c["name"] for c in cs] == ["总包君 @总包圈", "陈飞", "无备注者"]

    def test_aliases_carry_strong_identifiers(self):
        cs = parse_rion_contacts(_payload(SAMPLE))
        by_wxid = {c["wxid"]: c for c in cs}
        # remark 升为正名后不重复；wxid/微信号/昵称都进别名（splink blocking 用）
        assert by_wxid["wxid_a"]["aliases"] == ["cf123", "wxid_a", "阿飞"]
        assert by_wxid["wxid_owner"]["aliases"] == ["ZongBaoJ01", "wxid_owner"]

    def test_bad_payload_returns_empty(self):
        assert parse_rion_contacts("{}") == []
        assert parse_rion_contacts('{"data": {"contacts": []}}') == []


class TestRegister:
    def test_persons_and_owner_links(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        cs = parse_rion_contacts(_payload(SAMPLE))
        stats = register_wechat_contacts(st, cs, owner_wxid="wxid_owner")
        assert st.count("person") == 3
        assert stats == {"persons": 3, "created": 3, "links": 2}  # 好友→主人，自身无边

    def test_idempotent_rerun(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        cs = parse_rion_contacts(_payload(SAMPLE))
        register_wechat_contacts(st, cs, owner_wxid="wxid_owner")
        stats2 = register_wechat_contacts(st, cs, owner_wxid="wxid_owner")
        assert stats2 == {"persons": 3, "created": 0, "links": 0}
        assert st.count("person") == 3

    def test_no_owner_no_links(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        cs = parse_rion_contacts(_payload(SAMPLE))
        stats = register_wechat_contacts(st, cs, owner_wxid=None)
        assert stats["links"] == 0 and stats["created"] == 3

    def test_link_registered_in_store(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        cs = parse_rion_contacts(_payload(SAMPLE))
        register_wechat_contacts(st, cs, owner_wxid="wxid_owner")
        assert st.link_stats() == {"friend_of": 2}
        row = st._conn.execute(
            "SELECT from_id, to_id FROM entity_links LIMIT 1"
        ).fetchone()
        assert row[1] == "person/总包君-总包圈"  # 无正名覆盖时用昵称 slug（" @"归并为单个"-"）

    def test_owner_name_override_merges_into_git_entity(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        st.register("person", "总包君", aliases=["z@git.com"], source="git")
        cs = parse_rion_contacts(_payload(SAMPLE))
        stats = register_wechat_contacts(
            st, cs, owner_wxid="wxid_owner", owner_name="总包君"
        )
        row = st._conn.execute(
            "SELECT aliases, sources FROM entities WHERE entity_id='person/总包君'"
        ).fetchone()
        assert set(json.loads(row[0])) >= {"z@git.com", "ZongBaoJ01", "wxid_owner"}
        assert set(json.loads(row[1])) == {"git", "wechat"}
        # 边全部指向 git 同名实体（跨渠道锚点成立）
        n = st._conn.execute(
            "SELECT COUNT(*) FROM entity_links WHERE to_id='person/总包君'"
        ).fetchone()[0]
        assert n == 2 and st.link_stats() == {"friend_of": 2}
