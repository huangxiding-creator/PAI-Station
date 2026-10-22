# -*- coding: utf-8 -*-
"""KB-CAT v1 编目引擎测试（FR2 验收，test-first）

DoD 对应（AC 编号即测试名后缀，供追溯矩阵引用）：
  ac1 受控扇出律：L1∈[8,22]、每级扇出 10–20、单目录 ≤200 触发分拆
  ac2 五个样例域全跑通 + 确定性（两次调用 canonical JSON 相等）
  ac3 _INDEX.md 枢纽卡生成且含 编号/主题/条目数
  ac4 ratio 和=100%；stats.files=槽位总和；quote 公式断言
  ac5 种子分类法匹配：水利域命中工程六域种子（L1 含六库相关大类名）
  ac6 槽位规则：占位文件名/类型扩展名/15字段元数据/徽章权限
"""
import json
import re
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import build_blueprint, ENGINE_VERSION  # noqa: E402
from catalog_engine.engine import SIZE_PLANS, RATIO_BY_SIZE  # noqa: E402
from catalog_engine.metadata import FIELDS, BADGES, PERM_BY_BADGE, PERM_LEVELS  # noqa: E402

SAMPLE_NEEDS = {
    "law": {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
            "intent": "诉讼与合规", "size_hint": "medium"},
    "math": {"domain": "初中数学教师备课库", "keywords": ["初中数学", "教案", "课程标准", "中考专题", "几何证明"],
             "intent": "备课与教研", "size_hint": "small"},
    "fin": {"domain": "企业财务管理", "keywords": ["会计核算", "财务报表", "税务筹划", "全面预算", "成本管控"],
            "intent": "核算与报表", "size_hint": "medium"},
    "ehs": {"domain": "EHS安全管理", "keywords": ["安全生产", "职业健康", "环境保护", "应急预案", "双重预防机制"],
            "intent": "隐患排查与合规", "size_hint": "medium"},
    "water": {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
              "intent": "施工与项目管理", "size_hint": "large"},
}
TOP_KEYS = {"domain", "need", "tree", "ratio", "stats", "quote", "provenance"}


def iter_file_dirs(tree):
    """产出所有直接落文件的目录节点：L2（无分拆时）或分拆子目录。"""
    for l1 in tree["l1"]:
        for l2 in l1["l2"]:
            if l2.get("split_dirs"):
                for sd in l2["split_dirs"]:
                    yield l2, sd
            else:
                yield l2, l2


def count_slots(tree):
    n = 0
    for _, d in iter_file_dirs(tree):
        n += len(d["files"])
    return n


class FanoutLawTest(unittest.TestCase):
    """ac1 受控扇出律"""

    def test_req_fr2_ac1_l1_and_l2_bounds(self):
        for key, need in SAMPLE_NEEDS.items():
            with self.subTest(domain=key):
                bp = build_blueprint(need, mode='taxonomy')
                l1s = bp["tree"]["l1"]
                self.assertGreaterEqual(len(l1s), 8, f"{key} L1 不足 8")
                self.assertLessEqual(len(l1s), 22, f"{key} L1 超过 22")
                for l1 in l1s:
                    self.assertGreaterEqual(len(l1["l2"]), 10, f"{key}/{l1['name']} L2 扇出<10")
                    self.assertLessEqual(len(l1["l2"]), 20, f"{key}/{l1['name']} L2 扇出>20")

    def test_req_fr2_ac1_files_per_group_10_20_standard_sizes(self):
        for key in ("law", "fin", "ehs", "math", "water"):
            bp = build_blueprint(SAMPLE_NEEDS[key], mode='taxonomy')
            for l2 in [x for l1 in bp["tree"]["l1"] for x in l1["l2"]]:
                self.assertGreaterEqual(l2["file_count"], 10)
                self.assertLessEqual(l2["file_count"], 20)

    def test_req_fr2_ac1_no_dir_over_200_any_size(self):
        for key, need in SAMPLE_NEEDS.items():
            bp = build_blueprint(need, mode='taxonomy')
            for _, d in iter_file_dirs(bp["tree"]):
                self.assertLessEqual(len(d["files"]), 200, f"{key} 目录超 200: {d['path']}")

    def test_req_fr2_ac1_split_over_200(self):
        huge = dict(SAMPLE_NEEDS["law"], size_hint="huge", domain="超大规模法务资料总库")
        bp = build_blueprint(huge, mode='taxonomy')
        splits = [(l2, sd) for l2, sd in iter_file_dirs(bp["tree"]) if sd is not l2]
        self.assertTrue(splits, "huge 规模未触发分拆")
        for _, d in iter_file_dirs(bp["tree"]):
            self.assertLessEqual(len(d["files"]), 200)
        l2 = splits[0][0]
        names = [sd["name"] for sd in l2["split_dirs"]]
        self.assertEqual(names, [f"{l2['name']}-1", f"{l2['name']}-2"])
        self.assertEqual([len(sd["files"]) for sd in l2["split_dirs"]], [200, 50])
        # 纯函数单元：450 槽 → 200/200/50 三分拆
        from catalog_engine.blueprint import split_files
        chunks = split_files("试验主题", ["f%03d" % i for i in range(450)])
        self.assertEqual([c["name"] for c in chunks], ["试验主题-1", "试验主题-2", "试验主题-3"])
        self.assertEqual([len(c["files"]) for c in chunks], [200, 200, 50])


class FiveDomainsTest(unittest.TestCase):
    """ac2 五个样例域全跑通且确定性"""

    def test_req_fr2_ac2_run_and_deterministic(self):
        for key, need in SAMPLE_NEEDS.items():
            with self.subTest(domain=key):
                bp = build_blueprint(need, mode='taxonomy')
                self.assertEqual(set(bp.keys()), TOP_KEYS)
                self.assertEqual(bp["domain"], need["domain"])
                self.assertEqual(bp["need"], need)
                bp2 = build_blueprint(json.loads(json.dumps(need)), mode='taxonomy')
                self.assertEqual(json.dumps(bp, sort_keys=True, ensure_ascii=False),
                                 json.dumps(bp2, sort_keys=True, ensure_ascii=False),
                                 f"{key} 两次生成不一致（确定性被破坏）")


class IndexMdTest(unittest.TestCase):
    """ac3 _INDEX.md 枢纽卡"""

    def test_req_fr2_ac3_index_md_contents(self):
        bp = build_blueprint(SAMPLE_NEEDS["law"], mode='taxonomy')
        for l1 in bp["tree"]["l1"]:
            self.assertIn("_INDEX.md", l1["index_md"])
            self.assertIn("路径编号", l1["index_md"])
            self.assertIn("下级条目表", l1["index_md"])
            for l2 in l1["l2"]:
                md = l2["index_md"]
                self.assertIn("_INDEX.md", md)
                self.assertIn("路径编号", md)
                self.assertIn(l2["path"], md, "枢纽卡缺路径编号")
                self.assertIn("主题", md)
                self.assertIn(l2["name"], md, "枢纽卡缺主题名")
                self.assertIn("条目数", md)
                self.assertIn(str(l2["file_count"]), md, "枢纽卡条目数与实际不符")


class RatioStatsQuoteTest(unittest.TestCase):
    """ac4 配比/统计/报价"""

    def test_req_fr2_ac4_ratio_sums_100(self):
        for size, ratio in RATIO_BY_SIZE.items():
            self.assertEqual(sum(ratio.values()), 100, f"{size} 配比和≠100")
        self.assertEqual(RATIO_BY_SIZE["medium"], {"core": 55, "field": 35, "guide": 10},
                         "medium 默认配比必须 55/35/10")
        for key, need in SAMPLE_NEEDS.items():
            bp = build_blueprint(need, mode='taxonomy')
            self.assertEqual(bp["ratio"], RATIO_BY_SIZE[need["size_hint"]])

    def test_req_fr2_ac4_stats_and_quote(self):
        bp = build_blueprint(SAMPLE_NEEDS["law"], mode='taxonomy')
        self.assertEqual(bp["stats"]["files"], count_slots(bp["tree"]), "stats.files≠槽位总和")
        self.assertGreater(bp["stats"]["files"], 0)
        self.assertEqual(bp["stats"]["gb"], round(bp["stats"]["bytes"] / 1024 ** 3, 2))
        q = bp["quote"]
        self.assertEqual((q["base"], q["per_gb"], q["md_factor"], q["ima_add"]),
                         (29.0, 2.0, 1.5, 19.0), "A 档报价参数被改动")
        self.assertEqual(q["total"], round(29.0 + bp["stats"]["gb"] * 2.0, 1), "quote.total 公式不符")


class SeedTaxonomyTest(unittest.TestCase):
    """ac5 种子分类法复用（先匹配种子，匹配不上才自建）"""

    SIX_VAULTS = ["市场库", "企业库", "专家库", "知识库", "案例库", "研报库"]

    def test_req_fr2_ac5_water_hits_six_domain_seed(self):
        bp = build_blueprint(SAMPLE_NEEDS["water"], mode='taxonomy')
        names = [l1["name"] for l1 in bp["tree"]["l1"]]
        for vault in self.SIX_VAULTS:
            self.assertIn(vault, names, f"水利域 L1 缺工程六域种子大类: {vault}")
        self.assertEqual(bp["tree"]["mode"], "six_domains")
        self.assertIn("six_domains", " ".join(bp["provenance"]["seed_taxonomy"]))

    def test_req_fr2_ac5_non_engineering_stays_clc(self):
        for key in ("law", "math", "fin", "ehs"):
            bp = build_blueprint(SAMPLE_NEEDS[key], mode='taxonomy')
            self.assertEqual(bp["tree"]["mode"], "clc", f"{key} 误触发六域种子")
            self.assertIn("clc_22", " ".join(bp["provenance"]["seed_taxonomy"]))
        law = build_blueprint(SAMPLE_NEEDS["law"], mode='taxonomy')
        self.assertIn("政治法律", [l1["name"] for l1 in law["tree"]["l1"]], "律所域未命中中图法 D 政治法律")


class SlotRulesTest(unittest.TestCase):
    """ac6 槽位占位规则与 15 字段元数据垫片"""

    NAME_RE = re.compile(r"^.+_(core|field|guide)_\d{3}\.(pdf|docx|xlsx|md)$")
    TIER_EXT = {"core": {"pdf"}, "field": {"docx", "pdf", "xlsx"}, "guide": {"md"}}

    def test_req_fr2_ac6_slot_names_exts_badges(self):
        bp = build_blueprint(SAMPLE_NEEDS["fin"], mode='taxonomy')
        seen = 0
        for _, d in iter_file_dirs(bp["tree"]):
            for s in d["files"]:
                seen += 1
                self.assertRegex(s["name"], self.NAME_RE, f"占位文件名违规: {s['name']}")
                tier = s["tier"]
                self.assertIn(tier, self.TIER_EXT)
                ext = s["name"].rsplit(".", 1)[1]
                self.assertIn(ext, self.TIER_EXT[tier], f"{tier} 扩展名违规: {s['name']}")
                self.assertIn(s["badge"], BADGES)
                self.assertIn(s["perm"], PERM_LEVELS)
                self.assertEqual(s["perm"], PERM_BY_BADGE[s["badge"]])
                for f in FIELDS:
                    self.assertIn(f, s, f"槽位缺 15 字段之一: {f}")
                self.assertIsNone(s["checksum_slot"])
        self.assertGreater(seen, 0)

    def test_req_fr2_ac6_provenance_shape(self):
        bp = build_blueprint(SAMPLE_NEEDS["ehs"], mode='taxonomy')
        p = bp["provenance"]
        self.assertEqual(p["engine_version"], ENGINE_VERSION)
        self.assertTrue(p["seed_taxonomy"])
        self.assertTrue(p["stage_log"])


if __name__ == "__main__":
    unittest.main()
