# -*- coding: utf-8 -*-
"""T-048 验证：发送审计总线（REQ-019.AC1）——落盘字段/90天轮转/周报汇总。"""
import json
import os
import time
from pathlib import Path

from zbops.radar import audit_log


def test_record_fields(tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    audit_log.record("B", "水利群@chatroom", "今日规范速递：GB/T 8110-2020 要点" * 3,
                     chat_count=1, global_count=3)
    f = tmp_path / f"audit-{time.strftime('%Y%m%d')}.jsonl"
    assert f.exists()
    e = json.loads(f.read_text(encoding="utf-8").splitlines()[0])
    assert set(e) >= {"ts", "leg", "group", "summary", "chat_count", "global_count"}
    assert e["leg"] == "B" and e["group"] == "水利群@chatroom"
    assert len(e["summary"]) == 50  # 摘要=前50字
    assert e["chat_count"] == 1 and e["global_count"] == 3


def test_all_legs_recorded(tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    for leg in ("A", "B", "cowagent", "8440"):
        audit_log.record(leg, "g", "t")
    lines = (tmp_path / f"audit-{time.strftime('%Y%m%d')}.jsonl"
             ).read_text(encoding="utf-8").splitlines()
    assert {json.loads(x)["leg"] for x in lines} == {"A", "B", "cowagent", "8440"}


def test_rotate_90d(tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    old = tmp_path / "audit-20200101.jsonl"
    old.write_text("{}\n", encoding="utf-8")
    old_utime = time.time() - 100 * 86400
    os.utime(old, (old_utime, old_utime))
    new = tmp_path / f"audit-{time.strftime('%Y%m%d')}.jsonl"
    new.write_text("{}\n", encoding="utf-8")
    removed = audit_log.rotate(max_days=90)
    assert removed == 1 and not old.exists() and new.exists()


def test_weekly_summary(tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    for _ in range(3):
        audit_log.record("B", "g", "t")
    audit_log.record("A", "g2", "t2")
    s = audit_log.weekly_summary()
    assert s["total"] == 4 and s["by_leg"] == {"B": 3, "A": 1}
    assert sum(s["by_day"].values()) == 4


def test_weekly_summary_bad_line_tolerant(tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    audit_log.record("B", "g", "t")
    f = tmp_path / f"audit-{time.strftime('%Y%m%d')}.jsonl"
    f.write_text(f.read_text(encoding='utf-8') + "{corrupted\n", encoding="utf-8")
    s = audit_log.weekly_summary()  # 坏行不崩，好行照算
    assert s["total"] == 1
