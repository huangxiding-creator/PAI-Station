# -*- coding: utf-8 -*-
"""tier_gate_v3_recompute 单测 (百倍V3 / T-004, REQ-012).

不碰真池: tmp 池夹具 (pool_state/manifest/tiers) 驱动全流水。
覆盖: v3 单门判定 (900万→False / 1100万→True)、增量写回红线
(既有键值+顺序零改动, 只+tier_gate_v3)、备份只增、重跑幂等、
manifest 重算回退、dry-run 零写盘、权威源 rule 文本、run 端到端出报告。
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import tier_gate_v3_recompute as tgv3  # noqa: E402

V3 = "tier_gate_v3"


def _mk_pool(root: Path, name: str, state: dict, manifest_rows=None,
             tiers=None):
    d = root / name
    d.mkdir(parents=True)
    if manifest_rows is not None:
        if tiers is not None:
            (d / "tiers.json").write_text(
                json.dumps(tiers, ensure_ascii=False), encoding="utf-8")
        (d / "manifest.jsonl").write_text(
            "\n".join(json.dumps(r, ensure_ascii=False)
                      for r in manifest_rows) + "\n", encoding="utf-8")
    (d / "pool_state.json").write_text(
        json.dumps(state, ensure_ascii=False, indent=1) + "\n",
        encoding="utf-8")
    return d


def _rich_state(t1=None, t2=None):
    """仿真池 state: 嵌套 dict/list/中文/既有分层账键, 验增量红线用."""
    s = {
        "campaign": "T1TEST",
        "kws": ["工程总承包", "EPC"],
        "total_chars": 12345,
        "items": 7,
        "by_engine": {"stock:corpus": 8000, "cross:policy": {"nested": [1, 2]}},
        "domains": ["工程总承包招投标合规工作指南", "todo"],
        "gate_chars": 200000000,
        "tier_gate_ok": False,
        "tier_note": "旧判注记 保持原样",
        "created": "2026-10-15 00:00",
    }
    if t1 is not None:
        s["t1_chars"] = t1
        s["t1_items"] = 100
    if t2 is not None:
        s["t2_chars"] = t2
        s["t2_items"] = 200
    return s


# ---------- v3 单门判定: 900万→False / 1100万→True ----------

def test_t1_900w_fails_gate(tmp_path):
    d = _mk_pool(tmp_path, "P900", _rich_state(t1=9_000_000, t2=5_000_000))
    r = tgv3.recompute_pool(d, t1_min=10_000_000)
    assert r["v3"]["t1_pass"] is False
    assert r["v3"]["t1_chars"] == 9_000_000
    assert r["v3"]["t2_chars"] == 5_000_000


def test_t1_1100w_passes_gate(tmp_path):
    d = _mk_pool(tmp_path, "P1100", _rich_state(t1=11_000_000, t2=0))
    r = tgv3.recompute_pool(d, t1_min=10_000_000)
    assert r["v3"]["t1_pass"] is True


# ---------- 增量写回红线: 原有键原样保留 ----------

def test_writeback_incremental_keys_preserved(tmp_path):
    d = _mk_pool(tmp_path, "PINC", _rich_state(t1=9_000_000, t2=1))
    before = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
    r = tgv3.recompute_pool(d, t1_min=10_000_000, apply=True)
    after = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
    # 1) 只多了一个键
    assert set(after) - set(before) == {V3}
    # 2) 既有键值 deep-equal 零改动 (含嵌套 dict/list)
    for k, v in before.items():
        assert after[k] == v, f"既有键 {k} 被改动"
    # 3) 既有键顺序原样 (增量=尾部追加, 不重排)
    assert list(after) == list(before) + [V3]
    # 4) tier_gate_ok=False 等旧判字段原样在盘 (不覆盖旧字段)
    assert after["tier_gate_ok"] is False and after["gate_chars"] == 200000000
    assert after[V3]["t1_pass"] is False
    assert r["write_back"]["keys_after"] == r["write_back"]["keys_before"] + 1


def test_backup_created_once_and_kept_on_rerun(tmp_path):
    d = _mk_pool(tmp_path, "PBAK", _rich_state(t1=11_000_000, t2=2))
    original = (d / "pool_state.json").read_text(encoding="utf-8")
    tgv3.recompute_pool(d, t1_min=10_000_000)          # 第一跑: 备份首份
    bak = d / tgv3.BACKUP_NAME
    assert bak.is_file() and bak.read_text(encoding="utf-8") == original
    tgv3.recompute_pool(d, t1_min=10_000_000)          # 重跑: 备份不覆盖
    assert bak.read_text(encoding="utf-8") == original
    after = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
    assert set(after) - {"campaign", "kws", "total_chars", "items",
                         "by_engine", "domains", "gate_chars",
                         "tier_gate_ok", "tier_note", "created",
                         "t1_chars", "t1_items", "t2_chars",
                         "t2_items"} == {V3}           # 仍只多一键


def test_dry_run_writes_nothing(tmp_path):
    d = _mk_pool(tmp_path, "PDRY", _rich_state(t1=9_000_000, t2=3))
    original = (d / "pool_state.json").read_text(encoding="utf-8")
    tgv3.recompute_pool(d, t1_min=10_000_000, apply=False)
    assert (d / "pool_state.json").read_text(encoding="utf-8") == original
    assert not (d / tgv3.BACKUP_NAME).exists()


# ---------- manifest 重算回退 (池无 t1/t2 原值, 如 EPC50-SNEI) ----------

def _mrow(path, chars, judge="valid", key=None):
    return {"source_path": path, "url_norm": "", "chars": chars,
            "judge": judge, "dedup_key": key or path}


def test_recompute_fallback_from_manifest(tmp_path):
    rows = [
        _mrow("E:/x/中石化南京工程EPC.md", 6_000_000),           # T1
        _mrow("E:/x/中石化南京工程中标.md", 5_500_000),           # T1
        _mrow("E:/x/中石化南京工程dup.md", 999_999, key="u:dup"),
        _mrow("E:/x/同key第二行.md", 888_888, key="u:dup"),        # dedup 虚账
        _mrow("E:/x/中国寰球工程.docx", 4_000_000),               # T2
        _mrow("E:/x/rejected被拒.md", 7_700_000, judge="rejected"),
    ]
    d = _mk_pool(tmp_path, "PREC", _rich_state(), manifest_rows=rows,
                 tiers={"T1": ["中石化南京工程"], "T2": ["中国寰球"]})
    r = tgv3.recompute_pool(d, t1_min=10_000_000)
    assert r["v3"]["t1_chars"] == 12_499_999          # valid×dedup(同 key 留
    # 首份 999,999 计, 第二份 888,888 虚账剔)×T1 词表
    assert r["v3"]["t2_chars"] == 4_000_000
    assert r["v3"]["t1_pass"] is True
    assert "重算" in r["v3"]["t1_t2_source"]
    st = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
    assert "t1_chars" not in st                        # 不顺手补写旧风格键


# ---------- 权威源口径 ----------

def test_rule_text_and_t1_min_from_gates_v3():
    t1_min = tgv3.load_t1_min()
    assert t1_min == 10_000_000                        # gates.json v3 在役值
    rule = f"T1>={t1_min}, total gate removed (v3)"
    s = {"campaign": "X", "t1_chars": t1_min, "t2_chars": 0}
    v3 = tgv3.compute_v3(s, Path("."), t1_min, now="2026-10-15T00:00:00+08:00")
    assert v3["rule"] == rule
    assert v3["rule"] == "T1>=10000000, total gate removed (v3)"
    assert v3["t1_pass"] is True and v3["computed_at"].startswith("2026-10-15")


def test_total_gate_removed_semantics():
    """v3 总门已撤: t2 巨大也救不了 t1 不足; t1 足够则 t2=0 也过."""
    s = {"t1_chars": 1_000, "t2_chars": 999_999_999}   # T1 缺→ False
    v3 = tgv3.compute_v3(s, Path("."), 10_000_000, now="t")
    assert v3["t1_pass"] is False
    s2 = {"t1_chars": 10_000_000, "t2_chars": 0}       # T1 足→ True (无总门)
    assert tgv3.compute_v3(s2, Path("."), 10_000_000,
                           now="t")["t1_pass"] is True


# ---------- run 端到端 (多池+报告落盘, REQ-012.AC1 形状) ----------

def test_run_end_to_end_with_report(tmp_path):
    _mk_pool(tmp_path, "PA", _rich_state(t1=9_000_000, t2=1))
    _mk_pool(tmp_path, "PB", _rich_state(t1=11_000_000, t2=2))
    rep = tmp_path / "work" / "tier_gate_v3_compare.md"
    out = tgv3.run(pool_root=tmp_path, pools=["PA", "PB"], report_path=rep)
    assert rep.is_file()
    txt = rep.read_text(encoding="utf-8")
    assert "PA" in txt and "PB" in txt and "False" in txt and "True" in txt
    assert "两案诚实记录" in txt and "v5" in txt          # 案一/案二叙事在位
    for p in ("PA", "PB"):
        st = json.loads((tmp_path / p / "pool_state.json")
                        .read_text(encoding="utf-8"))
        assert V3 in st                                  # AC1: 键在盘
        assert (tmp_path / p / tgv3.BACKUP_NAME).is_file()
    verd = {r["pool"]: r["v3"]["t1_pass"] for r in out["results"]}
    assert verd == {"PA": False, "PB": True}
