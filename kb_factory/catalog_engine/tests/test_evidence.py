# -*- coding: utf-8 -*-
"""P0 #6 证据锚定一等公民测试——Evidence/anchor_file/validate_evidence/
render_evidence_appendix + build_tree_from_docs 接线。

锚律：无证据链接的节点直接拒收；页码/条款号未知一律 None（零造假）。"""
import json
import os
import sys
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

import pytest

from kb_factory.catalog_engine.evidence import (
    CONF_ANCHORED, CONF_MATCHED, CONF_VERBATIM, SOURCES, Evidence,
    anchor_file, derive_doc_id, evidence_from_doc, extract_std_no,
    render_evidence_appendix, validate_evidence,
)
from kb_factory.catalog_engine.document_engine import (
    DocFile, build_blueprint_document_driven, build_tree_from_docs, classify_doc,
)


def _ev(clause="第5.2.1条", page=12, confidence=CONF_VERBATIM) -> Evidence:
    return Evidence(doc_id="GB/T 50358", source="gb",
                    title="建设项目工程总承包管理规范",
                    page=page, clause=clause, confidence=confidence,
                    url="https://openstd.samr.gov.cn/bzgk/gb/50358")


def _sample_bp(strip_evidence: int = 0) -> dict:
    """最小蓝图：1×L1 / 1×L2 / 3 文件槽；前 strip_evidence 个去掉 evidence。"""
    files = []
    for i, (doc_id, clause) in enumerate([("GB/T 50358", "第5.2.1条"),
                                          ("SL 252", None),
                                          ("《中华人民共和国水法》", None)]):
        f = {"name": f"{doc_id}.pdf", "fmt": "pdf", "real": True,
             "evidence": Evidence(doc_id=doc_id, source="gb" if i < 2 else "local",
                                  title=doc_id, page=12 if clause else None,
                                  clause=clause, confidence=CONF_ANCHORED).to_dict()}
        files.append(f)
    for f in files[:strip_evidence]:
        f.pop("evidence", None)
    return {"domain": "测试域",
            "tree": {"mode": "document_driven", "root": "测试知识库",
                     "l1": [{"code": "D-01", "name": "合规底线",
                             "l2": [{"code": "D-01/01", "name": "法律法规",
                                     "files": files, "file_count": len(files)}]}]}}


# ── Evidence 构造与序列化 ──────────────────────────────────────────────

def test_p0_06_evidence_construct_and_serialize():
    ev = _ev()
    assert ev.doc_id == "GB/T 50358" and ev.source in SOURCES
    assert ev.page == 12 and ev.clause == "第5.2.1条"
    assert ev.confidence == 1.0
    d = ev.to_dict()
    assert d["doc_id"] == "GB/T 50358" and d["clause"] == "第5.2.1条"
    # 序列化可进蓝图 JSON（None 字段如实保留，不造值）
    assert json.loads(json.dumps(d, ensure_ascii=False)) == d
    # 往返一致
    assert Evidence.from_dict(d) == ev


def test_p0_06_evidence_validation_rejects_fabrication():
    with pytest.raises(ValueError):
        Evidence(doc_id="", source="gb")                    # 空标识=无证据
    with pytest.raises(ValueError):
        Evidence(doc_id="x", source="github")               # 来源闭集外
    with pytest.raises(ValueError):
        Evidence(doc_id="x", source="gb", confidence=1.5)   # 置信度越界


# ── anchor_file ────────────────────────────────────────────────────────

def test_p0_06_anchor_file_attaches_evidence():
    slot = {"name": "GB-T 50358规范.pdf", "fmt": "pdf", "real": True}
    out = anchor_file(slot, _ev())
    assert out is slot  # 就地更新并返回
    assert out["evidence"]["doc_id"] == "GB/T 50358"
    assert out["evidence"]["clause"] == "第5.2.1条"


def test_p0_06_anchor_file_extracts_from_real_wenku_slot():
    """real=True 槽未显式传证据 → 从槽内 wenku 元数据提取；页码未知=None。"""
    slot = {"name": "水法.pdf", "real": True, "doc_id": "6000000001",
            "title": "中华人民共和国水法", "source": "wenku",
            "url": "https://wenku.baidu.com/view/abc"}
    out = anchor_file(slot)
    ev = out["evidence"]
    assert ev["doc_id"] == "6000000001" and ev["source"] == "wenku"
    assert ev["confidence"] == CONF_ANCHORED   # URL 可点验
    assert ev["page"] is None and ev["clause"] is None  # 零造假：未实证不填


def test_p0_06_anchor_placeholder_never_fabricates():
    """占位槽（real 缺失）不造证据——交给 validate_evidence 拒收。"""
    slot = {"name": "占位槽.pdf", "fmt": "pdf"}
    out = anchor_file(slot)
    assert "evidence" not in out


# ── validate_evidence ──────────────────────────────────────────────────

def test_p0_06_validate_evidence_all_pass():
    v = validate_evidence(_sample_bp())
    assert v == {"total": 3, "with_evidence": 3, "without_evidence": 0,
                 "evidence_rate": 1.0, "pass": True, "missing": []}


def test_p0_06_validate_evidence_partial_rejects_by_name():
    v = validate_evidence(_sample_bp(strip_evidence=1))
    assert v["pass"] is False                       # 零证据节点拒收
    assert v["total"] == 3 and v["with_evidence"] == 2
    assert v["without_evidence"] == 1
    assert v["evidence_rate"] == round(2 / 3, 4)
    assert v["missing"] == ["GB/T 50358.pdf"]       # 点名缺证据节点


# ── render_evidence_appendix ───────────────────────────────────────────

def test_p0_06_render_appendix_contains_clause_and_page():
    md = render_evidence_appendix(_sample_bp())
    assert md.startswith("# 证据锚点附录")
    assert "D-01 合规底线" in md            # L1 节点
    assert "D-01/01 法律法规" in md         # L2 节点
    assert "第5.2.1条" in md                # 条款号
    assert "| 12 |" in md or "12" in md     # 页码
    assert "未定位" in md                   # 未知页码/条款如实标注
    assert "GB/T 50358" in md               # doc_id


# ── build_tree_from_docs 接线 ──────────────────────────────────────────

def _real_docs() -> list[DocFile]:
    docs = [
        DocFile(title="GB/T 50358 建设项目工程总承包管理规范", source="wenku",
                url="https://wenku.baidu.com/view/1", doc_id="6000000001"),
        DocFile(title="SL 252 水利水电工程等级划分及洪水标准", source="wenku",
                url="https://wenku.baidu.com/view/2"),
        DocFile(title="《中华人民共和国水法》", source="local"),
    ]
    for d in docs:
        d.doc_type = classify_doc(d.title)
    return docs


def test_p0_06_build_tree_attaches_evidence_to_every_slot():
    tree = build_tree_from_docs(_real_docs(), "水利水电")
    files = [f for l1 in tree for l2 in l1["l2"] for f in l2["files"]]
    assert files, "建树无文件"
    for f in files:
        ev = f.get("evidence")
        assert ev and ev["doc_id"] and ev["source"] in SOURCES, f"{f['name']} 缺证据"
        assert ev["page"] is None and ev["clause"] is None  # 未实证不填（零造假）


def test_p0_06_document_driven_blueprint_passes_evidence_gate():
    docs = _real_docs()
    bp = build_blueprint_document_driven(
        {"domain": "水利水电知识库", "keywords": ["EPC"], "intent": "技术",
         "size_hint": "small"}, docs)
    v = validate_evidence(bp)
    assert v["pass"] is True, f"零证据节点被放行: {v}"
    assert v["evidence_rate"] == 1.0
    md = render_evidence_appendix(bp)
    assert "6000000001" in md                    # 显式 wenku docID 优先于标准号回退
    assert "SL 252" in md                        # 无显式 id → 标准号兜底
    assert "第5.2.1条" not in md                  # 有锚无条款（未实证不填）


def test_p0_06_derive_doc_id_fallback_chain():
    assert extract_std_no("SL 252 水利水电工程等级划分及洪水标准") == "SL 252"
    assert extract_std_no("GB/T 50358 建设项目工程总承包管理规范") == "GB/T 50358"
    # 无标准号 → 标题净名兜底；显式 doc_id 最优先
    assert derive_doc_id(title="《中华人民共和国水法》") == "《中华人民共和国水法》"
    assert derive_doc_id(doc_id="6001", title="随便") == "6001"
    with pytest.raises(ValueError):
        derive_doc_id()                      # 全空拒绝造标识


def test_p0_06_evidence_from_doc_confidence_scale():
    wenku_url = evidence_from_doc(_real_docs()[0])
    assert wenku_url.confidence == CONF_ANCHORED            # URL 可点验 0.9
    local = evidence_from_doc(_real_docs()[2])
    assert local.source == "local" and local.confidence == CONF_ANCHORED
    bare = DocFile(title="SL 252 水利水电工程等级划分及洪水标准", source="wenku")
    assert evidence_from_doc(bare).confidence == CONF_MATCHED  # 无 URL 0.7
    assert evidence_from_doc(bare).doc_id == "SL 252"           # 标准号兜底


if __name__ == "__main__":
    for fn in [test_p0_06_evidence_construct_and_serialize,
               test_p0_06_evidence_validation_rejects_fabrication,
               test_p0_06_anchor_file_attaches_evidence,
               test_p0_06_anchor_file_extracts_from_real_wenku_slot,
               test_p0_06_anchor_placeholder_never_fabricates,
               test_p0_06_validate_evidence_all_pass,
               test_p0_06_validate_evidence_partial_rejects_by_name,
               test_p0_06_render_appendix_contains_clause_and_page,
               test_p0_06_build_tree_attaches_evidence_to_every_slot,
               test_p0_06_document_driven_blueprint_passes_evidence_gate,
               test_p0_06_derive_doc_id_fallback_chain,
               test_p0_06_evidence_from_doc_confidence_scale]:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
