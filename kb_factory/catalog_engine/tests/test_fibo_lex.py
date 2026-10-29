# -*- coding: utf-8 -*-
"""fibo_lex 加载器测试（fibo 财务本体导入，v2.7 #8 验收，test-first）。

DoD 对应（AC 编号即测试名后缀，供追溯矩阵引用）：
  ac1 导入规模：概念数 ≥500 类（主干五模块 + 父级闭包）
  ac2 层级合法：无孤儿（parent/parents 全部可解析）、无环、depth 与主父类链一致
  ac3 中文化率如实：加载器实算 zh_rate == 种子内逐模块 stats_meta（数字零造假）；
      zh 非空必有 manual_v1 源，未映射 zh=None 如实保留英文
  ac4 加载幂等：两次加载深度相等；模块集=预期八模块
  ac5 FND 公共层：机构/主体/文件/时间/量 五概念组齐全，概念 id 全部可追溯
  ac6 出处固化：MIT 许可 / tag=master_2026Q3 / tarball sha256 齐备
"""
import re
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import fibo_lex  # noqa: E402

SHA256_RE = re.compile(r"^[0-9a-f]{64}$")


class TestFiboLex(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.reg = fibo_lex.load_registry()
        cls.st = fibo_lex.stats(cls.reg)

    def test_ac1_import_count_ge_500(self):
        """ac1：导入概念数 ≥500（门），并回读实际规模入档。"""
        self.assertGreaterEqual(self.st["concepts"], 500,
                                f"导入概念数 {self.st['concepts']} < 500")
        # 任务点名主干五模块必须在库（CA 任务命名=FIBO 实际模块码 CAE）
        for mod in fibo_lex.TRUNK_MODULES:
            self.assertIn(mod, self.reg["modules"], f"主干模块缺失: {mod}")

    def test_ac2_hierarchy_legal_no_orphans(self):
        """ac2：validate 问题清单必须为空（无孤儿/无环/depth 如实/标签与 zh 源一致）。"""
        problems = fibo_lex.validate(self.reg)
        self.assertEqual(problems, [], f"层级问题 {len(problems)} 条: {problems[:5]}")
        self.assertGreater(self.st["roots"], 0, "必须有根（FIBO 命名空间内根类）")
        # 抽查经典主干：金融工具 → 证券 → 权益工具 链路在库
        for cid in ("FinancialInstrument", "Security", "EquityInstrument",
                    "Account", "Customer", "Loan"):
            self.assertIn(cid, self.reg["concepts"], f"核心概念缺失: {cid}")
        self.assertEqual(self.reg["concepts"]["Loan"]["zh"], "贷款")
        self.assertEqual(self.reg["concepts"]["Account"]["zh"], "账户")
        self.assertEqual(self.reg["concepts"]["Customer"]["zh"], "客户")

    def test_ac3_zh_rate_honest(self):
        """ac3：加载器实算逐模块统计 == 种子文件内 stats_meta（如实对账）。"""
        self.assertGreater(self.st["zh_rate"], 0, "首轮人工映射后 zh_rate 必须大于 0")
        self.assertLessEqual(self.st["zh_rate"], 1.0)
        for mod, meta in sorted(self.reg["modules"].items()):
            got = self.st["per_module"][mod]
            claimed = meta["stats_meta"]
            self.assertEqual(got["classes"], claimed["classes"], f"{mod} classes 不符")
            self.assertEqual(got["zh_mapped"], claimed["zh_mapped"], f"{mod} zh_mapped 不符")
            self.assertEqual(got["zh_rate"], claimed["zh_rate"], f"{mod} zh_rate 不符")
            self.assertEqual(got["roots"], claimed["roots"], f"{mod} roots 不符")
            self.assertEqual(got["max_depth"], claimed["max_depth"], f"{mod} max_depth 不符")
        # zh 与 zh_source 严格互斥绑定（validate 已查，此处再独立复核全量）
        for cid, rec in self.reg["concepts"].items():
            if rec["zh"]:
                self.assertEqual(rec["zh_source"], "manual_v1", f"{cid} zh 无 manual_v1 源")
            else:
                self.assertIsNone(rec["zh_source"], f"{cid} 未映射但 zh_source 非空")
                self.assertTrue(rec["en"].strip(), f"{cid} 未映射却无英文标签")

    def test_ac4_load_idempotent(self):
        """ac4：两次全量加载深度相等；模块集与文件集一一对应（幂等）。"""
        again = fibo_lex.load_registry()
        self.assertEqual(again, self.reg, "两次加载结果不相等")
        self.assertEqual(sorted(self.reg["modules"]), sorted(fibo_lex.EXPECTED_MODULES),
                         "模块集 != 预期八模块")
        names = {p.stem for p in fibo_lex.module_files()}
        self.assertEqual(names, set(fibo_lex.EXPECTED_MODULES))

    def test_ac5_fnd_common_five_groups(self):
        """ac5：五概念组（机构/主体/文件/时间/量）齐全且 id 全部可追溯。"""
        doc = fibo_lex.fnd_common()
        keys = [g["key"] for g in doc["groups"]]
        self.assertEqual(keys, ["organizations", "parties", "documents", "time", "quantities"])
        self.assertEqual([g["zh"] for g in doc["groups"]], ["机构", "主体", "文件", "时间", "量"])
        for g in doc["groups"]:
            self.assertGreater(len(g["concepts"]), 0, f"组 {g['key']} 为空")
            for c in g["concepts"]:
                self.assertIn(c["id"], self.reg["concepts"],
                              f"组 {g['key']} 概念不可追溯: {c['id']}")
                reg_c = self.reg["concepts"][c["id"]]
                self.assertEqual(c["zh"], reg_c["zh"], f"{c['id']} 公共层与注册表 zh 不一致")

    def test_ac6_provenance_pinned(self):
        """ac6：出处三元组（repo/tag/license）与 tarball sha256 逐模块固化。"""
        for mod, meta in sorted(self.reg["modules"].items()):
            src = meta["source"]
            self.assertEqual(src["repo"], "EDMCouncil/fibo")
            self.assertEqual(src["tag"], "master_2026Q3")
            self.assertEqual(src["license"], "MIT")
            self.assertIn("Enterprise Data Management Council", src["license_copyright"])
            self.assertRegex(src["tarball_sha256"], SHA256_RE)
        # 概念字段契约：九键齐全 + IRI 落在 fibo 命名空间
        for cid, rec in self.reg["concepts"].items():
            for k in fibo_lex.CONCEPT_KEYS:
                self.assertIn(k, rec, f"{cid} 缺字段 {k}")
            self.assertTrue(rec["iri"].startswith(
                "https://spec.edmcouncil.org/fibo/ontology/"), f"{cid} IRI 异常")
            self.assertEqual(rec["module"], rec["iri"].split("/ontology/")[1].split("/")[0])


if __name__ == "__main__":
    unittest.main()
