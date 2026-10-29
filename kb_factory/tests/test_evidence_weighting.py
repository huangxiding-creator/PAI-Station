# -*- coding: utf-8 -*-
"""证据回流加权测试（W5.5：蓝图结构 × 渠道真实命中联动）— stdlib unittest，零真网络。

验收分支全覆盖：
  hit_counts：有命中写入 / 跨 adapter 求和 / 无 adapter 数据缺省（既有输出不变）
  adjust_structure：hot ×1.5 / cold ×0.7 / 下限保底 3 槽 / 中间带不动 /
                    hit_counts None/空零副作用 / 未命中组名不动 / 热阈优先 /
                    自定义阈值 / 混合组配比和恒=100 / 空组跳过
  CLI：--evidence 开（enrich 后自动调结构）/ 关（默认，向后兼容）/ 无命中跳过
"""
import io
import json
import os
import shutil
import sys
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # 仓库根入 sys.path

from kb_factory.catalog_engine.engine import adjust_structure
from kb_factory.catalog_engine.metadata import make_slot, sanitize_filename
from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta
from kb_factory.channel_adapters import enrich as enr


# ---------------- 造件（形状同 channel_adapters/tests/test_adapters） ----------------

def make_slots(n_core=5, n_field=4, n_guide=1, path="KN-01/01/", theme="水利工程",
               domain="水利EPC"):
    """按 catalog_engine 槽位形状造占位槽（tier 档 ext 与引擎一致）。"""
    exts = {"core": ["pdf"], "field": ["docx", "pdf", "xlsx"], "guide": ["md"]}
    slots, idx = [], 0
    for tier, n in (("core", n_core), ("field", n_field), ("guide", n_guide)):
        for k in range(1, n + 1):
            ext = exts[tier][(k - 1) % len(exts[tier])]
            name = f"{sanitize_filename(theme)}_{tier}_{k:03d}.{ext}"
            slot = {"name": name, "path": path, "tier": tier, "ext": ext}
            slot.update(make_slot(name=name, tier=tier, ext=ext, theme=theme,
                                  l1_name="知识库", domain=domain, path=path,
                                  badge="green_free", perm="green", idx=idx,
                                  need_hash8="abcd1234"))
            slots.append(slot)
            idx += 1
    return slots


def mini_blueprint(group_specs):
    """迷你蓝图：group_specs=[(L2 组名, slots)]；schema 对齐引擎产物。"""
    l2_nodes = []
    for i, (name, slots) in enumerate(group_specs, 1):
        l2_nodes.append({"code": f"KN-01/{i:02d}", "dir": f"{i:02d}",
                         "path": f"KN-01/{i:02d}/", "name": name, "theme": f"{name}主题",
                         "file_count": len(slots), "files": list(slots)})
    return {"domain": "水利EPC",
            "need": {"domain": "水利EPC", "keywords": ["EPC"], "intent": "施工",
                     "size_hint": "small"},
            "ratio": {"core": 50, "field": 35, "guide": 15},
            "tree": {"mode": "six_domains", "root": "水利EPC", "l1": [
                {"code": "KN", "dir": "KN-01", "path": "KN-01/", "name": "知识库",
                 "theme": "t", "source": "seed", "l2": l2_nodes}]},
            "stats": {}, "quote": {},
            "provenance": {"engine_version": "kb-cat/1.0.0", "seed_taxonomy": [],
                           "stage_log": []}}


class FakeAdapter(ChannelAdapter):
    """假渠道：按查询返回注入的 FileMeta（零网络）。"""

    def __init__(self, channel, items, available=True):
        self.channel, self.items, self._available = channel, items, available

    def available(self):
        return self._available

    def metadata(self, query, limit):
        return self.items[:limit]


def metas(n):
    return [FileMeta(title=f"真实文件{i}·水利工程", fmt="pdf", pages=20 + i,
                     badge="green_free", perm="green", source_url=f"https://x/{i}",
                     extra={"doc_id": str(i)}) for i in range(n)]


def snapshot(bp):
    return json.dumps(bp, ensure_ascii=False, sort_keys=True)


G1 = "01 工程总承包"
G2 = "02 造价与合同管理"


# ---------------- enrich：hit_counts 写入/缺省 ----------------

class TestHitCounts(unittest.TestCase):
    def test_hit_counts_written_when_adapter_returns(self):
        bp = mini_blueprint([(G1, make_slots())])
        enr.enrich_blueprint(bp, [FakeAdapter("fake", metas(12))], per_topic=12)
        self.assertEqual(bp["provenance"]["hit_counts"], {G1: 12})

    def test_hit_counts_summed_across_adapters(self):
        bp = mini_blueprint([(G1, make_slots())])
        enr.enrich_blueprint(bp, [FakeAdapter("a", metas(12)), FakeAdapter("b", metas(3))],
                             per_topic=12)
        self.assertEqual(bp["provenance"]["hit_counts"], {G1: 15})

    def test_hit_counts_absent_without_adapter_data(self):
        """无 adapter 数据（空列表/空返回/全不可用/限流）→ 字段缺省，既有输出不变。"""
        cases = [[], [FakeAdapter("fake", [])],
                 [FakeAdapter("fake", metas(3), available=False)]]
        for adapters in cases:
            bp = mini_blueprint([(G1, make_slots())])
            enr.enrich_blueprint(bp, adapters, per_topic=12)
            self.assertNotIn("hit_counts", bp["provenance"],
                             msg=f"adapters={[a.channel for a in adapters]}")
            # 既有行为不变：provenance 只多 channel_enrichment 一键 + S8 一行
            self.assertEqual(set(bp["provenance"]),
                             {"engine_version", "seed_taxonomy", "stage_log",
                              "channel_enrichment"})
            self.assertTrue(bp["provenance"]["stage_log"][-1].startswith("S8"))

    def test_hit_counts_absent_when_no_group_queried(self):
        bp = mini_blueprint([(G1, make_slots())])
        enr.enrich_blueprint(bp, [FakeAdapter("fake", metas(12))], per_topic=12,
                             max_topics=0)
        self.assertNotIn("hit_counts", bp["provenance"])


# ---------------- adjust_structure：纯函数各分支 ----------------

class TestAdjustStructure(unittest.TestCase):
    def l2_of(self, bp, i=0):
        return bp["tree"]["l1"][0]["l2"][i]

    def test_none_hit_counts_zero_side_effect(self):
        bp = mini_blueprint([(G1, make_slots())])
        before = snapshot(bp)
        res = adjust_structure(bp, None)
        self.assertIs(res, bp)                       # 原样返回同一对象
        self.assertEqual(snapshot(bp), before)       # 零副作用（逐字节不变）

    def test_empty_hit_counts_zero_side_effect(self):
        bp = mini_blueprint([(G1, make_slots())])
        before = snapshot(bp)
        self.assertIs(adjust_structure(bp, {}), bp)
        self.assertEqual(snapshot(bp), before)

    def test_hot_group_grows_x1_5(self):
        bp = mini_blueprint([(G1, make_slots())])    # 10 槽 core5/field4/guide1
        adjust_structure(bp, {G1: 8})                # 命中 8 ≥ hot → 10×1.5=15
        l2 = self.l2_of(bp)
        names = [s["name"] for s in l2["files"]]
        self.assertEqual(l2["file_count"], 15)
        self.assertEqual(len(l2["files"]), 15)
        # 新增占位槽：stem=L2 组名（引擎 _make_slots 同款），tier 配额
        # tier_counts(15, ratio)=core8/field5/guide2 → 追加 3/1/1
        by_tier = {t: sum(1 for s in l2["files"] if s["tier"] == t)
                   for t in ("core", "field", "guide")}
        self.assertEqual(by_tier, {"core": 8, "field": 5, "guide": 2})
        self.assertIn("01工程总承包_core_006.pdf", names)  # 引擎同款占位名（组尾追加）
        self.assertIn("01工程总承包_guide_002.md", names)
        # 既有槽不动；新槽是占位（identifier 延续引擎编号）
        self.assertEqual(l2["files"][10]["identifier"], "KBC1-abcd1234-000010")
        self.assertEqual(l2["files"][0]["name"], "水利工程_core_001.pdf")
        # 配比重算（8/5/2 → 最大余数法和恒=100）
        self.assertEqual(sum(bp["ratio"].values()), 100)
        self.assertEqual(bp["ratio"], {"core": 54, "field": 33, "guide": 13})
        # provenance 落账
        self.assertEqual(bp["provenance"]["evidence_weighting"],
                         {"hot": 8, "cold": 2, "groups_grew": 1, "groups_shrunk": 0})
        self.assertTrue(bp["provenance"]["stage_log"][-1].startswith("S9 证据回流加权"))

    def test_cold_group_shrinks_x0_7(self):
        bp = mini_blueprint([(G1, make_slots())])
        adjust_structure(bp, {G1: 2})                # 命中 2 ≤ cold → 10×0.7=7
        l2 = self.l2_of(bp)
        names = [s["name"] for s in l2["files"]]
        self.assertEqual(l2["file_count"], 7)
        self.assertEqual(len(l2["files"]), 7)
        self.assertNotIn("水利工程_field_003.xlsx", names)  # 组尾丢弃
        self.assertNotIn("水利工程_guide_001.md", names)
        self.assertIn("水利工程_core_001.pdf", names)       # 前段保留
        self.assertEqual(sum(bp["ratio"].values()), 100)
        self.assertEqual(bp["ratio"], {"core": 71, "field": 29, "guide": 0})
        self.assertEqual(bp["provenance"]["evidence_weighting"]["groups_shrunk"], 1)

    def test_cold_floor_keeps_min_3_slots(self):
        """下限保底：×0.7 后不足 3 槽的组保 3（3 槽组不再缩，4 槽组缩到 3）。"""
        bp = mini_blueprint([(G1, make_slots(n_core=2, n_field=1, n_guide=0)),
                             (G2, make_slots(n_core=2, n_field=2, n_guide=0))])
        before_ratio = dict(bp["ratio"])
        adjust_structure(bp, {G1: 0, G2: 0})
        self.assertEqual(self.l2_of(bp, 0)["file_count"], 3)   # 3×0.7=2 → 保底 3（不变）
        self.assertEqual(self.l2_of(bp, 1)["file_count"], 3)   # 4×0.7=2.8→3 → 缩到 3
        self.assertEqual(len(self.l2_of(bp, 1)["files"]), 3)
        # G1 未变、G2 变了 → 仍触发配比重算（和恒=100）
        self.assertEqual(sum(bp["ratio"].values()), 100)

    def test_floor_only_no_change_no_provenance_write(self):
        """全部组落到「保底=现值」→ 零变化 → 不写 evidence_weighting/ratio 原样。"""
        bp = mini_blueprint([(G1, make_slots(n_core=2, n_field=1, n_guide=0))])
        before = snapshot(bp)
        adjust_structure(bp, {G1: 0})
        self.assertEqual(snapshot(bp), before)

    def test_mid_band_untouched(self):
        bp = mini_blueprint([(G1, make_slots())])
        before = snapshot(bp)
        adjust_structure(bp, {G1: 5})                # 2 < 5 < 8 中间带
        self.assertEqual(snapshot(bp), before)

    def test_unknown_group_names_untouched(self):
        bp = mini_blueprint([(G1, make_slots())])
        before = snapshot(bp)
        adjust_structure(bp, {"不存在的组": 99})
        self.assertEqual(snapshot(bp), before)

    def test_hot_threshold_takes_precedence_on_overlap(self):
        """hot/cold 区间重叠时 hot 规则优先（规格顺序）：×1.5 生效。"""
        bp = mini_blueprint([(G1, make_slots())])
        adjust_structure(bp, {G1: 2}, hot=2, cold=8)  # 2 同时 ≥hot 且 ≤cold
        self.assertEqual(self.l2_of(bp)["file_count"], 15)

    def test_custom_thresholds(self):
        bp = mini_blueprint([(G1, make_slots())])
        adjust_structure(bp, {G1: 4}, hot=4)          # 自定义 hot=4：4 命中即热
        self.assertEqual(self.l2_of(bp)["file_count"], 15)

    def test_mixed_hot_cold_ratio_still_100(self):
        bp = mini_blueprint([(G1, make_slots()), (G2, make_slots())])
        adjust_structure(bp, {G1: 8, G2: 1})          # G1 热 ×1.5、G2 冷 ×0.7
        self.assertEqual(self.l2_of(bp, 0)["file_count"], 15)
        self.assertEqual(self.l2_of(bp, 1)["file_count"], 7)
        self.assertEqual(sum(bp["ratio"].values()), 100)
        self.assertEqual(bp["ratio"], {"core": 59, "field": 32, "guide": 9})
        self.assertEqual(bp["provenance"]["evidence_weighting"]["groups_grew"], 1)
        self.assertEqual(bp["provenance"]["evidence_weighting"]["groups_shrunk"], 1)

    def test_empty_files_group_skipped(self):
        bp = mini_blueprint([(G1, []), (G2, make_slots())])
        adjust_structure(bp, {G1: 99, G2: 8})
        self.assertEqual(self.l2_of(bp, 0)["file_count"], 0)  # 空组不参与缩放
        self.assertEqual(self.l2_of(bp, 1)["file_count"], 15)

    def test_enrich_then_adjust_pipeline(self):
        """蓝图结构 × 真实命中联动：enrich 记 hit_counts → adjust 热组扩容，
        已回填真实槽保留在前段、追加占位槽在后段。"""
        bp = mini_blueprint([(G1, make_slots())])
        enr.enrich_blueprint(bp, [FakeAdapter("fake", metas(12))], per_topic=12)
        hits = bp["provenance"]["hit_counts"]
        self.assertEqual(hits, {G1: 12})
        adjust_structure(bp, hits)
        slots = self.l2_of(bp)["files"]
        self.assertEqual(len(slots), 15)
        self.assertTrue(all(str(s["source"]).startswith("https://") for s in slots[:10]))
        self.assertTrue(all(s["source"] == "channel_adapter_pending" for s in slots[10:]))
        self.assertEqual(sum(bp["ratio"].values()), 100)


# ---------------- CLI：--evidence 开关 ----------------

class TestCliEvidence(unittest.TestCase):
    def run_main(self, argv, items):
        bp = mini_blueprint([(G1, make_slots())])
        d = tempfile.mkdtemp()
        self.addCleanup(shutil.rmtree, d, True)
        src, out, audit = (os.path.join(d, x) for x in ("bp.json", "out.json", "audit.jsonl"))
        with open(src, "w", encoding="utf-8") as f:
            json.dump(bp, f, ensure_ascii=False)
        buf = io.StringIO()
        with mock.patch.dict(os.environ, {"KB_ADAPTER_AUDIT": audit}), \
                mock.patch.object(enr, "build_default_adapters",
                                  lambda a: [FakeAdapter("fake", items)]), \
                redirect_stdout(buf):
            rc = enr.main([src, "-o", out] + argv)
        self.assertEqual(rc, 0)
        with open(out, encoding="utf-8") as f:
            return json.load(f), buf.getvalue()

    def test_cli_default_off_backward_compatible(self):
        out, _ = self.run_main([], metas(12))          # 默认不开 --evidence
        l2 = out["tree"]["l1"][0]["l2"][0]
        self.assertEqual(l2["file_count"], 10)         # 结构不动
        self.assertEqual(out["ratio"], {"core": 50, "field": 35, "guide": 15})
        self.assertNotIn("evidence_weighting", out["provenance"])
        self.assertIn("hit_counts", out["provenance"])  # 命中事实仍如实记录

    def test_cli_evidence_flag_adjusts_structure(self):
        out, stdout = self.run_main(["--evidence"], metas(12))
        l2 = out["tree"]["l1"][0]["l2"][0]
        self.assertEqual(l2["file_count"], 15)         # hot=12≥8 → ×1.5
        self.assertEqual(sum(out["ratio"].values()), 100)
        self.assertEqual(out["provenance"]["evidence_weighting"]["groups_grew"], 1)
        self.assertTrue(any(line.startswith("[evidence]") for line in stdout.splitlines()))
        self.assertTrue(out["provenance"]["stage_log"][-1].startswith("S9"))

    def test_cli_evidence_no_hits_skips(self):
        out, stdout = self.run_main(["--evidence"], [])
        self.assertNotIn("hit_counts", out["provenance"])
        self.assertNotIn("evidence_weighting", out["provenance"])
        self.assertIn("跳过结构加权", stdout)
        self.assertEqual(out["tree"]["l1"][0]["l2"][0]["file_count"], 10)


if __name__ == "__main__":
    unittest.main()
