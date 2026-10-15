# -*- coding: utf-8 -*-
"""test_gates_source — 引擎树三消费点读 gates.json 单一权威源 (T-002R/REQ-010).

REQ-010.AC2 证明:
  a) gates.json 副本改 t1_min_chars=12345678 → ammo_pool / epc50_start_gate /
     superline.contracts 三处决策函数读到的 T1 门同步变 (无缓存, 改 json
     即生效); tier_report 端到端判定随 json 抬门翻转 (决策点真用权威值).
  b) flags.legacy_t12_gate=True → 旧 v2 双门口径回开: T12 判定回到旧行为
     (T1 ≥ 三百万 ∧ T1+T2 ≥ 三千万), 同池在新口径下判 FAIL.

跑法: py -m pytest reforge_factory/tests/test_gates_source.py -q
"""
import io
import json
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as ap                                # noqa: E402
from superline import contracts as C                  # noqa: E402

# epc50 模块级会以 io.TextIOWrapper(sys.stdout.buffer) 重配 stdout —
# 在独立 devnull 流上完成 import, 不包 pytest 捕获流 (wrapper GC 时会
# close 底层, 曾致 "I/O operation on closed file"), import 后即还原.
_pytest_stdout = sys.stdout
sys.stdout = io.TextIOWrapper(open(os.devnull, "wb"), encoding="utf-8",
                              errors="replace")
import epc50_start_gate as eg                        # noqa: E402
sys.stdout = _pytest_stdout


def _mk_camp(tmp_path, monkeypatch, t1_chars, t2_chars=0):
    """最小一手池: T1 词命中 t1_chars 字 (+ 可选 T2 词命中 t2_chars 字)."""
    monkeypatch.setattr(ap, "POOL_ROOT", tmp_path)
    d = tmp_path / "SRCX"
    d.mkdir()
    (d / "tiers.json").write_text(
        json.dumps({"T1": ["本体"], "T2": ["同业"]}, ensure_ascii=False),
        encoding="utf-8")
    rows = [{"source_path": "E:/x/本体0.pdf", "url_norm": "",
             "chars": t1_chars, "judge": "valid", "dedup_key": "k1"}]
    if t2_chars:
        rows.append({"source_path": "E:/x/同业a.pdf", "url_norm": "",
                     "chars": t2_chars, "judge": "valid", "dedup_key": "k2"})
    (d / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")
    (d / "pool_state.json").write_text(
        json.dumps({"campaign": "SRCX", "kws": []}), encoding="utf-8")
    return d


# ---------- a) 改 gates.json → 三消费点决策函数同步 (REQ-010.AC2, 无缓存) ----------

def test_a_t1_gate_syncs_across_three_consumers(gates_json):
    """改副本 t1_min_chars=12345678 → 三处决策函数同步读到 (无缓存证明)."""
    gates_json()                                        # 底=真 gates.json (v3 口径)
    assert ap.gate_t1_min_chars() == 10_000_000         # ammo_pool 决策点
    assert eg.gate1b_thresholds() == (10_000_000, None)  # epc50 门1b (T12 关)
    assert C.gate_defaults()["t1_min_chars"] == 10_000_000

    gates_json(t1_min_chars=12345678)                   # 只改副本, 不重启进程
    assert ap.gate_t1_min_chars() == 12345678           # 三处同步变 = 无缓存
    assert eg.gate1b_thresholds()[0] == 12345678
    assert C.gate_defaults()["t1_min_chars"] == 12345678


def test_a_tier_report_gate_flips_with_json(tmp_path, monkeypatch, gates_json):
    """端到端: 同一池, 只改 gates.json → tier_report 判定翻转 (决策时现读)."""
    _mk_camp(tmp_path, monkeypatch, t1_chars=12_000_000)
    gates_json(t1_min_chars=12_000_000)
    assert ap.tier_report("SRCX")["gate_ok"] is True    # T1 1200万 ≥ 1200万门
    gates_json(t1_min_chars=12_345_678)                 # 门抬到 1234.5678万
    assert ap.tier_report("SRCX")["gate_ok"] is False   # 同池不重采即翻 FAIL


# ---------- b) legacy_t12_gate=True → 旧 v2 双门口径回开 (REQ-002 回滚路径) ----------

def test_b_legacy_t12_gate_reopens_old_double_gate(tmp_path, monkeypatch,
                                                   gates_json):
    """同池对照: 旧行为 (T1≥300万 ∧ T1+T2≥3000万) PASS ↔ 新口径 (T1≥1000万) FAIL."""
    # 池: T1=400万 (>旧300万门, <新1000万门), T2=3050万 (T1+T2=3450万 >旧3000万门)
    _mk_camp(tmp_path, monkeypatch, t1_chars=4_000_000, t2_chars=30_500_000)

    gates_json(flags={"legacy_t12_gate": True, "legacy_total_gate": False,
                      "legacy_chapter_band": False})
    assert ap.gate_t12_min_chars() == 30_000_000        # 旧 v2 T12 门回开
    assert eg.gate1b_thresholds() == (3_000_000, 30_000_000)  # epc50 同步回旧口径
    assert C.gate_defaults()["t12_min_chars"] == 30_000_000   # contracts 同步
    assert ap.tier_report("SRCX")["gate_ok"] is True    # 旧行为: 双门皆过

    gates_json()                                        # 回默认 (三旗 false)
    assert ap.gate_t12_min_chars() is None              # 新口径: T12 总门关
    assert ap.tier_report("SRCX")["gate_ok"] is False   # 同池 400万 < 1000万门
