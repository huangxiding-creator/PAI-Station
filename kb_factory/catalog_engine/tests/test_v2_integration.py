# -*- coding: utf-8 -*-
"""v2 全链集成测试——9 个 v2 模块串成完整产线，钉死模块间接缝。

链（任务令 1022）：
  doc_search(真网/合成) → structure_miner.extract_domain_seeds →
  document_engine.build_blueprint_document_driven → evidence.validate_evidence →
  lint.lint_blueprint → corrector.self_correct →
  contract.generate_contract + verify_reproducibility →
  multistore.build_multistore → ascode.export_as_code

本测试钉死的模块间接缝（兼容事实，改动前先读）：
1. corrector 文档入参 duck-typed：DocFile 对象与 dict 均可进自纠环
   （原版只认 dict，v2 全链 DocFile 直入会 AttributeError——已修）。
2. corrector 蓝图形状是 children/children，与 canonical tree.l1/l2 并行：
   self_correct 深拷贝后只增删 bp["children"] 骨架，绝不触碰 bp["tree"]——
   本测试断言 tree 内容零变（文件槽/证据原样保留）。
3. ascode 蓝图形状是 DITA topics（bp.topics），本测试 _topics_view() 从
   tree.l1/l2 视图换算（L2 → topic，doc_type → 六类型）。
4. multistore 路由依赖 doc_type 已分型；build_blueprint_document_driven 会
   就地分型，故 multistore 必须在其后调用（本链序已满足）。
"""
import os
import sys
import tempfile
import time
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

from kb_factory.catalog_engine import (
    ascode, contract, corrector, document_engine, evidence, lint,
    multistore, structure_miner,
)

# 水利EPC 需求（extract_domain 命中「水利|水电」模式 → 领域=水利水电）
_WATER_NEED = {
    "domain": "水利水电工程总承包",
    "keywords": ["水利", "水电", "EPC", "总承包"],
    "intent": "施工合规、技术标准与操作实务知识库",
}

# L2 文档类型 → ascode 六类型（标准/法规/案例/方法/模板/参考）
_DOC_TYPE_TO_TOPIC = {
    "法律法规": "regulation",
    "国家标准": "standard",
    "行业标准": "standard",
    "国际标准": "standard",
    "技术规范": "standard",
    "案例实务": "case",
    "培训教材": "method",
    "模板范本": "template",
    "工具书": "reference",
    "其他": "reference",
}


def _topics_view(bp: dict) -> dict:
    """canonical 蓝图（tree.l1/l2）→ ascode DITA 视图（domain + topics）。

    L2 → topic；title=L2 名、parent=L1 名、description=theme。
    """
    topics = []
    for l1 in bp.get("tree", {}).get("l1", []):
        for l2 in l1.get("l2", []):
            topics.append({
                "type": _DOC_TYPE_TO_TOPIC.get(l2.get("name"), "reference"),
                "title": l2.get("name", ""),
                "parent": l1.get("name", ""),
                "description": str(l2.get("theme", "")),
                "source": "document_driven",
            })
    return {"domain": bp.get("domain", ""), "topics": topics}


def _run_chain(docs: list, need: dict) -> dict:
    """共用全链：S2 种子 → S9 即代码；返回各步产物供断言。"""
    out = {"docs": docs}

    # S2 结构种子
    out["seeds"] = structure_miner.extract_domain_seeds(docs)

    # S3 文件驱动蓝图
    out["bp"] = document_engine.build_blueprint_document_driven(need, docs)

    # S4 证据锚定验收
    out["evidence"] = evidence.validate_evidence(out["bp"])

    # S5 lint 反模式门
    out["lint"] = lint.lint_blueprint(out["bp"])

    # S6 自纠环（corrector 只动 children 骨架；tree 零变）
    out["bp2"], out["history"] = corrector.self_correct(out["bp"], docs)
    out["lint_final"] = lint.lint_blueprint(out["bp2"])

    # S7 声明式契约 + 可复现验证
    out["contract"] = contract.generate_contract(out["bp2"], docs)
    out["verify"] = contract.verify_reproducibility(out["bp2"], out["contract"])

    # S8 类型化多库（依赖 S3 就地分型的 doc_type）
    out["multistore"] = multistore.build_multistore(docs)

    # S9 即代码导出（DITA topics 视图）+ 反导入
    out["topics_bp"] = _topics_view(out["bp2"])
    out["tmpdir"] = tempfile.TemporaryDirectory()
    out["ascode_paths"] = ascode.export_as_code(out["topics_bp"], out["tmpdir"].name)
    out["ascode_roundtrip"] = ascode.import_from_code(out["tmpdir"].name)
    return out


def _assert_chain(test: unittest.TestCase, r: dict) -> None:
    """全链不变量：每步非空 + tree 零变 + 终态 lint 过 + 契约可复现。"""
    n = len(r["docs"])
    test.assertGreater(n, 0)

    # S2 种子
    test.assertTrue(r["seeds"]["core_terms"], "core_terms 不得为空")
    test.assertTrue(r["seeds"]["type_distribution"], "type_distribution 不得为空")

    # S3 蓝图：文件槽 = 文档数（每件真实文档都有落位）
    bp = r["bp"]
    test.assertTrue(bp["tree"]["l1"], "L1 层不得为空")
    test.assertEqual(bp["stats"]["files"], n, "全部文档须落位为文件槽")

    # S4 证据：每槽必锚
    ev = r["evidence"]
    test.assertEqual(ev["total"], n)
    test.assertEqual(ev["without_evidence"], 0, f"零证据节点拒收: {ev['missing'][:5]}")

    # S5 lint（自纠前）+ S6 自纠环 + 终态 lint（任务门：最终 overall_pass）
    test.assertTrue(r["lint"].overall_pass, r["lint"].summary)
    test.assertTrue(r["history"], "自纠环至少一轮体检")
    test.assertTrue(r["bp2"]["tree"]["l1"], "自纠后蓝图非空")
    test.assertEqual(r["bp2"]["tree"], bp["tree"],
                     "corrector 只动 children 骨架，canonical tree 不得被改")
    test.assertTrue(r["lint_final"].overall_pass,
                    f"终态 lint 未过: {r['lint_final'].summary}")

    # S7 契约 + 复现
    test.assertTrue(r["contract"].rules, "契约规则不得为空")
    test.assertTrue(r["verify"]["identical"],
                    f"契约重放不一致: {r['verify']['diff_details'][:3]}")

    # S8 多库：全部文档路由入四库
    counts = r["multistore"].store_counts()
    test.assertEqual(sum(counts.values()), n, "四库总数须等于文档数")
    test.assertTrue(any(counts.values()), "至少一库非空")

    # S9 即代码：schema/tree/manifest + 每主题一文件；反导入主题数守恒
    paths = r["ascode_paths"]
    for must in ("schema.yaml", "tree.md", "manifest.json"):
        test.assertIn(must, paths)
    topics = r["topics_bp"]["topics"]
    test.assertTrue(topics, "topics 视图不得为空")
    test.assertEqual(len(paths), 3 + len(topics))
    test.assertEqual(len(r["ascode_roundtrip"]["topics"]), len(topics))


class TestSyntheticFullPipeline(unittest.TestCase):
    """合成域全链（零真网）：contract.generate_synthetic_domain 30 件代 doc_search。"""

    def test_synthetic_full_pipeline(self):
        t0 = time.time()
        # S1 合成语料（13 类模板轮转，纯算术确定性，不烧 API）
        docs = contract.generate_synthetic_domain("水利水电", 30)
        self.assertEqual(len(docs), 30)

        r = _run_chain(docs, _WATER_NEED)
        try:
            _assert_chain(self, r)
            # 合成域确定性：evidence_rate 必为满分
            self.assertEqual(r["evidence"]["evidence_rate"], 1.0)
            # 跨库引用非空（13 类模板必产生多库共享特征词）
            self.assertTrue(r["multistore"].cross_references, "跨库引用不得为空")
        finally:
            r["tmpdir"].cleanup()
        print(f"\n[synthetic full pipeline] 30 docs -> "
              f"{len(r['ascode_paths'])} ascode files, "
              f"{round(time.time() - t0, 2)}s")


class TestRealWenkuPipeline(unittest.TestCase):
    """真网全链：wenku 免登录 API 检索水利EPC 域（硬门 ≤3 次查询）。"""

    def test_real_wenku_pipeline(self):
        from kb_factory.catalog_engine.doc_search import search_wenku_docs

        t0 = time.time()
        # S1 真实检索（max_queries=3：水法/防洪法/水污染防治法 三查，纪律硬门）
        domain_info = document_engine.extract_domain(
            _WATER_NEED["domain"] + " " + " ".join(_WATER_NEED["keywords"]))
        self.assertEqual(domain_info["domain"], "水利水电")
        docs = search_wenku_docs(domain_info, max_queries=3)
        self.assertGreater(len(docs), 0, "wenku 三查须检索到真实文档")
        self.assertTrue(all(d.source == "wenku" for d in docs))

        r = _run_chain(docs, _WATER_NEED)
        try:
            _assert_chain(self, r)
            # 任务硬门：检索到的都是真实文档 → 证据率 > 0.5
            self.assertGreater(r["evidence"]["evidence_rate"], 0.5,
                               f"evidence_rate={r['evidence']['evidence_rate']}")
        finally:
            r["tmpdir"].cleanup()
        print(f"\n[real wenku pipeline] {len(docs)} real docs -> "
              f"evidence_rate={r['evidence']['evidence_rate']}, "
              f"{round(time.time() - t0, 2)}s")


if __name__ == "__main__":
    unittest.main()
