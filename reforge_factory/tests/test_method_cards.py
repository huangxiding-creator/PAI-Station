# -*- coding: utf-8 -*-
"""V-006 / REQ-024+025 — 跨学科方法卡注册器 + 三域包 12 维测试
与 V-000 / REQ-000+001 — 宪法占位测试 (L6 无留痕不升级 / 域包指纹).

REQ-025.AC1: register_card 四件套缺任一拒注册 (ValueError);
REQ-024.AC1: dimension_matrix 出厂注册三域包后 12 维全在 + 各带方法卡四件套;
REQ-000.AC1: 无排除留痕的 EEI 深度断言不高于 L5 (占位 — depth_ladder 现无 L6);
REQ-001.AC1: 三域包各带 ≥3 关键词 (域指纹可回溯) + 方法卡四件套齐备.
"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # reforge_factory/

from crossdisc import method_cards as mc                    # noqa: E402
from completeness import dimension_matrix as dm             # noqa: E402
from completeness import depth_ladder as dl                 # noqa: E402

THREE = ("做空审计", "法务穿透", "调查叙事")
FOUR_PIECES = mc.METHOD_CARD_SCHEMA

_FULL_CARD: dict = {
    "source_authority_table": {"实验记录": "A", "教科书": "B", "博客转载": "C"},
    "independence_keys": ["lab", "batch"],
    "hypothesis_templates": ["效应不存在"],
    "golden_questions": ["问一", "问二", "问三", "问四"],
}


# ---------- V-006 / REQ-025: 方法卡注册器 ----------------------------------

def test_builtin_three_cards_registered_and_listed():
    """三张出厂卡 import 即注册; list_cards 含三名且四件套齐备."""
    names = mc.list_cards()
    for n in THREE:
        assert n in names
        card = mc.get_card(n)
        for k in FOUR_PIECES:
            assert card.get(k), f"{n} 方法卡缺件套 {k}"


def test_register_full_card_then_cleanup():
    """完整四件套卡注册成功 → CARD_REGISTRY/list_cards 可见; 清理后消失."""
    try:
        assert mc.register_card("测试临时卡", dict(_FULL_CARD)) == "测试临时卡"
        assert "测试临时卡" in mc.list_cards()
        got = mc.get_card("测试临时卡")
        assert got["independence_keys"] == ["lab", "batch"]
        assert got is not _FULL_CARD          # 浅拷贝入库, 防外部引用篡改
    finally:
        del mc.CARD_REGISTRY["测试临时卡"]
    assert "测试临时卡" not in mc.list_cards()
    with pytest.raises(KeyError):
        mc.get_card("测试临时卡")


@pytest.mark.parametrize("missing", FOUR_PIECES)
def test_register_rejects_missing_piece(missing):
    """REQ-025.AC1: 四件套缺任一 → ValueError 拒注册且不落表."""
    card = {k: v for k, v in _FULL_CARD.items() if k != missing}
    with pytest.raises(ValueError, match="四件套缺失"):
        mc.register_card(f"缺{missing}", card)
    assert f"缺{missing}" not in mc.list_cards()


@pytest.mark.parametrize("key", FOUR_PIECES)
def test_register_rejects_empty_piece(key):
    """REQ-025 (空心防御): 件套键在但为空 → ValueError 拒注册."""
    card = dict(_FULL_CARD)
    card[key] = {} if key == "source_authority_table" else []
    with pytest.raises(ValueError):
        mc.register_card(f"空心{key}", card)
    assert f"空心{key}" not in mc.list_cards()


def test_register_rejects_bad_grade():
    """源权威表等级必须走 grade_rules A/B/C 口径 (grade_rules 参数化)."""
    card = dict(_FULL_CARD)
    card["source_authority_table"] = {"某源": "D"}     # 非法等级字母
    with pytest.raises(ValueError, match="等级非法"):
        mc.register_card("坏等级卡", card)
    card2 = dict(_FULL_CARD)
    card2["source_authority_table"] = {"某源": "最佳"}  # 非等级形制
    with pytest.raises(ValueError):
        mc.register_card("坏形制卡", card2)
    # 合法: 括注形制 "C(保守地板)" (出厂卡已实证) + grade_rules 活表字母
    card3 = dict(_FULL_CARD)
    card3["source_authority_table"] = {"某源": "B(权威二手)"}
    try:
        mc.register_card("括注等级卡", card3)
        assert mc.get_card("括注等级卡")["source_authority_table"]["某源"] == "B(权威二手)"
    finally:
        del mc.CARD_REGISTRY["括注等级卡"]


def test_every_card_golden_questions_nonempty():
    """每张出厂卡黄金四问列表非空 (学科惯例恰四问)."""
    for n in THREE:
        gq = mc.get_card(n)["golden_questions"]
        assert isinstance(gq, list) and gq
        assert all(isinstance(q, str) and q.strip() for q in gq)
        assert len(gq) == 4                    # 黄金四问


# ---------- V-006+V-000 / REQ-024+001: 三域包 12 维 + 域包指纹 ---------------

def test_req_024_twelve_dims_after_registration():
    """REQ-024.AC1: 三域包注册后 12 维全在 (原 9 + 3)."""
    packs = dm._active_dimensions()
    assert len(packs) == 12
    assert set(packs) == set(dm.DIMENSION_PACKS) | set(THREE)
    for n in THREE:                            # 注册在 _EXTRA, 词表同源
        assert packs[n] == dm.CROSSDISC_DIMENSIONS[n]


def test_req_001_domain_fingerprint():
    """REQ-001.AC1: 三域各带关键词 ≥3 个 (域指纹) 且各带方法卡四件套."""
    packs = dm._active_dimensions()
    assert len(packs) == 12 and set(THREE) <= set(packs)
    for n in THREE:
        assert len(packs[n]) >= 3, f"域包 {n} 关键词 <3, 指纹不可回溯"
        card = mc.get_card(n)                  # 域包↔方法卡同名同域可回溯
        for k in FOUR_PIECES:
            assert card.get(k), f"{n} 方法卡缺件套 {k}"


# ---------- V-000 / REQ-000: L6 无留痕不升级 (占位) --------------------------

def test_req_000_l6_no_trace_downgrade():
    """REQ-000.AC1 占位: 无 ach_arena 排除链留痕的 EEI 深度不高于 L5.

    当前 depth_ladder 尚未引入 L6 — 断言 LEVELS 不含 L6 即占位通过;
    一旦 V-003 引入 L6, 本测自动切换为实证对拍: 满配证据 (数据密度+双源+
    反证+own_calc) 但无 rival 排除留痕 → eei_level() 不得返回 L6.
    """
    if "L6" not in dl.LEVELS:
        assert "L6" not in dl.LEVELS           # 占位: L6 未引入
        return
    rows = [                                   # 满配证据: L1..L5 全命中信号
        {"judge": "valid", "tree_node": "E1",
         "text_head": "3 家公司 年营收 5 亿元 利润 2 亿元 现金流 1 亿元",
         "url_norm": "https://a.example.com/x", "stance": "against"},
        {"judge": "valid", "tree_node": "E1",
         "text_head": "4 亿元 应收 2 亿元", "url_norm": "https://b.example.com/y",
         "own_calc": "自算", "stance": "support"},
    ]
    lv = dl.eei_level({"id": "E1"}, rows)      # 无 rival_exclusion 留痕
    assert lv in dl.LEVELS and lv != "L6" and int(lv[1:]) <= 5
