# -*- coding: utf-8 -*-
"""编目字段四件套 + TSV 元数据块测试（v2.6 #6）— stdlib unittest，零网络。

覆盖：
  clean_title  站点头/尾剥、叠层尾、括注尾、广告词、书名号保护、
               干净题名零漂移负例、纯站点剥空回退原题负例
  digest       渠道真实摘要截断（abstract/snippet/intro/description 优先级）、
               零造假负例（无来源→「待补充」+ digest_from=none 显式标注）、
               短真实摘要如实保留（不注水凑 60 字）、HTML 残标/换行清洗
  clc_no       v1 大类字母直取、六域/v2 组名别名映射、无映射如实 None
  catalog_entry四件套字段齐、受控标签 3-5 去重、确定性
  ensure_catalog 增量补缺（既有真实值优先不回退）、幂等、分拆组拍平
  dump_group_tsv 每组一张 TSV、dataverse 六列头、行可读回（6 字段整）、
                 vocabulary/parent/required/multiple 映射
  enrich 接线   回填即编目（真实摘要+净题名入库）、占位槽零触碰、provenance 键集不变
"""
import csv
import os
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

from kb_factory.catalog_engine import cataloging as cat
from kb_factory.channel_adapters import enrich as enr
from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta

NEED = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包"],
        "intent": "施工与项目管理", "size_hint": "small"}


# ---------------- 造件 ----------------

def v1_slot(tier="core", ext=None, seq=1, theme="水利水电专题研究"):
    ext = ext or {"core": "pdf", "field": "docx", "guide": "md"}[tier]
    stem = f"{theme}_{tier}_{seq:03d}"
    return {"name": f"{stem}.{ext}", "path": "T-01/01/", "tier": tier, "ext": ext,
            "title": stem, "identifier": f"KBC1-00000000-{seq:06d}"}


def v1_bp(slots=None, l2_name="水利水电专题研究"):
    """v1 taxonomy 形状最小蓝图（L1 code=T → 中图法大类直取）。"""
    return {"domain": NEED["domain"], "need": NEED,
            "ratio": {"core": 50, "field": 35, "guide": 15},
            "stats": {}, "quote": {}, "provenance": {},
            "tree": {"mode": "clc", "root": NEED["domain"], "l1": [
                {"code": "T", "dir": "T-01", "path": "T-01/", "name": "工业技术",
                 "theme": "中图法 T 工业技术", "source": "clc_22", "l2": [
                    {"code": "T-01/01", "dir": "01", "path": "T-01/01/", "name": l2_name,
                     "theme": f"{l2_name}：主题组文件槽", "files": slots if slots is not None else [],
                     "file_count": len(slots or [])}]}]}}


def v2_bp():
    """v2 document_driven 形状最小蓝图（槽无 tier/无 ext，档位按超越层名推）。"""
    return {"domain": "水利水电", "need": NEED, "ratio": {"core": 50, "field": 35, "guide": 15},
            "stats": {}, "quote": {}, "provenance": {},
            "tree": {"mode": "document_driven", "root": "水利水电知识库", "l1": [
                {"code": "D-01", "dir": "01", "path": "D-01/", "name": "合规底线",
                 "theme": "法律法规与强制性标准", "l2": [
                    {"code": "D-01/01", "dir": "01", "path": "D-01/01/", "name": "法律法规",
                     "files": [{"name": "中华人民共和国水法.pdf", "fmt": "pdf", "real": True}],
                     "file_count": 1}]}]}}


class FakeAdapter(ChannelAdapter):
    """假渠道：按查询返回注入的 FileMeta（零网络）。"""

    channel = "fake"

    def __init__(self, metas, available=True):
        self._metas, self._ok, self.calls = metas, available, []

    def metadata(self, query, limit):
        self.calls.append((query, limit))
        return self._metas[:limit]

    def available(self):
        return self._ok


# ---------------- clean_title：净题名 ----------------

class TestCleanTitle(unittest.TestCase):

    def test_site_suffix_and_ad_bracket_stripped(self):
        self.assertEqual(cat.clean_title("【精品】水利EPC实务手册 - 百度文库"), "水利EPC实务手册")

    def test_site_prefix_stripped(self):
        self.assertEqual(cat.clean_title("百度文库 - 水利EPC实务手册"), "水利EPC实务手册")

    def test_stacked_site_suffix(self):
        self.assertEqual(cat.clean_title("施工组织设计_豆丁网_book118"), "施工组织设计")

    def test_site_paren_suffix(self):
        self.assertEqual(cat.clean_title("合同范本 - 原创力文档（book118.com）"), "合同范本")

    def test_ad_word_tail_stripped(self):
        self.assertEqual(cat.clean_title("水利工程EPC实务免费下载"), "水利工程EPC实务")

    def test_clean_title_negative_noop(self):
        """负例：干净题名零漂移（书名号/编号/规范号原样保留）。"""
        t = "SL 303 水利水电工程施工组织设计规范"
        self.assertEqual(cat.clean_title(t), t)
        self.assertEqual(cat.clean_title("《建设工程质量管理条例》解读"), "《建设工程质量管理条例》解读")

    def test_pure_site_falls_back_to_original(self):
        """负例：纯站点名剥空 → 回退原题（绝不产空净题名）。"""
        self.assertEqual(cat.clean_title("百度文库"), "百度文库")

    def test_empty_string(self):
        self.assertEqual(cat.clean_title(""), "")
        self.assertEqual(cat.clean_title(None), "")


# ---------------- digest：零造假提要 ----------------

class TestDigest(unittest.TestCase):

    def test_abstract_truncated_to_100(self):
        extra = {"abstract": "水利枢纽工程EPC总承包管理实务要点梳理，" * 10}
        text, key = cat.digest_from_extra(extra)
        self.assertEqual(key, "abstract")
        self.assertEqual(text, extra["abstract"][:100])  # 60-100 字高位截断

    def test_priority_abstract_over_snippet_intro(self):
        extra = {"abstract": "文库摘要", "snippet": "研报片段", "intro": "站方摘要"}
        self.assertEqual(cat.digest_from_extra(extra), ("文库摘要", "abstract"))

    def test_fallback_snippet_intro_description(self):
        self.assertEqual(cat.digest_from_extra({"snippet": "研报片段"})[1], "snippet")
        self.assertEqual(cat.digest_from_extra({"intro": "站方摘要"})[1], "intro")
        self.assertEqual(cat.digest_from_extra({"description": "库简介"})[1], "description")

    def test_short_real_summary_kept_as_is(self):
        """短于 60 字的真实摘要如实保留（零造假：不注水凑数）。"""
        self.assertEqual(cat.digest_from_extra({"intro": "海外EPC项目风险摘要。"}),
                         ("海外EPC项目风险摘要。", "intro"))

    def test_negative_no_source_yields_placeholder(self):
        """负例：无来源（空 extra/缺键/纯空白/纯 URL）→ 「待补充」显式标注。"""
        for extra in ({}, {"doc_id": "x1"}, {"description": "  \n "}, {"abstract": "https://x.y/z"}):
            slot = v1_slot()
            meta = FileMeta(title="真实文件·水利工程", fmt="pdf", extra=extra)
            entry = cat.catalog_entry(slot, {}, {}, NEED, meta=meta, channel="wenku")
            self.assertEqual(entry["digest"], "待补充", msg=f"extra={extra}")
            self.assertEqual(entry["digest_from"], "none")

    def test_html_em_and_newlines_cleaned(self):
        text, key = cat.digest_from_extra({"snippet": "<em>水利</em>工程\n\n总承包\t实务"})
        self.assertEqual((text, key), ("水利工程 总承包 实务", "snippet"))

    def test_placeholder_slot_without_meta_is_pending(self):
        """占位槽无渠道来源 → 提要「待补充」（占位 description 不得冒充提要）。"""
        entry = cat.catalog_entry(v1_slot(tier="guide"), {}, {}, NEED)
        self.assertEqual(entry["digest"], "待补充")
        self.assertEqual(entry["digest_from"], "none")


# ---------------- clc_no：分组映射 ----------------

class TestClcNo(unittest.TestCase):

    def test_v1_l1_letter_direct(self):
        self.assertEqual(cat.clc_for_group({"code": "T", "name": "工业技术"},
                                           {"name": "水利水电专题研究"}), "T")

    def test_six_domain_group_alias_hit(self):
        """六域 L1 code（MK）非中图法 → L2 组名别名映射（金融货币→F 经济）。"""
        self.assertEqual(cat.clc_for_group({"code": "MK", "name": "市场库"},
                                           {"name": "金融货币"}), "F")

    def test_v2_doc_type_alias_hit(self):
        self.assertEqual(cat.clc_for_group({"code": "D-01", "name": "合规底线"},
                                           {"name": "法律法规"}), "D")

    def test_negative_no_mapping_is_none(self):
        """负例：组名无任何中图法别名命中 → 如实 None（禁编造类号）。"""
        self.assertIsNone(cat.clc_for_group({"code": "MK", "name": "企业库", "theme": ""},
                                            {"name": "标杆专访"}))

    def test_l1_theme_does_not_leak_into_children(self):
        """回归：L1 theme 长描述（「政策 · 法规 · …」）不得把无命中子组全染成
        同一类——兜底只信 L1 短名，theme 一律不参与打分。"""
        kn = {"code": "KN", "name": "知识库", "theme": "知识库（KN）：政策 · 法规 · 课程 · 实务手册"}
        self.assertIsNone(cat.clc_for_group(kn, {"name": "国际EPC"}))
        self.assertIsNone(cat.clc_for_group(kn, {"name": "VIP必修课"}))
        self.assertEqual(cat.clc_for_group(kn, {"name": "政策法规资讯"}), "D")  # L2 自身命中仍生效
        # v2 兜底走 L1 短名：「合规底线」含 D 别名「合规」
        self.assertEqual(cat.clc_for_group({"code": "D-01", "name": "合规底线"},
                                           {"name": "VIP案例库"}), "D")


# ---------------- catalog_entry：四件套字段 ----------------

class TestCatalogEntry(unittest.TestCase):

    def test_four_fields_with_real_meta(self):
        slot = v1_slot()
        meta = FileMeta(title="【精品】水利EPC实务手册 - 百度文库", fmt="pdf", pages=88,
                        extra={"abstract": "水利枢纽EPC总承包全过程管理实务要点，" * 3})
        bp = v1_bp([slot])
        l1, l2 = bp["tree"]["l1"][0], bp["tree"]["l1"][0]["l2"][0]
        entry = cat.catalog_entry(slot, l1, l2, NEED, meta=meta, channel="wenku")
        self.assertEqual(entry["clc_no"], "T")
        self.assertEqual(entry["clean_title"], "水利EPC实务手册")
        self.assertEqual(entry["digest"], "水利枢纽EPC总承包全过程管理实务要点，" * 3)
        self.assertEqual(entry["digest_from"], "wenku")
        # 受控标签：命中关键词→L2 组名→中图法类名→域→tier 标签，3-5 个去重
        tags = entry["tags"]
        self.assertTrue(3 <= len(tags) <= 5, msg=f"tags={tags}")
        self.assertEqual(tags[0], "水利水电")           # 命中需求关键词居首
        self.assertIn("水利水电专题研究", tags)          # L2 组名
        self.assertIn("工业技术", tags)                  # 中图法类名（受控）
        self.assertEqual(len(tags), len(set(tags)))      # 去重

    def test_deterministic_same_input_same_output(self):
        s1, s2 = v1_slot(), v1_slot()
        bp = v1_bp([s1])
        l1, l2 = bp["tree"]["l1"][0], bp["tree"]["l1"][0]["l2"][0]
        self.assertEqual(cat.catalog_entry(s1, l1, l2, NEED),
                         cat.catalog_entry(s2, l1, l2, NEED))

    def test_tags_cap_at_five(self):
        slot = v1_slot()
        need = dict(NEED, keywords=["水利水电", "EPC总承包", "施工", "造价", "安全"])
        entry = cat.catalog_entry(slot, {"code": "T", "name": "工业技术"},
                                  {"name": "水利水电专题研究"}, need)
        self.assertEqual(len(entry["tags"]), 5)


# ---------------- ensure_catalog：增量补缺 ----------------

class TestEnsureCatalog(unittest.TestCase):

    def test_fills_missing_preserves_real_and_idempotent(self):
        s_real, s_bare = v1_slot(seq=1), v1_slot(tier="guide", seq=2)
        s_real["catalog"] = {"clc_no": "T", "clean_title": "真实件", "digest": "渠道真实摘要",
                             "digest_from": "wenku", "tags": ["水利水电"]}
        bp = v1_bp([s_real, s_bare])
        r1 = cat.ensure_catalog(bp)
        self.assertEqual(r1, {"groups": 1, "files": 2, "filled": 1})  # 只补裸槽
        self.assertEqual(s_real["catalog"]["digest"], "渠道真实摘要")   # 既有真实值不回退
        self.assertEqual(s_bare["catalog"]["digest"], "待补充")         # 裸槽如实标注
        r2 = cat.ensure_catalog(bp)
        self.assertEqual(r2["filled"], 0)                              # 幂等

    def test_split_dirs_flattened(self):
        s = v1_slot()
        bp = v1_bp([])
        l2 = bp["tree"]["l1"][0]["l2"][0]
        l2["files"], l2["split_dirs"] = [], [
            {"name": "水利水电专题研究-1", "path": "T-01/01/水利水电专题研究-1/", "files": [s]}]
        r = cat.ensure_catalog(bp)
        self.assertEqual(r["files"], 1)
        self.assertIn("catalog", s)


# ---------------- dump_group_tsv：TSV 元数据块 ----------------

class TestDumpGroupTsv(unittest.TestCase):

    def test_each_group_one_tsv_readable_back(self):
        slots = [v1_slot(tier="core", seq=1), v1_slot(tier="field", seq=2),
                 v1_slot(tier="guide", seq=3)]
        bp = v1_bp(slots)
        with tempfile.TemporaryDirectory() as d:
            paths = cat.dump_group_tsv(bp, d)
            self.assertEqual(len(paths), 1)                       # 一个 L2 组一张
            p = paths[0]
            self.assertTrue(os.path.basename(p).startswith("T-01-01"), p)
            with open(p, encoding="utf-8", newline="") as f:
                rows = list(csv.reader(f, delimiter="\t"))
            self.assertEqual(tuple(rows[0]), cat.TSV_COLUMNS)     # dataverse 六列头
            self.assertEqual(rows[0], ["name", "type", "required", "multiple",
                                       "vocabulary", "parent"])
            self.assertEqual(len(rows), 1 + len(slots))           # 头 + 每文件一行
            for row in rows[1:]:
                self.assertEqual(len(row), 6)                     # 可读回：6 字段整
            core_row = rows[1]
            self.assertEqual(core_row[0], slots[0]["name"])       # name=文件名
            self.assertEqual(core_row[1], "pdf")                  # type=扩展名
            self.assertEqual(core_row[2], "true")                 # core 档必备
            self.assertEqual(core_row[3], "true")                 # 多值标签
            self.assertEqual(core_row[4].split("|")[0], "水利水电")  # 受控词表
            self.assertEqual(core_row[5], "T")                    # parent=中图法类号
            guide_row = rows[3]
            self.assertEqual(guide_row[2], "false")
            self.assertEqual(guide_row[5], "T")

    def test_v2_blueprint_and_missing_clc_parent_empty(self):
        """v2 蓝图：fmt 列/超越层档位可用；无中图法映射组 parent 留空。"""
        slots = [{"name": "中华人民共和国水法.pdf", "fmt": "pdf", "real": True}]
        bp = v2_bp()
        bp["tree"]["l1"][0]["l2"][0]["files"] = slots
        # 再挂一个无映射组（六域 MK + 标杆专访）→ parent=""
        bp["tree"]["l1"].append({"code": "MK", "name": "企业库", "l2": [
            {"code": "MK-01/01", "name": "标杆专访",
             "files": [{"name": "标杆专访_field_001.docx", "tier": "field", "ext": "docx",
                        "title": "标杆专访_field_001"}]}]})
        with tempfile.TemporaryDirectory() as d:
            paths = cat.dump_group_tsv(bp, d)
            self.assertEqual(len(paths), 2)
            with open(paths[0], encoding="utf-8", newline="") as f:
                rows = list(csv.reader(f, delimiter="\t"))
            self.assertEqual(rows[1][:3], ["中华人民共和国水法.pdf", "pdf", "true"])
            self.assertEqual(rows[1][5], "D")                     # 法律法规→D
            with open(paths[1], encoding="utf-8", newline="") as f:
                rows2 = list(csv.reader(f, delimiter="\t"))
            self.assertEqual(rows2[1][5], "")                     # 无映射如实留空


# ---------------- enrich 接线：回填即编目 ----------------

class TestEnrichWiring(unittest.TestCase):

    def test_filled_slot_cataloged_placeholder_untouched(self):
        """回填槽四件套入库；未回填占位槽零触碰（增量纪律）。"""
        slots = [v1_slot(tier="core", seq=1), v1_slot(tier="core", seq=2),
                 v1_slot(tier="guide", seq=3)]
        metas = [FileMeta(title=f"【精品】真实文件{i}·水利工程 - 百度文库", fmt="pdf",
                          pages=20 + i, extra={"abstract": f"第{i}号水利工程EPC总承包实务摘要，"
                                                           "覆盖设计采购施工全流程要点与风险控制。" * 2})
                 for i in range(2)]
        bp = v1_bp(slots)
        enr.enrich_blueprint(bp, [FakeAdapter(metas)], per_topic=3)
        filled = [s for s in slots if "catalog" in s]   # 回填槽=带四件套的槽
        kept = [s for s in slots if "catalog" not in s]
        self.assertEqual(len(filled), 2)
        for i, s in enumerate(filled):                            # 回填即编目
            self.assertEqual(s["catalog"]["clean_title"], f"真实文件{i}·水利工程")
            self.assertEqual(s["catalog"]["digest_from"], "fake")
            self.assertNotEqual(s["catalog"]["digest"], "待补充")
            self.assertEqual(s["catalog"]["clc_no"], "T")
            self.assertTrue(3 <= len(s["catalog"]["tags"]) <= 5)
        for s in kept:                                            # 占位槽不碰
            self.assertNotIn("catalog", s)

    def test_provenance_keys_unchanged(self):
        """接线零 provenance 漂移：本测试蓝图基线 {stage_log} → 回填后只多
        channel_enrichment 一键，四件套接线不引入任何新 provenance 键。"""
        slots = [v1_slot(seq=1)]
        metas = [FileMeta(title="真实文件·水利工程", fmt="pdf", extra={"abstract": "摘要正文" * 12})]
        bp = v1_bp(slots)
        self.assertEqual(set(bp["provenance"]), set())            # 基线：空 provenance
        enr.enrich_blueprint(bp, [FakeAdapter(metas)], per_topic=3)
        # 有渠道命中 → 既有契约三键（hit_counts 本就写）；接线不得引入第四键
        self.assertEqual(set(bp["provenance"]),
                         {"channel_enrichment", "stage_log", "hit_counts"})
        self.assertIn("S8", bp["provenance"]["stage_log"][-1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
