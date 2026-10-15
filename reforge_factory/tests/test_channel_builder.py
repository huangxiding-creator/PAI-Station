# -*- coding: utf-8 -*-
"""建渠器四步法测试 (T-015 / REQ-029 后半 / KB-CHANNEL-BUILDER-SPEC)。

覆盖 (全程合成/mock, 不占真请求配额; 真请求守卫见 test_channels_academic.py):
  1. verdict 状态机: 200+样本→available; 401/403→needs_creds; 429→needs_creds
     (匿名限流口径); 200 无样本→abandoned; 5xx→abandoned; 不可达→abandoned
  2. probe 无配方渠道 → ValueError (不冒充探测)
  3. implement: 三件套返回在盘模块路径; 未知渠道 no_recipe
  4. 队列解析: 「学术英文（OpenAlex/S2/arXiv 待建渠 T-015）」一条展开三件套;
     纯 id/arXiv 缺口名/academic_en 基名; 未知缺口 no_recipe 留痕不丢
  5. 队列文件装载: [{name,sop_step}] / 纯字符串 / 每行一名字文本
  6. enlist: 只增追加 (既有条目一字不动) + totals 计数同步; 幂等
     (重复入列不重复登记, 文件字节不变); dry-run 不写
  7. 四步编排: available 全链入列+台账步序 start→probe→verdict→implement→
     enlisted; abandoned/鉴权墙不入列留 skip; 429 匿名限流入列带实证注记
"""
import io
import json
import sys
import urllib.error
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import channel_builder as cb  # noqa: E402


# ---- 夹具 ---------------------------------------------------------------

def make_manifest(path: Path, n: int = 2) -> Path:
    chans = [{"id": f"chan{i}", "name": f"渠道{i}", "runner": "-", "note": "-"}
             for i in range(1, n + 1)]
    path.write_text(json.dumps(
        {"version": 2, "updated": "2026-10-01", "totals": {
            "families": 1, "named_channels": n, "site_endpoints": 10},
         "families": [], "named_channels": chans},
        ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    return path


def probe_ok(channel="openalex"):
    return {"channel": channel, "reachable": True, "http_status": 200,
            "sample_ok": True, "latency_ms": 800, "error": None,
            "query": cb.PROBE_QUERY}


@pytest.fixture
def lab(tmp_path):
    return {
        "manifest": make_manifest(tmp_path / "channel_manifest.json"),
        "ledger": tmp_path / "work" / "channel_build_ledger.jsonl",
    }


def ledger_steps(path: Path) -> list[dict]:
    return [json.loads(ln) for ln in
            Path(path).read_text(encoding="utf-8").splitlines() if ln.strip()]


# ---- 1. verdict 状态机 --------------------------------------------------

def test_verdict_available():
    v = cb.verdict(probe_ok())
    assert v["verdict"] == "available"
    assert "200" in v["reason"] and "样本" in v["reason"]


@pytest.mark.parametrize("status", [401, 402, 403])
def test_verdict_needs_creds_auth_wall(status):
    v = cb.verdict({"reachable": True, "http_status": status, "sample_ok": False})
    assert v["verdict"] == "needs_creds"
    assert str(status) in v["reason"]


def test_verdict_needs_creds_rate_limit():
    v = cb.verdict({"reachable": True, "http_status": 429, "sample_ok": False})
    assert v["verdict"] == "needs_creds"
    assert "429" in v["reason"] and "限流" in v["reason"]


def test_verdict_abandoned_bad_shape():
    v = cb.verdict({"reachable": True, "http_status": 200, "sample_ok": False})
    assert v["verdict"] == "abandoned"
    assert "形态" in v["reason"]


@pytest.mark.parametrize("status", [500, 503])
def test_verdict_abandoned_server_error(status):
    v = cb.verdict({"reachable": True, "http_status": status, "sample_ok": False})
    assert v["verdict"] == "abandoned"


def test_verdict_abandoned_unreachable():
    v = cb.verdict({"reachable": False, "http_status": None, "sample_ok": False,
                    "error": "URLError: timed out"})
    assert v["verdict"] == "abandoned"
    assert "不可达" in v["reason"] and "timed out" in v["reason"]


# ---- 2/3. probe 与 implement -------------------------------------------

def test_probe_unknown_channel_raises():
    with pytest.raises(ValueError, match="no_probe_recipe"):
        cb.probe("nonexistent_channel")


def test_probe_timeout_retry_then_success(monkeypatch):
    """KB「超时重试」: 第 1 发超时, 重试 1 次成功 → 200 + sample_ok, attempts=2。"""
    calls = {"n": 0}

    def flaky(q, limit):
        calls["n"] += 1
        if calls["n"] == 1:
            raise TimeoutError("The read operation timed out")
        return [{"title": "EPC contract study", "url": "https://x/1",
                 "year": 2024, "abstract_head": "a", "source": "s"}]

    monkeypatch.setitem(cb.RECIPES, "_test", {
        "aliases": ["_test"], "probe_fn": flaky, "module": "x.py",
        "functions": [], "manifest": {"id": "_test", "name": "t", "runner": "r",
                                      "note": "n"}})
    monkeypatch.setattr(cb.time, "sleep", lambda s: None)  # 重试间隔不拖慢测试
    pr = cb.probe("_test")
    assert pr["reachable"] is True and pr["http_status"] == 200
    assert pr["sample_ok"] is True and pr["attempts"] == 2


def test_probe_timeout_both_attempts_unreachable(monkeypatch):
    def always_timeout(q, limit):
        raise TimeoutError("The read operation timed out")

    monkeypatch.setitem(cb.RECIPES, "_test", {
        "aliases": ["_test"], "probe_fn": always_timeout, "module": "x.py",
        "functions": [], "manifest": {"id": "_test", "name": "t", "runner": "r",
                                      "note": "n"}})
    monkeypatch.setattr(cb.time, "sleep", lambda s: None)
    pr = cb.probe("_test")
    assert pr["reachable"] is False and pr["http_status"] is None
    assert pr["attempts"] == 2 and "TimeoutError" in pr["error"]


def test_probe_http_status_not_retried(monkeypatch):
    """429/5xx 不自动重试 (限流端点不打扰): 1 发即判。"""
    calls = {"n": 0}

    def limited(q, limit):
        calls["n"] += 1
        raise urllib.error.HTTPError(
            "u", 429, "Too Many Requests", hdrs=None, fp=io.BytesIO(b"{}"))

    monkeypatch.setitem(cb.RECIPES, "_test", {
        "aliases": ["_test"], "probe_fn": limited, "module": "x.py",
        "functions": [], "manifest": {"id": "_test", "name": "t", "runner": "r",
                                      "note": "n"}})
    monkeypatch.setattr(cb.time, "sleep", lambda s: None)
    pr = cb.probe("_test")
    assert pr["http_status"] == 429 and pr["attempts"] == 1
    assert calls["n"] == 1


def test_implement_known_returns_module_on_disk():
    for cid in ("openalex", "semantic_scholar", "arxiv"):
        im = cb.implement(cid)
        assert im["module"] == "reforge_factory/channels/academic.py"
        assert im["module_exists"] is True
        assert im["functions"]


def test_implement_unknown_no_recipe():
    im = cb.implement("court_wenshu")
    assert im["module"] is None
    assert "no_recipe" in im["reason"]


# ---- 4. 队列解析 --------------------------------------------------------

def test_resolve_academic_gap_entry_expands_to_trio():
    picked, no_recipe = cb.resolve_queue_entries(
        ["学术英文（OpenAlex/S2/arXiv 待建渠 T-015）"])
    assert set(picked) == {"openalex", "semantic_scholar", "arxiv"}
    assert no_recipe == []


def test_resolve_single_names_and_base():
    assert cb.resolve_queue_entries(["arXiv（待建渠 T-015）"])[0] == ["arxiv"]
    assert cb.resolve_queue_entries(["academic_en"])[0] == \
        ["openalex", "semantic_scholar", "arxiv"]
    assert cb.resolve_queue_entries(["semantic_scholar"])[0] == \
        ["semantic_scholar"]
    assert cb.resolve_queue_entries(["OpenAlex"])[0] == ["openalex"]


def test_resolve_unknown_kept_as_no_recipe():
    picked, no_recipe = cb.resolve_queue_entries(
        [{"name": "wenshu 直采", "sop_step": "1"}, "openalex"])
    assert picked == ["openalex"]
    assert len(no_recipe) == 1 and no_recipe[0]["name"] == "wenshu 直采"


def test_resolve_dedupe_across_entries():
    picked, _ = cb.resolve_queue_entries(["arXiv", "arXiv（待建渠 T-015）"])
    assert picked == ["arxiv"]


# ---- 5. 队列文件装载 ----------------------------------------------------

def test_load_gap_file_queue_dict_format(tmp_path):
    p = tmp_path / "C_axis_queue.json"
    p.write_text(json.dumps(
        [{"name": "OpenAlex", "sop_step": "T-015 四步法"}, "arXiv"],
        ensure_ascii=False), encoding="utf-8")
    assert cb.load_gap_file(p) == [
        {"name": "OpenAlex", "sop_step": "T-015 四步法"}, "arXiv"]


def test_load_gap_file_text_lines(tmp_path):
    p = tmp_path / "gaps.txt"
    p.write_text("OpenAlex\n\nSemantic Scholar (S2)\n某无配方渠道\n",
                 encoding="utf-8")
    assert cb.load_gap_file(p) == ["OpenAlex", "Semantic Scholar (S2)",
                                   "某无配方渠道"]


# ---- 6. enlist 只增 + 幂等 ----------------------------------------------

def test_enlist_appends_and_keeps_existing_entries(lab):
    before = lab["manifest"].read_text(encoding="utf-8")
    out = cb.enlist("openalex", probe_ok(), cb.verdict(probe_ok()),
                    manifest_path=lab["manifest"], ledger_path=lab["ledger"])
    assert out["enlisted"] is True
    data = json.loads(lab["manifest"].read_text(encoding="utf-8"))
    ids = [c["id"] for c in data["named_channels"]]
    assert ids == ["chan1", "chan2", "openalex"]  # 只尾部追加
    # 既有条目一字不动: 原条目序列在新文件中保持原字节序列
    assert json.dumps(data["named_channels"][:2], ensure_ascii=False) == \
        json.dumps(json.loads(before)["named_channels"], ensure_ascii=False)
    assert data["totals"]["named_channels"] == 3
    assert data["updated"]  # updated 日期同步


def test_enlist_idempotent(lab):
    pr, vd = probe_ok(), cb.verdict(probe_ok())
    cb.enlist("arxiv", pr, vd, manifest_path=lab["manifest"],
              ledger_path=lab["ledger"])
    snap = lab["manifest"].read_text(encoding="utf-8")
    out2 = cb.enlist("arxiv", pr, vd, manifest_path=lab["manifest"],
                     ledger_path=lab["ledger"])
    assert out2["enlisted"] is False and out2["reason"] == "already_enlisted"
    assert lab["manifest"].read_text(encoding="utf-8") == snap  # 文件字节不变
    assert len(ledger_steps(lab["ledger"])) == 2  # 每次调用各留一行


def test_enlist_dry_run_no_write(lab):
    before = lab["manifest"].read_text(encoding="utf-8")
    out = cb.enlist("openalex", probe_ok(), cb.verdict(probe_ok()),
                    manifest_path=lab["manifest"], ledger_path=lab["ledger"],
                    dry_run=True)
    assert out["enlisted"] is False and out["reason"] == "dry_run"
    assert lab["manifest"].read_text(encoding="utf-8") == before


def test_enlist_entry_schema_matches_manifest(lab):
    cb.enlist("semantic_scholar", probe_ok(), cb.verdict(probe_ok()),
              manifest_path=lab["manifest"], ledger_path=lab["ledger"])
    data = json.loads(lab["manifest"].read_text(encoding="utf-8"))
    entry = data["named_channels"][-1]
    assert set(entry) >= {"id", "name", "runner", "note"}  # 与既有条目同 schema
    assert "probe http=200" in entry["note"]  # 探实证随行


# ---- 7. 四步编排 --------------------------------------------------------

def test_build_channel_full_flow_available(lab, monkeypatch):
    monkeypatch.setattr(cb, "probe", lambda ch: probe_ok(ch))
    r = cb.build_channel("openalex", manifest_path=lab["manifest"],
                         ledger_path=lab["ledger"], campaign="EPC-BID26")
    assert r["enlisted"] is True and r["verdict"] == "available"
    steps = [ln["step"] for ln in ledger_steps(lab["ledger"])]
    assert steps == ["start", "probe", "verdict", "implement", "enlist"]
    first = ledger_steps(lab["ledger"])[0]
    assert first["campaign"] == "EPC-BID26"
    assert json.loads(lab["manifest"].read_text(encoding="utf-8"))[
        "named_channels"][-1]["id"] == "openalex"


def test_build_channel_abandoned_not_enlisted(lab, monkeypatch):
    monkeypatch.setattr(cb, "probe", lambda ch: {
        "channel": ch, "reachable": True, "http_status": 503,
        "sample_ok": False, "latency_ms": 1, "error": "HTTPError 503",
        "query": cb.PROBE_QUERY})
    r = cb.build_channel("openalex", manifest_path=lab["manifest"],
                         ledger_path=lab["ledger"])
    assert r["enlisted"] is False and r["verdict"] == "abandoned"
    data = json.loads(lab["manifest"].read_text(encoding="utf-8"))
    assert [c["id"] for c in data["named_channels"]] == ["chan1", "chan2"]
    assert ledger_steps(lab["ledger"])[-1]["step"] == "skip"  # 放弃也留判决


def test_build_channel_auth_wall_not_enlisted(lab, monkeypatch):
    monkeypatch.setattr(cb, "probe", lambda ch: {
        "channel": ch, "reachable": True, "http_status": 401,
        "sample_ok": False, "latency_ms": 1, "error": "HTTPError 401",
        "query": cb.PROBE_QUERY})
    r = cb.build_channel("openalex", manifest_path=lab["manifest"],
                         ledger_path=lab["ledger"])
    assert r["enlisted"] is False
    assert "不入列" in r["reason"]


def test_build_channel_rate_limit_enlists_with_evidence(lab, monkeypatch):
    """429 匿名限流 + 配方允许 → 入列, note 留探实证 (cnki 账号态待验先例)。"""
    monkeypatch.setattr(cb, "probe", lambda ch: {
        "channel": ch, "reachable": True, "http_status": 429,
        "sample_ok": False, "latency_ms": 1, "error": "HTTPError 429",
        "query": cb.PROBE_QUERY})
    r = cb.build_channel("semantic_scholar", manifest_path=lab["manifest"],
                         ledger_path=lab["ledger"])
    assert r["enlisted"] is True and r["verdict"] == "needs_creds"
    entry = json.loads(lab["manifest"].read_text(encoding="utf-8"))[
        "named_channels"][-1]
    assert "probe http=429" in entry["note"]


def test_build_channel_unknown_recipe_skipped_logged(lab):
    r = cb.build_channel("wenshu", manifest_path=lab["manifest"],
                         ledger_path=lab["ledger"])
    assert r["skipped"] is True and "no_recipe" in r["reason"]
    assert ledger_steps(lab["ledger"])[0]["step"] == "skip"


def test_build_channel_dry_run(lab, monkeypatch):
    monkeypatch.setattr(cb, "probe", lambda ch: probe_ok(ch))
    before = lab["manifest"].read_text(encoding="utf-8")
    r = cb.build_channel("openalex", manifest_path=lab["manifest"],
                         ledger_path=lab["ledger"], dry_run=True)
    assert r["enlisted"] is False and r["reason"] == "dry_run"
    assert lab["manifest"].read_text(encoding="utf-8") == before


# ---- 默认路径 -----------------------------------------------------------

def test_default_paths():
    assert cb.DEFAULT_MANIFEST_PATH == cb.REPO_ROOT / "ResearchFactory-Eng" / \
        "channel_manifest.json"
    assert cb.DEFAULT_LEDGER_PATH.name == "channel_build_ledger.jsonl"
    assert "百倍V3" in str(cb.DEFAULT_LEDGER_PATH) and "work" in \
        str(cb.DEFAULT_LEDGER_PATH)
