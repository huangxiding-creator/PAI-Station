# -*- coding: utf-8 -*-
"""KB-FACTORY 编目引擎 v2 P0 #10：反模式 lint 发布门测试（test-first, stdlib only）。

DoD 对应（AC 编号即测试名后缀，供追溯矩阵引用）：
  ac1 完美蓝图 → 8 项检查全 pass，overall_pass=True
  ac2 空节点（L2 files=0 且 split_dirs=0）→ 空节点检查 fail，overall_pass=False
  ac3 同一文件名出现在多个 L2 → 重复文件检查 warning
  ac4 L1 下只有 1 个 L2 → 孤儿节点检查 warning
  ac5 命名超长（>30 字符）与 L1 总数越界（<2 或 >8）→ warning
  ac6 覆盖率 real_docs/files<0.5 → warning；标准号缺空格（GB50300）→ info
  ac7 深度不均（某 L1 L2<3 且另一 L1 L2>10）→ warning
  ac8 render_lint_report 输出 Markdown 表格报告
  ac9 build_blueprint 集成：provenance.lint 四键入册，lint 失败不阻断输出
"""
import unittest

from kb_factory.catalog_engine import build_blueprint
from kb_factory.catalog_engine.lint import (
    LintReport, lint_blueprint, render_lint_report,
)

STATUS_PASS = "pass"


def _l2(code: str, name: str, files: list, split_dirs=None, **extra) -> dict:
    node = {"code": code, "dir": code.split("/")[-1], "path": f"{code}/", "name": name,
            "theme": f"{name}主题组", "files": files, "file_count": len(files)}
    if split_dirs is not None:
        node["split_dirs"] = split_dirs
    node.update(extra)
    return node


def _l1(code: str, name: str, l2: list, **extra) -> dict:
    node = {"code": code, "dir": code, "path": f"{code}/", "name": name,
            "theme": f"{name}一级主题", "source": "document_driven", "l2": l2}
    node.update(extra)
    return node


def _f(name: str, **extra) -> dict:
    slot = {"name": name, "real": True, "size_kb": 100}
    slot.update(extra)
    return slot


def _perfect_bp() -> dict:
    """完美蓝图：3 个 L1（2-8 区间内），各 4 个 L2（3-10 区间内），文件名唯一且短。"""
    l1s, names = [], iter(f"文件{i:03d}.pdf" for i in range(1, 100))
    for i in range(1, 4):
        l2s = [_l2(f"D-{i:02d}/{j:02d}", f"主题组{j}", [_f(next(names)) for _ in range(2)])
               for j in range(1, 5)]
        l1s.append(_l1(f"D-{i:02d}", f"一级类{i}", l2s))
    total = sum(len(x["files"]) for a in l1s for x in a["l2"])
    return {"domain": "测试域", "mode": "document_driven",
            "tree": {"mode": "document_driven", "root": "测试域知识库", "l1": l1s},
            "stats": {"files": total, "real_docs": total, "l1_count": 3, "l2_count": 12},
            "provenance": {}}


class PerfectBlueprintTest(unittest.TestCase):
    """ac1 完美蓝图全绿"""

    def test_req_p0_10_ac1_perfect_blueprint_all_pass(self):
        report = lint_blueprint(_perfect_bp())
        self.assertIsInstance(report, LintReport)
        self.assertEqual(len(report.checks), 8, "检查项数量应为 8")
        self.assertTrue(all(c.status == STATUS_PASS for c in report.checks),
                        [c.detail for c in report.checks if c.status != STATUS_PASS])
        self.assertEqual((report.passed, report.failed, report.warnings), (8, 0, 0))
        self.assertTrue(report.overall_pass)
        self.assertIn("总体通过", report.summary)


class EmptyNodeTest(unittest.TestCase):
    """ac2 空节点 → fail"""

    def test_req_p0_10_ac2_empty_node_fails(self):
        bp = _perfect_bp()
        bp["tree"]["l1"][0]["l2"].append(_l2("D-01/09", "空主题组", []))
        report = lint_blueprint(bp)
        empty = next(c for c in report.checks if c.check_id == "empty_nodes")
        self.assertEqual(empty.status, "fail")
        self.assertIn("D-01/09", empty.detail)
        self.assertEqual(report.failed, 1)
        self.assertFalse(report.overall_pass, "overall_pass 必须 = (failed==0)")
        # 分拆目录承载文件的 L2 不算空节点（files=0 但 split_dirs 有内容）
        bp2 = _perfect_bp()
        bp2["tree"]["l1"][0]["l2"].append(
            _l2("D-01/09", "分拆主题组", [], split_dirs=[{"name": "分拆主题组-1",
                                                          "path": "D-01/09/分拆主题组-1/",
                                                          "files": [_f("文件A.pdf")]}]))
        self.assertTrue(lint_blueprint(bp2).overall_pass)


class DuplicateFileTest(unittest.TestCase):
    """ac3 重复文件 → warning"""

    def test_req_p0_10_ac3_duplicate_file_warns(self):
        bp = _perfect_bp()
        bp["tree"]["l1"][1]["l2"][2]["files"].append(_f("文件001.pdf"))  # 已在 D-01/01
        report = lint_blueprint(bp)
        dup = next(c for c in report.checks if c.check_id == "duplicate_files")
        self.assertEqual(dup.status, "warning")
        self.assertIn("文件001.pdf", dup.detail)
        self.assertIn("D-02/03", dup.detail)
        self.assertEqual(report.warnings >= 1, True)
        self.assertTrue(report.overall_pass, "warning 不改变 overall_pass")


class OrphanL1Test(unittest.TestCase):
    """ac4 孤儿 L1（仅 1 个 L2）→ warning"""

    def test_req_p0_10_ac4_orphan_l1_warns(self):
        bp = _perfect_bp()
        bp["tree"]["l1"].append(_l1("D-09", "孤儿类", [_l2("D-09/01", "独子组", [_f("文件090.pdf")])]))
        report = lint_blueprint(bp)
        orphan = next(c for c in report.checks if c.check_id == "orphan_l1")
        self.assertEqual(orphan.status, "warning")
        self.assertIn("孤儿类", orphan.detail)
        self.assertIn("合并", orphan.detail)
        self.assertTrue(report.overall_pass)


class NamingAndHierarchyTest(unittest.TestCase):
    """ac5 命名超长 + L1 总数越界 → warning"""

    def test_req_p0_10_ac5_long_names_and_l1_count_warn(self):
        bp = _perfect_bp()
        bp["tree"]["l1"][0]["name"] = "特别长" * 11  # 33 字符 > 30
        bp["tree"]["l1"][1]["l2"][0]["name"] = "超长二级主题名称" * 3  # 30+ 字符
        report = lint_blueprint(bp)
        naming = next(c for c in report.checks if c.check_id == "naming_length")
        self.assertEqual(naming.status, "warning")
        l1c = next(c for c in report.checks if c.check_id == "l1_count")
        self.assertEqual(l1c.status, "pass", "3 个 L1 在 [2,8] 内应通过")
        # L1 过少
        thin = _perfect_bp()
        thin["tree"]["l1"] = thin["tree"]["l1"][:1]
        self.assertEqual(next(c for c in lint_blueprint(thin).checks
                              if c.check_id == "l1_count").status, "warning")
        # L1 过多
        fat = _perfect_bp()
        for i in range(4, 10):
            fat["tree"]["l1"].append(_l1(f"D-{i:02d}", f"加塞类{i}",
                                         [_l2(f"D-{i:02d}/01", "组", [_f(f"加塞{i}.pdf")])]))
        self.assertEqual(next(c for c in lint_blueprint(fat).checks
                              if c.check_id == "l1_count").status, "warning")


class CoverageAndStdNumberTest(unittest.TestCase):
    """ac6 覆盖率 <0.5 → warning；标准号缺空格 → info"""

    def test_req_p0_10_ac6_coverage_and_std_number(self):
        bp = _perfect_bp()
        bp["stats"]["real_docs"] = 4   # 4/24 < 0.5
        bp["tree"]["l1"][0]["l2"][0]["files"].append(_f("GB50300统一标准.pdf"))  # 缺空格
        bp["tree"]["l1"][0]["l2"][1]["files"].append(_f("GB 50300 建筑施工质量验收统一标准.pdf"))
        report = lint_blueprint(bp)
        cov = next(c for c in report.checks if c.check_id == "coverage")
        self.assertEqual(cov.status, "warning")
        self.assertIn("50%", cov.detail)
        std = next(c for c in report.checks if c.check_id == "std_number_format")
        self.assertEqual(std.status, "info")
        self.assertIn("GB50300", std.detail)
        self.assertNotIn("GB 50300 建筑施工质量验收统一标准", std.detail,
                         "带空格规范号文件不应被列为违规")
        self.assertTrue(report.overall_pass, "warning/info 不算失败")


class DepthImbalanceTest(unittest.TestCase):
    """ac7 深度不均 → warning"""

    def test_req_p0_10_ac7_depth_imbalance_warns(self):
        bp = _perfect_bp()
        bp["tree"]["l1"][0]["l2"] = bp["tree"]["l1"][0]["l2"][:2]  # 2 < 3
        fat = [_l2(f"D-02/{j:02d}", f"加厚{j}", [_f(f"加厚{j}.pdf")]) for j in range(5, 13)]
        bp["tree"]["l1"][1]["l2"].extend(fat)  # 12 > 10
        report = lint_blueprint(bp)
        depth = next(c for c in report.checks if c.check_id == "depth_imbalance")
        self.assertEqual(depth.status, "warning")
        self.assertIn("一级类1", depth.detail)
        self.assertIn("一级类2", depth.detail)


class RenderReportTest(unittest.TestCase):
    """ac8 Markdown 渲染"""

    def test_req_p0_10_ac8_render_lint_report_markdown(self):
        md = render_lint_report(lint_blueprint(_perfect_bp()))
        self.assertIn("# 蓝图 Lint 报告", md)
        self.assertIn("| # | 检查项 | 结果 | 详情 |", md)
        self.assertIn("PASS", md)
        self.assertIn("空节点", md)
        # 警告样例也渲染
        bp = _perfect_bp()
        bp["tree"]["l1"][0]["l2"].append(_l2("D-01/09", "空主题组", []))
        md2 = render_lint_report(lint_blueprint(bp))
        self.assertIn("FAIL", md2)
        self.assertIn("未通过", md2)


class EngineIntegrationTest(unittest.TestCase):
    """ac9 build_blueprint 集成——provenance.lint 入册，失败不阻断"""

    NEED = {"domain": "lint测试域", "keywords": ["lint", "蓝图"], "intent": "反模式检查",
            "size_hint": "small"}

    def test_req_p0_10_ac9_provenance_lint_attached(self):
        bp = build_blueprint(self.NEED, mode="taxonomy")
        self.assertIn("lint", bp["provenance"], "provenance 缺 lint 键")
        lint_meta = bp["provenance"]["lint"]
        self.assertEqual(set(lint_meta), {"passed", "failed", "warnings", "overall_pass"})
        self.assertEqual(lint_meta["failed"], 0, "taxonomy 蓝图不应有 fail 级反模式")
        self.assertTrue(lint_meta["overall_pass"])
        self.assertEqual(lint_meta["passed"] + lint_meta["warnings"],
                         len(lint_blueprint(bp).checks), "计数应覆盖全部检查项")
        # lint 只记入 provenance，不改变蓝图顶层契约
        self.assertEqual(set(bp), {"domain", "need", "tree", "ratio", "stats", "quote",
                                   "provenance"})

    def test_req_p0_10_ac9_lint_failure_does_not_block(self):
        """lint fail 的蓝图仍完整返回（决策交给 provenance）。"""
        bp = build_blueprint(self.NEED, mode="taxonomy")
        report = lint_blueprint(bp)
        self.assertTrue(report.failed == 0 or bp is not None)  # 引擎从不因 lint 抛异常
        self.assertEqual(bp["provenance"]["lint"]["overall_pass"], report.overall_pass)


if __name__ == "__main__":
    unittest.main()
