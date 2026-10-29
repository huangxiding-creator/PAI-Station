# -*- coding: utf-8 -*-
"""P1 #9 声明式可复现契约测试——生成蓝图→生成契约→verify_reproducibility→identical=True；
合成领域回归（不烧真实 API）；篡改必被检出（misplaced/规则/结构三维）。"""
import copy
import json
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

import pytest

from kb_factory.catalog_engine.document_engine import (
    DocFile, classify_doc, build_blueprint_document_driven,
)
from kb_factory.catalog_engine.contract import (
    MappingContract, generate_contract, save_contract, load_contract,
    verify_reproducibility, generate_synthetic_domain,
)


def _build(name: str, n: int = 50):
    """完整链：合成文档 → 蓝图 → 契约（generate 内部已自检可复现）。"""
    docs = generate_synthetic_domain(name, n)
    bp = build_blueprint_document_driven(
        {"domain": name, "keywords": [name, "EPC"], "intent": f"{name}知识库"}, docs)
    contract = generate_contract(bp, docs)
    return docs, bp, contract


def test_p1_9_contract_reproducible_roundtrip():
    docs, bp, contract = _build("水利水电", 50)
    assert contract.engine_version
    assert len(contract.input_hash) == 64 and len(contract.schema_hash) == 64
    # 契约字段齐全，规则为声明式三元组（condition/action/target）
    assert contract.rules, "规则不得为空"
    for r in contract.rules:
        assert set(("condition", "action", "target")) <= set(r)
    assert any(r["action"] == "assign_to" for r in contract.rules)
    assert any(r["action"] == "place_under" for r in contract.rules)
    # 核心：同文档+同映射=同KB
    result = verify_reproducibility(bp, contract)
    assert result == {"identical": True, "diff_count": 0, "diff_details": []}


def test_p1_9_synthetic_domain_regression():
    # 合成领域确定性：同 name+同 n_docs 必产同列表
    a = generate_synthetic_domain("水利水电", 50)
    b = generate_synthetic_domain("水利水电", 50)
    assert [d.__dict__ for d in a] == [d.__dict__ for d in b]
    # 多类型覆盖（法规/标准/案例/工具书等 ≥6 类）
    types = {classify_doc(d.title) for d in a}
    assert len(types) >= 6, f"合成领域类型覆盖不足: {types}"
    # 奇数规模第二领域回归（非模板周期整倍数）
    docs, bp, contract = _build("法律实务", 37)
    assert verify_reproducibility(bp, contract)["identical"] is True
    # 蓝图内每件文件分类 == 引擎真值（契约规则面完整）
    for d in docs:
        assert d.doc_type == classify_doc(d.title)


def test_p1_9_save_load_yaml_roundtrip(tmp_path):
    _, bp, contract = _build("水利水电", 50)
    path = save_contract(contract, str(tmp_path / "mapping_contract.yaml"))
    assert path.endswith(".yaml")
    # YAML 兼容=JSON 语法（JSON 是合法 YAML 1.2 子集，零依赖）
    raw = json.loads(open(path, encoding="utf-8").read())
    assert set(raw) == {"engine_version", "input_hash", "schema_hash", "rules", "created_at"}
    loaded = load_contract(path)
    assert isinstance(loaded, MappingContract)
    assert loaded == contract


def test_p1_9_determinism_hashes_and_rules():
    d1, bp1, c1 = _build("水利水电", 50)
    d2, bp2, c2 = _build("水利水电", 50)
    assert c1.input_hash == c2.input_hash
    assert c1.schema_hash == c2.schema_hash
    assert c1.rules == c2.rules
    # 不同领域输入哈希必不同
    _, _, c3 = _build("教育教学", 50)
    assert c3.input_hash != c1.input_hash


def test_p1_9_detects_misplaced_file():
    _, bp, contract = _build("水利水电", 50)
    bad = copy.deepcopy(bp)
    # 把首个分组的最后一件文件挪进同层另一分组（不动 file_count，纯落位篡改）
    moved = None
    for l1 in bad["tree"]["l1"]:
        if len(l1["l2"]) >= 2:
            moved = l1["l2"][0]["files"].pop()
            l1["l2"][1]["files"].append(moved)
            break
    assert moved, "合成领域应存在多分组层"
    result = verify_reproducibility(bad, contract)
    assert result["identical"] is False
    assert result["diff_count"] >= 1
    assert any(d["kind"] == "misplaced" and d["file"] == moved["name"]
               for d in result["diff_details"])


def test_p1_9_detects_rule_tamper():
    _, bp, contract = _build("水利水电", 50)
    bad = copy.deepcopy(contract)
    bad.rules[0]["target"] = "篡改层"
    result = verify_reproducibility(bp, bad)
    assert result["identical"] is False and result["diff_count"] >= 1


def test_p1_9_detects_schema_tamper():
    _, bp, contract = _build("水利水电", 50)
    bad = copy.deepcopy(bp)
    bad["tree"]["l1"][0]["name"] += "改名"
    result = verify_reproducibility(bad, contract)
    assert result["identical"] is False
    assert any(d["kind"] == "schema_hash_mismatch" for d in result["diff_details"])


def test_p1_9_generate_refuses_unreproducible_blueprint():
    docs, bp, _ = _build("水利水电", 50)
    bad = copy.deepcopy(bp)
    for l1 in bad["tree"]["l1"]:
        if len(l1["l2"]) >= 2:
            l1["l2"][1]["files"].append(l1["l2"][0]["files"].pop())
            break
    with pytest.raises(ValueError):
        generate_contract(bad, docs)
