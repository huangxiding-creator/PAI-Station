"""M7a 进程快照：tasklist CSV 解析 + 按名合并内存 top-N。"""
from datetime import datetime

from paistation.sense.process_snapshot import (
    parse_tasklist,
    snapshot_event,
    top_by_memory,
)
from paistation.sense.voice_events import validate_event

_NOW = datetime(2026, 9, 15, 12, 0, 0)

_SAMPLE = (
    '"chrome.exe","4012","Console","1","312,456 K"\n'
    '"chrome.exe","5120","Console","1","208,104 K"\n'
    '"pycharm64.exe","6100","Console","1","1,024,900 K"\n'
    '"explorer.exe","1200","Console","1","45,678 K"\n'
)


def test_parse_tasklist_rows():
    rows = parse_tasklist(_SAMPLE)
    assert len(rows) == 4
    assert rows[0] == {"name": "chrome.exe", "pid": 4012, "mem_kb": 312456}
    assert rows[2]["name"] == "pycharm64.exe"
    assert rows[2]["mem_kb"] == 1024900


def test_parse_skips_garbage():
    rows = parse_tasklist('坏行\n"","","","",""\n"ok.exe","9","C","1","1 K"\n')
    assert rows == [{"name": "ok.exe", "pid": 9, "mem_kb": 1}]


def test_parse_empty_output():
    assert parse_tasklist("") == []
    assert parse_tasklist("系统找不到指定的文件。") == []


def test_top_by_memory_merges_same_name():
    top = top_by_memory(parse_tasklist(_SAMPLE), n=2)
    assert top[0] == {"name": "pycharm64.exe", "mem_mb": 1000.9}
    assert top[1] == {"name": "chrome.exe", "mem_mb": round(520560 / 1024, 1)}


def test_snapshot_event_validates():
    ev = snapshot_event([{"name": "chrome.exe", "mem_mb": 508.4}],
                        now_fn=lambda: _NOW)
    assert ev["type"] == "process.snapshot"
    assert ev["meta"]["top"][0]["name"] == "chrome.exe"
    assert validate_event(ev)
