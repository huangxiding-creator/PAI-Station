# -*- coding: utf-8 -*-
"""域1 非代码项目实体化：群名→业务线、会议主题→项目、白龟湖目录→项目。"""

from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_projects import (  # noqa: E402
    calibrate_attributions,
    classify_group_project,
    extract_meeting_projects,
    register_group_projects,
    register_meeting_projects,
)


class TestClassifyGroupProject:
    """群名 → 业务线 project 名（子串匹配，emoji/编号容忍）。"""

    def test_zongbaozhisheng(self):
        assert classify_group_project("总包之声01群") == "总包之声"

    def test_zongbaozhisheng_coop(self):
        # 联营群名都带 ×总包之声，归同一条业务线
        assert classify_group_project("红律说法×总包之声06") == "总包之声"
        assert classify_group_project("*造价人家园+总包之声01") == "总包之声"

    def test_xueyuan_with_emoji_prefix(self):
        assert classify_group_project("🔥🔥总包学园15群") == "总包学园"

    def test_shalong_city(self):
        assert classify_group_project("总包沙龙-成都") == "总包沙龙"

    def test_reading_club(self):
        assert classify_group_project("总包读书会VIP") == "总包读书会"

    def test_qianwen_ai(self):
        assert classify_group_project("总包千问AI-2群") == "总包千问AI"

    def test_ecosystem(self):
        assert classify_group_project("总包生态圈投资人") == "总包生态圈"

    def test_shizhan(self):
        assert classify_group_project("项目总包实战交流②群") == "项目总包实战交流"

    def test_unrelated_returns_none(self):
        assert classify_group_project("家庭群") is None

    def test_owner_ego_group_not_matched(self):
        # 克制：总包君个人/refly 群不归属任何业务线
        assert classify_group_project("总包君-refly") is None


class TestExtractMeetingProjects:
    """会议主题 → (kind, name) 列表。"""

    def test_jiangxiang(self):
        assert extract_meeting_projects("江巷灌区视频监控方案讨论") == [
            ("project", "江巷灌区信息化")]

    def test_dajiatan(self):
        assert extract_meeting_projects("总包大家谈：钟泉 黄细丁，总第 28 期") == [
            ("project", "总包大家谈")]

    def test_epc_training(self):
        assert extract_meeting_projects("EPC总裁培训班策划会") == [
            ("project", "EPC总裁培训班")]

    def test_ai_topics(self):
        got = extract_meeting_projects(
            "AI开放麦：聊工程豹、工程大脑、水利安全AI眼镜如何做出来的？")
        assert ("topic", "工程豹") in got
        assert ("topic", "工程大脑") in got
        assert ("topic", "水利安全AI眼镜") in got

    def test_quick_meeting_skipped(self):
        assert extract_meeting_projects("总包君的快速会议") == []
        assert extract_meeting_projects("刘君预定的会议") == []

    def test_ecosystem_strategy(self):
        assert extract_meeting_projects("总包生态圈战略研讨会202607") == [
            ("project", "总包生态圈")]


class TestRegisterProjects:
    """登记 project 实体 + part_of/operated_by 边（幂等）。"""

    def test_group_project_edges(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        store.register("org", "总包之声01群", aliases=["22595941714@chatroom"],
                       source="wechat_group")
        created = register_group_projects(store)
        assert created >= 1
        assert store._conn.execute(
            "SELECT 1 FROM entities WHERE entity_id='project/总包之声'"
        ).fetchone()
        # 群 → 业务线 part_of 边
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='org/总包之声01群' "
            "AND to_id='project/总包之声' AND relation='part_of'"
        ).fetchone()
        # 业务线 → 公司 operated_by（副业归属）
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='project/总包之声' "
            "AND to_id LIKE 'org/总包说%' AND relation='operated_by'"
        ).fetchone()
        # 幂等：再跑 created==0
        assert register_group_projects(store) == 0
        store.close()

    def test_meeting_project_edges(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        register_meeting_projects(
            store, ["江巷灌区视频监控方案讨论", "总包大家谈 27 期"])
        # 江巷灌区 → 黄河设计院（主业归属）
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='project/江巷灌区信息化' "
            "AND to_id='org/黄河勘测规划设计研究院' AND relation='operated_by'"
        ).fetchone()
        store.close()


class TestCalibrateAttributions:
    """落款/内容证据归属校准（cx_search 全盘扫描实证 2026-09-16）。"""

    def test_topics_attributed(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        added = calibrate_attributions(store)
        assert added >= 3
        # 工程豹=总包千问公众号改名 → 副业
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='topic/工程豹' "
            "AND to_id LIKE 'org/总包说%' AND relation='operated_by'"
        ).fetchone()
        # 水利安全AI眼镜 → 主业（owner_statement 口径不变）
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='topic/水利安全AI眼镜' "
            "AND to_id='org/黄河勘测规划设计研究院' AND relation='operated_by'"
        ).fetchone()

    def test_git_project_researchfactory_side(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        calibrate_attributions(store)
        assert store._conn.execute(
            "SELECT 1 FROM entity_links WHERE from_id='project/ResearchFactory-Eng' "
            "AND to_id LIKE 'org/总包说%' AND relation='operated_by'"
        ).fetchone()

    def test_idempotent(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        calibrate_attributions(store)
        assert calibrate_attributions(store) == 0
        store.close()
