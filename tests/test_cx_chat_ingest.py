# -*- coding: utf-8 -*-
"""群聊元数据入轴契约测试（零内容纪律是硬约束）。"""

from __future__ import annotations

import json
from pathlib import Path

from paistation.cx.ingest_chat import (
    SOURCE,
    normalize_type,
    parse_history_doc,
    parse_messages,
)
from paistation.cx.timeline import TimelineStore

LINES = [
    "[2025-09-01 07:56] me: [链接/文件]",
    "[2025-09-01 08:37] 魏宏健: [链接/文件]",
    "[2025-09-01 09:21] 许亚伶: 今晚8点直播，扫码预约",
    "[2025-09-01 09:21] 许亚伶: [图片] (local_id=761)",
    "[2025-09-02 07:39:05] me: [链接] 三部门新规落地",
    "不是消息格式的行",
    "",
]


def doc() -> dict:
    return {
        "chat": "精英学友3群(数字化转型+AI)",
        "username": "18354918738@chatroom",
        "messages": LINES,
    }


def test_parse_messages_shapes():
    rows = parse_messages(LINES)
    assert rows == [
        ("2025-09-01", "07:56:00", "me", "link"),
        ("2025-09-01", "08:37:00", "魏宏健", "link"),
        ("2025-09-01", "09:21:00", "许亚伶", "text"),
        ("2025-09-01", "09:21:00", "许亚伶", "image"),
        ("2025-09-02", "07:39:05", "me", "link"),
    ]


def test_normalize_type():
    assert normalize_type("[图片] (local_id=1)") == "image"
    assert normalize_type("[链接/文件]") == "link"
    assert normalize_type("[未知标签] xx") == "未知标签"
    assert normalize_type("纯文本消息") == "text"


def test_history_doc_aggregates_by_day():
    events = parse_history_doc(doc(), "18354918738@chatroom", "精英学友3群")
    assert [e.source_id for e in events] == [
        "18354918738@chatroom#2025-09-01",
        "18354918738@chatroom#2025-09-02",
    ]
    d1 = events[0].payload
    assert d1["senders"] == {"me": 1, "魏宏健": 1, "许亚伶": 2}
    assert d1["total"] == 4
    assert d1["group"] == "精英学友3群"
    # start=当日最后一条消息时刻（封套统一 UTC，校验换回本地）
    local1, local2 = events[0].start.astimezone(), events[1].start.astimezone()
    assert local1.hour == 9 and local1.minute == 21
    assert local2.second == 5


def test_zero_content_discipline():
    """消息正文绝不入轴：payload 里搜不到任何正文片段。"""
    for e in parse_history_doc(doc(), "x@chatroom", "g"):
        blob = json.dumps(e.payload, ensure_ascii=False)
        for leak in ("直播", "扫码", "新规", "local_id", "三部门"):
            assert leak not in blob


def test_ingest_idempotent(tmp_path: Path):
    events = parse_history_doc(doc(), "18354918738@chatroom", "g")
    store = TimelineStore(tmp_path / "t.db")
    store.ingest(events)
    ins2, skip2 = store.ingest(events)
    assert (ins2, skip2) == (0, len(events))
    assert store.count(SOURCE) == len(events)
    store.close()
