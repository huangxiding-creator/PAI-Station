# -*- coding: utf-8 -*-
"""media_group_collector 单测——不跑真 opencli（monkeypatch run_36kr），覆盖落盘/过账/幂等。"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import media_group_collector as mgc  # noqa: E402


def test_collect_writes_artifact_and_passes_ledger(tmp_path, monkeypatch):
    monkeypatch.setattr(mgc, "BATTLES_ROOT", tmp_path)
    monkeypatch.setattr(mgc, "run_36kr", lambda q, l=3, t=120: (0, "| 1 | 文章A | | https://36kr.com/p/1 |"))
    led = tmp_path / "B" / "_pipeline" / "channel_ledger.json"
    led.parent.mkdir(parents=True)
    led.write_text(json.dumps({"channels": {"media_group": {
        "status": "done", "evidence": "36kr 首过账+登录墙实测"}}}, ensure_ascii=False), encoding="utf-8")
    s = mgc.collect("B", query="测试公司")
    assert s["rc"] == 0 and s["hits_heuristic"] == 1
    art = Path(s["artifact"])
    assert art.exists() and "文章A" in art.read_text(encoding="utf-8")
    d = json.loads(led.read_text(encoding="utf-8"))
    mg = d["channels"]["media_group"]
    assert str(art) in mg["artifacts"] and mg["status"] == "done"


def test_collect_rc_fail_no_ledger_write(tmp_path, monkeypatch):
    monkeypatch.setattr(mgc, "BATTLES_ROOT", tmp_path)
    monkeypatch.setattr(mgc, "run_36kr", lambda q, l=3, t=120: (1, ""))
    led = tmp_path / "B" / "_pipeline" / "channel_ledger.json"
    led.parent.mkdir(parents=True)
    orig = {"channels": {"media_group": {"status": "done", "artifacts": ["x.md"]}}}
    led.write_text(json.dumps(orig, ensure_ascii=False), encoding="utf-8")
    s = mgc.collect("B", query="q")
    assert s["rc"] == 1
    assert json.loads(led.read_text(encoding="utf-8")) == orig  # 失败不动账本


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
    assert mg["artifacts"] == [str(art)]  # 幂等不重复


def test_ledger_missing_no_crash(tmp_path, monkeypatch):
    monkeypatch.setattr(mgc, "BATTLES_ROOT", tmp_path)
    mgc.ledger_pass("Nope", tmp_path / "a.md", "q")  # 无账本=诚实跳过，不炸
