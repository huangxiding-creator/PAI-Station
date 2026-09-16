# -*- coding: utf-8 -*-
"""双角色视角：项目归属→角色传导（群成员/邮件联系人按角色分榜）。"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.roles import (  # noqa: E402
    MAIN_ORG,
    SIDE_ORG,
    entity_roles,
    role_of_project,
)


def _seed(store: EntityStore) -> None:
    """三线项目 + 两类群 + 成员 + 邮件联系人。"""
    store.register("org", "黄河勘测规划设计研究院", source="t")
    store.register("org", "总包说(海南)教育科技有限公司", source="t")
    store.register("org", "个人AI工作站运营群", source="t")
    # 主业项目+群
    store.register("project", "江巷灌区信息化", source="t")
    store.register_link("project/江巷灌区信息化", MAIN_ORG, "operated_by", "t")
    store.register("org", "江巷灌区项目群", source="t")
    store.register_link("org/江巷灌区项目群", "project/江巷灌区信息化",
                        "part_of", "t")
    # 副业项目+群
    store.register("project", "总包之声", source="t")
    store.register_link("project/总包之声", SIDE_ORG, "operated_by", "t")
    store.register("project", "总包大家谈", source="t")
    store.register_link("project/总包大家谈", SIDE_ORG, "operated_by", "t")
    store.register("org", "总包之声01群", source="t")
    store.register_link("org/总包之声01群", "project/总包之声", "part_of", "t")
    # 个人线项目（owned_by 本人、无 operated_by）
    store.register("project", "IdeaDig", source="t")
    store.register_link("project/IdeaDig", "person/总包君", "owned_by", "t")
    # 人
    store.register("person", "设计院同事", source="t")
    store.register_link("person/设计院同事", "org/江巷灌区项目群",
                        "member_of", "t")
    store.register("person", "学园运营者", source="t")
    store.register_link("person/学园运营者", "org/总包之声01群",
                        "member_of", "t")
    # 混合：既在主业群也在副业群
    store.register("person", "两栖协作者", source="t")
    store.register_link("person/两栖协作者", "org/江巷灌区项目群",
                        "member_of", "t")
    store.register_link("person/两栖协作者", "org/总包之声01群",
                        "member_of", "t")
    store._conn.commit()


class TestRoleOfProject:
    def test_main_side_personal(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        assert role_of_project(store, "project/江巷灌区信息化") == "main"
        assert role_of_project(store, "project/总包之声") == "side"
        assert role_of_project(store, "project/IdeaDig") == "personal"
        assert role_of_project(store, "project/不存在") is None
        store.close()


class TestEntityRoles:
    def test_group_member_inherits_project_role(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        assert entity_roles(store, "person/设计院同事") == {"main"}
        assert entity_roles(store, "person/学园运营者") == {"side"}

    def test_both_roles_for_amphibian(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        assert entity_roles(store, "person/两栖协作者") == {"main", "side"}

    def test_unknown_person_empty(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        assert entity_roles(store, "person/路人甲") == set()
        store.close()


class TestWorksOnConduction:
    def test_meeting_attendee_gets_main_role(self, tmp_path):
        from paistation.cx.ingest_projects import link_meeting_attendees
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        store.register("person", "会议参与人", aliases=["wo_123"], source="t")
        store._conn.commit()
        created = link_meeting_attendees(store, [{
            "subject": "江巷灌区视频监控方案讨论",
            "attendees": [{"userid": "wo_123", "name": "会议参与人"}],
        }])
        assert created == 1
        assert entity_roles(store, "person/会议参与人") == {"main"}
        store.close()

    def test_side_meeting_attendee(self, tmp_path):
        from paistation.cx.ingest_projects import link_meeting_attendees
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        store.register("person", "大家谈嘉宾", source="t")
        store._conn.commit()
        created = link_meeting_attendees(store, [{
            "subject": "总包大家谈：钟泉 黄细丁，总第 28 期",
            "attendees": [{"userid": "", "name": "大家谈嘉宾"}],
        }])
        assert created == 1
        assert entity_roles(store, "person/大家谈嘉宾") == {"side"}
        store.close()


class TestTagEventRole:
    """时间轴事件 → 角色标签（年终总结等按角色过滤的地基）。"""

    def test_meeting_subject_main(self, tmp_path):
        from paistation.cx.roles import tag_event_role
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        assert tag_event_role(store, "meeting.attend",
                              {"subject": "江巷灌区视频监控方案讨论"}) == "main"
        assert tag_event_role(store, "meeting.attend",
                              {"subject": "总包大家谈 27 期"}) == "side"

    def test_meeting_quick_unknown(self, tmp_path):
        from paistation.cx.roles import tag_event_role
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        assert tag_event_role(store, "meeting.attend",
                              {"subject": "总包君的快速会议"}) is None

    def test_commit_by_repo(self, tmp_path):
        from paistation.cx.roles import tag_event_role
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        store.register("project", "We-AIPO", source="t")
        store.register_link("project/We-AIPO", SIDE_ORG, "operated_by", "t")
        store._conn.commit()
        # repo 名直接对应 project slug
        assert tag_event_role(store, "work.commit",
                              {"repo": "We-AIPO"}) == "side"
        assert tag_event_role(store, "work.commit",
                              {"repo": "IdeaDig"}) == "personal"
        assert tag_event_role(store, "work.commit",
                              {"repo": "无此仓"}) is None

    def test_email_by_sender(self, tmp_path):
        from paistation.cx.roles import tag_event_role
        store = EntityStore(tmp_path / "e.db")
        _seed(store)
        # 期刊社 ←往来→ 论文 project → 黄河院（真实库同构）
        store.register("org", "人民黄河杂志社",
                       aliases=["rmhh2010@163.com"], source="t")
        store.register("project", "论文：知识增强视觉推理", source="t")
        store.register_link("project/论文-知识增强视觉推理", MAIN_ORG,
                            "operated_by", "t")
        store.register_link("org/人民黄河杂志社", "project/论文-知识增强视觉推理",
                            "corresponds_with", "t")
        store._conn.commit()
        assert tag_event_role(store, "email.receive",
                              {"from_email": "rmhh2010@163.com"}) == "main"
        assert tag_event_role(store, "email.receive",
                              {"from_email": "news@random.com"}) is None
