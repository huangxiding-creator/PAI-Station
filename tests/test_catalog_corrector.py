"""P1 #3 框架级自纠环（kb_factory/catalog_engine/corrector.py）测试。

缺陷蓝图（空节点 + 低覆盖 + 冗余 + 同类分裂）→ self_correct → overall 提升。
"""
import copy

import pytest

from kb_factory.catalog_engine.corrector import (
    CritiqueResult,
    critique,
    repair,
    self_correct,
)


def _flawed_bp():
    """缺陷蓝图：2 个空 L2 节点 + 大坝文档被拆进 2 个 L2（冗余/不一致）。"""
    return {
        "name": "水利工程知识库",
        "children": [
            {
                "name": "水工建筑物",
                "children": [
                    {"name": "大坝工程", "keywords": ["大坝"]},
                    {"name": "厂房工程", "keywords": ["厂房"]},  # 空节点
                ],
            },
            {
                "name": "施工技术",
                "children": [
                    {"name": "大坝监测", "keywords": ["大坝", "监测"]},  # 与大坝工程冗余
                    {"name": "地下工程", "keywords": ["地下"]},  # 空节点
                ],
            },
            {
                "name": "地质与边坡",
                "children": [
                    {"name": "边坡工程", "keywords": ["边坡"]},
                ],
            },
        ],
    }


def _documents():
    """文档集：大坝×3 / 隧洞×3（蓝图无对应节点→低覆盖）/ 边坡×2 / 散件×1（str 形态）。"""
    return [
        {"name": "大坝安全监测技术规范.pdf", "type": "大坝"},
        {"name": "大坝混凝土施工手册.docx", "type": "大坝"},
        {"name": "大坝安全监测实施细则.pdf", "type": "大坝"},
        {"name": "隧洞掘进施工指南.pdf", "type": "隧洞"},
        {"name": "隧洞支护设计标准.pdf", "type": "隧洞"},
        {"name": "隧洞衬砌质量验收.pdf", "type": "隧洞"},
        {"name": "边坡稳定分析报告.pdf", "type": "边坡"},
        {"name": "边坡治理工程案例.docx", "type": "边坡"},
        "引水渠衬砌施工方案.pdf",
    ]


def _l2_names(bp):
    return [l2["name"] for l1 in bp.get("children", []) for l2 in l1.get("children", [])]


def test_p1_003_critique_detects_defects():
    c = critique(_flawed_bp(), _documents())
    assert isinstance(c, CritiqueResult)
    assert c.coverage == pytest.approx(5 / 9)  # 隧洞×3 + 散件未归入
    assert c.empty_nodes == 2  # 厂房工程 / 地下工程
    assert c.redundancy == pytest.approx(3 / 9)  # 大坝×3 同时落两个 L2
    assert c.consistency < 1.0  # 大坝同类被拆到 大坝工程/大坝监测
    assert c.overall < 0.8  # 不达标 → 触发自纠
    assert c.issues  # 有具体问题描述
    assert any("空" in s for s in c.issues)
    assert any("覆盖" in s for s in c.issues)


def test_p1_003_repair_drops_empty_merges_redundant_extends_coverage():
    bp = _flawed_bp()
    frozen = copy.deepcopy(bp)
    c = critique(bp, _documents())
    fixed = repair(bp, c, _documents())
    assert bp == frozen  # 不就地改入参

    names = _l2_names(fixed)
    assert "厂房工程" not in names and "地下工程" not in names  # 空节点删除
    assert "大坝监测" not in names  # 冗余节点被合并
    dam = next(l2 for l1 in fixed["children"] for l2 in l1["children"]
               if l2["name"] == "大坝工程")
    assert "大坝监测" in dam.get("cross_refs", [])  # 重复处留交叉引用
    assert "监测" in dam["keywords"]  # 合并后关键词并集

    after = critique(fixed, _documents())
    assert after.coverage == pytest.approx(1.0)  # 未分类文档获得新 L2
    assert after.empty_nodes == 0


def test_p1_003_self_correct_improves_overall():
    bp = _flawed_bp()
    final, history = self_correct(bp, _documents(), max_iterations=3)

    assert len(history) >= 2  # 至少经历一轮修复
    assert history[0].overall < 0.8
    assert history[-1].overall > history[0].overall  # 自纠提升
    assert history[-1].overall > 0.8  # 达标收敛
    assert history[-1].empty_nodes == 0
    assert history[-1].coverage == pytest.approx(1.0)
    # 末轮体检与返回蓝图一致
    assert critique(final, _documents()).overall == pytest.approx(history[-1].overall)
    # 入参蓝图未被就地修改
    assert bp == _flawed_bp()


def test_p1_003_good_blueprint_single_pass():
    bp = {
        "children": [
            {"name": "水工建筑物", "children": [
                {"name": "大坝工程", "keywords": ["大坝"]},
                {"name": "隧洞工程", "keywords": ["隧洞"]},
                {"name": "边坡工程", "keywords": ["边坡"]},
            ]},
            {"name": "施工技术", "children": [
                {"name": "混凝土施工", "keywords": ["混凝土", "施工方案"]},
            ]},
        ],
    }
    final, history = self_correct(bp, _documents())
    assert len(history) == 1  # 首轮即达标，无需修复
    assert history[0].overall > 0.8


def test_p1_003_empty_corpus_conventions():
    c = critique(_flawed_bp(), [])
    assert c.coverage == 1.0  # 无文档=空覆盖不扣分
    assert c.consistency == 1.0
    assert c.redundancy == 0.0
    assert c.empty_nodes == 5  # 全部节点皆空
    assert c.overall < 1.0  # 空节点仍被扣分
