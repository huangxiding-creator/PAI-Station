# -*- coding: utf-8 -*-
"""redteam_run 单测 — 红队轮战役级 runner (T-013 / REQ-043).

覆盖 (父指令四点):
  ① 合成框架+树 → 失败路径 3-5 条 / affected_chapters 非空 / ICD 7 档带
  ② unanswered→exit2 / responded→exit0 (responses 逐条登记)
  ③ KAC against 计数联动 (挂树反证>0 → ⚠; ==0 → 未经反证检验)
  ④ 树缺失降级不炸 (kac degraded + 种子假设兜底)
附加:
  ⑤ framework 缺 → 失败路径按池维度模板生成并标 degraded + 自动降级回应
  ⑥ 概率由池实测推导 (陈旧行/引擎垄断占比联动, 数字零造假)
  ⑦ 真实池只读冒烟 (EPC-BID26, 输出落 tmp; 池字节不变)
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import redteam_run as RT                                      # noqa: E402
from superline.redteam_gate import LIKELIHOOD_BANDS           # noqa: E402

FRAMEWORK_MD = """# 合成战役测试报告: 某省 EPC 总承包市场
## 第一章 市场规模与数据总貌
## 第二章 竞争格局与风险反例
## 第三章 政策口径与时间轴
"""

_VALID_BANDS = {f"{w} {lo}-{hi}%" for w, lo, hi in LIKELIHOOD_BANDS}


def _row(node: str, *, engine: str = "rss:test", stance: str = "support",
         judge: str = "valid", chars: int = 100, ts: str = "2026-12-31T00:00:00",
         dedup: str = "") -> dict:
    return {"ts": ts, "engine": engine, "source_path": f"E:/pool/{node}.md",
            "url_norm": "", "chars": chars, "judge": judge,
            "dedup_key": dedup or f"{node}-{engine}-{stance}", "tree_node": node,
            "stance": stance, "text_head": "合成行"}


def _tree() -> dict:
    eei_s = {"id": "Q1-E1", "need": "正面证据", "grades": ["B"],
             "stance": "support", "channels_hint": [], "queries": [],
             "status": "single"}
    eei_a = {"id": "Q1-E2", "need": "反面证据", "grades": ["B"],
             "stance": "against", "channels_hint": [], "queries": [],
             "status": "single"}
    return {"campaign": "SYN-A", "topic": "某省 EPC 总承包市场",
            "region": "某省",
            "hypotheses": [
                {"id": "H1", "text": "某省 EPC 总承包市场 处于扩张周期",
                 "prior": 0.4},
                {"id": "H2", "text": "某省 EPC 总承包市场 已过峰值", "prior": 0.3},
                {"id": "H3", "text": "某省 EPC 总承包市场 结构性分化", "prior": 0.3}],
            "subquestions": [
                {"id": "Q1", "dim": "市场级", "text": "市场规模",
                 "falsifiable": True, "eeis": [eei_s, eei_a]}],
            "stats": {"subquestions": 1, "eeis": 2}}


def _make_pool(root: Path, cid: str, *, tree: dict | None = None,
               rows: list[dict] | None = None, kws: list[str] | None = None):
    d = root / cid
    d.mkdir(parents=True)
    if tree is not None:
        (d / "question_tree.json").write_text(
            json.dumps(tree, ensure_ascii=False, indent=1), encoding="utf-8")
    if rows is not None:
        (d / "manifest.jsonl").write_text(
            "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
            encoding="utf-8")
    (d / "pool_state.json").write_text(json.dumps({
        "campaign": cid, "items": len(rows or []), "total_chars": 10 ** 6,
        "kws": kws or ["EPC", "总承包", "市场规模"]}, ensure_ascii=False),
        encoding="utf-8")
    return d


# ---- ① 合成框架+树: 失败路径 3-5 条 / affected_chapters 非空 --------------

def test_framework_paths_band_and_chapters(tmp_path):
    _make_pool(tmp_path, "SYN-A", tree=_tree(),
               rows=[_row("Q1-E1"), _row("Q1-E2", stance="against")])
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                 pool_root=tmp_path, work_dir=tmp_path / "out")
    fps = rep["failure_paths"]
    assert 3 <= len(fps) <= 5
    for p in fps:
        assert isinstance(p["path"], str) and p["path"]
        assert p["probability_band"] in _VALID_BANDS     # ICD 203 七档带
        assert isinstance(p["affected_chapters"], list) and p["affected_chapters"]
        assert p["response_status"] in ("unanswered", "responded")
        assert {"path", "probability_band", "affected_chapters",
                "response_status", "response_note"} <= set(p)
    # 框架在场 → 不降级, affected_chapters 来自框架章名
    assert rep["framework_degraded"] is False
    chapters = {c for p in fps for c in p["affected_chapters"]}
    assert any("第一章" in c or "第二章" in c or "第三章" in c for c in chapters)
    out = tmp_path / "out" / "redteam_SYN-A.json"
    assert out.is_file()


def test_five_families_present_with_framework(tmp_path):
    _make_pool(tmp_path, "SYN-A", tree=_tree(), rows=[_row("Q1-E1")])
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                 pool_root=tmp_path, work_dir=tmp_path / "out")
    fams = {p["family"] for p in rep["failure_paths"]}
    # 五族至少 4 族在场 (3-5 条裁剪后) 且战役定制位在场
    assert len(fams & set(RT.FAMILIES)) >= 4
    assert any(p["family"] == RT.CUSTOM_FAMILY for p in rep["failure_paths"])


# ---- ② unanswered→exit2 / responded→exit0 ---------------------------------

def test_unanswered_exit2(tmp_path):
    _make_pool(tmp_path, "SYN-A", tree=_tree(), rows=[_row("Q1-E1")])
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                 pool_root=tmp_path, work_dir=tmp_path / "out")
    assert rep["exit_code"] == 2
    assert any(p["response_status"] == "unanswered" for p in rep["failure_paths"])
    assert all(not p["response"] for p in rep["failure_paths"]
               if p["response_status"] == "unanswered")


def test_responded_exit0(tmp_path):
    _make_pool(tmp_path, "SYN-A", tree=_tree(), rows=[_row("Q1-E1")])
    fams = [p["family"] for p in RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                                        pool_root=tmp_path,
                                        work_dir=tmp_path / "o1")["failure_paths"]]
    responses = {f: f"回应: {f} 已补双源+反证腿" for f in fams}
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD, responses=responses,
                 pool_root=tmp_path, work_dir=tmp_path / "o2")
    assert rep["exit_code"] == 0
    assert all(p["response_status"] == "responded" for p in rep["failure_paths"])
    assert all(p["response"] for p in rep["failure_paths"])   # 逐条回应在案
    # 部分回应 → 仍有 unanswered → exit 2
    rep2 = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                  responses={fams[0]: "只回一条"},
                  pool_root=tmp_path, work_dir=tmp_path / "o3")
    assert rep2["exit_code"] == 2


# ---- ③ KAC against 计数联动 ------------------------------------------------

def test_kac_against_count_linkage(tmp_path):
    # 2 条 valid 挂树反证 → 每根假设 against_count>0 → ⚠
    _make_pool(tmp_path, "SYN-A", tree=_tree(),
               rows=[_row("Q1-E1"), _row("Q1-E2", stance="against"),
                     _row("Q1-E2", stance="against", engine="sogou:wechat",
                          dedup="d2")])
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                 pool_root=tmp_path, work_dir=tmp_path / "out")
    kac = rep["kac"]
    assert kac["degraded"] is False
    assert len(kac["root_hypotheses"]) == 3          # HYPOTHESIS_SEEDS 三根
    for h in kac["root_hypotheses"]:
        assert h["against_count"] == 2               # 挂树 against 计数联动
        assert h["flag"].startswith("⚠")


def test_kac_zero_against_flagged_untested(tmp_path):
    # 反证腿缺位 (judge!=valid 或未挂树的 against 不计) → 未经反证检验
    _make_pool(tmp_path, "SYN-A", tree=_tree(),
               rows=[_row("Q1-E1"),
                     _row("Q1-E2", stance="against", judge="reject"),
                     _row("", stance="against")])     # 未挂树不计
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                 pool_root=tmp_path, work_dir=tmp_path / "out")
    for h in rep["kac"]["root_hypotheses"]:
        assert h["against_count"] == 0
        assert h["flag"] == "未经反证检验"


# ---- ④ 树缺失降级不炸 -------------------------------------------------------

def test_tree_missing_degrades_without_crash(tmp_path):
    _make_pool(tmp_path, "SYN-A", rows=[_row("Q1-E1")])     # 无树
    rep = RT.run("SYN-A", framework_md=FRAMEWORK_MD,
                 pool_root=tmp_path, work_dir=tmp_path / "out")
    assert rep["kac"]["degraded"] is True
    assert rep["kac"]["root_hypotheses"], "树缺失须以种子假设兜底而非空转"
    assert all(h["flag"] == "未经反证检验"
               for h in rep["kac"]["root_hypotheses"])
    assert 3 <= len(rep["failure_paths"]) <= 5


# ---- ⑤ framework 缺 → 池维度模板 + degraded + 自动降级回应 ------------------

def test_no_framework_degraded_pool_templates(tmp_path):
    _make_pool(tmp_path, "SYN-B", tree=_tree(), rows=[_row("Q1-E1")])
    rep = RT.run("SYN-B", pool_root=tmp_path, work_dir=tmp_path / "out")
    assert rep["framework_degraded"] is True
    assert 3 <= len(rep["failure_paths"]) <= 5
    assert all(p["degraded"] is True for p in rep["failure_paths"])
    # 降级即回应 (REQ-043: 回应不了的章节降级或补采) → 无 unanswered
    assert all(p["response_status"] == "responded" for p in rep["failure_paths"])
    assert all(p["response"] for p in rep["failure_paths"])
    assert rep["exit_code"] == 0
    # 池维度 affected_chapters (kws 派生) 非空
    assert all(p["affected_chapters"] for p in rep["failure_paths"])
    assert rep["material_diff"], "降级决策+补采登记须入 material_diff 在案"


# ---- ⑥ 概率由池实测推导 -----------------------------------------------------

def test_probability_derived_from_pool_stats(tmp_path):
    # 陈旧行占比升高 → 数据时效失效概率升高 (纯函数联动, 禁手拍)
    fresh = [_row("Q1-E1"), _row("Q1-E2", stance="against")]
    stale = [_row("Q1-E1", ts="2020-01-01T00:00:00"),
             _row("Q1-E2", stance="against", ts="2020-01-01T00:00:00")]
    sf, ss = RT.pool_stats(fresh), RT.pool_stats(stale)
    assert ss["stale_share"] == 1.0 and sf["stale_share"] == 0.0
    assert RT.family_probability("数据时效失效", ss, True) \
        > RT.family_probability("数据时效失效", sf, True)
    # 集成侧: 陈旧池实跑 → 该族入选且带高带 (裁剪按概率降序, 高者存活)
    _make_pool(tmp_path, "SYN-S", tree=_tree(), rows=stale)
    fps = RT.run("SYN-S", framework_md=FRAMEWORK_MD, pool_root=tmp_path,
                 work_dir=tmp_path / "os")["failure_paths"]
    p = {x["family"]: x for x in fps}["数据时效失效"]
    assert p["probability_pct"] > 50


def test_engine_monopoly_raises_probability(tmp_path):
    # 单一引擎垄断 chars → 单一信源垄断概率高于多引擎均衡池 (纯函数联动)
    mono = [_row("Q1-E1", engine="stock:corpus", chars=9000),
            _row("Q1-E2", stance="against", engine="stock:corpus", chars=9000),
            _row("Q1-E1", engine="rss:x", chars=100)]
    mixed = [_row("Q1-E1", engine="stock:corpus", chars=100),
             _row("Q1-E2", stance="against", engine="rss:x", chars=100),
             _row("Q1-E1", engine="websearch:y", chars=100)]
    sm, sx = RT.pool_stats(mono), RT.pool_stats(mixed)
    assert sm["top_engine_share"] > sx["top_engine_share"]
    assert RT.family_probability("单一信源垄断", sm, True) \
        > RT.family_probability("单一信源垄断", sx, True)


# ---- ⑦ 真实池只读冒烟 (EPC-BID26; 池字节不变) ------------------------------

_REAL_POOL = (RT.POOL_ROOT / "EPC-BID26" / "pool_state.json")


@pytest.mark.skipif(not _REAL_POOL.exists(), reason="真实池缺席, 跳过实盘冒烟")
def test_real_bid26_readonly_smoke(tmp_path):
    before = {p.name: p.read_bytes() for p in
              (RT.POOL_ROOT / "EPC-BID26").glob("*") if p.is_file()}
    rep = RT.run("EPC-BID26", pool_root=RT.POOL_ROOT, work_dir=tmp_path)
    after = {p.name: p.read_bytes() for p in
             (RT.POOL_ROOT / "EPC-BID26").glob("*") if p.is_file()}
    assert before == after                                    # 真实池只读
    assert 3 <= len(rep["failure_paths"]) <= 5
    assert rep["framework_degraded"] is True                  # 无框架 → degraded
    assert rep["kac"]["degraded"] is True                     # 无树 → degraded
    assert (tmp_path / "redteam_EPC-BID26.json").is_file()
