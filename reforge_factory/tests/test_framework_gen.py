# -*- coding: utf-8 -*-
"""S1-1 框架生成器 v1 单测 — 纯夹具 (零真池/零网络).

验收: ①schema 校验过 ②同输入重跑 3 次章数波动 ≤1 (实测=0, 指纹同)
③路由字段齐备率 100%. 另覆盖: 四框架族/目标章数补齐裁剪/密度无侦察
只准 low/模型分档/S1 准入门 (批准前不动工)/坏输入硬拒.

跑法: python -X utf8 tests/test_framework_gen.py   (pytest 兼容)
"""
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import charter_gate as CG          # noqa: E402
from superline import contracts as C              # noqa: E402
from superline import framework_gen as FG         # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s11_test_"))


def _charter(family="enterprise", chapters=15, t1=None):
    t1 = t1 or ["中石化南京工程", "中石化南京", "SNEI", "南京工程",
                "中石化", "宁波乙烯"]
    return {"schema": "charter_v1", "campaign_id": "TEST-1",
            "report_title": "《中石化南京工程有限公司怎么干EPC总承包？》",
            "company": "中石化南京工程有限公司", "family": family,
            "input_level": "L1",
            "restatement": "复述: 回答企业怎么干成 EPC 总承包。",
            "reader": "总包企业管理层", "volume": {"chapters": chapters,
                                                 "sections": 3,
                                                 "total_chars": 300000},
            "core_question": "中石化南京工程EPC总承包，到底怎么干成？",
            "counter_questions": ["X 为什么可能是错的？", "X 被谁取代？",
                                  "X 失败案例？"],
            "tiers": {"T1": t1, "T2": ["中石化洛阳工程", "SEI"],
                      "T3": ["EPC总承包", "工程总承包"]},
            "approval": "approved", "round": 1}


# ------------------------------------------------ ①②③ 验收三判据
def test_schema_determinism_and_route_completeness():
    ch = _charter()
    fws = [FG.generate(ch) for _ in range(3)]
    errs = [C.validate_framework(fw) for fw in fws]
    assert all(e == [] for e in errs), errs[0][:3]
    counts = [len(fw["chapters"]) for fw in fws]
    assert max(counts) - min(counts) <= 1            # 波动 ≤1 (实测 0)
    assert counts == [15, 15, 15]
    fps = {C.fingerprint(fw) for fw in fws}
    assert len(fps) == 1                             # 同输入同指纹
    for fw in fws:
        done, total = C.route_completeness(fw)
        assert done == total and total == 15         # 齐备率 100%


# ------------------------------------------------ 四框架族 + 章数补齐裁剪
def test_four_families_and_volume_target():
    for fam in ("enterprise", "industry", "topic", "policy"):
        fw = FG.generate(_charter(family=fam, chapters=9))
        assert C.validate_framework(fw) == []
        assert len(fw["chapters"]) == 9
        assert fw["family"] == fam
    fw30 = FG.generate(_charter(chapters=30))        # 补齐 (12→30)
    assert len(fw30["chapters"]) == 30
    assert C.validate_framework(fw30) == []
    fw5 = FG.generate(_charter(chapters=5))          # 裁剪 (12→5)
    assert len(fw5["chapters"]) == 5
    assert C.validate_framework(fw5) == []
    assert fw5["chapters"][0]["title"] == "引言与研究框架"   # 保头
    assert fw5["chapters"][-1]["title"] == "结论与行动清单"  # 保尾


# ------------------------------------------------ 密度纪律 + 模型分档
def test_density_rules_and_model_band():
    fw = FG.generate(_charter())
    assert all(c["evidence_density"] == "low" for c in fw["chapters"])  # 无侦察只准 low
    assert all("scout_hits" not in c for c in fw["chapters"])
    scout = {"企业基本面": ["a", "b", "c"], "市场与对标": ["d"]}
    fw2 = FG.generate(_charter(), scout=scout)
    by_t = {c["title"]: c for c in fw2["chapters"]}
    assert by_t["企业基本面"]["evidence_density"] == "high"
    assert by_t["企业基本面"]["scout_hits"] == ["a", "b", "c"]
    assert by_t["市场与对标"]["evidence_density"] == "medium"
    gap_ids = [c["id"] for c in fw2["chapters"]
               if c["budget_band"] == "gap"]
    assert gap_ids and set(gap_ids) <= set(fw2["model_band"]["escalated"])
    assert fw2["model_band"]["default"] == "free"    # 默认免费档


# ------------------------------------------------ tier_map 语义挂点
def test_tier_map_semantic_hooks():
    fw = FG.generate(_charter())
    by_t = {c["title"]: c for c in fw["chapters"]}
    bench = by_t["市场与对标"]
    assert bench["tier_map"].get("T2")               # 对标章挂 T2 竞对词
    assert bench["budget_band"] == "gap"             # 对标章=补弹档
    core = by_t["项目管理体系"]
    assert core["tier_map"].get("T3")                # 体系章挂 T3 领域词
    assert core["tier_map"]["T1"]                    # 每章 T1 非空
    assert fw["chapters"][0]["tier_map"]["T1"] == [  # 引言拿核心词头
        "中石化南京工程", "中石化南京", "SNEI"]


# ------------------------------------------------ S1 准入门 + 硬拒
def test_s1_gate_and_hard_refuse():
    bd = _TMP / "b1"
    (bd / "00 研究报告需求").mkdir(parents=True)
    try:
        FG.load_charter(str(bd))
        raised = False
    except PermissionError:
        raised = True
    assert raised                                    # 未批准禁动工
    calls = []
    orig = CG._push_wecom
    CG._push_wecom = lambda t: calls.append(t) or True
    try:
        CG.build("《中石化南京工程有限公司怎么干EPC总承包？》",
                 battle_dir=str(bd), pool_id="TEST-1")
        CG.submit(str(bd))
        CG.receipt(str(bd), "ACCEPTED")
    finally:
        CG._push_wecom = orig
    ch = FG.load_charter(str(bd))                    # 批准件可载入
    assert ch["approval"] == "approved"
    fw = FG.generate(ch)
    assert C.validate_framework(fw) == []
    assert (bd / "00 研究报告需求" / "framework.json").is_file() is False
    p = FG.render(fw, str(bd))
    assert p.is_file()
    # 硬拒不兜底: 未批准 charter → ValueError (回炉/降级在 S1-3)
    bad = _charter()
    bad["approval"] = "pending"
    try:
        FG.generate(bad)
        refused = False
    except ValueError:
        refused = True
    assert refused
    # 坏 family → ValueError
    try:
        FG.generate(_charter(family="domain"))
        fam_refused = False
    except ValueError:
        fam_refused = True
    assert fam_refused


# ------------------------------------------------ --scout 两形态归一 (S1-2 接口)
def test_load_scout_two_shapes():
    import json
    p1 = _TMP / "scout_bare.json"
    p1.write_text(json.dumps({"企业基本面": ["a", "b"]}, ensure_ascii=False),
                  encoding="utf-8")
    assert FG._load_scout(str(p1)) == {"企业基本面": ["a", "b"]}
    p2 = _TMP / "scout_v1.json"                       # S1-2 scout.json 包形
    p2.write_text(json.dumps({"schema": "scout_v1", "hits": {
        "企业基本面": [{"title": "t", "url": "u", "source":
                       "zh-search-pro", "query": "q"}],
        "零章": []}}, ensure_ascii=False), encoding="utf-8")
    got = FG._load_scout(str(p2))
    assert list(got) == ["企业基本面"]                  # 空命中键剔除
    assert got["企业基本面"] == ["t | u"]


# ------------------------------------------------ S1-3 回炉环 + 降级 (验收: 各触发≥1)
def test_s13_rework_and_degrade_paths():
    import json
    bd = _TMP / "b13"
    out = bd / "00 研究报告需求"
    out.mkdir(parents=True, exist_ok=True)
    ch = _charter()
    good = json.dumps(FG.generate(ch), ensure_ascii=False, indent=1)
    # ① 坏 JSON 注入 (尾逗号) → 回炉 r1 清洗修复 (数据零丢失)
    (out / "framework.json").write_text(good.rstrip()[:-1] + ",}",
                                        encoding="utf-8")
    fw, meta = FG.load_framework(str(bd), ch)
    assert meta["mode"] == "reworked" and meta["rounds"] >= 1
    assert C.validate_framework(fw) == [] and len(fw["chapters"]) == 15
    # ② GBK 编码体 → r2 抢救 (utf-8 严格读死)
    (out / "framework.json").write_bytes(good.encode("gbk"))
    fw2, meta2 = FG.load_framework(str(bd), ch)
    assert meta2["mode"] == "reworked"
    assert C.validate_framework(fw2) == []
    # ③ 全轮死 → 降级 default_framework (warn 在 + 校验零错 + 账本留痕)
    (out / "framework.json").write_bytes(b"\x88\xff\x99 not-json \x00")
    fw3, meta3 = FG.load_framework(str(bd), ch)
    assert meta3 == {"mode": "degraded", "rounds": FG.MAX_REWORK}
    assert fw3["generator"] == "default_fallback" and fw3["warn"]
    assert C.validate_framework(fw3) == []       # 兜底件不悬空
    ledger = [json.loads(ln) for ln in
              (out / "rework_ledger.jsonl").read_text(encoding="utf-8")
              .splitlines() if ln.strip()]
    kinds = [r["kind"] for r in ledger]
    assert "framework:reworked" in kinds and "framework:degraded" in kinds
    # 好件原样 → clean 零修复轮
    (out / "framework.json").write_text(good, encoding="utf-8")
    _, meta4 = FG.load_framework(str(bd), ch)
    assert meta4["mode"] == "clean" and meta4["rounds"] == 0
    # 缺席 → absent (不臆造)
    (out / "framework.json").unlink()
    fw5, meta5 = FG.load_framework(str(bd), ch)
    assert fw5 is None and meta5["mode"] == "absent"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
