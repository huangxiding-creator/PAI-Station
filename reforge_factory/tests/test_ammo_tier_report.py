# -*- coding: utf-8 -*-
"""tier_report 单测——分层门 v3 主判器（1005 用户定调）的核心账目逻辑。

不碰真池：monkeypatch POOL_ROOT 到 tmp_path，构造 manifest/tiers/state 夹具。
覆盖: 四层分类/dedup/valid 过滤/T3 封顶/双门判定/无词表回退/坏行免疫。
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as ap  # noqa: E402


def _row(path, chars, judge="valid", key=None):
    return {"source_path": path, "url_norm": "", "chars": chars,
            "judge": judge, "dedup_key": key or path}


@pytest.fixture
def camp(tmp_path, monkeypatch):
    monkeypatch.setattr(ap, "POOL_ROOT", tmp_path)
    d = tmp_path / "TIERX"
    d.mkdir()
    return d


def _write(d, rows, tiers=None, kws=None):
    if tiers is not None:
        (d / "tiers.json").write_text(
            json.dumps(tiers, ensure_ascii=False), encoding="utf-8")
    (d / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")
    (d / "pool_state.json").write_text(
        json.dumps({"campaign": d.name, "kws": kws or []}), encoding="utf-8")


TIERS = {"T1": ["四川电力"], "T2": ["电力设计院"]}


def test_tier_classification_four_buckets(camp):
    _write(camp, [
        _row("E:/x/四川电力设计咨询.pdf", 100),      # T1 命中优先
        _row("E:/x/某电力设计院年报.pdf", 200),       # T2
        _row("E:/x/工程总承包行业白皮书.pdf", 50),    # kws 命中 → T3
        _row("E:/x/ unrelated.docx", 10),            # T0
    ], tiers=TIERS, kws=["工程总承包"])
    t = ap.tier_report("TIERX")
    assert t["t1"] == 100 and t["n1"] == 1
    assert t["t2"] == 200 and t["n2"] == 1
    assert t["t3"] == 50 and t["n3"] == 1
    assert t["t0"] == 10 and t["n0"] == 1
    assert t["tiers_configured"] is True


def test_dedup_key_counts_once(camp):
    _write(camp, [
        _row("E:/x/a.pdf", 100, key="K"),
        _row("E:/x/b.pdf", 999, key="K"),            # 同 key 第二行=虚账
    ], tiers=TIERS)
    t = ap.tier_report("TIERX")
    assert t["t1"] + t["t2"] + t["t3"] + t["t0"] == 100


def test_invalid_rows_skipped(camp):
    _write(camp, [
        _row("E:/x/四川电力.pdf", 100, judge="rejected"),
        _row("E:/x/四川电力2.pdf", 100),
    ], tiers=TIERS)
    assert ap.tier_report("TIERX")["t1"] == 100


def test_t3_capped_and_gate_math(camp, monkeypatch):
    monkeypatch.setattr(ap, "T3_CAP_CHARS", 500)
    _write(camp, [
        _row("E:/x/行业泛文.pdf", 800),               # T3 超 cap
        _row("E:/x/四川电力a.pdf", 300),              # T1
    ], tiers=TIERS, kws=["行业"])
    t = ap.tier_report("TIERX")
    assert t["t3_capped"] == 500
    assert t["gate_chars"] == 300 + 500


def test_gate_ok_double_gate(camp, monkeypatch):
    monkeypatch.setattr(ap, "T1_MIN_CHARS", 100)
    monkeypatch.setattr(ap, "T12_MIN_CHARS", 500)
    _write(camp, [
        _row("E:/x/四川电力a.pdf", 120),              # T1 120 ≥100 但 t1+t2=120 <500
    ], tiers=TIERS)
    assert ap.tier_report("TIERX")["gate_ok"] is False
    _write(camp, [
        _row("E:/x/四川电力a.pdf", 120),
        _row("E:/x/电力设计院b.pdf", 400),            # 补 T2 后双门过
    ], tiers=TIERS)
    assert ap.tier_report("TIERX")["gate_ok"] is True


def test_no_tiers_configured_flag(camp):
    _write(camp, [_row("E:/x/a.pdf", 10)])
    t = ap.tier_report("TIERX")
    assert t["tiers_configured"] is False and t["t0"] == 10


def test_malformed_lines_immune(camp):
    (camp / "manifest.jsonl").write_text(
        "{broken json\n\n" + json.dumps(_row("E:/x/四川电力.pdf", 10)) + "\n",
        encoding="utf-8")
    t = ap.tier_report("TIERX")  # 无 tiers.json → 全落 T0, 但坏行必须被跳过
    assert t["t0"] == 10 and t["n0"] == 1


def test_bad_campaign_id_rejected():
    with pytest.raises(ValueError):
        ap.tier_report("bad/id")
