# -*- coding: utf-8 -*-
"""SKOS 中间表示导出测试（KB-FACTORY v2.7 #15）— stdlib unittest，零网络。

覆盖（任务验收口径逐条对应）：
  JSON-LD 可解析      json 文本往返全等、@context/@graph 结构齐、节点 @id 齐
  概念层级树深=蓝图树  fixture/分拆组 fixture/引擎真蓝图三证（split_dirs 拍平口径）
  notation/altLabel   L1 大类字母直取、slot catalog.clc_no/tags 采集、
                      无来源不落键（禁编造）、MK 非大类无 notation
  概念数守恒          蓝图节点数=Concept 数（测试独立重数，不信模块自述）；
                      引擎真蓝图+导览层挂载两证
  from_taxonomy       engineering_epc.yaml 出合法 SKOS（对账独立重读 YAML）、
                      YAML 缺位回退 loader.six_domains 旧真源、
                      非工程域家族缺 YAML 如实 FileNotFoundError、fibo 通用走读、确定性
  纯读纪律            to_skos 前后入参蓝图逐字节不变、同输入必同输出
  validate_skos 负例  缺 prefLabel/broader 悬空/@id 重复/缺 ConceptScheme
  落盘                export_blueprint 建目录+读回全等+文件名
"""
import copy
import json
import os
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))  # E:\AI-Station
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))        # kb_factory/（loader 回退链）

import yaml  # noqa: E402

from kb_factory.catalog_engine import cataloging as cat  # noqa: E402
from kb_factory.catalog_engine import skos_export as sx  # noqa: E402
from kb_factory.catalog_engine.engine import build_blueprint  # noqa: E402
from catalog_engine.taxonomy import CLC_22, SIX_DOMAINS  # noqa: E402

CLC_LETTERS = {c["code"] for c in CLC_22}
ROOT = Path(sx.__file__).resolve().parents[1]              # kb_factory/
TAX = ROOT / "seeds" / "taxonomy"

NEED = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包"],
        "intent": "施工与项目管理", "size_hint": "small"}

CAT_A = {"clc_no": "T", "clean_title": "水利EPC实务手册", "digest": "待补充",
         "digest_from": "none", "tags": ["水利水电", "EPC总承包", "工业技术"]}
CAT_B = {"clc_no": "TV", "clean_title": "水工设计手册", "digest": "待补充",
         "digest_from": "none", "tags": ["水工设计"]}


# ---------------- 造件与独立重数（不信被测模块自述） ----------------

def slot(seq=1, tier="core", catalog=None):
    stem = f"水利水电专题研究_{tier}_{seq:03d}"
    s = {"name": f"{stem}.pdf", "path": "T-01/01/", "tier": tier, "ext": "pdf",
         "title": stem, "identifier": f"KBC1-00000000-{seq:06d}"}
    if catalog is not None:
        s["catalog"] = catalog
    return s


def fixture_bp():
    """两 L1（T=中图法大类 / MK=六域非大类）×各一 L2×槽 3+1（含裸槽无 catalog）。"""
    slots = [slot(seq=1, catalog=CAT_A), slot(seq=2, catalog=CAT_B), slot(seq=3)]
    return {"domain": NEED["domain"], "need": NEED, "ratio": {}, "stats": {},
            "quote": {}, "provenance": {},
            "tree": {"mode": "clc", "root": NEED["domain"], "l1": [
                {"code": "T", "dir": "T-01", "path": "T-01/", "name": "工业技术",
                 "theme": "中图法 T 工业技术", "source": "clc_22", "l2": [
                    {"code": "T-01/01", "dir": "01", "path": "T-01/01/",
                     "name": "水利水电专题研究", "theme": "主题组文件槽",
                     "files": slots, "file_count": len(slots)}]},
                {"code": "MK", "dir": "MK-01", "path": "MK-01/", "name": "市场库",
                 "theme": "区域市场 · 前瞻 · 研究成果", "source": "six_domains", "l2": [
                    {"code": "MK-01/01", "dir": "01", "path": "MK-01/01/",
                     "name": "区域市场报告", "theme": "主题组文件槽",
                     "files": [slot(seq=4)], "file_count": 1}]}]}}


def split_bp():
    """分拆组形态：首组 files 全部转入 split_dirs（受控扇出拍平口径证）。"""
    bp = fixture_bp()
    l2 = bp["tree"]["l1"][0]["l2"][0]
    l2["files"] = []
    l2["split_dirs"] = [{"name": "水利水电专题研究-1", "path": "T-01/01/水利水电专题研究-1/",
                         "files": [slot(seq=1, catalog=CAT_A), slot(seq=2, catalog=CAT_B),
                                   slot(seq=3)]}]
    return bp


def _slots(l2):
    if l2.get("files"):
        return list(l2["files"])
    return [f for sd in l2.get("split_dirs") or [] for f in sd.get("files") or []]


def _l1s(bp):
    return (bp.get("tree") or {}).get("l1") or []


def _count_nodes(bp):
    """蓝图节点数独立重数：L1 + L2 + 文件槽（split_dirs 拍平）。"""
    n = 0
    for l1 in _l1s(bp):
        n += 1
        for l2 in l1.get("l2") or []:
            n += 1 + len(_slots(l2))
    return n


def _bp_depth(bp):
    """蓝图树深独立重数：L1=1 → L2=2 → 文件=3（分拆=文件系统扇出不加层）。"""
    best = 0
    for l1 in _l1s(bp):
        d = 1
        for l2 in l1.get("l2") or []:
            d = max(d, 3 if _slots(l2) else 2)
        best = max(best, d)
    return best


def _concepts(sk):
    return [n for n in sk["@graph"] if n.get("@type") == "skos:Concept"]


def _scheme(sk):
    return next(n for n in sk["@graph"] if n.get("@type") == "skos:ConceptScheme")


def _sk_depth(sk):
    """概念层级树深（broader 链上溯）：顶层=1，叶=L1→L2→文件=3。"""
    broad = {c["@id"]: c["broader"]["@id"] for c in _concepts(sk)
             if isinstance(c.get("broader"), dict)}

    def up(cid):
        d = 1
        while cid in broad:
            cid, d = broad[cid], d + 1
        return d
    return max((up(c["@id"]) for c in _concepts(sk)), default=0)


def _by_label(sk, label):
    return [c for c in _concepts(sk) if c.get("prefLabel") == label]


def _yaml_named(children):
    return [c for c in children if isinstance(c, dict)
            and str(c.get("name") or "").strip()]


def _yaml_concept_count(path):
    doc = yaml.safe_load(Path(path).read_text(encoding="utf-8"))

    def cnt(nodes):
        return sum(1 + cnt(_yaml_named(c.get("children") or []))
                   for c in _yaml_named(nodes))
    return cnt(doc["tree"]["children"])


def _yaml_depth(path):
    doc = yaml.safe_load(Path(path).read_text(encoding="utf-8"))

    def dep(nodes):
        return max((1 + dep(_yaml_named(c.get("children") or []))
                    for c in _yaml_named(nodes)), default=0)
    return dep(doc["tree"]["children"])


# ---------------- to_skos：JSON-LD 可解析 + 结构 ----------------

class TestToSkos(unittest.TestCase):

    def test_jsonld_parseable_roundtrip(self):
        """JSON-LD 文本可解析且往返全等；@context 带 kb/skos 前缀；节点 @id 齐。"""
        sk = sx.to_skos(fixture_bp())
        text = sx.to_jsonld(sk)
        self.assertEqual(json.loads(text), sk)              # 可解析+全等
        ctx = sk["@context"]
        self.assertEqual(ctx["kb"], sx.KB_VOCAB)            # schema_synth 同源 kb vocab
        self.assertEqual(ctx["skos"], sx.SKOS_NS)
        for n in sk["@graph"]:
            self.assertTrue(n.get("@id"))
        self.assertEqual(sx.validate_skos(sk), [])          # 结构健康

    def test_scheme_and_tops(self):
        sk = sx.to_skos(fixture_bp())
        scheme = _scheme(sk)
        self.assertEqual(scheme["prefLabel"], "水利EPC工程")  # ConceptScheme=域
        tops = [r["@id"] for r in scheme["hasTopConcept"]]
        self.assertEqual(len(tops), 2)                      # 两 L1 概念=顶层
        by_label = {c.get("prefLabel"): c for c in _concepts(sk) if "topConceptOf" in c}
        self.assertEqual(set(by_label), {"工业技术", "市场库"})
        for c in by_label.values():
            self.assertNotIn("broader", c)                  # 顶层无 broader
        # L1→L2 narrower 双向：工业技术 narrower 含首组
        top = _by_label(sk, "工业技术")[0]
        self.assertEqual([r["@id"] for r in top["narrower"]],
                         [c["@id"] for c in _by_label(sk, "水利水电专题研究")])
        l2c = _by_label(sk, "水利水电专题研究")[0]
        self.assertEqual(l2c["broader"]["@id"], top["@id"])
        self.assertEqual(len(l2c["narrower"]), 3)           # 槽=叶概念

    def test_preflabel_uses_title_for_slots(self):
        sk = sx.to_skos(fixture_bp())
        leaf = [c for c in _concepts(sk) if "altLabel" in c][0]
        self.assertTrue(leaf["prefLabel"].startswith("水利水电专题研究_"))  # title 非 name


# ---------------- 概念层级树深=蓝图树 ----------------

class TestHierarchyDepth(unittest.TestCase):

    def test_depth_matches_blueprint_three_ways(self):
        for bp in (fixture_bp(), split_bp(), _engine_bp()):
            sk = sx.to_skos(bp)
            self.assertEqual(_sk_depth(sk), _bp_depth(bp),
                             msg=f"mode={bp['tree'].get('mode')} split={bool(_has_split(bp))}")
            self.assertEqual(_sk_depth(sk), 3)

    def test_split_dirs_flatten_not_extra_level(self):
        """分拆目录=文件系统扇出：概念层级不加深（拍平同 cataloging 口径）。"""
        self.assertEqual(_sk_depth(sx.to_skos(split_bp())), 3)


def _has_split(bp):
    return any(l2.get("split_dirs") for l1 in _l1s(bp) for l2 in l1.get("l2") or [])


def _engine_bp(guided=False):
    bpd = build_blueprint(NEED, mode="taxonomy", guided=guided)
    cat.ensure_catalog(bpd)                                 # 四件套入库（编目真值）
    return bpd


# ---------------- notation / altLabel 采集 ----------------

class TestNotationAltLabel(unittest.TestCase):

    def test_notation_l1_letter_and_slot_clc(self):
        sk = sx.to_skos(fixture_bp())
        got = {c.get("notation") for c in _concepts(sk) if "notation" in c}
        self.assertEqual(got, {"T", "TV"})                  # L1 大类 T + 槽 clc T/TV
        self.assertIn("notation", _by_label(sk, "工业技术")[0])       # T 大类直取
        self.assertNotIn("notation", _by_label(sk, "市场库")[0])      # MK 非大类不落
        self.assertNotIn("notation", _by_label(sk, "区域市场报告")[0])  # L2 不落（规约）
        bare = [c for c in _concepts(sk) if "notation" not in c and "broader" in c
                and c["broader"]["@id"] == _by_label(sk, "市场库")[0]["@id"]]
        self.assertEqual(len(bare), 1)                      # 裸槽（无 catalog）无 notation

    def test_altlabel_equals_catalog_tags(self):
        sk = sx.to_skos(fixture_bp())
        with_tags = sorted((tuple(c["altLabel"]) for c in _concepts(sk) if "altLabel" in c))
        self.assertEqual(with_tags, [tuple(CAT_A["tags"]), tuple(CAT_B["tags"])])
        union = {t for c in _concepts(sk) for t in c.get("altLabel", [])}
        self.assertEqual(union, {"水利水电", "EPC总承包", "工业技术", "水工设计"})

    def test_engine_blueprint_notations_independent(self):
        """引擎真蓝图：notation/altLabel 集合与独立重采逐项相等。"""
        bp = _engine_bp()
        sk = sx.to_skos(bp)
        want_n = {l1["code"] for l1 in _l1s(bp) if l1.get("code") in CLC_LETTERS}
        want_n |= {s["catalog"]["clc_no"] for l1 in _l1s(bp) for l2 in l1.get("l2") or []
                   for s in _slots(l2)
                   if (s.get("catalog") or {}).get("clc_no")}
        got_n = {c["notation"] for c in _concepts(sk) if "notation" in c}
        self.assertEqual(got_n, want_n)
        want_t = {t for l1 in _l1s(bp) for l2 in l1.get("l2") or [] for s in _slots(l2)
                  for t in (s.get("catalog") or {}).get("tags") or []}
        got_t = {t for c in _concepts(sk) for t in c.get("altLabel", [])}
        self.assertEqual(got_t, want_t)


# ---------------- 概念数守恒 ----------------

class TestConceptConservation(unittest.TestCase):

    def test_fixture_counts(self):
        for bp in (fixture_bp(), split_bp()):
            self.assertEqual(len(_concepts(sx.to_skos(bp))), _count_nodes(bp))
        self.assertEqual(_count_nodes(fixture_bp()), 8)     # 2 L1 + 2 L2 + 4 槽

    def test_engine_blueprint_conservation(self):
        for guided in (False, True):
            bp = _engine_bp(guided=guided)
            sk = sx.to_skos(bp)
            self.assertEqual(len(_concepts(sk)), _count_nodes(bp),
                             msg=f"guided={guided}")
            self.assertEqual(sx.validate_skos(sk), [])
            self.assertEqual(len(_scheme(sk)["hasTopConcept"]), len(_l1s(bp)))
            if guided:
                self.assertIn("导览", {c["prefLabel"] for c in _concepts(sk)
                                       if "topConceptOf" in c})  # 00-导览→导览


# ---------------- 纯读纪律 + 确定性 + 防御 ----------------

class TestPurityAndDefensive(unittest.TestCase):

    def test_no_mutation_and_deterministic(self):
        bp = fixture_bp()
        before = json.dumps(bp, sort_keys=True, ensure_ascii=False)
        sk1, sk2 = sx.to_skos(bp), sx.to_skos(bp)
        self.assertEqual(sk1, sk2)                          # 同输入必同输出
        self.assertEqual(json.dumps(bp, sort_keys=True, ensure_ascii=False), before)

    def test_empty_tree_scheme_only(self):
        for bad in ({"domain": "空域", "tree": {}}, {"domain": "空域"}):
            sk = sx.to_skos(bad)
            self.assertEqual(_concepts(sk), [])
            self.assertEqual(sx.validate_skos(sk), [])

    def test_non_dict_raises(self):
        with self.assertRaises(ValueError):
            sx.to_skos(None)
        with self.assertRaises(ValueError):
            sx.to_skos([1, 2])


# ---------------- from_taxonomy ----------------

class TestFromTaxonomy(unittest.TestCase):

    EPC = TAX / "engineering_epc.yaml"

    def test_engineering_epc_valid_skos(self):
        sk = sx.from_taxonomy(self.EPC)
        self.assertEqual(sx.validate_skos(sk), [])          # 合法 SKOS
        self.assertEqual(_scheme(sk)["prefLabel"], "工程总承包")
        self.assertEqual(len(_concepts(sk)), _yaml_concept_count(self.EPC))  # 守恒
        self.assertEqual(len(_scheme(sk)["hasTopConcept"]), 6)  # 六库顶层
        self.assertEqual(_sk_depth(sk), _yaml_depth(self.EPC))  # 树深=2
        notations = {c["notation"] for c in _concepts(sk) if "notation" in c}
        self.assertTrue({"MK", "EN", "KN", "KN-01", "CA-01"} <= notations)  # 真分组 id
        self.assertEqual(json.loads(sx.to_jsonld(sk)), sk)  # JSON-LD 可解析

    def test_engineering_epc_deterministic(self):
        self.assertEqual(sx.from_taxonomy(self.EPC), sx.from_taxonomy(self.EPC))

    def test_missing_yaml_falls_back_to_six_domains(self):
        """YAML 缺位 → loader 回退旧真源：六库 49 分组同形 SKOS（缺文件不缺结构）。"""
        with tempfile.TemporaryDirectory() as d:
            sk = sx.from_taxonomy(Path(d) / "engineering_epc.yaml")
        self.assertEqual(sx.validate_skos(sk), [])
        want = 6 + sum(len(v["groups"]) for v in SIX_DOMAINS)
        self.assertEqual(len(_concepts(sk)), want)
        self.assertIn("回退", _scheme(sk).get("definition", ""))  # 溯源如实

    def test_missing_other_family_raises(self):
        with tempfile.TemporaryDirectory() as d:
            with self.assertRaises(FileNotFoundError):
                sx.from_taxonomy(Path(d) / "thuocl_lexicon.yaml")

    def test_fibo_generic_walk(self):
        """非工程域家族走通用树走读（layer→module 两层，模块 id 作 notation）。"""
        p = TAX / "fibo_ontology.yaml"
        sk = sx.from_taxonomy(p)
        self.assertEqual(sx.validate_skos(sk), [])
        self.assertEqual(len(_concepts(sk)), _yaml_concept_count(p))
        self.assertEqual(_sk_depth(sk), _yaml_depth(p))
        self.assertIn("BE", {c["notation"] for c in _concepts(sk) if "notation" in c})


# ---------------- validate_skos 负例 ----------------

class TestValidateNegative(unittest.TestCase):

    def test_missing_preflabel_flagged(self):
        sk = copy.deepcopy(sx.to_skos(fixture_bp()))
        del sk["@graph"][1]["prefLabel"]                    # concept/2（首 L2）
        self.assertTrue(any("prefLabel" in p for p in sx.validate_skos(sk)))

    def test_dangling_broader_flagged(self):
        sk = copy.deepcopy(sx.to_skos(fixture_bp()))
        for c in sk["@graph"]:
            if c.get("@id") == "kb:concept/3":              # 首槽概念
                c["broader"]["@id"] = "kb:concept/9999"
        self.assertTrue(any("broader 悬空" in p for p in sx.validate_skos(sk)))

    def test_duplicate_id_flagged(self):
        sk = sx.to_skos(fixture_bp())
        sk["@graph"].append(copy.deepcopy(sk["@graph"][1]))  # 复制首 L2 概念
        self.assertTrue(any("重复" in p for p in sx.validate_skos(sk)))

    def test_missing_scheme_flagged(self):
        sk = sx.to_skos(fixture_bp())
        sk["@graph"] = [n for n in sk["@graph"]
                        if n.get("@type") != "skos:ConceptScheme"]
        self.assertTrue(any("ConceptScheme" in p for p in sx.validate_skos(sk)))


# ---------------- 落盘：export_blueprint ----------------

class TestExportBlueprint(unittest.TestCase):

    def test_export_creates_dir_and_roundtrip(self):
        bp = fixture_bp()
        with tempfile.TemporaryDirectory() as d:
            out = os.path.join(d, "out", "sub")             # 不存在的嵌套目录
            path = sx.export_blueprint(bp, out)
            self.assertTrue(os.path.isfile(path))
            self.assertTrue(path.endswith("水利EPC工程-skos.jsonld"), path)
            with open(path, encoding="utf-8") as f:
                self.assertEqual(json.load(f), sx.to_skos(bp))  # 读回全等
            custom = sx.export_blueprint(bp, out, filename="custom.jsonld")
            self.assertTrue(os.path.basename(custom), "custom.jsonld")


if __name__ == "__main__":
    unittest.main(verbosity=2)
