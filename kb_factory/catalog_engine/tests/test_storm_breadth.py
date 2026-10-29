# -*- coding: utf-8 -*-
"""STORM 多视角广度腿测试（v2.7 #13，storm_breadth——巨人 stanford-oval/storm 纯规则复刻）。

覆盖口径（对齐任务单）：
  ① 行业视角库规格：每行业 5-8 视角；律所/工程既定视角在册；关键词组为非空
    子主题词且行业内两两不交（并集>单路的结构性保证）
  ② 水利域多视角 vs 单路 L2 覆盖对比：多视角并集组数 > 单路（最强单视角），
    且 > 需求词直检种子池的单路口径——增益量化进 metrics（breadth_gain）
  ③ 去重负例：同义组必并（包含关系/编辑距离近邻）；非同义负例必不并；
    breadth 输出内两两不同义
  ④ 两段式精修：第一段按视角归并（分区完备不重不漏）；第二段按中图法
    A-Z 序重排（类序单调，未命中殿后）
  ⑤ depth 开关零漂移：无参=depth=None 逐字节一致；显式 standard 仅
    provenance.depth 一键之差（既有契约）；pro/flagship 自动启用 STORM——
    L2 组数/编号零漂移、增强组如实换入、metrics 入 provenance、确定性
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import build_blueprint, storm_breadth  # noqa: E402
from catalog_engine.blueprint import canonical_json  # noqa: E402
from catalog_engine.storm_breadth import (PERSPECTIVES, breadth_expand, blend_topics,  # noqa: E402
                                          dedup_names, same_group)
from catalog_engine.taxonomy import CLC_22  # noqa: E402

WATER = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计",
                                        "工程监理", "工程造价"],
         "intent": "施工与项目管理", "size_hint": "large"}


def _groups(bp):
    return [l2 for l1 in bp["tree"]["l1"] for l2 in l1["l2"]]


def _codes(bp):
    return [l2["code"] for l1 in bp["tree"]["l1"] for l2 in l1["l2"]]


def _names(bp):
    return [l2["name"] for l1 in bp["tree"]["l1"] for l2 in l1["l2"]]


def _water_storm():
    return breadth_expand(WATER["domain"], WATER["keywords"])


# ── ① 行业视角库规格 ──────────────────────────────────────────────────────

def test_perspective_library_shape():
    assert len(PERSPECTIVES) >= 6  # 律所/工程/财务/医疗/教育 + 兜底行业
    for key, ind in PERSPECTIVES.items():
        ps = ind["perspectives"]
        assert 5 <= len(ps) <= 8, f"{key} 视角数 {len(ps)} 越界 [5,8]"
        for p in ps:
            kws = p["keywords"]
            assert p["name"] and isinstance(kws, list) and kws
            assert all(isinstance(k, str) and len(k) >= 2 for k in kws)
            assert p.get("clc_hint") in {c["code"] for c in CLC_22} | {None}
    law = {p["name"] for p in PERSPECTIVES["law"]["perspectives"]}
    eng = {p["name"] for p in PERSPECTIVES["engineering"]["perspectives"]}
    assert {"诉讼仲裁", "合规风控", "尽职调查", "知识产权", "劳动人事"} <= law
    assert {"勘察设计", "施工技术", "质量验收", "安全环保", "运维检修"} <= eng


def test_perspective_keywords_disjoint_within_industry():
    """视角关键词组行业内两两不交 → 多视角并集严格大于任意单路（结构性保证）。"""
    for key, ind in PERSPECTIVES.items():
        seen = {}
        for p in ind["perspectives"]:
            bag = set(p["keywords"]) | {p["name"]}
            for other, obag in seen.items():
                assert bag.isdisjoint(obag), f"{key}: {p['name']} 与 {other} 关键词相交"
            seen[p["name"]] = bag


# ── ② 多视角 vs 单路覆盖对比（量化进 metrics）────────────────────────────

def test_water_union_beats_single_path_metrics():
    r = _water_storm()
    assert r["industry"] == "engineering"
    m = r["metrics"]
    assert m["perspectives_used"] >= 5
    assert m["single_path_groups"] > 0            # 单路基准非空（有比较意义）
    assert m["union_groups"] > m["single_path_groups"]   # 并集 > 最强单视角
    assert m["union_groups"] > m["seed_only_groups"]     # 并集 > 需求词直检种子池
    assert m["breadth_gain"] == m["union_groups"] - m["single_path_groups"]
    assert m["breadth_gain"] > 0
    # 分视角归并计数 ≤ 各自单路草案数（跨视角去重只减不增），且并集=分区和
    per_p = {b["perspective"]: len(b["groups"]) for b in r["by_perspective"]}
    assert per_p and all(v <= m["single_path_groups"] for v in per_p.values())


def test_water_union_groups_are_real_topics():
    """并集组来自真实视角素材（每个组都能溯源到某视角，且为中图法序）。"""
    r = _water_storm()
    assert r["groups"]
    for g in r["groups"]:
        assert g["perspective"] in r["perspectives"]
        assert isinstance(g["name"], str) and 2 <= len(g["name"]) <= 30


# ── ③ 去重负例：同义组必并 ────────────────────────────────────────────────

def test_dedup_merges_synonym_groups():
    # 正例：同义组必并——包含关系（整串互含）
    assert len(dedup_names(["质量验收", "质量验收管理"])) == 1
    assert len(dedup_names(["民事诉讼", "民事诉讼实务"])) == 1
    # 正例：同义组必并——编辑距离近邻（错别字/近形）
    assert len(dedup_names(["工程造价咨询", "工程造价资询"])) == 1  # 距离1
    assert len(dedup_names(["运维检修实务", "运维检修实夯"])) == 1  # 距离1（≥5字容差2）
    # 负例：非同义必不并
    assert len(dedup_names(["质量验收", "安全环保"])) == 2
    assert len(dedup_names(["诉讼仲裁", "劳动人事"])) == 2
    assert len(dedup_names(["工程勘察", "地质勘察"])) == 2  # 4字距离2 > 容差1
    assert same_group("竣工结算", "竣工资料") is False


def test_breadth_output_has_no_synonym_pairs():
    """水利域并集清单内两两不同义（宽进后必并掉同义组）。"""
    r = _water_storm()
    names = [g["name"] for g in r["groups"]]
    for i in range(len(names)):
        for j in range(i + 1, len(names)):
            assert not same_group(names[i], names[j]), \
                f"同义组未并: {names[i]} ~ {names[j]}"


def test_blend_topics_dedup_and_length_contract():
    """blend 契约：长度恒=plan_l2；同义组不二进（尾部回填保长）；无相关组零改动。"""
    spec = {"code": "T", "name": "工业技术", "theme": "", "source": "", "seed_topics": []}
    base = [f"骨架主题{i:02d}" for i in range(1, 13)]
    storm = {"groups": [{"name": n, "perspective": "施工技术",
                         "clc": "T", "clc_name": "工业技术"}
                        for n in ("混凝土浇筑", "灌浆施工", "土石方开挖", "基坑工程")]}
    out, added = blend_topics(spec, base, 12, storm)
    assert len(out) == 12 and added == 3            # k = 12//4 = 3
    assert out[-3:] == ["混凝土浇筑", "灌浆施工", "土石方开挖"]  # 尾部换入
    # 同义组必并：骨架已含同名组时不二进，回填原尾保长（added 只计实换入）
    base2 = ["施工组织设计"] + [f"骨架主题{i:02d}" for i in range(2, 12)]
    storm2 = {"groups": [{"name": n, "perspective": "施工技术", "clc": "T",
                          "clc_name": "工业技术"}
                         for n in ("施工组织设计", "混凝土浇筑", "灌浆施工")]}
    out2, added2 = blend_topics(spec, base2, 12, storm2)
    assert len(out2) == 12 and added2 == 2
    assert out2.count("施工组织设计") == 1 and "混凝土浇筑" in out2
    # 无相关组（clc 不对齐且组名与 spec 名不互含）→ 原样返回
    spec_x = {"code": "MK", "name": "市场库", "theme": "", "source": "", "seed_topics": []}
    out3, added3 = blend_topics(spec_x, base, 12, storm)
    assert out3 == base and added3 == 0
    # storm=None 零漂移
    out4, added4 = blend_topics(spec, base, 12, None)
    assert out4 == base and added4 == 0


# ── ④ 两段式精修 ──────────────────────────────────────────────────────────

def test_two_stage_refinement_by_perspective():
    """第一段按视角归并：分区完备（并集=分区和、不重不漏、视角序=声明序）。"""
    r = _water_storm()
    parts = [list(b["groups"]) for b in r["by_perspective"]]
    flat = [n for part in parts for n in part]
    assert sorted(flat) == sorted(g["name"] for g in r["groups"])
    assert len(flat) == len(set(flat))  # 不重
    assert r["by_perspective"][0]["perspective"] == r["perspectives"][0]


def test_two_stage_refinement_clc_order():
    """第二段按中图法 A-Z 序重排：类序单调不减，未命中（clc=None）殿后。"""
    r = _water_storm()
    order = {c["code"]: i for i, c in enumerate(CLC_22)}
    idx_seq = [order[g["clc"]] if g["clc"] else len(order) + 1 for g in r["groups"]]
    assert idx_seq == sorted(idx_seq)  # 单调（未归类 > 任何类 > 越界码）
    assert any(g["clc"] for g in r["groups"])  # 水利域确有可归类组


# ── ⑤ depth 开关零漂移（build 管线接线）──────────────────────────────────

def test_depth_switch_standard_zero_drift():
    """无参 = depth=None 逐字节一致；非法值同；显式 standard 仅 provenance.depth
    一键之差（既有契约），两者都无 provenance.storm（STORM 不启用=零漂移）。"""
    a = build_blueprint(WATER, mode="taxonomy")
    b = build_blueprint(WATER, mode="taxonomy", depth=None)
    assert canonical_json(a) == canonical_json(b)
    for bad in ("", "huge", "deep", 2, True):
        c = build_blueprint(WATER, mode="taxonomy", depth=bad)
        assert canonical_json(c) == canonical_json(a), f"非法 depth={bad!r} 漂移"
    std = build_blueprint(WATER, mode="taxonomy", depth="standard")
    for k in ("tree", "ratio", "stats", "quote", "need", "domain"):
        assert a[k] == std[k], f"{k} 被显式 standard 改动"
    assert std["provenance"]["depth"] == "standard"
    assert "storm" not in std["provenance"] and "storm" not in a["provenance"]
    assert not any("S2b" in line for line in std["provenance"]["stage_log"])


def test_depth_pro_flagship_enable_storm_structure_stable():
    """pro/flagship 自动启用 STORM：metrics 入 provenance、L2 组数/编号零漂移、
    增强组如实换入（蓝图内 storm 组名覆盖数多于 standard）、槽量仍按深度档放大。"""
    std = build_blueprint(WATER, mode="taxonomy")
    outs = {d: build_blueprint(WATER, mode="taxonomy", depth=d)
            for d in ("pro", "flagship")}
    storm_names = {g["name"] for g in _water_storm()["groups"]}
    cov_std = len(storm_names & set(_names(std)))
    for d, bp in outs.items():
        st = bp["provenance"]["storm"]
        assert st["enabled"] is True and st["industry"] == "engineering"
        assert st["union_groups"] > st["single_path_groups"] > 0  # 增益量化入档
        assert st["breadth_gain"] == st["union_groups"] - st["single_path_groups"]
        assert st["groups_blended"] >= 1
        assert any("S2b STORM多视角广度" in line for line in bp["provenance"]["stage_log"])
        # 结构零漂移：编号/组数不变，只换名；槽量=深度档口径（轨A4 不破）
        assert _codes(bp) == _codes(std)
        assert bp["stats"]["l2_count"] == std["stats"]["l2_count"]
        assert bp["stats"]["files"] > std["stats"]["files"]
        for name in set(_names(bp)) - set(_names(std)):  # STORM 换入名守 lint 口径
            assert 2 <= len(name) <= 30  # （种子骨架既有长书名是历史口径，只计增量）
        assert len(storm_names & set(_names(bp))) > cov_std  # 覆盖增长
    # 旗舰档换入更多（并集面相同，但组内槽数×1.8 的同时增强组同在）
    assert (outs["flagship"]["stats"]["files"]
            > outs["pro"]["stats"]["files"] > std["stats"]["files"])


def test_storm_determinism_and_lint_still_pass():
    """同输入同 depth 同输出（含 STORM 路径）；pro 蓝图仍过反模式 lint 发布门。"""
    a = build_blueprint(WATER, mode="taxonomy", depth="pro")
    b = build_blueprint(WATER, mode="taxonomy", depth="pro")
    assert canonical_json(a) == canonical_json(b)
    assert a["provenance"]["lint"]["overall_pass"] is True


if __name__ == "__main__":
    for fn in [test_perspective_library_shape, test_perspective_keywords_disjoint_within_industry,
               test_water_union_beats_single_path_metrics, test_water_union_groups_are_real_topics,
               test_dedup_merges_synonym_groups, test_breadth_output_has_no_synonym_pairs,
               test_blend_topics_dedup_and_length_contract,
               test_two_stage_refinement_by_perspective, test_two_stage_refinement_clc_order,
               test_depth_switch_standard_zero_drift,
               test_depth_pro_flagship_enable_storm_structure_stable,
               test_storm_determinism_and_lint_still_pass]:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
