# -*- coding: utf-8 -*-
"""E1 单测：production_bridge 产线渠道桥——收割引擎接入研报产线调研渠道（1023 用户令）。

被测物 = kb_factory.harvest_engine.production_bridge：
- search_channel(topic, limit) → list[FileMeta]（三站检索聚合，envelope/频控复用）；
- to_pool_evidence(meta) → ammo_pool manifest 兼容条目（对齐 reforge_factory/ammo_pool.py
  ingest 行 schema；黄线件带 wall_status + 形态标注）；
- registration_row() → named_channels 注册行底稿（channel_builder enlist 同格式）；
- invocation_row()/append_invocations() → channel_invocations.jsonl 追加器
  （对齐 legs/constitution_invoke_sweep.py log_inv 键序）；
- CLI：search "主题词" --pool EPC-OVERSEAS（dry-run 默认；--commit 只追加不改动）。

侦察对齐基准（2026-10-23 实测，EPC-OVERSEAS 在役账）：
- manifest.jsonl 行 15 核心键（ingest 同构）：ts/engine/source_path/url_norm/chars/
  credibility/dedup_key/judge/judge_reason/judge_engine/tree_node/stance/budget_band/
  text_head；tier/axis 非行级字段（tier 由 tiers.json 词表×标题在 tier_report 读时派生，
  axis 在 completeness/C_axis.json 传感账）——本桥不发明行级 tier/axis 键；
- channel_invocations.jsonl 行 = {channel, ts("%F %T"), tool, queries, yield, note?}；
- named_channels 行 = {id, name, runner, note}（ResearchFactory-Eng/channel_manifest.json）。

测试纪律（WORKER_CONVENTIONS）：离线单测零网络（适配器注入）；实弹用例
（@pytest.mark.live）= 真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 时跳过并明示。
"""
import json
import os
import re
import sys
from pathlib import Path

import pytest

_REPO = Path(__file__).resolve().parents[3]
if str(_REPO) not in sys.path:
    sys.path.insert(0, str(_REPO))
if str(_REPO / "reforge_factory") not in sys.path:
    sys.path.insert(0, str(_REPO / "reforge_factory"))

import ammo_pool  # noqa: E402  产线真符号（norm_url/dedup_key/ingest 行 schema）
from completeness.channel_matrix import _alias_table, resolve_engine  # noqa: E402
from kb_factory.channel_adapters.base import FileMeta  # noqa: E402
from kb_factory.harvest_engine import production_bridge as pb  # noqa: E402
from kb_factory.harvest_engine.adapters.base import WALL_PAID  # noqa: E402

#: ingest 行 15 核心键（reforge_factory/ammo_pool.py ingest() 逐键对齐基准）。
CORE_KEYS = ("ts", "engine", "source_path", "url_norm", "chars", "credibility",
             "dedup_key", "judge", "judge_reason", "judge_engine", "tree_node",
             "stance", "budget_band", "text_head")
#: 桥允许的加性键（只增不改核心语义；消费方 .get 容忍）。
ADDITIVE_KEYS = {"form", "wall_status"}


class _FakeAdapter:
    """离线假适配器：零网络，返回预设 FileMeta 或抛预设异常（确定性注入点）。"""

    def __init__(self, metas=(), reason="", exc=None):
        self._metas = list(metas)
        self._reason = reason
        self._exc = exc

    def search(self, query, limit):
        if self._exc is not None:
            raise self._exc
        return self._metas[:limit]


def _meta(title="FIDIC合同管理要点", url="https://wenku.baidu.com/view/ab12cd34ef56.html",
          perm="green", site="wenku", **extra):
    m = FileMeta(title=title, fmt="doc", pages=30, perm=perm, source_url=url,
                 extra=dict(extra))
    m.extra.setdefault("site", site)
    return m


# ------------------------------------------------ 段1 检索聚合（注入单测）

def test_e1_search_channel_aggregates_three_sites():
    """三站检索聚合：各站 FileMeta 汇流 + extra['site'] 标注 + out 报告逐站计数。"""
    adapters = {"wenku": _FakeAdapter([_meta("A"), _meta("B")]),
                "book118": _FakeAdapter([_meta("C", url="https://max.book118.com/x/1.shtm",
                                               site="book118")]),
                "doc88": _FakeAdapter([_meta("D", url="https://www.doc88.com/p-1.html",
                                             site="doc88")])}
    report = {}
    metas = pb.search_channel("FIDIC", 10, adapters=adapters, report=report)
    assert [m.title for m in metas] == ["A", "B", "C", "D"]
    assert {m.extra["site"] for m in metas} == {"wenku", "book118", "doc88"}
    assert report["total"] == 4
    by_site = {o.site: o for o in report["outcomes"]}
    assert by_site["wenku"].ok and by_site["wenku"].n == 2
    assert by_site["book118"].n == 1 and by_site["doc88"].n == 1


def test_e1_search_channel_failsoft_not_implemented():
    """doc88 段1 未建（真实行为 NotImplementedError）→ fail-soft 记因不炸链。"""
    adapters = {"wenku": _FakeAdapter([_meta("A")]),
                "book118": _FakeAdapter(),
                "doc88": _FakeAdapter(exc=NotImplementedError("doc88 段1 search 未定"))}
    report = {}
    metas = pb.search_channel("FIDIC", 10, adapters=adapters, report=report)
    assert [m.title for m in metas] == ["A"]
    by_site = {o.site: o for o in report["outcomes"]}
    assert not by_site["doc88"].ok and by_site["doc88"].n == 0
    assert "not_implemented" in by_site["doc88"].reason


def test_e1_search_channel_wall_zero_yield_still_invoked():
    """book118 匿名登录墙（真实行为 []+reason）→ 调用已发生收获另计，reason 入账。"""
    adapters = {"wenku": _FakeAdapter([_meta("A")]),
                "book118": _FakeAdapter(reason="login_gated"),
                "doc88": _FakeAdapter(exc=NotImplementedError("x"))}
    report = {}
    metas = pb.search_channel("FIDIC", 10, adapters=adapters, report=report)
    assert len(metas) == 1
    by_site = {o.site: o for o in report["outcomes"]}
    assert by_site["book118"].ok and by_site["book118"].n == 0
    assert by_site["book118"].reason == "login_gated"


def test_e1_search_channel_marks_yellow_perm_as_paid_wall():
    """黄线件（perm=yellow，wenku sellType VIP 实测口径）→ 统一墙标 paid_wall。"""
    yellow = _meta("VIP件", perm="yellow")
    adapters = {"wenku": _FakeAdapter([yellow, _meta("free件")])}
    metas = pb.search_channel("FIDIC", 10, adapters=adapters)
    by_title = {m.title: m for m in metas}
    assert by_title["VIP件"].extra["wall_status"] == WALL_PAID
    assert "wall_status" not in by_title["free件"].extra


# ------------------------------------------------ 段2 证据条目 schema 对齐

def test_e1_to_pool_evidence_schema_aligns_ingest_row():
    """条目 15 核心键与 ingest 行逐键对齐 + 加性键白名单 + 判态 pending/零字（元数据层）。"""
    entry = pb.to_pool_evidence(_meta("A"))
    assert set(CORE_KEYS) <= set(entry)
    assert set(entry) - set(CORE_KEYS) <= ADDITIVE_KEYS
    assert entry["engine"] == "kb_harvest:wenku"
    assert entry["judge"] == "pending" and entry["judge_reason"] == ""
    assert entry["chars"] == 0                     # 检索线索未取全文，零造假
    assert entry["credibility"] == "unknown"
    assert entry["stance"] == "support" and entry["budget_band"] == ""
    assert entry["form"] == "search_lead"
    assert "wall_status" not in entry              # 绿件无墙键


def test_e1_to_pool_evidence_dedup_matches_ammo_pool_symbol():
    """dedup_key/url_norm 与产线真符号逐字节相等（跨引擎去重不漂移）。"""
    meta = _meta("A", url="https://wenku.baidu.com/view/ab12cd34ef56.html?fr=x")
    entry = pb.to_pool_evidence(meta)
    assert entry["url_norm"] == ammo_pool.norm_url(meta.source_url)
    assert entry["dedup_key"] == ammo_pool.dedup_key(meta.source_url, "")


def test_e1_to_pool_evidence_walled_item_carries_wall_and_form():
    """黄线件：wall_status 落统一标记 + form 形态标注（任务卡明示）。"""
    entry = pb.to_pool_evidence(_meta("VIP件", perm="yellow"))
    assert entry["wall_status"] == WALL_PAID
    assert entry["form"] == "search_lead"
    assert set(entry) - set(CORE_KEYS) == {"form", "wall_status"}


def test_e1_to_pool_evidence_tree_stance_band_passthrough():
    """tree_node/stance/budget_band 透传（挂树 EEI/ACH 立场/S2-2 分档口径同 ingest）。"""
    entry = pb.to_pool_evidence(_meta("A"), tree="Q23-E1", stance="against",
                                band="gap")
    assert entry["tree_node"] == "Q23-E1"
    assert entry["stance"] == "against" and entry["budget_band"] == "gap"


# ------------------------------------------------ 段3 注册行/调用账对齐

def test_e1_registration_row_maps_engine_label_via_c_axis_sensor():
    """注册行（named_channels 底稿）经 C 轴传感器自身解析器点亮 kb_harvest 渠道。"""
    reg = pb.registration_row()
    assert set(reg) == {"id", "name", "runner", "note"}
    assert reg["id"] == pb.CHANNEL_ID == "kb_harvest"
    table = _alias_table([reg])                    # 传感器真符号：入列后别名表
    for label in ("kb_harvest:wenku", "kb_harvest:book118", "kb_harvest:doc88"):
        assert "kb_harvest" in resolve_engine(label, table)["channels"], label


def test_e1_invocation_row_matches_ledger_shape():
    """调用账行与 constitution_invoke_sweep.log_inv 同键序同时间格式（传感账口径）。"""
    report = {}
    pb.search_channel(
        "FIDIC", 10,
        adapters={"wenku": _FakeAdapter([_meta("A"), _meta("B")]),
                  "book118": _FakeAdapter(reason="login_gated"),
                  "doc88": _FakeAdapter(exc=NotImplementedError("x"))},
        report=report)
    row = pb.invocation_row("FIDIC", report, new_count=2)
    assert list(row) == ["channel", "ts", "tool", "queries", "yield", "note"]
    assert row["channel"] == pb.CHANNEL_ID
    assert re.fullmatch(r"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}", row["ts"])
    assert row["queries"] == "FIDIC"
    assert "2" in row["yield"] and "wenku" in row["yield"]
    assert "book118" in row["note"] or "doc88" in row["note"]  # 墙/未建如实入注


# ------------------------------------------------ 段4 追加器：只追加不改动

def _seed_pool(tmp_path: Path, n_manifest=2, dup_url=None) -> Path:
    pool = tmp_path / "EPC-TEST"
    pool.mkdir(exist_ok=True)
    rows = []
    for i in range(n_manifest):
        rows.append(json.dumps(
            {"ts": "2026-10-23T00:00:00", "engine": "seed", "source_path": f"s{i}",
             "url_norm": "", "chars": 100 + i, "credibility": "unknown",
             "dedup_key": f"c:seed{i}", "judge": "valid", "judge_reason": "",
             "judge_engine": "", "tree_node": "", "stance": "support",
             "budget_band": "", "text_head": f"seed{i}"}, ensure_ascii=False))
    if dup_url is not None:                       # 查重靶：与桥将产出的 key 同
        rows.append(json.dumps(
            {"ts": "2026-10-23T00:00:00", "engine": "kb_harvest:wenku",
             "source_path": "", "url_norm": ammo_pool.norm_url(dup_url),
             "chars": 0, "credibility": "unknown",
             "dedup_key": ammo_pool.dedup_key(dup_url, ""), "judge": "pending",
             "judge_reason": "", "judge_engine": "", "tree_node": "",
             "stance": "support", "budget_band": "", "text_head": "旧线索"},
            ensure_ascii=False))
    (pool / "manifest.jsonl").write_text("\n".join(rows) + "\n", encoding="utf-8")
    (pool / "channel_invocations.jsonl").write_text(
        json.dumps({"channel": "seed", "ts": "2026-10-23 00:00:00", "tool": "t",
                    "queries": "q", "yield": "y", "note": ""},
                   ensure_ascii=False) + "\n", encoding="utf-8")
    return pool


def test_e1_append_manifest_append_only_and_dedup(tmp_path, capsys):
    """manifest 只追加：既有行字节不动 + dedup_key 查重跳过 + 预览先行。"""
    dup_url = "https://wenku.baidu.com/view/dup0000000000000000000000000000.html"
    pool = _seed_pool(tmp_path, dup_url=dup_url)
    mp = pool / "manifest.jsonl"
    before = mp.read_bytes()
    dup_entry = pb.to_pool_evidence(_meta("旧线索已在池", url=dup_url))
    new_entry = pb.to_pool_evidence(
        _meta("新线索", url="https://wenku.baidu.com/view/new000000000000000000000.html"))
    new, skipped = pb.filter_new([dup_entry, new_entry], mp)
    assert len(new) == 1 and skipped == 1
    stats = pb.append_manifest(pool, new, dry_run=False)
    after = mp.read_bytes()
    assert after.startswith(before)               # 只追加：旧内容为前缀
    assert stats["appended"] == 1 and stats["skipped"] == 0
    out = capsys.readouterr().out
    assert "追加预览" in out                        # 追加前 diff 预览（纪律）


def test_e1_append_invocation_append_only(tmp_path, capsys):
    """channel_invocations.jsonl 只追加：既有行字节不动 + 恰 +1 行。"""
    pool = _seed_pool(tmp_path)
    ip = pool / "channel_invocations.jsonl"
    before = ip.read_bytes()
    report = {}
    pb.search_channel("FIDIC", 5, adapters={"wenku": _FakeAdapter([_meta("A")]),
                                            "book118": _FakeAdapter(),
                                            "doc88": _FakeAdapter(
                                                exc=NotImplementedError("x"))},
                      report=report)
    row = pb.invocation_row("FIDIC", report, new_count=1)
    pb.append_invocations(pool, [row], dry_run=False)
    after = ip.read_bytes()
    assert after.startswith(before)
    assert after.count(b"\n") == before.count(b"\n") + 1
    assert json.loads(after.decode("utf-8").splitlines()[-1])["channel"] == "kb_harvest"
    assert "调用账预览" in capsys.readouterr().out


# ------------------------------------------------ 段5 CLI（dry-run 默认）

def _fake_adapters_full():
    return {"wenku": _FakeAdapter([_meta("A"), _meta("B", url=URL_B)]),
            "book118": _FakeAdapter(reason="login_gated"),
            "doc88": _FakeAdapter(exc=NotImplementedError("doc88 段1 未建"))}


URL_B = "https://wenku.baidu.com/view/bb000000000000000000000000000000.html"


def test_e1_cli_dryrun_prints_and_touches_nothing(tmp_path, capsys):
    """CLI dry-run（默认）：证据条目/注册行/调用账/diff 预览全打印，零落盘。"""
    pool = _seed_pool(tmp_path)
    mb = (pool / "manifest.jsonl").read_bytes()
    ib = (pool / "channel_invocations.jsonl").read_bytes()
    rc = pb.main(["search", "FIDIC", "--pool", "EPC-TEST",
                  "--pool-root", str(tmp_path), "--limit", "5"],
                 adapters=_fake_adapters_full())
    assert rc == 0
    out = capsys.readouterr().out
    assert "[evidence]" in out and "kb_harvest" in out
    assert "注册行" in out and "调用账预览" in out and "追加预览" in out
    assert "dry-run" in out
    assert (pool / "manifest.jsonl").read_bytes() == mb
    assert (pool / "channel_invocations.jsonl").read_bytes() == ib


def test_e1_cli_commit_appends_manifest_and_ledger(tmp_path, capsys):
    """CLI --commit：manifest +N 行/调用账 +1 行（只追加）+ 预览先于落盘。"""
    pool = _seed_pool(tmp_path)
    mp, ip = pool / "manifest.jsonl", pool / "channel_invocations.jsonl"
    mb, ib = mp.read_bytes(), ip.read_bytes()
    rc = pb.main(["search", "FIDIC", "--pool", "EPC-TEST",
                  "--pool-root", str(tmp_path), "--limit", "5", "--commit"],
                 adapters=_fake_adapters_full())
    assert rc == 0
    ma, ia = mp.read_bytes(), ip.read_bytes()
    assert ma.startswith(mb) and ma.count(b"\n") == mb.count(b"\n") + 2
    assert ia.startswith(ib) and ia.count(b"\n") == ib.count(b"\n") + 1
    out = capsys.readouterr().out
    assert out.index("追加预览") < out.index("已追加")   # 预览在落盘动作之前
    assert "已追加 manifest +2" in out


def test_e1_cli_commit_refuses_unknown_pool(tmp_path, capsys):
    """--commit 对不存在战役池拒写（产线在役资产纪律：不静默建池）。"""
    rc = pb.main(["search", "FIDIC", "--pool", "NO-SUCH-POOL",
                  "--pool-root", str(tmp_path), "--commit"],
                 adapters=_fake_adapters_full())
    assert rc == 2
    assert "拒写" in capsys.readouterr().out


# ------------------------------------------------ 段6 实弹（真实网络）

@pytest.mark.live
def test_e1_live_search_wenku_real_word():
    """实弹 1 词：wenku syncmrecall 免登录检索（zero-mock）→ ≥1 FileMeta + 条目可产。"""
    if os.environ.get("KB_HARVEST_SKIP_LIVE") == "1":
        pytest.skip("KB_HARVEST_SKIP_LIVE=1 — 实弹用例跳过（CI 场景，明示）")
    adapters = pb.build_search_adapters(("wenku",))
    report = {}
    metas = pb.search_channel("FIDIC", 3, adapters=adapters, report=report)
    by_site = {o.site: o for o in report["outcomes"]}
    assert by_site["wenku"].ok, f"wenku 检索调用未完成: {by_site['wenku'].reason}"
    assert metas, "wenku 实弹检索应 ≥1 条（FR2.AC1 同源免登录口径）"
    entry = pb.to_pool_evidence(metas[0])
    assert entry["engine"] == "kb_harvest:wenku" and entry["url_norm"]
    assert entry["judge"] == "pending" and entry["chars"] == 0
