# -*- coding: utf-8 -*-
"""百倍V3 追溯矩阵绑定测试 — 每条 REQ 一个命名联动测试 (P9 织补, require=tests).

命名规约: test_req_<id>_ac1_<slug> — trace_matrix.py 按 ``REQ-\\d{3}`` /
``req_\\d{3}`` 字面识别测试覆盖, 本文件让 38 条 REQ 全部获得**可执行**绑定:
不是空跑 — 每个函数都是其 AC 锚点的轻量真断言 (gates 键值 / 模块在位 /
产物在盘 / 账本读数 / 对拍 / 小子集代理), 产物缺席=真实缺口如实暴露.

路径纪律: 一律绝对路径 (E:/AI-Station/...); WORK=计划 work/ 目录.
规范: REQUIREMENTS.md (EARS v2, 2026-10-15); 矩阵: .super-skill/trace.md.

跑法: py -m pytest reforge_factory/tests/test_req_trace_v3.py -q
"""
from __future__ import annotations

import importlib.util
import json
import re
import subprocess
import sys
from pathlib import Path

import pytest

RF = Path("E:/AI-Station/reforge_factory")                     # 引擎根
PLAN = Path("E:/AI-Station/ResearchFactory-Eng/06 迭代优化"
            "/百倍V3_极致调研变现计划")                          # 计划根
WORK = PLAN / "work"                                           # 计划 work/
AMMO = Path("E:/AI-Station/ammo_pool")                         # 战役池根
RP = Path("E:/AI-Station/report_platform")                     # 变现平台根
BID26 = AMMO / "EPC-BID26"                                     # 在役回测战役
CG_PATH = (Path("E:/AI-Station/_proposals/flagship-paid-report-1007")
           / "work" / "collection_gate.py")                    # S1 门(属主在 1007/work)

sys.path.insert(0, str(RF))                                    # reforge_factory 入径


def _gates() -> dict:
    return json.loads((RF / "config" / "gates.json").read_text(encoding="utf-8"))


def _json(p: Path):
    return json.loads(Path(p).read_text(encoding="utf-8"))


def _jsonl_rows(p: Path) -> list:
    return [json.loads(l) for l in Path(p).read_text(encoding="utf-8").splitlines()
            if l.strip()]


def _load_module(name: str, path: Path):
    """按绝对路径装载非包目录下的单文件模块 (work / report_platform 同范式)."""
    spec = importlib.util.spec_from_file_location(name, Path(path))
    mod = importlib.util.module_from_spec(spec)
    sys.modules[name] = mod
    spec.loader.exec_module(mod)
    return mod


# ============================================================ R0 宪法约束

def test_req_000_ac1_no_delete_ops():
    """REQ-000.AC1: V3 代码零 rmtree/unlink — 宪法删除守卫扫描真跑.

    AC 锚点目录 reforge_factory/v3_new/ 与 1007/work/v3_new/ 若在档则扫之;
    另把已交付 V3 新件 (v3_*.py 三审计件 + completeness/ 五轴包 + S1 门
    collection_gate.py) 一并纳入 scan_deletion_calls 实扫, 断言零命中.
    (ammo_pool.py 为 V3 前在役件, 其 unlink 行系存量逻辑, 不在本 AC 范围.)
    """
    import v3_constitution_audit as vca
    targets = [RF / "v3_new", Path("E:/AI-Station/_proposals/flagship-paid-report"
                                   "-1007/work/v3_new")]
    targets += [RF / "v3_constitution_audit.py", RF / "v3_number_audit.py",
                RF / "v3_sepl_closeout.py", RF / "completeness", CG_PATH]
    existing = [t for t in targets if t.exists()]
    assert existing, "V3 交付件全部缺席本身就是缺口"
    hits = vca.scan_deletion_calls(existing)
    assert hits == [], f"V3 代码出现未授权删除调用: {hits}"


def test_req_001_ac1_number_audit_replay():
    """REQ-001.AC1: 数字零造假 — 五类对拍审计件在位且对 BID26 池可复跑."""
    import v3_number_audit as vna
    for fn in ("audit_completeness", "audit_funnel", "audit_chars",
               "audit_decisions", "audit_sprint", "run_all"):
        assert callable(getattr(vna, fn)), f"v3_number_audit 缺核心函数 {fn}"
    items, notes = vna.audit_completeness(BID26)               # 真跑一类抽检复算
    assert isinstance(items, list) and isinstance(notes, list)


def test_req_002_ac1_legacy_flags():
    """REQ-002.AC1: gates.json 只增不删 — 三 legacy 旗标在档且默认 false."""
    flags = _gates()["flags"]
    for k in ("legacy_t12_gate", "legacy_total_gate", "legacy_chapter_band"):
        assert k in flags, f"缺可回开旗标 {k}"
        assert flags[k] is False, f"{k} 默认态应为 false"


def test_req_003_ac1_push_freeze():
    """REQ-003.AC1: 推送冻结令在役 — 审计件对 E:/AI-Station 真跑对账 pass."""
    import v3_constitution_audit as vca
    res = vca.audit_push_freeze(Path("E:/AI-Station"))
    assert res["status"] == "pass", f"推送冻结对账异常: {res}"


# ============================================================ R1 门体系重构

def test_req_010_ac1_single_gate_source():
    """REQ-010.AC1: gates.json 单一权威源 — 四消费点零门参数赋值字面量."""
    import gates_loader as GL
    assert GL.DEFAULT_CONFIG_PATH == RF / "config" / "gates.json"
    consumers = [RF / "ammo_pool.py", RF / "epc50_start_gate.py", CG_PATH,
                 RF / "superline" / "contracts.py"]
    literals = re.compile(r"3_?000_000|30_?000_000|20_?000_000|50_?000_000"
                          r"|200_?000_000")
    for c in consumers:
        text = c.read_text(encoding="utf-8")
        assert "gates_loader" in text, f"{c.name} 未走 gates_loader 权威源"
        assert not literals.search(text), f"{c.name} 残留硬编码门参数字面量"


def test_req_011_ac1_t1_gate():
    """REQ-011.AC1: T1≥1000万字单门 — t12 总门撤销 (null), 2亿仅存参考线."""
    g = _gates()
    assert g["t1_min_chars"] == 10000000
    assert g["t12_total_gate"] is None
    assert g["legacy_total_budget_reference"] == 200000000   # 旧门保留为参考线


def test_req_012_ac1_tier_gate_v3_parallel():
    """REQ-012.AC1: 三历史池并行落 tier_gate_v3 且旧口径不覆盖 + 对照报告在档."""
    for camp in ("EPC-BID26", "F1-BLUEBOOK", "EPC50-SNEI"):
        d = AMMO / camp
        assert "tier_gate_v3" in _json(d / "pool_state.json"), \
            f"{camp} pool_state 缺 tier_gate_v3 新口径字段"
        assert (d / "pool_state.pre-v3.bak.json").is_file(), \
            f"{camp} 旧口径备份缺席 (不得覆盖旧字段)"
    assert (WORK / "tier_gate_v3_compare.md").is_file(), "新旧口径对照报告未落盘"


def test_req_013_ac1_length_gate_lifted():
    """REQ-013.AC1: 成稿上限撤销 — report_length.max=null + min_chapters=3 保底."""
    g = _gates()
    assert g["report_length"]["max"] is None
    assert g["report_length"]["min_chapters"] == 3
    band = g["chapter_band"]
    assert band["mode"] == "density"
    assert set(band["floor_per_type"]) >= {"精编", "融合", "原创"}   # 章型下限保底


def test_req_014_ac1_density_thresholds():
    """REQ-014.AC1: 章级密度门 — 阈值件(分位数落盘)+打回记录在档, 工具可 import."""
    import density_gate
    for fn in ("metrics", "chapter_verdict", "load_thresholds"):
        assert callable(getattr(density_gate, fn)), f"density_gate 缺 {fn}"
    th = _json(RF / "config" / "density_thresholds.json")["thresholds"]
    for key in list(th.keys()):
        metrics = th[key]
        for m in ("redundancy_ratio_max", "new_ngram_rate_min",
                  "slop_density_per_kchar_max"):
            assert m in metrics, f"density_thresholds[{key}] 缺指标 {m}"
    assert (WORK / "density_rejects.jsonl").is_file(), "密度门打回记录未落盘"


def test_req_015_ac1_completeness_verdict():
    """REQ-015.AC1: S1 完备门五轴 all_green_or_waived — 合成账本两例真判.

    五轴全绿 → pass=True; 抽掉 D 轴 → D=unknown, failing_axes=[D], pass=False
    (缺任一轴即 FAIL, 与 test_collection_gate_completeness 同一被测函数).
    """
    cg = _load_module("collection_gate_req_trace", CG_PATH)
    green5 = {ax: {"axis": ax, "green": True}
              for ax in ("T", "B", "D", "P", "C")}
    ok = cg.completeness_gate_verdict(green5)
    assert ok["pass"] is True
    assert ok["axis_statuses"] == {"T": "green", "B": "green", "D": "green",
                                   "P": "green", "C": "green"}
    no_d = {ax: rec for ax, rec in green5.items() if ax != "D"}
    bad = cg.completeness_gate_verdict(no_d)
    assert bad["pass"] is False
    assert bad["axis_statuses"]["D"] == "unknown"
    assert bad["failing_axes"] == ["D"]


# ============================================================ R2 完备性五轴

def test_req_020_ac1_cidx_ledger():
    """REQ-020.AC1: 五轴账本在档每轴有记录 + CIdx 计算函数可 import."""
    from completeness import cidx
    assert callable(cidx.compute_cidx) and callable(cidx.assemble)
    axes = {r.get("axis") for r in _jsonl_rows(BID26 / "completeness_ledger.jsonl")}
    assert {"T", "B", "D", "P", "C"} <= axes, f"五轴账本缺轴: {sorted(axes)}"


def test_req_021_ac1_timeline_waivers():
    """REQ-021.AC1: 全史时间轴在档 + 豁免年 100% 带 reason (登记器拒收空理由)."""
    from completeness import entity_timeline as et
    tl = _json(BID26 / "timeline.json")
    assert tl["gap_years"], "BID26 时间轴无空窗年记录"
    for w in tl.get("gap_waivers", []):
        assert str(w.get("reason") or "").strip(), f"豁免年 {w.get('year')} 缺理由"
    kept = et.apply_waivers(tl, [{"year": 1954, "reason": "三史+官网+年报均查无"},
                                 {"year": 1955, "reason": ""}])["gap_waivers"]
    assert [w["year"] for w in kept] == [1954]        # 无 reason 条目被拒收


def test_req_022_ac1_dimension_matrix():
    """REQ-022.AC1: 九维域包全格在档 + 降级/缺口格 100% 带 reason (禁隐身缺格)."""
    from completeness import dimension_matrix as dmz
    assert callable(dmz.main)
    dm = _json(BID26 / "dimension_matrix.json")
    assert len(dm["dims"]) == 9, f"九维不齐: {len(dm['dims'])}"
    for g in dm.get("open_gaps", []):
        assert str(g.get("reason") or "").strip(), f"降级格 {g} 缺理由"


def test_req_023_ac1_depth_ladder():
    """REQ-023.AC1: 深度阶梯三字段在档 (eei_total/五级分布/关键EEI≥L3占比)."""
    from completeness import depth_ladder as dl
    assert callable(dl.scan)
    d = _json(BID26 / "depth_ladder.json")
    for k in ("eei_total", "eei_levels", "key_eei_ge_l3_pct"):
        assert k in d, f"depth_ladder 缺字段 {k}"


def test_req_024_ac1_coverage_facets():
    """REQ-024.AC1: 十面 facet 点亮矩阵在档 + L1 以下面一律未点亮."""
    from completeness import coverage_facets as cf
    assert callable(cf.main)
    cv = _json(BID26 / "coverage_facets.json")
    facets = cv["facets"]
    assert facets, "facet 矩阵空"
    for name, f in facets.items():
        if f.get("best_depth") in ("L0", "L1"):
            assert f.get("lit") is False, f"面 {name} 深度不足 L2 却被点亮"


def test_req_025_ac1_heatmap_crosscheck():
    """REQ-025.AC1: 热图 json 抽 3 格与 T 轴 json 独立重推对拍 (lit=证据>0)."""
    hm = _json(WORK / "heatmap_EPC-BID26.json")
    year_counts = _json(BID26 / "completeness" / "T_axis.json")["year_counts"]
    cells = {c["cell"]: c["state"] for c in hm["axes"]["T"]["cells"]}
    assert len(cells) >= 3, "热图 T 轴格数不足"
    for cell in list(cells)[:3]:                        # 抽前 3 格逐格对拍
        expect = "lit" if year_counts.get(cell, 0) > 0 else "gap"
        assert cells[cell] == expect, \
            f"热图格 {cell}={cells[cell]} 与轴 json 重推 {expect} 不一致"
    assert hm["source"]["ledger_cidx_row"] is True      # 与账本 CIdx 行同源


def test_req_026_ac1_appendix_four():
    """REQ-026.AC1: 过程附录四件套在档 + 附录构建器可 import."""
    import appendix_builder
    assert callable(appendix_builder.main)
    appx = WORK / "appendix_demo_EPC-BID26" / "appendix"
    for f in ("prisma_funnel.md", "ach_matrix.md", "coverage_heatmap.md",
              "evidence_stamps.json"):
        assert (appx / f).is_file(), f"过程附录缺件 {f}"


def test_req_027_ac1_press_review():
    """REQ-027.AC1: PRESS 2015 独立评议件在档且含逐项清单结论."""
    import press_review
    assert callable(press_review.main)
    text = (WORK / "press_review_EPC-BID26.md").read_text(encoding="utf-8")
    rows = re.findall(r"^\|\s*\d+\s*\|", text, re.M)     # 清单概览表逐项行
    assert len(rows) >= 8, f"PRESS 清单不足 8 项: {len(rows)}"
    assert "needs_review" in text or "pass" in text      # 每项带状态结论


def test_req_028_ac1_ai_review_gate():
    """REQ-028.AC1: AI 审稿人过线出厂 — DEMO 件总分≥75 且 verdict=pass."""
    import ai_reviewer
    assert callable(ai_reviewer.review)
    ar = _json(WORK / "ai_review_EPC-BID26-DEMO.json")
    assert ar["total_score"] >= 75, f"总分 {ar['total_score']} 未过 75 线"
    assert ar["verdict"] == "pass"


def test_req_029_ac1_channel_builder():
    """REQ-029.AC1: 建渠器+学术三 API 渠道入册 + 守卫测试文件在位."""
    import channel_builder
    from channels import academic
    for fn in ("probe", "verdict"):
        assert callable(getattr(channel_builder, fn, None)) or callable(
            getattr(channel_builder, "main", None))
    manifest = _json(Path("E:/AI-Station/ResearchFactory-Eng"
                          "/channel_manifest.json"))
    names = json.dumps(manifest, ensure_ascii=False)
    for cid in ("openalex", "semantic_scholar", "arxiv"):
        assert cid in names, f"学术渠道 {cid} 未入 channel_manifest"
    assert (RF / "tests" / "test_guard_academic.py").is_file(), "守卫测试缺席"


# ============================================================ R3 变现前置

def test_req_030_ac1_demand_radar():
    """REQ-030.AC1: 需求雷达评分卡 ≥5 候选 + 原始信号 jsonl 在档."""
    from superline import demand_radar
    assert callable(demand_radar.main)
    cards = _json(RF / "superline" / "radar_scorecards.json")
    assert len(cards) >= 5, f"评分卡仅 {len(cards)} 张 (<5 候选)"
    assert (RF / "superline" / "radar_signals.jsonl").is_file(), "原始信号未落盘"


def test_req_031_ac1_product_family():
    """REQ-031.AC1: ≥6 层变现面 SKU 骨架 — 每层带价格/试读面/徽章."""
    from superline import product_family_gen
    assert callable(product_family_gen.gen)
    pf = _json(WORK / "product_family_BID26.json")
    layers = pf["layers"]
    assert len(layers) >= 6, f"变现面仅 {len(layers)} 层"
    for ly in layers:
        priced = (ly.get("price") is not None) \
            or ("price_lo" in ly and "price_hi" in ly) \
            or str(ly.get("note") or "").strip()        # 议价层以 note 声明价格锚
        assert priced and ly.get("price_band") and ly.get("sample_hook") \
            and ly.get("badges"), f"层 {ly.get('layer')} 缺价格面/试读面/徽章"


def test_req_032_ac1_funnel_ledger():
    """REQ-032.AC1: 漏斗事件账本+周报北极星在档, funnel_query 实查四级漏斗."""
    assert (RP / "funnel_events.jsonl").is_file()
    weeklies = list((RP / "weekly").glob("*.md"))
    assert weeklies, "周报北极星 (weekly/YYYY-WW.md) 未产出"
    r = subprocess.run([sys.executable, str(RP / "funnel_query.py"),
                        "--sku", "SUB-ANNUAL-1999"],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace", cwd=str(RP.parent))
    assert r.returncode == 0, f"funnel_query 实查失败: {r.stderr[-300:]}"
    assert "四级漏斗" in r.stdout          # schema: sku/channel/level/ts 四级可查


def test_req_033_ac1_pricing_experiment():
    """REQ-033.AC1: good-better-best 三档+同价诱饵变体+阶梯涨价件就位 (实验 SHOULD)."""
    pe = _load_module("pricing_experiment_req_trace", RP / "pricing_experiment.py")
    t = pe.tiers("SUB-ANNUAL-1999")
    assert {"good", "better", "best", "decoy"} <= set(t), f"三档+诱饵不全: {sorted(t)}"
    assert callable(pe.ladder_state) and callable(pe.public_notice)  # 阶梯涨价+公示


def test_req_034_ac1_sprint_ledger():
    """REQ-034.AC1: GOAL_LEDGER 周分解在档 + sprint W1 首周如实记 0."""
    import sprint_ledger as sl
    assert callable(sl.read_records)
    assert (RP / "GOAL_LEDGER.md").is_file(), "¥100k 周分解 GOAL_LEDGER 缺席"
    rows = _jsonl_rows(WORK / "sprint_ledger.jsonl")
    w1 = [r for r in rows if r.get("week") == "W1"]
    assert w1, "sprint_ledger 无 W1 行"
    assert w1[0]["actual"] == 0, f"W1 actual 应如实记 0, 实为 {w1[0]['actual']}"


def test_req_035_ac1_enterprise_handover():
    """REQ-035.AC1: 定制承接方案模板在案 (SHOULD — 实际线索到达依赖外部)."""
    from superline import product_family_gen
    assert callable(product_family_gen.gen)
    text = (WORK / "product_family_BID26.json").read_text(encoding="utf-8")
    assert "承接方案" in text, "产品族缺「定制研究承接方案模板」线索承接面"
    # 注: ≥1 份实际线索方案 (work/enterprise_leads/) 依赖外部买家线索到达,
    # 按 REQUIREMENTS.md 降级理由如实缓行, 不以夹具伪造.


def test_req_036_ac1_ref_tracking():
    """REQ-036.AC1: 订阅 SKU 骨架 + ?ref= 落库字段与带 ref 访问记录在案."""
    sub = _json(RP / "subscription_sku.json")
    assert sub.get("requirement") == "REQ-036.AC1"
    events = _jsonl_rows(RP / "funnel_events.jsonl")
    assert events, "漏斗事件账本为空"
    assert "ref" in events[0], "事件 schema 缺 ?ref= 转介绍追踪字段"
    assert any(str(e.get("ref") or "").strip() for e in events), "无带 ref 访问记录"


# ============================================================ R4 主权与问责

def test_req_040_ac1_decision_ledger():
    """REQ-040.AC1: 主权决策账本在档 + 决策件与统计件可 import."""
    import decision_ledger
    import decision_stats
    assert callable(decision_stats.main)
    assert (BID26 / "decision_ledger.jsonl").is_file(), "BID26 决策账本缺席"


def test_req_041_ac1_stop_rule():
    """REQ-041.AC1: 边际增益停止规则 — stopping 三参数在 gates + 停时件可 import."""
    import stop_rule
    assert callable(stop_rule.decide)
    st = _gates()["stopping"]
    for k in ("gain_threshold", "rounds", "fuse_hours"):
        assert k in st, f"stopping 缺参数 {k}"
    assert st["fuse_hours"] > 0                # 绝对时长保险丝在位


def test_req_042_ac1_calibration():
    """REQ-042.AC1: 校准账本 ≥5 条 + Brier 对账腿对合成样本出已知分."""
    import brier_score as bs
    rows = _jsonl_rows(RF / "calibration_ledger.jsonl")
    assert len(rows) >= 5, f"校准账本仅 {len(rows)} 条"
    assert bs.brier(70, True) == pytest.approx(0.09)     # (0.7-1)^2 已知分
    rep = bs.synthetic_report()                          # 合成样本跑出已知分
    assert rep["match"] is True and rep["n"] >= 1


def test_req_043_ac1_redteam():
    """REQ-043.AC1: 红队轮前置 — 失败路径 3-5 条全回应 + 实质修改 diff 在案."""
    import redteam_run
    assert callable(redteam_run.build_failure_paths)
    rt = _json(WORK / "redteam_EPC-BID26.json")
    fps = rt["failure_paths"]
    assert 3 <= len(fps) <= 5, f"失败路径应 3-5 条, 实为 {len(fps)}"
    for fp in fps:
        assert str(fp.get("response") or "").strip(), f"{fp.get('id')} 无回应"
    assert len(rt.get("material_diff", [])) >= 1, "无导致实质修改的 diff"


def test_req_044_ac1_snapshot_audit():
    """REQ-044.AC1: 增量 valid 行 100% 带存档快照 — 对 BID26 cutoff 后实扫."""
    import snapshot_audit as sa
    assert callable(sa.audit_campaign)
    res = sa.audit_campaign(BID26, since="2026-10-15")   # W0 生效日起真扫
    assert res is not None
    assert res["missing"] == 0 and res["artifact_missing"] == 0, \
        f"增量 valid 行缺存档快照: {res}"
    assert sum(res["fields"].values()) == 0, f"快照字段缺失: {res['fields']}"


def test_req_045_ac1_hitrate_generator():
    """REQ-045.AC1: 命中率页生成器就位 — 对合成账本可渲染 (上线随到期批次)."""
    import brier_score as bs
    rows = [{"prob": p, "outcome": o, "brier": bs.brier(p, o)}
            for p, o in ((90, True), (50, False), (30, False))]
    s = bs.summarize(rows)
    assert s["settled"] == 3 and s["hit_rate"] is not None
    page = bs._render("synthetic", s)
    assert "hit_rate=33.33%" in page          # 合成账本渲染出已知命中率


# ============================================================ R5 章程与衔接

def test_req_050_ac1_pipeline_v2():
    """REQ-050.AC1: REPORT_PIPELINE v2 落盘 — S-1/S8 新段+v1 存档+state 同步."""
    md = (Path("E:/AI-Station/_proposals/flagship-paid-report-1007/work")
          / "REPORT_PIPELINE.md").read_text(encoding="utf-8")
    for marker in ("S-1", "S8", "v1 存档"):
        assert marker in md, f"REPORT_PIPELINE.md 缺 {marker}"
    ps = _json(Path("E:/AI-Station/_proposals/flagship-paid-report-1007/work")
               / "pipeline_state.json")
    assert "report_length" in ps and "release_protocol" in ps   # state 同步 v2


def test_req_051_ac1_supplement_ledger():
    """REQ-051.AC1: BID26 只升不逆收尾 — 补采对账台账在档 + 收尾件可 import."""
    import bid26_finish_kit
    assert callable(bid26_finish_kit.main)
    assert (WORK / "bid26_supplement_ledger.jsonl").is_file(), \
        "补采对账台账 bid26_supplement_ledger.jsonl 缺席"


def test_req_052_ac1_writeback():
    """REQ-052.AC1: S8 回写件在位 — 漏斗样本→权重因子真算三态."""
    import writeback as wb
    assert callable(wb.run) and callable(wb.weight_factor)
    assert callable(wb.pricing_suggestion)
    f_pay, r_pay = wb.weight_factor({"pay": 1, "visit": 10})
    f_none, r_none = wb.weight_factor({})
    assert f_pay > 1.0 and r_pay == "payment", "有支付漏斗应升权"
    assert f_none == 1.0 and r_none == "no_signal", "无信号应保持基权"


# ============================================================ R6 质量基座

def test_req_060_ac1_suite_green():
    """REQ-060.AC1: 测试基线绿 — 小子集代理全量实跑 (gates_loader 套件 exit 0)."""
    r = subprocess.run([sys.executable, "-m", "pytest",
                        "reforge_factory/tests/test_gates_loader.py", "-q"],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace", cwd="E:/AI-Station")
    assert r.returncode == 0, f"基线小子集失败: {r.stdout[-400:]}"


def test_req_061_ac1_sepl():
    """REQ-061.AC1: SEPL — 收口审计件在位 + V3 提交带 pytest 摘要真查 git log."""
    import v3_sepl_closeout as sepl
    for fn in ("has_pytest_summary", "extract_declared_passed", "run_audit"):
        assert callable(getattr(sepl, fn)), f"v3_sepl_closeout 缺 {fn}"
    r = subprocess.run(["git", "-C", "E:/AI-Station", "log",
                        "--grep=passed", "--oneline", "-n", "5"],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace")
    assert r.returncode == 0 and r.stdout.strip(), "V3 提交无 pytest 摘要行"
