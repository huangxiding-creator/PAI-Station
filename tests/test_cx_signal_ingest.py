# -*- coding: utf-8 -*-
"""信号流解析并入轴契约测试。"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from paistation.cx.events import EventEnvelope
from paistation.cx.ingest_signal import SOURCE, parse_signal_file
from paistation.cx.timeline import TimelineStore

SAMPLES = {
    "window.focus": '{"ts": "2026-09-18T06:04:06.110", "type": "window.focus", "source": "fgwindow", "text": "360壁纸", "evidence": {"prev_process": "python.exe", "prev_title": "C:\\\\x\\\\python.exe"}, "meta": {"process": "360huabao.exe", "attention": "focus"}}',
    "presence.afk": '{"ts": "2026-09-16T13:35:04.979", "type": "presence.afk", "source": "presence", "text": "", "evidence": {"idle_s": 948.9}, "meta": {"phase": "start"}}',
    "session.lock": '{"ts": "2026-09-16T14:30:00.688", "type": "session.state", "source": "wts", "text": "", "evidence": {"locked": true}, "meta": {"locked": true, "phase": "lock"}}',
    "session.unlock": '{"ts": "2026-09-16T14:30:10.699", "type": "session.state", "source": "wts", "text": "", "evidence": {"locked": false}, "meta": {"locked": false, "phase": "unlock"}}',
    "clipboard.change": '{"ts": "2026-09-16T14:29:55.683", "type": "clipboard.change", "source": "clipboard", "text": "", "evidence": {"sig": "image"}, "meta": {"kind": "image"}}',
    "browser.url": '{"ts": "2026-09-16T15:04:40.462", "type": "browser.url", "source": "history", "text": "mp.weixin.qq.com", "evidence": {"title": "mp.weixin.qq.com - Google Chrome"}, "meta": {"domain": "mp.weixin.qq.com"}}',
    "process.snapshot": '{"ts": "2026-09-18T06:04:03.107", "type": "process.snapshot", "source": "tasklist", "text": "", "evidence": {"count": 10}, "meta": {"top": [{"name": "code.exe"}]}}',
}


@pytest.fixture()
def day_file(tmp_path: Path) -> Path:
    lines = list(SAMPLES.values())
    lines.append("{not-json")  # 毒行
    lines.append('{"type": "window.focus"}')  # 无 ts 跳过
    p = tmp_path / "2026-09-18.jsonl"
    p.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return p


def test_type_mapping_and_skips(day_file: Path):
    events = parse_signal_file(day_file)
    types = [e.type for e in events]
    # process.snapshot 不入轴；毒行/无 ts 行不炸不收
    assert types == [
        "focus.window",
        "presence.afk",
        "session.lock",
        "session.unlock",
        "clipboard.change",
        "browser.url",
    ]
    assert all(e.source == SOURCE for e in events)
    assert [e.source_id for e in events] == [f"2026-09-18#{i}" for i in range(1, 7)]


def test_payload_shapes(day_file: Path):
    events = {e.type: e for e in parse_signal_file(day_file)}
    assert events["focus.window"].payload["process"] == "360huabao.exe"
    assert events["presence.afk"].payload == {"phase": "start", "idle_s": 948.9}
    assert events["clipboard.change"].payload == {"kind": "image"}
    assert "text" not in events["clipboard.change"].payload  # 不落内容


def test_session_lock_fallback_without_phase(tmp_path: Path):
    p = tmp_path / "2026-09-18.jsonl"
    p.write_text(json.dumps({
        "ts": "2026-09-18T10:00:00", "type": "session.state",
        "evidence": {"locked": True}, "meta": {"locked": True},
    }), encoding="utf-8")
    (evt,) = parse_signal_file(p)
    assert evt.type == "session.lock"


def test_ingest_idempotent(day_file: Path, tmp_path_factory):
    db = tmp_path_factory.mktemp("db") / "timeline.db"
    events = parse_signal_file(day_file)
    store = TimelineStore(db)
    store.ingest(events)
    inserted2, skipped2 = store.ingest(events)
    assert (inserted2, skipped2) == (0, len(events))
    assert store.count(SOURCE) == len(events)
    store.close()


def test_envelope_contract_is_utc(day_file: Path):
    for e in parse_signal_file(day_file):
        assert isinstance(e, EventEnvelope)
        assert e.start.tzinfo is not None
        assert e.end is None
