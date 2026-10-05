# -*- coding: utf-8 -*-
"""media_group_collector 单测——不跑真 opencli（monkeypatch 子进程层），覆盖闭环/入池/过账/幂等。"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import media_group_collector as mgc  # noqa: E402

SEARCH_OUT = (
    "| rank | title | date | url |\n| --- | --- | --- | --- |\n"
    "| 1 | 智能光伏时代 |  | https://36kr.com/p/2628283988181252 |\n"
    "| 2 | 第二篇 |  | https://36kr.com/p/999 |\n")
ARTICLE_OUT = (
    "| field | value |\n| --- | --- |\n| title | 智能光伏时代 |\n"
    "| author | 王 |\n| body | " + "正文" * 300 + " |\n")


@pytest.fixture
def battle_env(tmp_path, monkeypatch):
    """临时 battle 目录 + 账本 + 打桩 opencli 与 pool_ingest。"""
    monkeypatch.setattr(mgc, "BATTLES_ROOT", tmp_path)
    monkeypatch.setattr(mgc, "run_36kr", lambda q, l=3, t=120: (0, SEARCH_OUT))
    monkeypatch.setattr(mgc, "_run_article",
                        lambda aid, t=180: (0, ARTICLE_OUT if aid == "2628283988181252" else ""))
    ingested = []
    monkeypatch.setattr(mgc, "pool_ingest",
                        lambda ammo, art, text, url: ingested.append(
                            {"url": url, "chars": len(text)}) or {"ingested": 1, "chars": len(text)})
    led = tmp_path / "B" / "_pipeline" / "channel_ledger.json"
    led.parent.mkdir(parents=True)
    led.write_text(json.dumps({"channels": {"media_group": {
        "status": "done", "evidence": "首过账", "artifacts": []}}}, ensure_ascii=False),
        encoding="utf-8")
    return {"tmp": tmp_path, "ingested": ingested, "ledger": led}


def test_parse_hits():
    hits = mgc._parse_hits(SEARCH_OUT)
    assert len(hits) == 2
    assert hits[0]["id"] == "2628283988181252" and hits[0]["title"] == "智能光伏时代"


def test_parse_article():
    t, b = mgc._parse_article(ARTICLE_OUT)
    assert t == "智能光伏时代" and len(b) >= 500


def test_collect_full_chain_ingests_bodies(battle_env):
    s = mgc.collect("B", query="测试公司", ammo="EPCX")
    assert s["rc"] == 0 and s["hits"] == 2
    assert s["ok"] == 1 and s["fetch_fail"] == 1  # 第二篇空正文不凑数
    assert battle_env["ingested"][0]["url"].endswith("2628283988181252")
    assert battle_env["ingested"][0]["chars"] >= 500
    doc = Path(s["artifact"]).read_text(encoding="utf-8")
    assert "智能光伏时代" in doc and "正文" in doc


def test_collect_ledger_artifact_appended(battle_env):
    s = mgc.collect("B", query="q", ammo="EPCX")
    d = json.loads(battle_env["ledger"].read_text(encoding="utf-8"))
    assert str(Path(s["artifact"])) in d["channels"]["media_group"]["artifacts"]


def test_collect_search_fail_no_ingest_no_ledger(battle_env, monkeypatch):
    monkeypatch.setattr(mgc, "run_36kr", lambda q, l=3, t=120: (1, ""))
    orig = battle_env["ledger"].read_text(encoding="utf-8")
    s = mgc.collect("B", query="q", ammo="EPCX")
    assert s["rc"] == 1 and s["ok"] == 0
    assert battle_env["ledger"].read_text(encoding="utf-8") == orig


def test_ledger_idempotent_no_dup(tmp_path, monkeypatch):
    monkeypatch.setattr(mgc, "BATTLES_ROOT", tmp_path)
    led = tmp_path / "B" / "_pipeline" / "channel_ledger.json"
    led.parent.mkdir(parents=True)
    led.write_text(json.dumps({"channels": {"media_group": {
        "status": "done", "artifacts": []}}}, ensure_ascii=False), encoding="utf-8")
    art = tmp_path / "B" / "04 网络调研搜集的资料" / "媒体组" / "36kr_x.md"
    mgc.ledger_pass("B", art, "q")
    mgc.ledger_pass("B", art, "q")
    mg = json.loads(led.read_text(encoding="utf-8"))["channels"]["media_group"]
    assert mg["artifacts"] == [str(art)]


def test_ledger_missing_no_crash(tmp_path, monkeypatch):
    monkeypatch.setattr(mgc, "BATTLES_ROOT", tmp_path)
    mgc.ledger_pass("Nope", tmp_path / "a.md", "q")
