# -*- coding: utf-8 -*-
"""THUOCL 词表 loader 测试（六库种子 v2.6 #1，波1）
判据对应：
tc1 词量门：11 领域词总数实测 ≥ 5 万（零造假，实测为准）
tc2 映射覆盖：11 领域 100% 有映射，且目标 100% 落在六库 49 分组内
tc3 loader 幂等：两次调用结果全等，域内无重复词
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from catalog_engine import thuocl_lex
from catalog_engine.taxonomy import SIX_DOMAINS


def _groups49():
    return {g for v in SIX_DOMAINS for g in v["groups"]}


def test_total_word_count_ge_50k():
    lex = thuocl_lex.load_thuocl()
    total = sum(len(ws) for ws in lex.values())
    assert total >= 50000, f"词总数实测 {total} < 50000"


def test_domain_alignment_11():
    lex = thuocl_lex.load_thuocl()
    assert set(lex) == set(thuocl_lex.DOMAIN_CN)
    assert set(thuocl_lex.DOMAIN_CN) == set(thuocl_lex.DOMAIN_GROUP_MAP)
    assert len(lex) == 11


def test_group_map_valid_in_49_groups_100pct():
    groups49 = _groups49()
    assert len(groups49) == 49
    targets = [g for gs in thuocl_lex.DOMAIN_GROUP_MAP.values() for g in gs]
    bad = [g for g in targets if g not in groups49]
    assert not bad, f"映射目标不在49分组: {bad}"
    for dom, gs in thuocl_lex.DOMAIN_GROUP_MAP.items():
        assert gs, f"{dom} 无映射"


def test_loader_idempotent():
    a = thuocl_lex.load_thuocl()
    b = thuocl_lex.load_thuocl()
    assert a == b
    for dom, ws in a.items():
        assert len(dict(ws)) == len(ws), f"{dom} 域内有重复词"


def test_df_positive_and_desc():
    lex = thuocl_lex.load_thuocl()
    for dom, ws in lex.items():
        assert ws, f"{dom} 词表为空"
        dfs = [d for _, d in ws]
        assert all(isinstance(d, int) and d > 0 for d in dfs), dom
        assert dfs == sorted(dfs, reverse=True), f"{dom} df 未降序"


def test_word_df_index_lookup():
    lex = thuocl_lex.load_thuocl()
    idx = thuocl_lex.word_df_index(lex)
    dom, ws = next(iter(lex.items()))
    probe_w = ws[0][0]
    assert probe_w in idx and dom in idx[probe_w] and idx[probe_w][dom] == ws[0][1]
    assert thuocl_lex.total_word_count(lex) == sum(len(v) for v in lex.values())
