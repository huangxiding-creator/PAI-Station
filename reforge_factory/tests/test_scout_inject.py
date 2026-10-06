# -*- coding: utf-8 -*-
"""S1-2 侦察注入腿单测 — 假腿注入 (离线零真检索).

覆盖: ①查询面 (报告名双腿+章词只 zh 面 — anysearch 限额纪律)
②去重截断 ③Relative Results 段形态 ④渠道账本留痕 + anysearch 首笔产量
⑤零命中显式 low ⑥回灌 framework_gen 升密度 (真链) ⑦ast 零网络根模块.

跑法: python -X utf8 tests/test_scout_inject.py   (pytest 兼容)
"""
import ast
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import charter_gate as CG          # noqa: E402
from superline import contracts as C              # noqa: E402
from superline import framework_gen as FG         # noqa: E402
from superline import scout_inject as SI          # noqa: E402
from superline import tier_expander as TE         # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s12_test_"))
SI.LEDGER_PATH = _TMP / "scout_ledger.jsonl"      # 账本隔离
TE.POOL_ROOT = _TMP / "ammo_pool"
TE.POOL_ROOT.mkdir(parents=True, exist_ok=True)

_FW = {"schema": "framework_v1", "campaign_id": "TEST-1",
       "report_title": "《X公司怎么干EPC总承包？》", "family": "enterprise",
       "version": 1,
       "chapters": [
           {"id": "ch01", "title": "企业基本面", "tier_map": {"T1": ["X公司"]},
            "channels": ["on_demand"], "budget_band": "outline_wide",
            "evidence_density": "low"},
           {"id": "ch02", "title": "市场与对标", "tier_map": {"T1": ["Y竞对"]},
            "channels": ["on_demand"], "budget_band": "gap",
            "evidence_density": "low"}]}


def _fake_legs(calls):
    def zh(q):
        calls.append(("zh-search-pro", q))
        return [{"title": f"{q} 官网", "url": f"http://z/{q}",
                 "source": "zh-search-pro", "query": q},
                {"title": "dup", "url": "http://dup", "source":
                 "zh-search-pro", "query": q}]

    def anys(q):
        calls.append(("anysearch", q))
        return [{"title": f"{q} 快讯", "url": f"http://a/{q}",
                 "source": "anysearch", "query": q}]
    return {"zh-search-pro": zh, "anysearch": anys}


# ------------------------------------------------ ①②③ 查询面/去重/段形态
def test_scout_query_plan_dedup_and_md():
    calls = []
    hits = SI.scout(_FW, legs=_fake_legs(calls))
    zh_q = [q for c, q in calls if c == "zh-search-pro"]
    any_q = [q for c, q in calls if c == "anysearch"]
    assert any_q == [_FW["report_title"]]          # anysearch 只打报告名
    assert _FW["report_title"] in zh_q             # 报告名双腿
    assert {"X公司", "Y竞对"} <= set(zh_q)          # 章词全走 zh 面
    # 去重: dup URL 只记一次 (报告名键先占 http://dup)
    n_dup = sum(1 for v in hits.values()
                for h in v if h["url"] == "http://dup")
    assert n_dup == 1
    md = SI.relative_results_md(hits)
    assert md.startswith("# Relative Search Results")
    assert "http://z/X公司" in md and "anysearch" in md
    assert "zh-search-pro" in md


# ------------------------------------------------ ④ 渠道账本 + anysearch 首笔
def test_ledger_and_anysearch_first_entry():
    calls = []
    SI.scout(_FW, legs=_fake_legs(calls))
    first = SI.ledger_first("anysearch")
    assert first and first["query"] == _FW["report_title"]
    assert first["n_hits"] == 1 and first["ts"]
    zfirst = SI.ledger_first("zh-search-pro")
    assert zfirst and zfirst["query"] == _FW["report_title"]


# ------------------------------------------------ ⑤⑥ 零命中显式 low + 回灌真链
def test_zero_hits_low_and_framework_feedback():
    fw2 = dict(_FW)
    fw2["chapters"] = [dict(c) for c in _FW["chapters"]]
    hits = SI.scout(fw2, legs={"zh-search-pro": lambda q: []})  # 全零命中
    md = SI.relative_results_md(hits)
    assert "零命中 — 密度显式 low" in md
    # 回灌: scout 命中 → 密度升档 (framework_gen 真链)
    ch = {"schema": "charter_v1", "campaign_id": "TEST-1",
          "report_title": _FW["report_title"], "family": "enterprise",
          "input_level": "L1", "restatement": "复述: r。",
          "reader": "管理层", "volume": {"chapters": 3, "sections": 3,
                                        "total_chars": 90000},
          "core_question": "X 怎么干成？",
          "counter_questions": ["a？", "b？", "c？"],
          "tiers": {"T1": ["X公司", "X工程"], "T2": ["Y竞对"],
                    "T3": ["EPC"]},
          "approval": "approved", "round": 1}
    scout_json = SI.to_scout_json({"企业基本面": [
        {"title": "t", "url": "u", "source": "zh-search-pro", "query": "q"}]})
    fw = FG.generate(ch, scout=scout_json)
    by = {c["title"]: c for c in fw["chapters"]}
    if "企业基本面" in by:                            # enterprise 族章在
        assert by["企业基本面"]["evidence_density"] == "medium"
        assert by["企业基本面"]["scout_hits"]
    assert C.route_completeness(fw)[0] == C.route_completeness(fw)[1]


# ------------------------------------------------ ⑦ ast 零网络根模块
def test_zero_paid_no_network_imports():
    src = Path(SI.__file__).read_text(encoding="utf-8")
    mods = set()
    for node in ast.walk(ast.parse(src)):
        if isinstance(node, ast.Import):
            mods.update(a.name.split(".")[0] for a in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module:
            mods.add(node.module.split(".")[0])
    banned = {"urllib", "requests", "httpx", "curl_cffi", "socket"}
    assert not (mods & banned), f"侦察腿禁网络根模块: {mods & banned}"


# ------------------------------------------------ run() 落盘 (假腿)
def test_run_writes_scout_files():
    bd = _TMP / "b1"
    d00 = bd / "00 研究报告需求"
    d00.mkdir(parents=True)
    (d00 / "framework.json").write_text(
        __import__("json").dumps(_FW, ensure_ascii=False), encoding="utf-8")
    calls = []
    SI.run(str(bd), legs=_fake_legs(calls))
    assert (d00 / "scout.json").is_file()
    assert (d00 / "scout_relative_results.md").is_file()
    doc = __import__("json").loads(
        (d00 / "scout.json").read_text(encoding="utf-8"))
    assert doc["schema"] == "scout_v1" and doc["hits"]


# ------------------------------------------------ ⑧ 长标题0命中 → 简化回退
def test_anysearch_zero_fallback_simplified():
    assert SI._simplify_title(_FW["report_title"]) == "X公司 EPC"
    calls: list = []
    global_ledger = SI.LEDGER_PATH          # 独立账本 (不污染首笔断言)
    SI.LEDGER_PATH = _TMP / "scout_ledger_fb.jsonl"

    def anys0(q):                     # 长标题诚实0 → 简化查命中
        calls.append(q)
        return [] if q == _FW["report_title"] else [
            {"title": "快讯", "url": "http://a/simp", "source":
             "anysearch", "query": q}]
    try:
        hits = SI.scout(_FW, legs={"anysearch": anys0})
        assert calls == [_FW["report_title"], "X公司 EPC"]  # 恰两查 (限额)
        assert hits[_FW["report_title"]][0]["url"] == "http://a/simp"
    finally:
        SI.LEDGER_PATH = global_ledger


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
