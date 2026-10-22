# -*- coding: utf-8 -*-
"""结构优先种子挖掘器测试（KB-FACTORY 编目引擎 v2 P0 #2）。

覆盖三件：
- mine_clause_hierarchy：法规（章/条）+ 标准（1.1 / 5.2.1 小数编号）条款层级提取
- mine_toc_structure：目录页（点线+页码+缩进）目录树提取
- extract_domain_seeds：DocFile 列表 → 领域种子词（TF/停用词/类型分布/编号暗示）
"""
import sys
import os
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

from kb_factory.catalog_engine.document_engine import DocFile
from kb_factory.catalog_engine.structure_miner import (
    mine_clause_hierarchy,
    mine_toc_structure,
    extract_domain_seeds,
)

# ── 样例文本 ─────────────────────────────────────────────────────────────

LAW_TEXT = """中华人民共和国防洪法（节选）

第一章 总则

第一条 为了防治洪水，防御、减轻洪涝灾害，维护人民的生命和财产安全，制定本法。

第二条 防洪工作实行全面规划、统筹兼顾、预防为主、综合治理、局部利益服从全局利益的原则。

第二章 防洪规划

第九条 防洪规划应当服从流域、区域的综合规划。
"""

STANDARD_TEXT = """水利水电工程施工质量标准（样例）

1 总则

1.1 目的
本标准统一水利水电工程施工质量管理要求。

1.2 适用范围
适用于大中型水利水电工程。

5 施工要求

5.1 一般规定

5.2 质量控制

5.2.1 原材料进场检验应符合下列规定。

5.2.2 混凝土强度应满足设计要求。
"""

NOISE_TEXT = """正文段落一：本条说明的内容并不构成标题，500 元以上罚款属于正文。

正文段落二：详见第 3.2.1 条的具体要求（句中引用，行首不是编号）。
"""

TOC_TEXT = """目  录
第一章 概述…………………………1
  1.1 编制目的……………………2
  1.2 编制依据……………………3
第二章 工程概况……………………5
  2.1 水文气象……………………6
  2.2 地形地质……………………8
第三章 施工总布置……………………15
附录A 施工进度计划表……………………98
"""


def _fake_docs() -> list[DocFile]:
    titles = [
        "GB/T 50358 建设项目工程总承包管理规范",
        "SL 252 水利水电工程等级划分及洪水标准",
        "《中华人民共和国水法》",
        "《建设工程质量管理条例》",
        "水利水电工程施工组织设计规范 SL 303",
        "水利水电工程施工质量管理手册",
        "水利水电工程质量检验与评定标准",
        "EPC工程总承包项目质量管理指南",
    ]
    return [DocFile(title=t, source="wenku", fmt="pdf") for t in titles]


# ── mine_clause_hierarchy ────────────────────────────────────────────────

class TestMineClauseHierarchy(unittest.TestCase):

    def test_law_chapter_article_levels(self):
        """法规文本：章=level 1，条=level 2，顺序与文本一致。"""
        nodes = mine_clause_hierarchy(LAW_TEXT)
        nums = [(n["level"], n["num"]) for n in nodes]
        self.assertEqual(nums, [
            (1, "第一章"), (2, "第一条"), (2, "第二条"),
            (1, "第二章"), (2, "第九条"),
        ])
        self.assertEqual(nodes[0]["title"], "总则")
        self.assertEqual(nodes[1]["title"], "为了防治洪水，防御、减轻洪涝灾害，维护人民的生命和财产安全，制定本法")
        self.assertEqual(nodes[3]["title"], "防洪规划")

    def test_standard_dotted_numbering(self):
        """标准文本：1=level1，1.1=level2，5.2.1=level3。"""
        nodes = mine_clause_hierarchy(STANDARD_TEXT)
        got = {n["num"]: n["level"] for n in nodes}
        self.assertEqual(got["1"], 1)
        self.assertEqual(got["1.1"], 2)
        self.assertEqual(got["1.2"], 2)
        self.assertEqual(got["5"], 1)
        self.assertEqual(got["5.1"], 2)
        self.assertEqual(got["5.2"], 2)
        self.assertEqual(got["5.2.1"], 3)
        self.assertEqual(got["5.2.2"], 3)
        by_num = {n["num"]: n for n in nodes}
        self.assertEqual(by_num["1"]["title"], "总则")
        self.assertEqual(by_num["5.2.1"]["title"], "原材料进场检验应符合下列规定")
        # 顺序按文本行序
        self.assertEqual([n["num"] for n in nodes],
                         ["1", "1.1", "1.2", "5", "5.1", "5.2", "5.2.1", "5.2.2"])

    def test_noise_body_not_extracted(self):
        """正文行首非编号者、行中引用不提取；'500 元'类数字噪声拒绝。"""
        self.assertEqual(mine_clause_hierarchy(NOISE_TEXT), [])
        self.assertEqual(mine_clause_hierarchy(""), [])
        self.assertEqual(mine_clause_hierarchy("随便一段没有编号的文本。\n再来一段。"), [])

    def test_determinism(self):
        """同输入必同输出（确定性纪律）。"""
        self.assertEqual(mine_clause_hierarchy(LAW_TEXT), mine_clause_hierarchy(LAW_TEXT))


# ── mine_toc_structure ───────────────────────────────────────────────────

class TestMineTocStructure(unittest.TestCase):

    def test_toc_levels_and_pages(self):
        nodes = mine_toc_structure(TOC_TEXT)
        got = [(n["level"], n["num"], n["title"], n["page"]) for n in nodes]
        self.assertEqual(got, [
            (1, "第一章", "概述", 1),
            (2, "1.1", "编制目的", 2),
            (2, "1.2", "编制依据", 3),
            (1, "第二章", "工程概况", 5),
            (2, "2.1", "水文气象", 6),
            (2, "2.2", "地形地质", 8),
            (1, "第三章", "施工总布置", 15),
            (1, "附录A", "施工进度计划表", 98),
        ])

    def test_toc_dotted_leaders_and_tab_pages(self):
        """点线/点号混排与空白页码都能取页码。"""
        text = "第一章 概述 ......... 12\n1.1 目的\t3\n"
        nodes = mine_toc_structure(text)
        self.assertEqual([(n["num"], n["page"]) for n in nodes],
                         [("第一章", 12), ("1.1", 3)])

    def test_toc_empty(self):
        self.assertEqual(mine_toc_structure(""), [])
        self.assertEqual(mine_toc_structure("目  录\n"), [])


# ── extract_domain_seeds ─────────────────────────────────────────────────

class TestExtractDomainSeeds(unittest.TestCase):

    def test_seeds_schema_and_core_terms(self):
        seeds = extract_domain_seeds(_fake_docs())
        self.assertEqual(set(seeds), {"core_terms", "hierarchy_hints", "type_distribution"})
        # 高频专业术语在 core_terms 前排（水利水电工程×4 → 必在前三）
        self.assertIn("水利水电工程", seeds["core_terms"][:3])
        # 停用词/纯结构词不入 core_terms
        for stop in ("中华人民共和国", "的总则"):
            self.assertNotIn(stop, seeds["core_terms"])
        # 跨界碎片词不入 core_terms（等频更长词"水利水电工程"已全覆盖它们）
        for frag in ("水利水电工", "利水电工", "水电工程"):
            self.assertNotIn(frag, seeds["core_terms"])
        self.assertLessEqual(len(seeds["core_terms"]), 20)

    def test_type_distribution_counts(self):
        docs = _fake_docs()
        seeds = extract_domain_seeds(docs)
        dist = seeds["type_distribution"]
        self.assertEqual(sum(dist.values()), len(docs))
        self.assertGreater(dist.get("技术规范", 0), 0)
        self.assertGreater(dist.get("法律法规", 0), 0)

    def test_hierarchy_hints_from_titles(self):
        docs = [DocFile(title="水利工程质量控制 第二部分"),
                DocFile(title="防洪法释义 第一章解读"),
                DocFile(title="施工规范条文说明 5.2.1 条解读"),
                DocFile(title="附录 施工用表")]
        hints = extract_domain_seeds(docs)["hierarchy_hints"]
        self.assertIn("第X部分", hints)
        self.assertIn("第X章", hints)
        self.assertIn("附录", hints)
        self.assertIn("三级编号(x.y.z)", hints)

    def test_empty_documents(self):
        self.assertEqual(extract_domain_seeds([]),
                         {"core_terms": [], "hierarchy_hints": [], "type_distribution": {}})

    def test_determinism(self):
        self.assertEqual(extract_domain_seeds(_fake_docs()),
                         extract_domain_seeds(_fake_docs()))


if __name__ == "__main__":
    unittest.main(verbosity=2)
