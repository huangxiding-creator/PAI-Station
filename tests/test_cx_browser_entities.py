# -*- coding: utf-8 -*-
"""CX 三路扩展测试：浏览器史 / 会议 / 实体登记表。"""

from __future__ import annotations

import json
import sqlite3
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

import pytest

from paistation.cx.entities import EntityStore, collect_git_authors
from paistation.cx.ingest_browser import parse_360_history, parse_chromium_history
from paistation.cx.ingest_sources import parse_meetings_json


def _make_chromium_db(path: Path) -> None:
    conn = sqlite3.connect(str(path))
    conn.executescript(
        "CREATE TABLE urls (id INTEGER PRIMARY KEY, url TEXT, title TEXT);"
        "CREATE TABLE visits (id INTEGER PRIMARY KEY, url INTEGER, visit_time INTEGER);"
    )
    conn.execute("INSERT INTO urls VALUES (1, 'https://a.com', 'A 站')")
    conn.execute("INSERT INTO visits VALUES (10, 1, 13433824398336486)")
    conn.commit()
    conn.close()


class TestBrowserParsers:
    def test_chromium_webkit_epoch(self, tmp_path):
        db = tmp_path / "h.db"
        _make_chromium_db(db)
        evs = parse_chromium_history(db, "browser_test")
        assert len(evs) == 1
        assert evs[0].type == "web.visit"
        assert evs[0].start.year > 2020  # WebKit 微秒纪元换算成立

    def test_360_json(self):
        text = json.dumps(
            [{"date": "2026年9月15日", "time": "11:27", "title": "360导航",
              "domain": "hao.360.com"},
             {"date": "坏行", "time": "xx", "title": "t", "domain": "d"}],
            ensure_ascii=False,
        )
        evs = parse_360_history(text)
        assert len(evs) == 1
        # naive 视为本地时间 → 封套规范化为 UTC（+08:00 → 03:27Z）
        assert evs[0].start.hour == 3 and evs[0].start.day == 15

    def test_meetings_json(self):
        text = json.dumps(
            {"meetings": [
                {"meeting_id": "123", "start_time": "2026-09-15T15:00:00+08:00",
                 "end_time": "2026-09-15T16:00:00+08:00", "subject": "周会",
                 "meeting_code": "999"},
                {"meeting_id": "", "start_time": None},
            ]}
        )
        evs = parse_meetings_json(text)
        assert len(evs) == 1
        assert evs[0].type == "meeting.attend" and evs[0].end is not None


class TestEntityStore:
    def test_register_new_and_merge_aliases(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        eid, created = st.register("person", "张三", ["z@x.com"], source="git")
        assert created
        _, created2 = st.register("person", "张三", ["z2@x.com"], source="lark")
        assert not created2  # 同名同类 → 合并
        assert st.count() == 1
        row = st._conn.execute(
            "SELECT aliases, sources FROM entities WHERE entity_id=?", (eid,)
        ).fetchone()
        assert set(json.loads(row[0])) == {"z@x.com", "z2@x.com"}
        assert set(json.loads(row[1])) == {"git", "lark"}

    def test_invalid_kind_rejected(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        with pytest.raises(ValueError):
            st.register("alien", "x")

    def test_merge_absorbs(self, tmp_path):
        st = EntityStore(tmp_path / "e.db")
        st.register("person", "李四", ["a@x.com"], source="git")
        st.register("person", "李四哥", ["b@x.com"], source="wechat")
        assert st.merge("person/李四", "person/李四哥")
        row = st._conn.execute(
            "SELECT aliases FROM entities WHERE entity_id='person/李四'"
        ).fetchone()
        assert "李四哥" in json.loads(row[0])

    def test_collect_git_authors(self, tmp_path):
        repo = tmp_path / "r"
        repo.mkdir()
        env = dict(os.environ)
        for args in (
            ["git", "init", "-q"],
            ["git", "config", "user.name", "测试者"],
            ["git", "config", "user.email", "t@t.com"],
        ):
            subprocess.run(args, cwd=str(repo), check=True, env=env,
                           creationflags=0x08000000, capture_output=True)
        (repo / "f.txt").write_text("x", encoding="utf-8")
        subprocess.run(["git", "add", "."], cwd=str(repo), check=True,
                       capture_output=True, creationflags=0x08000000)
        subprocess.run(
            ["git", "commit", "-q", "-m", "init",
             "--date=2026-09-16T10:00:00+08:00"],
            cwd=str(repo), check=True, capture_output=True,
            creationflags=0x08000000, env=env,
        )
        authors = collect_git_authors([str(repo)])
        assert authors == [{"name": "测试者", "email": "t@t.com", "repos": [str(repo)]}]


import os  # noqa: E402  (测试体内使用)
