# -*- coding: utf-8 -*-
"""文件驱动引擎测试——真实检索+目录提炼+超越层。"""
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

from kb_factory.catalog_engine.document_engine import (
    DocFile, classify_doc, extract_domain, build_tree_from_docs, build_blueprint_document_driven,
)


def _fake_docs(domain: str, n: int = 30) -> list[DocFile]:
    """造一组模拟真实检索结果（覆盖多类型）。"""
    templates = [
        ("GB/T 50358 建设项目工程总承包管理规范", "国家标准"),
        ("SL 252 水利水电工程等级划分及洪水标准", "行业标准"),
        ("GB 50500 建设工程工程量清单计价规范", "国家标准"),
        ("《中华人民共和国水法》", "法律法规"),
        ("《建设工程质量管理条例》", "法律法规"),
        ("《水利工程建设项目验收管理规定》", "法律法规"),
        ("水利水电工程施工组织设计规范 SL 303", "技术规范"),
        ("EPC工程总承包项目管理指南", "技术规范"),
        ("水利工程施工案例分析", "案例实务"),
        ("工程总承包合同范本", "模板范本"),
        ("水利水电工程手册", "工具书"),
        ("安全生产培训教程", "培训教材"),
    ]
    docs = []
    for i in range(n):
        t, dt = templates[i % len(templates)]
        docs.append(DocFile(title=f"{t}（第{i//len(templates)+1}版）" if i >= len(templates) else t,
                            source="wenku", fmt="pdf", pages=50+i, badge="green_free", perm="green"))
    return docs


def test_extract_domain_water():
    d = extract_domain("水利EPC项目团队建一个施工知识库")
    assert d["matched"] and d["domain"] == "水利水电"
    assert any("水法" in k for k in d["law_keywords"])


def test_classify_doc():
    assert classify_doc("GB/T 50358 建设项目工程总承包管理规范") == "国家标准"
    assert classify_doc("SL 252 水利水电工程等级划分及洪水标准") == "行业标准"
    assert classify_doc("《中华人民共和国建筑法》") == "法律法规"
    assert classify_doc("水利水电工程施工组织设计规范") == "技术规范"
    assert classify_doc("水利工程施工案例分析") == "案例实务"


def test_build_tree_real_docs():
    docs = _fake_docs("水利水电", 30)
    for d in docs:
        d.doc_type = classify_doc(d.title)
    tree = build_tree_from_docs(docs, "水利水电")

    # 超越层应在
    layer_names = [l1["name"] for l1 in tree]
    assert "合规底线" in layer_names, f"缺合规底线: {layer_names}"
    assert "技术标准" in layer_names, f"缺技术标准: {layer_names}"

    # L1 ≤ 4（超越层数量）
    assert len(tree) <= 4, f"L1 超限: {len(tree)}"

    # L3 应含真实文件（real=True）
    all_files = [f for l1 in tree for l2 in l1["l2"] for f in l2["files"]]
    assert len(all_files) >= 20, f"文件太少: {len(all_files)}"
    assert all(f.get("real") for f in all_files), "存在非真实文件"
    # 文件名应含标准号或法规名（非占位格式）
    assert any("GB" in f["name"] or "SL" in f["name"] or "法" in f["name"]
               for f in all_files), "缺少标准号/法规名文件"


def test_blueprint_output_schema():
    docs = _fake_docs("水利水电", 30)
    bp = build_blueprint_document_driven(
        {"domain": "水利水电知识库", "keywords": ["EPC", "施工"], "intent": "技术管理",
         "size_hint": "small"}, docs)

    # 顶层键
    assert all(k in bp for k in ("domain", "need", "tree", "ratio", "stats", "quote", "provenance"))
    # 树结构
    assert bp["tree"]["mode"] == "document_driven"
    assert len(bp["tree"]["l1"]) > 0
    # 统计
    assert bp["stats"]["files"] > 0
    assert bp["stats"]["real_docs"] > 0
    assert bp["stats"]["gb"] > 0
    # 报价
    assert bp["quote"]["total"] == round(29 + bp["stats"]["gb"] * 2, 1)
    # 来源
    assert "wenku" in bp["provenance"]["sources"]


def test_mode_fallback():
    """强制 taxonomy 模式仍可用（v1 兼容）。"""
    from kb_factory.catalog_engine.engine import build_blueprint
    bp = build_blueprint({"domain": "测试域", "keywords": ["测试"],
                          "intent": "测试", "size_hint": "small"}, mode="taxonomy")
    assert bp["tree"]["mode"] in ("six_domains", "clc"), f"taxonomy 模式不通: {bp['tree']['mode']}"


if __name__ == "__main__":
    for fn in [test_extract_domain_water, test_classify_doc, test_build_tree_real_docs,
               test_blueprint_output_schema, test_mode_fallback]:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
