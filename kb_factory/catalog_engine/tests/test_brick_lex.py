# -*- coding: utf-8 -*-
"""brick_lex 加载器测试（brick 建筑本体导入，v2.7 波B 验收，对齐 fibo_lex 测试式样）。

DoD 对应（AC 编号即测试名后缀，供追溯矩阵引用）：
  ac1 导入规模：类数 ≥800（设备/空间/点三域 + 基座闭包）
  ac2 层级合法：无孤儿（parent/parents 全部可解析）、无环、depth 与主父类链一致
  ac3 中文化率如实：首轮人工映射 150-300 词门；加载器实算逐域统计 == 种子内
      stats_meta（数字零造假）；zh 非空必有 manual_v1 源，未映射 zh=None 如实保留英文
  ac4 加载幂等：两次加载深度相等；域集=预期四域；文件集与域集一一对应
  ac5 出处与许可固化：BSD-3-Clause / tag=v1.4.4 / asset sha256 齐备；LICENSE 原件在档
  ac6 供弹接口：engineering_terms 默认滤弃用类、require_zh 只出中文化、L2 深度门生效
"""
import re
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import brick_lex  # noqa: E402

SHA256_RE = re.compile(r"^[0-9a-f]{64}$")


class TestBrickLex(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.reg = brick_lex.load_registry()
        cls.st = brick_lex.stats(cls.reg)

    def test_ac1_import_count_ge_800(self):
        """ac1：导入类数 ≥800（门），并回读实际规模入档。"""
        self.assertGreaterEqual(self.st["concepts"], 800,
                                f"导入类数 {self.st['concepts']} < 800")
        # 任务点名主干三域（建筑设备/空间/点）必须在库
        for dom in brick_lex.TRUNK_DOMAINS:
            self.assertIn(dom, self.reg["domains"], f"主干域缺失: {dom}")
        self.assertGreaterEqual(self.st["per_domain"]["POINT"]["classes"], 300,
                                "点域（传感器词汇最富）应 ≥300 类")

    def test_ac2_hierarchy_legal_no_orphans(self):
        """ac2：validate 问题清单必须为空（无孤儿/无环/depth 如实/IRI 契约/deprecated 布尔）。"""
        problems = brick_lex.validate(self.reg)
        self.assertEqual(problems, [], f"层级问题 {len(problems)} 条: {problems[:5]}")
        self.assertGreater(self.st["roots"], 0, "必须有根（外部命名空间父被如实丢弃后落地为根）")
        # 抽查经典主干链：实体→类→设备→暖通空调设备→冷水机组；点位→传感器
        for cid in ("brick:Entity", "brick:Class", "brick:Equipment", "brick:Location",
                    "brick:Point", "brick:HVAC_Equipment", "brick:Air_Handling_Unit",
                    "brick:Chiller", "brick:Sensor", "brick:Setpoint", "brick:Zone",
                    "brick:System", "rec:Space", "rec:Room"):
            self.assertIn(cid, self.reg["concepts"], f"核心概念缺失: {cid}")
        # 任务点名三锚点中文化核验：HVAC→暖通空调 / Zone→区域 / AHU→空气处理机组
        self.assertEqual(self.reg["concepts"]["brick:HVAC_System"]["zh"], "暖通空调系统")
        self.assertEqual(self.reg["concepts"]["brick:Zone"]["zh"], "区域")
        self.assertEqual(self.reg["concepts"]["brick:Air_Handling_Unit"]["zh"], "空气处理机组")
        self.assertEqual(self.reg["concepts"]["brick:Sensor"]["zh"], "传感器")
        # 层级方向抽查：设备是类的子类、传感器是点位的子类
        self.assertEqual(self.reg["concepts"]["brick:Equipment"]["parent"], "brick:Class")
        self.assertEqual(self.reg["concepts"]["brick:Sensor"]["parent"], "brick:Point")

    def test_ac3_zh_rate_honest(self):
        """ac3：首轮映射 150-300 词门 + 加载器实算逐域统计 == 种子文件内 stats_meta。"""
        self.assertGreaterEqual(self.st["zh_mapped"], 150, "首轮映射不足 150 词")
        self.assertLessEqual(self.st["zh_mapped"], 300, "首轮映射超出 300 词")
        self.assertGreater(self.st["zh_rate"], 0, "首轮人工映射后 zh_rate 必须大于 0")
        self.assertLess(self.st["zh_rate"], 1.0, "首轮不可能全量中文化（如实保留英文）")
        for dom, meta in sorted(self.reg["domains"].items()):
            got = self.st["per_domain"][dom]
            claimed = meta["stats_meta"]
            for k in ("classes", "zh_mapped", "zh_rate", "roots", "max_depth", "deprecated"):
                self.assertEqual(got[k], claimed[k], f"{dom} stats.{k} 不符")
        # zh 与 zh_source 严格互斥绑定；未映射类英文标签非空
        for cid, rec in self.reg["concepts"].items():
            if rec["zh"]:
                self.assertEqual(rec["zh_source"], "manual_v1", f"{cid} zh 无 manual_v1 源")
            else:
                self.assertIsNone(rec["zh_source"], f"{cid} 未映射但 zh_source 非空")
                self.assertTrue(rec["en"].strip(), f"{cid} 未映射却无英文标签")

    def test_ac4_load_idempotent(self):
        """ac4：两次全量加载深度相等；域集与文件集一一对应（幂等）。"""
        again = brick_lex.load_registry()
        self.assertEqual(again, self.reg, "两次加载结果不相等")
        self.assertEqual(sorted(self.reg["domains"]), sorted(brick_lex.EXPECTED_DOMAINS),
                         "域集 != 预期四域")
        names = {p.stem for p in brick_lex.domain_files()}
        self.assertEqual(names, set(brick_lex.EXPECTED_DOMAINS))

    def test_ac5_provenance_and_license_pinned(self):
        """ac5：出处三元组（repo/tag/license）+ asset sha256 固化；BSD-3 LICENSE 原件在档。"""
        lic = brick_lex.LICENSE_FILE.read_text(encoding="utf-8")
        self.assertIn("Brick Consortium", lic, "LICENSE 须含版权主体")
        self.assertIn("Redistribution and use", lic, "LICENSE 须为 BSD 三条款正文")
        for dom, meta in sorted(self.reg["domains"].items()):
            src = meta["source"]
            self.assertEqual(src["repo"], "BrickSchema/Brick")
            self.assertEqual(src["tag"], "v1.4.4")
            self.assertEqual(src["license"], "BSD-3-Clause")
            self.assertIn("Brick Consortium", src["license_copyright"])
            self.assertRegex(src["asset_sha256"], SHA256_RE)
            self.assertEqual(src["license_file"], "seeds/brick/LICENSE")
        # 概念字段契约：十二键齐全 + IRI 落在 brick/rec 命名空间
        for cid, rec in self.reg["concepts"].items():
            for k in brick_lex.CONCEPT_KEYS:
                self.assertIn(k, rec, f"{cid} 缺字段 {k}")
            self.assertTrue(rec["iri"].startswith(
                brick_lex.NS_IRI[rec["namespace"]]), f"{cid} IRI 异常")
            self.assertEqual(rec["namespace"], cid.split(":")[0], f"{cid} 前缀/命名空间不符")

    def test_ac6_engineering_terms_supply(self):
        """ac6：供弹接口（收口波 L2/L3 接线点）过滤与深度门行为如实。"""
        # 全量主干域（含未映射英文词，未指定深度门）
        all_terms = brick_lex.engineering_terms()
        self.assertGreater(len(all_terms), 800, "三域未弃用类应 >800")
        self.assertTrue(all(t["deprecated"] is False for t in all_terms),
                        "默认必须过滤弃用类（brick 遗产位置词表）")
        # L2 供弹：限深度 + 只出中文化 → 全部 term==zh
        l2 = brick_lex.engineering_terms(domains=("EQUIP", "LOC", "POINT"),
                                         max_depth=4, require_zh=True)
        self.assertGreater(len(l2), 30, "L2 中文化主干词应 >30")
        self.assertTrue(all(t["zh"] for t in l2))
        self.assertTrue(all(t["depth"] <= 4 for t in l2))
        self.assertIn("brick:Air_Handling_Unit", {t["id"] for t in l2})
        # 未映射类 term 落英文（如实）
        en_only = [t for t in all_terms if not t["zh"]]
        self.assertTrue(en_only and all(t["term"] == t["en"] for t in en_only))


if __name__ == "__main__":
    unittest.main()
