# -*- coding: utf-8 -*-
"""词林术语归一层测试（KB-FACTORY v2.7 #10，波B）

判据对应：
tc1 倒排完整性：cilin.json 全量如实——77456 去重词/17809 唯一编码（简报口径
    「85777」= 巨人 README 词林+HowNet 并集词汇量，非词林文件词数，台账已记档，
    零造假纪律以实测 77456 为准）；倒排↔群表双侧对账 + _summary 台账交叉核对；
tc2 同群归一：'=' 原子同义群归一（真实锚点群 Aa01A01= 人族 / Bm05A02= 混凝土族），
    代表=DF 最高→最短→码点序最小；'#' 相关群/'@' 独立词不归一；幂等、顺序对齐；
tc3 开关默认关零漂移：env KB_CILIN_NORM 缺省=关——关态直通且连数据都不加载；
    显式参数优先于 env；真值口径 {1,true,on,yes}；
tc4 离线 mock：独立 mock 种子目录驱动全机制（不依赖真数据文件）；
    缺席/损坏 fail-soft——available=False + 原样直通，绝不抛。
"""
import json
import os
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import cilin_norm  # noqa: E402

KB_FACTORY = Path(__file__).resolve().parents[2]
CILIN_DIR = KB_FACTORY / "seeds" / "cilin"


@pytest.fixture(autouse=True)
def _clean_state(monkeypatch):
    """每测前清懒载缓存+钉真 seeds 目录+摘除 env，测试互不渗透。"""
    cilin_norm.reset()
    monkeypatch.setattr(cilin_norm, "SEEDS_DIR", CILIN_DIR)
    monkeypatch.delenv(cilin_norm.ENV_SWITCH, raising=False)
    yield
    cilin_norm.reset()


# ── tc1 倒排完整性（简报 85777 口径注记：实测 77456，见 _summary.json） ─────

def test_inverted_integrity_full_volume():
    assert cilin_norm.available(), f"真数据缺席: {cilin_norm.last_error()}"
    payload = json.loads((CILIN_DIR / "cilin.json").read_text(encoding="utf-8"))
    inv = payload["words"]
    assert len(inv) == 77456, \
        f"倒排词数实测 {len(inv)} != 77456（85777=词林+HowNet 并集口径，非本文件词数）"
    codes_from_words = set()
    for word, cs in inv.items():
        assert isinstance(cs, list) and cs, f"{word} 无编码"
        for c in cs:
            assert len(c) == 8 and c[7] in "=#@", f"坏编码 {c}"
            assert c[:7].isalnum(), f"前 7 位非五层码 {c}"
            codes_from_words.add(c)
    assert len(codes_from_words) == 17809, f"唯一编码 {len(codes_from_words)} != 17809"


def test_summary_ledger_crosscheck():
    """台账交叉核对：模块实测 ↔ _summary.json 逐项全等（零造假对账）。"""
    summary = json.loads((CILIN_DIR / "_summary.json").read_text(encoding="utf-8"))
    payload = json.loads((CILIN_DIR / "cilin.json").read_text(encoding="utf-8"))
    inv = payload["words"]
    assert summary["unique_words"] == len(inv) == 77456
    assert summary["code_groups"] == len({c for cs in inv.values() for c in cs}) == 17809
    assert summary["raw_bytes"] == 696374 and summary["raw_lines"] == 17817
    assert summary["groups_by_marker"] == {"=": 9988, "#": 3445, "@": 4376}
    assert "85777" in summary["note_85777"], "85777 口径注记缺失"


def test_inverted_matches_module_load():
    assert cilin_norm.available()
    payload = json.loads((CILIN_DIR / "cilin.json").read_text(encoding="utf-8"))
    data = cilin_norm._load()
    assert data is not None and data[0] == payload["words"]


def test_real_anchors():
    """真实锚点：人（多码词·数据序首个 '=' 码）与 混凝土/砼 工程群。"""
    assert cilin_norm.group_of("人") == "Aa01A01="
    assert cilin_norm.group_of("混凝土") == cilin_norm.group_of("砼") == "Bm05A02="
    inv = cilin_norm._load()[0]
    assert inv["安全帽"] == ["Bq05A08#"]          
    assert cilin_norm.group_of("安全帽") is None  # '#' 相关群不参与归一
    assert cilin_norm.group_of("不存在的词X") is None


# ── tc2 同群归一 ────────────────────────────────────────────────────────────

def test_same_group_all_members_converge():
    """Aa01A01= {人 士 人物 人士 人氏 人选} 全群收敛同一代表（无 DF→最短→码点序=人）。"""
    members = ["人", "士", "人物", "人士", "人氏", "人选"]
    out = cilin_norm.normalize_terms(members, enabled=True)
    assert set(out) == {"人"}, f"同群未收敛: {out}"
    assert out == ["人"] * 6, "顺序/长度未对齐"


def test_representative_selection_df_then_shortest():
    """Bm05A02= {混凝土, 砼}：无 DF→最短「砼」；DF 高→「混凝土」；平 DF→最短「砼」。"""
    assert cilin_norm.group_representative("Bm05A02=") == "砼"
    assert cilin_norm.group_representative("Bm05A02=", {"混凝土": 9, "砼": 1}) == "混凝土"
    assert cilin_norm.group_representative("Bm05A02=", {"混凝土": 5, "砼": 5}) == "砼"
    out = cilin_norm.normalize_terms(["砼", "混凝土"], term_df={"混凝土": 9}, enabled=True)
    assert out == ["混凝土", "混凝土"]


def test_subgroup_markers_not_merged():
    """'#' 相关群（安全帽所在帽类群）与 '@' 独立词不归一，原样保留。"""
    assert cilin_norm.normalize_terms(["安全帽"], enabled=True) == ["安全帽"]
    assert cilin_norm.normalize_map(["安全帽"], enabled=True) == {}


def test_idempotent_and_unknown_passthrough():
    once = cilin_norm.normalize_terms(["砼", "未知词"], enabled=True)
    twice = cilin_norm.normalize_terms(once, enabled=True)
    assert once == twice == ["砼", "未知词"]
    assert cilin_norm.normalize_map(["士", "未知词"], enabled=True) == {"士": "人"}


def test_normalize_terms_never_mutates_input():
    src = ["砼"]
    cilin_norm.normalize_terms(src, enabled=True)
    assert src == ["砼"]


# ── tc3 开关默认关零漂移 ────────────────────────────────────────────────────

def test_default_off_zero_drift_no_load():
    """env 缺省=关：真词林词也原样直通，且连数据都不加载（真零漂移）。"""
    src = ["砼", "人物", "安全帽", "未知词"]
    assert cilin_norm.normalize_terms(src) == src
    assert cilin_norm.normalize_map(src) == {}
    assert cilin_norm._STATE["inverted"] is None, "关态不应加载数据"


def test_explicit_disabled_overrides_env(monkeypatch):
    monkeypatch.setenv(cilin_norm.ENV_SWITCH, "1")
    src = ["砼"]
    assert cilin_norm.normalize_terms(src, enabled=False) == src


def test_env_truthy_table(monkeypatch):
    src = ["人物"]
    for truthy in ("1", "true", "on", "yes", "ON", "True"):
        cilin_norm.reset()
        monkeypatch.setenv(cilin_norm.ENV_SWITCH, truthy)
        assert cilin_norm.normalize_terms(src) == ["人"], truthy
    for falsy in ("0", "", "off", "no"):
        monkeypatch.setenv(cilin_norm.ENV_SWITCH, falsy)
        assert cilin_norm.normalize_terms(src) == src, falsy


# ── tc4 离线 mock ───────────────────────────────────────────────────────────

MOCK_WORDS = {
    "甲": ["Zz01A01="], "乙": ["Zz01A01="], "丙": ["Zz01A01="],
    "独": ["Zz02A01@"],
    "相": ["Zz03A01#"], "关": ["Zz03A01#"],
    "多": ["Zz04A01#", "Zz05A01="], "多伴": ["Zz05A01="],
    "坏码": ["XX"],
}


def _mock_dir(tmp_path):
    d = tmp_path / "cilin_mock"
    d.mkdir()
    (d / "cilin.json").write_text(
        json.dumps({"meta": {"source": "mock"}, "words": MOCK_WORDS}, ensure_ascii=False),
        encoding="utf-8")
    return d


def test_offline_mock_full_mechanism(tmp_path, monkeypatch):
    monkeypatch.setattr(cilin_norm, "SEEDS_DIR", _mock_dir(tmp_path))
    assert cilin_norm.available(), cilin_norm.last_error()
    # '=' 群：无 DF → 码点序最小「丙」；DF 高者胜「甲」
    assert cilin_norm.group_representative("Zz01A01=") == "丙"
    assert cilin_norm.group_representative("Zz01A01=", {"甲": 3}) == "甲"
    assert cilin_norm.normalize_terms(["甲", "乙"], enabled=True) == ["丙", "丙"]
    assert cilin_norm.normalize_terms(["甲"], term_df={"甲": 3}, enabled=True) == ["甲"]
    # '@' 独立 / '#' 相关：不归一
    assert cilin_norm.normalize_terms(["独", "相", "关"], enabled=True) == ["独", "相", "关"]
    # 多码词取数据序首个 '=' 码（Zz05A01=）；坏码不入群
    assert cilin_norm.group_of("多") == "Zz05A01="
    assert cilin_norm.normalize_terms(["多伴", "坏码"], enabled=True) == ["多", "坏码"]


def test_offline_missing_seed_failsoft(tmp_path, monkeypatch):
    empty = tmp_path / "cilin_absent"
    empty.mkdir()
    monkeypatch.setattr(cilin_norm, "SEEDS_DIR", empty)
    src = ["甲", "乙"]
    assert cilin_norm.available() is False
    assert cilin_norm.last_error() and "载入失败" in cilin_norm.last_error()
    assert cilin_norm.normalize_terms(src, enabled=True) == src      # fail-soft 直通
    assert cilin_norm.group_of("甲") is None


def test_offline_corrupt_seed_failsoft(tmp_path, monkeypatch):
    d = tmp_path / "cilin_corrupt"
    d.mkdir()
    (d / "cilin.json").write_text("{坏 json", encoding="utf-8")
    monkeypatch.setattr(cilin_norm, "SEEDS_DIR", d)
    src = ["甲"]
    assert cilin_norm.available() is False
    assert cilin_norm.normalize_terms(src, enabled=True) == src
    assert cilin_norm.normalize_map(src, enabled=True) == {}


def test_off_state_immune_to_seed_swap(tmp_path, monkeypatch):
    """关态换任意 seeds 目录都零漂移（合规默认关的铁证）。"""
    monkeypatch.setattr(cilin_norm, "SEEDS_DIR", tmp_path / "nowhere")
    src = ["甲", "砼"]
    assert cilin_norm.normalize_terms(src) == src
