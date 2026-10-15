# -*- coding: utf-8 -*-
"""test_collection_gate_t1 — 旗舰产线 collection_gate 读 gates.json 权威源 (T-002B).

REQ-010.AC1/REQ-011.AC1 证明 (合成池, 不跑真实采集):
  a) T1=900万 → FAIL (v3 口径 T1≥1000万 单门主判)
  b) T1=1100万 → PASS 且 T12 总门不再判 (T2=0 亦过; 「总门已撤(v3)」)
  c) flags.legacy_t12_gate=True → 回旧 v5 双门 (T1<2000万 FAIL; 双门皆过则 PASS)
  d) gates.json 副本改 t1_min_chars → 同池重判即时翻转 (无缓存, REQ-010.AC2)

跑法: py -m pytest reforge_factory/tests/test_collection_gate_t1.py -q
"""
import importlib.util
import json
import sys
from pathlib import Path

import gates_loader as GL                                # noqa: E402 (conftest 已入 path)

CG_PATH = (Path(__file__).resolve().parents[2] / "_proposals"
           / "flagship-paid-report-1007" / "work" / "collection_gate.py")


def _load_cg():
    """按文件路径装载 collection_gate 模块 (work 目录非包, 不能普通 import).

    其内部 sys.path.insert 引擎根后 import gates_loader — 与本套件 conftest
    导入的是同一模块对象, 故 gates_json 夹具对 DEFAULT_CONFIG_PATH 的切换
    对 collection_gate 的决策时现读同样生效 (无缓存证明的前提).
    """
    spec = importlib.util.spec_from_file_location("collection_gate", CG_PATH)
    mod = importlib.util.module_from_spec(spec)
    sys.modules["collection_gate"] = mod
    spec.loader.exec_module(mod)
    return mod


def _mk_pool(base, t1_chars, t2_chars=0):
    """最小合成池: pool_state.json 只给 tier 判定后真账 t1/t2 (measure 门面)."""
    d = base / "CAMP"
    d.mkdir(parents=True, exist_ok=True)
    (d / "pool_state.json").write_text(json.dumps({
        "campaign": "CAMP", "total_chars": t1_chars + t2_chars, "items": 2,
        "t1_chars": t1_chars, "t2_chars": t2_chars,
        "t3_chars": 0, "t0_chars": 0,
    }, ensure_ascii=False), encoding="utf-8")
    return d


def _measure(cg, monkeypatch, pool_dir):
    """对合成池跑 measure (纯内存判定, 不 _save 不落真实 state)."""
    monkeypatch.setattr(cg, "F1_POOL", pool_dir)
    monkeypatch.setattr(cg, "F1_INV", pool_dir / "nope_inventory.json")
    monkeypatch.setattr(cg, "F1_TREE", pool_dir / "nope_tree.json")
    return cg.measure({})


# ---------- a) T1=900万 → FAIL (REQ-011.AC1: T1 ≥ 1000万单门) ----------

def test_a_t1_9m_fail_under_v3_single_gate(gates_json, tmp_path, monkeypatch):
    gates_json()                                       # 底=真 gates.json (v3 口径)
    cg = _load_cg()
    assert cg.gate_bar() == {"t1_min": 10_000_000, "t1t2_min": None,
                             "budget_chars": 200_000_000, "mode": "v3"}
    st = _measure(cg, monkeypatch, _mk_pool(tmp_path, t1_chars=9_000_000))
    assert st["word_gate_pass"] is False               # 900万 < 1000万门
    assert st["tier"]["t12_gate"] == "总门已撤(v3)"     # 总门口径已落 tier 账
    assert st["bar"]["t1_min"] == 10_000_000           # state bar=实际使用口径


# ---------- b) T1=1100万 → PASS 且总门不再判 (REQ-011) ----------

def test_b_t1_11m_pass_total_gate_withdrawn(gates_json, tmp_path, monkeypatch):
    gates_json()
    cg = _load_cg()
    # T2=0: 旧 v5 总门 (T1+T2≥5000万) 必不过 → PASS 即证明总门不再判
    st = _measure(cg, monkeypatch,
                  _mk_pool(tmp_path, t1_chars=11_000_000, t2_chars=0))
    assert st["word_gate_pass"] is True
    assert st["tier"]["t12_gate"] == "总门已撤(v3)"
    assert st["word_gate_pass"] is bool(
        st["tier"]["t1_valid"] >= st["bar"]["t1_min"])  # 判定只看 T1 单门


# ---------- c) legacy_t12_gate=True → 回旧 v5 双门 (REQ-002 回滚路径) ----------

def test_c_legacy_t12_gate_reverts_v5_double_gate(gates_json, tmp_path,
                                                  monkeypatch):
    gates_json(flags={"legacy_t12_gate": True, "legacy_total_gate": False,
                      "legacy_chapter_band": False})
    cg = _load_cg()
    assert cg.gate_bar()["t1_min"] == 20_000_000       # 旧 v5: 两千万
    assert cg.gate_bar()["t1t2_min"] == 50_000_000     # 旧 v5: 五千万
    # 同池对照 1: T1=1100万 (v3 PASS) → v5 T1 门 FAIL
    st = _measure(cg, monkeypatch, _mk_pool(tmp_path, t1_chars=11_000_000))
    assert st["word_gate_pass"] is False
    assert st["bar"]["mode"] == "legacy_v5"
    # 同池对照 2: T1=2500万 ∧ T1+T2=5500万 → v5 双门皆过 PASS (旧行为完整回开)
    st2 = _measure(cg, monkeypatch,
                   _mk_pool(tmp_path / "b", t1_chars=25_000_000,
                            t2_chars=30_000_000))
    assert st2["word_gate_pass"] is True


# ---------- d) 改 gates.json 副本 t1_min_chars → 即时生效 (REQ-010.AC2 无缓存) ----------

def test_d_gates_json_hot_reload_no_cache(gates_json, tmp_path, monkeypatch):
    cg = _load_cg()
    pool = _mk_pool(tmp_path, t1_chars=9_500_000)
    gates_json()                                       # 门=1000万 (真底)
    st = _measure(cg, monkeypatch, pool)
    assert st["word_gate_pass"] is False               # 950万 < 1000万
    gates_json(t1_min_chars=9_000_000)                 # 只改 tmp 副本, 不重启进程
    st2 = _measure(cg, monkeypatch, pool)              # 同池不重采重判
    assert st2["word_gate_pass"] is True               # 950万 ≥ 900万新门=即时生效
    assert st2["bar"]["t1_min"] == 9_000_000           # 落账同步新口径
