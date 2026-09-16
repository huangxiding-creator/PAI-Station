# -*- coding: utf-8 -*-
"""六维框架测试：维度映射完整性 / 等级合法性 / 探针与记分卡。"""

from __future__ import annotations

import json
import sqlite3

from paistation.cx.dimensions import (
    CURRENT_LEVELS,
    DIMENSION_FEEDS,
    Dimension,
    LEVEL_NAMES,
    coverage_report,
    probe_assets,
    probe_timeline,
)
from paistation.cx.timeline import TimelineStore
from tests.test_cx import _ev


class TestFramework:
    def test_six_dimensions_complete(self):
        assert len(Dimension) == 6

    def test_every_dimension_has_feeds(self):
        for dim in Dimension:
            assert DIMENSION_FEEDS[dim], f"{dim} 无登记源"

    def test_levels_valid_and_evidenced(self):
        from paistation.cx.dimensions import LEVEL_EVIDENCE

        for dim in Dimension:
            assert CURRENT_LEVELS[dim] in LEVEL_NAMES
            assert LEVEL_EVIDENCE[dim].strip()

    def test_report_covers_all_dimensions(self):
        rep = coverage_report({}, {})
        for dim in Dimension:
            assert dim.value in rep
            assert rep[dim.value]["level"] >= 0


class TestProbes:
    def test_timeline_probe_missing_db(self, tmp_path):
        assert probe_timeline(tmp_path / "none.db") == {}

    def test_timeline_probe_real_counts(self, tmp_path):
        store = TimelineStore(tmp_path / "cx.db")
        from datetime import datetime, timezone

        store.ingest(
            [
                _ev(source="git", source_id="a",
                    start=datetime(2026, 1, 2, tzinfo=timezone.utc)),
                _ev(source="git", source_id="b",
                    start=datetime(2026, 2, 3, tzinfo=timezone.utc)),
                _ev(source="power_system", source_id="p",
                    start=datetime(2026, 1, 2, 6, tzinfo=timezone.utc)),
            ]
        )
        store.close()
        tp = probe_timeline(tmp_path / "cx.db")
        assert tp["total_events"] == 3
        assert tp["git_months"] == 2
        assert tp["power_days"] == 1

    def test_asset_probe_handles_missing(self, tmp_path):
        ap = probe_assets(tmp_path, None)
        assert ap["installed_apps"] is None
        assert ap["weread_note_lines"] is None

    def test_asset_probe_reads_json(self, tmp_path):
        (tmp_path / "uninstall.json").write_text(
            json.dumps([{"DisplayName": "x"}, {"DisplayName": "y"}]),
            encoding="utf-8",
        )
        ap = probe_assets(tmp_path, None)
        assert ap["installed_apps"] == 2
