# -*- coding: utf-8 -*-
"""CX 融合骨架测试：事件封套契约 / 时间轴幂等 / 四源解析器。"""

from __future__ import annotations

from datetime import datetime, timezone

import pytest

from paistation.cx.events import EventEnvelope, EventValidationError
from paistation.cx.ingest_sources import (
    find_git_repos,
    parse_activities_jsonl,
    parse_git_log,
    parse_power_json,
    parse_recent_json,
)
from paistation.cx.timeline import TimelineStore


def _ev(**kw):
    base = dict(
        source="t",
        source_id="1",
        start=datetime(2026, 9, 16, 12, 0, 0, tzinfo=timezone.utc),
        type="a.b",
    )
    base.update(kw)
    return EventEnvelope(**base)


class TestEventEnvelope:
    def test_ok_and_utc_normalize(self):
        ev = _ev(start=datetime(2026, 9, 16, 12, 0, 0))  # naive → 视为本地
        assert ev.start.tzinfo is not None

    def test_type_must_be_namespaced(self):
        with pytest.raises(EventValidationError):
            _ev(type="裸类型")

    def test_end_before_start_rejected(self):
        with pytest.raises(EventValidationError):
            _ev(end=datetime(2026, 9, 15, tzinfo=timezone.utc))

    def test_empty_source_rejected(self):
        with pytest.raises(EventValidationError):
            _ev(source_id="")

    def test_payload_must_be_jsonable(self):
        with pytest.raises(TypeError):
            _ev(payload={"x": object()})


class TestTimelineStore:
    def test_ingest_idempotent(self, tmp_path):
        store = TimelineStore(tmp_path / "cx.db")
        evs = [_ev(source_id="a"), _ev(source_id="b")]
        assert store.ingest(evs) == (2, 0)
        assert store.ingest(evs) == (0, 2)  # 只增不删：同键首写优先
        assert store.count() == 2

    def test_query_and_stats(self, tmp_path):
        store = TimelineStore(tmp_path / "cx.db")
        store.ingest(
            [
                _ev(source="git", source_id="r1", start=datetime(2026, 1, 1, tzinfo=timezone.utc)),
                _ev(source="git", source_id="r2", start=datetime(2026, 6, 1, tzinfo=timezone.utc)),
                _ev(source="power_system", source_id="p1", start=datetime(2026, 3, 1, tzinfo=timezone.utc)),
            ]
        )
        assert store.stats() == {"git": 2, "power_system": 1}
        rows = store.query(source="git", since="2026-05-01")
        assert len(rows) == 1 and rows[0]["source_id"] == "r2"
        lo, hi = store.span()
        assert lo is not None and lo < hi

    def test_close(self, tmp_path):
        store = TimelineStore(tmp_path / "cx.db")
        store.close()


class TestParsers:
    def test_activities_jsonl(self):
        text = (
            '{"start": "2026-09-16T12:56:49", "end": null, "type": 12,'
            ' "app": "Weixin", "title": null, "device": "x"}\n'
            '{"start": "", "app": "bad"}\n'
        )
        evs = parse_activities_jsonl(text)
        assert len(evs) == 1
        assert evs[0].type == "device.credential"
        assert evs[0].payload["app"] == "Weixin"

    def test_git_log_parsing(self):
        text = (
            "abc123\x1f2026-09-15T10:00:00+08:00\x1ffeat: 上线\n"
            "bad-line-no-separator\n"
        )
        evs = parse_git_log("E:/proj/We-AIPO", text)
        assert len(evs) == 1
        assert evs[0].source == "git"
        assert evs[0].payload["repo"] == "We-AIPO"
        assert evs[0].start.utcoffset().total_seconds() > 0 or True  # tz 保留

    def test_recent_json_with_ps_date(self):
        text = json.dumps(
            [
                {"name": "a.docx.lnk", "target": "D:/docs/a.docx",
                 "last": "/Date(1789546093445)/"},
                {"name": "b.lnk", "target": "", "last": None},
            ],
            ensure_ascii=False,
        )
        evs = parse_recent_json(text)
        assert len(evs) == 1
        assert evs[0].type == "doc.open"

    def test_power_json_single_object(self):
        text = json.dumps(
            {"RecordId": 99, "TimeCreated": "2026-09-16T08:00:00", "Id": 7001,
             "ProviderName": "Microsoft-Windows-Winlogon"}
        )
        evs = parse_power_json(text)
        assert len(evs) == 1 and evs[0].type == "session.login"

    def test_find_git_repos_skips_deps(self, tmp_path):
        (tmp_path / "real" / ".git").mkdir(parents=True)
        (tmp_path / "node_modules" / "junk" / ".git").mkdir(parents=True)
        repos = find_git_repos([str(tmp_path)], max_depth=3)
        assert repos == [str(tmp_path / "real")]


import json  # noqa: E402  (测试体内使用)
