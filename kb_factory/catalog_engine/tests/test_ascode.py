# -*- coding: utf-8 -*-
"""P2 #8 类型化主题+即代码导出（ascode.py）测试 —— test-first，stdlib only。

链路：造蓝图 → export → 验证文件存在 → import → 验证一致 → diff 两版。

AC（测试名后缀供追溯矩阵引用）：
  ac1 TOPIC_TYPES 六类型与任务规格逐字一致；越界类型 fail-loud
  ac2 export_as_code 落盘 schema.yaml / tree.md / manifest.json / topics/<id>.md，
      frontmatter 含 类型/标题/来源/权威度，返回相对路径清单
  ac3 schema.yaml 含类型定义+层级关系；manifest sha256 与实文件一致
  ac4 import_from_code 反导入 == 原蓝图（双向兼容）
  ac5 diff_blueprints 检出 新增/删除/修改节点(含文件路径)/领域变更；相同蓝图 → []
  ac6 确定性：同蓝图两次导出字节级一致（无时钟、无随机）
"""
import copy
import hashlib
import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine.ascode import (  # noqa: E402
    TOPIC_TYPES, diff_blueprints, export_as_code, import_from_code,
)

SPEC_TOPIC_TYPES = {
    "standard": "标准项（国标/行标/企标）",
    "regulation": "法规项（法律/行政法规/规章）",
    "case": "案例项（事故/纠纷/成功实践）",
    "method": "方法项（流程/指南/操作规程）",
    "template": "模板项（合同/报告/检查表）",
    "reference": "参考项（手册/图集/数据表）",
}

BP = {
    "domain": "水利水电EPC知识库",
    "topics": [
        {"id": "standard_GB50500", "type": "standard",
         "title": "GB50500-2024 建设工程工程量清单计价规范", "source": "住建部",
         "authority": 5, "parent": None, "description": "工程量清单计价国标，EPC 计价核心依据。"},
        {"id": "regulation_水法", "type": "regulation",
         "title": "中华人民共和国水法", "source": "全国人大常委会",
         "authority": 5, "parent": None, "description": "水资源开发利用与保护的基本法律。"},
        {"id": "case_事故分析", "type": "case",
         "title": "某水库溃坝事故分析", "source": "水利部通报",
         "authority": 4, "parent": None, "description": "典型溃坝事故复盘与责任认定。"},
        {"id": "method_施工导流", "type": "method",
         "title": "施工导流方案编制指南", "source": "总包智库研究团队",
         "authority": 3, "parent": None, "description": "导流标准选择与方案比选流程。"},
        {"id": "template_检查表", "type": "template",
         "title": "单元工程质量检查表", "source": "项目部",
         "authority": 3, "parent": "method_施工导流", "description": "单元工程验收检查表模板。"},
        {"id": "reference_图集", "type": "reference",
         "title": "水工建筑物标准图集", "source": "水利设计院",
         "authority": 3, "parent": None, "description": "常用结构形式参考图集。"},
    ],
}


def make_bp_v2() -> dict:
    """v2：领域变更 + 权威度修改 + 标题修改 + 删除参考项 + 新增方法项。"""
    bp2 = copy.deepcopy(BP)
    bp2["domain"] = "水利水电EPC知识库v2"
    for t in bp2["topics"]:
        if t["id"] == "standard_GB50500":
            t["authority"] = 4  # 修改：权威度 5 → 4
        if t["id"] == "case_事故分析":
            t["title"] = "某水库溃坝事故深度复盘"  # 修改：标题
    bp2["topics"] = [t for t in bp2["topics"] if t["id"] != "reference_图集"]  # 删除
    bp2["topics"].append({"id": "method_安全监测", "type": "method",
                          "title": "大坝安全监测操作规程", "source": "运维中心",
                          "authority": 4, "parent": None,
                          "description": "测点布设与巡检流程。"})  # 新增
    return bp2


class TopicTypesTest(unittest.TestCase):
    """ac1 类型本体"""

    def test_p2_8_ac1_topic_types_match_spec(self):
        self.assertEqual(TOPIC_TYPES, SPEC_TOPIC_TYPES)
        self.assertEqual(len(TOPIC_TYPES), 6)

    def test_p2_8_ac1_unknown_type_fails_loud(self):
        with tempfile.TemporaryDirectory() as d:
            bad = copy.deepcopy(BP)
            bad["topics"][0]["type"] = "random_type"
            with self.assertRaises(ValueError):
                export_as_code(bad, d)


class ExportAsCodeTest(unittest.TestCase):
    """ac2/ac3 导出为文件系统结构"""

    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory()
        cls.out = Path(cls.tmp.name) / "ascode_out"
        cls.paths = export_as_code(BP, str(cls.out))

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_p2_8_ac2_layout_and_returned_paths(self):
        self.assertTrue((self.out / "schema.yaml").is_file())
        self.assertTrue((self.out / "tree.md").is_file())
        self.assertTrue((self.out / "manifest.json").is_file())
        for t in BP["topics"]:
            self.assertTrue((self.out / "topics" / f"{t['id']}.md").is_file(),
                            f"缺 topics/{t['id']}.md")
        self.assertIn("schema.yaml", self.paths)
        self.assertIn("topics/regulation_水法.md", self.paths)
        self.assertIn("manifest.json", self.paths)
        self.assertEqual(len(self.paths), 3 + len(BP["topics"]))  # schema+tree+manifest + 每主题一文件

    def test_p2_8_ac2_frontmatter_type_title_source_authority(self):
        for t in BP["topics"]:
            text = (self.out / "topics" / f"{t['id']}.md").read_text(encoding="utf-8")
            self.assertTrue(text.startswith("---\n"), t["id"])
            self.assertIn(f'type: "{t["type"]}"', text)
            self.assertIn(f'title: "{t["title"]}"', text)
            self.assertIn(f'source: "{t["source"]}"', text)
            self.assertIn(f"authority: {t['authority']}\n", text)
            self.assertIn(t["description"], text)  # 正文描述

    def test_p2_8_ac2_tree_md_is_human_readable_overview(self):
        tree = (self.out / "tree.md").read_text(encoding="utf-8")
        self.assertIn("水利水电EPC知识库", tree)
        for t in BP["topics"]:
            self.assertIn(t["id"], tree)
            self.assertIn(t["title"], tree)
        # 层级缩进：template_检查表 是 method_施工导流 的子节点（行首缩进两格）
        lines = tree.splitlines()
        p = next(i for i, ln in enumerate(lines) if ln.lstrip().startswith("- method_施工导流"))
        c = next(i for i, ln in enumerate(lines) if ln.lstrip().startswith("- template_检查表"))
        self.assertGreater(c, p)
        self.assertTrue(lines[c].startswith("  - "))  # 子节点缩进

    def test_p2_8_ac3_schema_yaml_has_types_and_hierarchy(self):
        schema = (self.out / "schema.yaml").read_text(encoding="utf-8")
        self.assertIn("topic_types:", schema)
        for k, v in SPEC_TOPIC_TYPES.items():
            self.assertIn(f"{k}: \"{v}\"", schema)
        self.assertIn("hierarchy:", schema)
        self.assertIn("parent", schema)

    def test_p2_8_ac3_manifest_hashes_match_files(self):
        m = json.loads((self.out / "manifest.json").read_text(encoding="utf-8"))
        self.assertEqual(m["domain"], BP["domain"])
        self.assertEqual(m["counts"]["topics"], len(BP["topics"]))
        self.assertEqual(m["counts"]["by_type"]["standard"], 1)
        for e in m["files"]:
            blob = (self.out / e["path"]).read_bytes()
            self.assertEqual(e["sha256"], hashlib.sha256(blob).hexdigest(), e["path"])
            self.assertEqual(e["bytes"], len(blob), e["path"])
        topic_files = [e for e in m["files"] if "topic_id" in e]
        self.assertEqual([e["topic_id"] for e in topic_files],
                         [t["id"] for t in BP["topics"]])  # 顺序保留


class RoundTripTest(unittest.TestCase):
    """ac4 双向兼容：import(export(bp)) == bp"""

    def test_p2_8_ac4_import_equals_original(self):
        with tempfile.TemporaryDirectory() as d:
            export_as_code(BP, d)
            self.assertEqual(import_from_code(d), BP)


class DiffBlueprintsTest(unittest.TestCase):
    """ac5 蓝图差异"""

    def test_p2_8_ac5_diff_detects_add_remove_modify_domain(self):
        lines = diff_blueprints(BP, make_bp_v2())
        joined = "\n".join(lines)
        self.assertIn("~ 领域: 水利水电EPC知识库 → 水利水电EPC知识库v2", joined)
        self.assertIn("+ 新增节点 [method] method_安全监测", joined)
        self.assertIn("topics/method_安全监测.md", joined)
        self.assertIn("- 删除节点 [reference] reference_图集", joined)
        self.assertIn("topics/reference_图集.md", joined)
        self.assertIn("~ 修改节点 [standard] standard_GB50500", joined)
        self.assertIn("authority: 5 → 4", joined)
        self.assertIn("~ 修改节点 [case] case_事故分析", joined)
        self.assertIn("title:", joined)

    def test_p2_8_ac5_identical_blueprints_empty_diff(self):
        self.assertEqual(diff_blueprints(BP, copy.deepcopy(BP)), [])


class DeterminismTest(unittest.TestCase):
    """ac6 同输入必同输出（字节级）"""

    def test_p2_8_ac6_two_exports_byte_identical(self):
        with tempfile.TemporaryDirectory() as d:
            a, b = Path(d) / "a", Path(d) / "b"
            export_as_code(BP, str(a))
            export_as_code(BP, str(b))
            fa = sorted(p.relative_to(a).as_posix() for p in a.rglob("*") if p.is_file())
            fb = sorted(p.relative_to(b).as_posix() for p in b.rglob("*") if p.is_file())
            self.assertEqual(fa, fb)
            for rel in fa:
                self.assertEqual((a / rel).read_bytes(), (b / rel).read_bytes(), rel)


if __name__ == "__main__":
    unittest.main()
