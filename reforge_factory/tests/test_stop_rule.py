# -*- coding: utf-8 -*-
"""test_stop_rule — 边际增益停时器单测 (T-005, REQ-041).

覆盖 (gates.json 权威值: gain_threshold_pct=2.0 / rounds=3 / fuse_hours=72):
  ① 连续 3 轮增益 0.5,1.0,1.5 全 <2% → stop_gain (REQ-041 主规则)
  ② [5.0,1.0,1.5] 末段连续低于阈值仅 2 轮 → continue (边界语义: 连续=尾部逐轮)
  ③ 增益高 [5,6,7] / 空历史 / 历史不足 N 轮 → continue
  ④ elapsed 100h > 72h → stop_fuse; 且高增益也拦 (保险丝红线优先于裁量)
  ⑤ 边界: elapsed 恰 72h 不熔断; 增益恰 2.0 不算 <阈值
  ⑥ 参数决策时读非 import 时 (monkeypatch load_gates 即时生效)
  ⑦ 每次调用自动落账 research_rounds 决策, 停时记录含每轮增益数 (REQ-041.AC1)
  ⑧ stop_rule 纯标准库

红线: 全部 tmp 夹具, 不碰真实 ammo_pool/.

跑法: py -m pytest reforge_factory/tests/test_stop_rule.py -q
"""
from __future__ import annotations

import ast
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import stop_rule as SR                                 # noqa: E402
import decision_ledger as DL                           # noqa: E402


# ------------------------------------------------ ① 主规则: 连续 N 轮低增益
def test_a_consecutive_low_gains_stop_gain():
    assert SR.decide([0.5, 1.0, 1.5], elapsed_hours=1.0) == "stop_gain"


def test_a_long_history_tail_window():
    """历史更长看尾部: 前 5 轮高增益救不了尾部连续 3 轮 <2%."""
    assert SR.decide([9.0, 8.0, 7.0, 1.0, 0.8, 1.2], elapsed_hours=2.0) == "stop_gain"


# ------------------------------------------------ ② 连续 = 尾部逐轮
def test_b_broken_streak_continues():
    """[5.0,1.0,1.5]: 低于阈值的尾部连续段只有 2 轮 (< rounds=3) → continue."""
    assert SR.decide([5.0, 1.0, 1.5], elapsed_hours=1.0) == "continue"


# ------------------------------------------------ ③ 继续分支
def test_c_high_gains_continue():
    assert SR.decide([5.0, 6.0, 7.0], elapsed_hours=10.0) == "continue"


def test_c_empty_or_short_history_continue():
    assert SR.decide([], elapsed_hours=0.0) == "continue"          # 无轮次
    assert SR.decide([1.0], elapsed_hours=0.0) == "continue"      # 不足 N 轮
    assert SR.decide([1.0, 1.5], elapsed_hours=0.0) == "continue"


# ------------------------------------------------ ④ 时长保险丝
def test_d_fuse_trips(tmp_path):
    assert SR.decide([5.0, 6.0, 7.0], elapsed_hours=100.0) == "stop_fuse"


def test_d_fuse_outranks_gain_discretion():
    """保险丝是红线 (不可裁), 高增益/低增益都拦: fuse 优先于 stop_gain."""
    assert SR.decide([0.5, 1.0, 1.5], elapsed_hours=100.0) == "stop_fuse"


# ------------------------------------------------ ⑤ 边界
def test_e_boundaries():
    assert SR.decide([5.0, 6.0, 7.0], elapsed_hours=72.0) == "continue"   # 恰=不熔断
    assert SR.decide([1.9, 1.99, 2.0], elapsed_hours=1.0) == "continue"   # 2.0 不算 <2.0
    assert SR.decide([1.9, 1.99, 1.999], elapsed_hours=1.0) == "stop_gain"


def test_e_negative_elapsed_rejected():
    try:
        SR.decide([1.0], elapsed_hours=-0.1)
        raise AssertionError("负时长应拒")
    except ValueError:
        pass


# ------------------------------------------------ ⑥ 决策时读 gates (非 import 时)
def test_f_stopping_params_read_at_decision_time(monkeypatch):
    """monkeypatch load_gates 立即改变 decide 行为 → 证明参数是调用时读的."""
    monkeypatch.setattr(
        SR.gates_loader, "load_gates",
        lambda config_path=None: {"stopping": {"gain_threshold_pct": 2.0,
                                               "rounds": 1, "fuse_hours": 72}})
    assert SR.decide([1.0], elapsed_hours=0.0) == "stop_gain"     # rounds=1 即停
    monkeypatch.setattr(
        SR.gates_loader, "load_gates",
        lambda config_path=None: {"stopping": {"gain_threshold_pct": 99.0,
                                               "rounds": 3, "fuse_hours": 72}})
    assert SR.decide([5.0, 6.0, 7.0], elapsed_hours=0.0) == "stop_gain"  # 阈值99
    monkeypatch.setattr(
        SR.gates_loader, "load_gates",
        lambda config_path=None: {"stopping": {"gain_threshold_pct": 2.0,
                                               "rounds": 3, "fuse_hours": 1.0}})
    assert SR.decide([5.0, 6.0, 7.0], elapsed_hours=2.0) == "stop_fuse"  # 保险丝收紧


def test_f_gain_threshold_short_key_alias(monkeypatch):
    """REQ-041.AC1 短键 gain_threshold 兜底读 (gates.json 同时携带两键)."""
    monkeypatch.setattr(
        SR.gates_loader, "load_gates",
        lambda config_path=None: {"stopping": {"gain_threshold": 50.0,
                                               "rounds": 2, "fuse_hours": 72}})
    assert SR.decide([5.0, 6.0], elapsed_hours=0.0) == "stop_gain"  # 短键生效


# ------------------------------------------------ ⑦ 自动落账
def test_g_decide_records_research_rounds_ledger(tmp_path):
    gains = [0.5, 1.0, 1.5]
    verdict = SR.decide(gains, elapsed_hours=1.5, campaign="T005-STOP",
                        pool_root=tmp_path)
    ledger = tmp_path / "T005-STOP" / "decision_ledger.jsonl"
    assert ledger.exists()
    recs = [json.loads(x) for x in ledger.read_text(encoding="utf-8").splitlines()]
    assert len(recs) == 1
    r = recs[0]
    assert r["decision_type"] == "research_rounds"     # REQ-040 域
    assert r["chosen"] == verdict == "stop_gain"
    assert r["context"]["round_gain_history"] == [0.5, 1.0, 1.5]   # 每轮增益数 (AC1)
    assert r["context"]["elapsed_hours"] == 1.5
    assert r["context"]["gain_threshold_pct"] == 2.0   # 决策参数入账可审计
    assert r["context"]["rounds"] == 3 and r["context"]["fuse_hours"] == 72
    assert r["outcome"] is None                        # 结果未判空位
    assert {o["k"] for o in r["options"]} == {"continue", "stop_gain", "stop_fuse"}


def test_g_decide_continue_also_records_and_increments(tmp_path):
    SR.decide([5.0, 6.0], elapsed_hours=1.0, campaign="T005-STOP", pool_root=tmp_path)
    v2 = SR.decide([5.0, 7.0], elapsed_hours=2.0, campaign="T005-STOP",
                   pool_root=tmp_path)
    recs = DL.load_records("T005-STOP", pool_root=tmp_path)
    assert [r["id"] for r in recs] == ["D-0001", "D-0002"]        # id 续增
    assert recs[1]["chosen"] == v2


def test_g_no_campaign_no_ledger_touch(tmp_path):
    """campaign 缺省 = 纯决策模式, 不写任何账本."""
    SR.decide([0.5, 1.0, 1.5], elapsed_hours=1.0)
    assert list(tmp_path.rglob("decision_ledger.jsonl")) == []


# ------------------------------------------------ ⑧ 纯标准库
def test_h_stdlib_only():
    allowed = {"json", "sys", "re", "time", "datetime", "pathlib",
               "__future__", "gates_loader", "decision_ledger"}  # 本地模块
    tree = ast.parse(Path(SR.__file__).read_text(encoding="utf-8"))
    imports = {n.names[0].name.split(".")[0]
               for n in ast.walk(tree)
               if isinstance(n, ast.Import)} | \
              {n.module.split(".")[0]
               for n in ast.walk(tree)
               if isinstance(n, ast.ImportFrom) and n.module}
    assert imports <= allowed, imports
