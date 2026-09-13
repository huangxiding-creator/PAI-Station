"""M1.7 事件流：schema 校验+日滚动+隐私红线（音频零落盘）。"""
import json
import time
from datetime import datetime, timedelta

import pytest

from paistation.sense.voice_events import (
    ALLOWED_TYPES,
    EventStream,
    build_voice_event,
    validate_event,
)


def test_build_voice_event_shape():
    ev = build_voice_event(text="帮我调研X", source="mic", speaker="me",
                           segment_ms=[1200, 5600], audio_hash="ab12")
    assert ev["type"] == "voice.transcript"
    assert ev["text"] == "帮我调研X"
    assert ev["evidence"]["segment_ms"] == [1200, 5600]
    assert ev["evidence"]["audio_hash"] == "ab12"
    assert ev["meta"]["events"] == []
    # ts 是 ISO 且可解析
    datetime.fromisoformat(ev["ts"])


def test_validate_event_accepts_known_types():
    for t in ("voice.transcript", "voice.utterance", "ambient.event",
              "fs.change", "cron.tick"):
        assert t in ALLOWED_TYPES
    ev = build_voice_event(text="x")
    ev["type"] = "fs.change"
    assert validate_event(ev) is True


def test_validate_event_rejects_unknown_type():
    ev = build_voice_event(text="x")
    ev["type"] = "evil.dump"
    assert validate_event(ev) is False


def test_validate_event_rejects_missing_ts_or_text_for_voice():
    ev = build_voice_event(text="x")
    del ev["ts"]
    assert validate_event(ev) is False
    ev2 = build_voice_event(text="")
    assert validate_event(ev2) is False  # 空转写不入流


def test_event_stream_append_and_read_back(tmp_path):
    stream = EventStream(data_dir=tmp_path)
    stream.append(build_voice_event(text="第一句"))
    stream.append(build_voice_event(text="第二句"))
    events = stream.read_today()
    assert [e["text"] for e in events] == ["第一句", "第二句"]
    assert all(e["type"] == "voice.transcript" for e in events)


def test_event_stream_rolls_by_date(tmp_path):
    stream = EventStream(data_dir=tmp_path, clock=lambda: datetime(2026, 9, 13, 10, 0))
    stream.append(build_voice_event(text="今天的"))
    yesterday = datetime(2026, 9, 12, 23, 59)
    stream2 = EventStream(data_dir=tmp_path, clock=lambda: yesterday)
    stream2.append(build_voice_event(text="昨天的"))
    files = sorted(p.name for p in tmp_path.rglob("*.jsonl"))
    assert files == ["2026-09-12.jsonl", "2026-09-13.jsonl"]
    today_events = stream.read_today()
    assert [e["text"] for e in today_events] == ["今天的"]


def test_event_stream_read_range(tmp_path):
    stream = EventStream(data_dir=tmp_path)
    for i in range(5):
        stream.append(build_voice_event(text=f"e{i}"))
    events = stream.read_range(3)
    assert len(events) == 3
    assert events[0]["text"] == "e2"  # 取最近 N 条


def test_privacy_no_raw_audio_on_disk(tmp_path):
    """隐私红线（NFR2）：事件流只落转写+标签，磁盘上不出现 PCM 字节。"""
    import numpy as np
    pcm = (np.random.default_rng(7).normal(0, 0.3, 16000)).astype(np.float32)
    stream = EventStream(data_dir=tmp_path)
    ev = build_voice_event(text="测试", segment_ms=[0, 1000],
                           audio_hash=hashlib_of(pcm))
    stream.append(ev)
    raw = pcm.tobytes()
    for p in tmp_path.rglob("*"):
        if p.is_file():
            assert raw not in p.read_bytes(), f"原始音频落盘: {p}"


def hashlib_of(x):
    import hashlib
    return hashlib.sha1(x.tobytes()).hexdigest()[:12]
