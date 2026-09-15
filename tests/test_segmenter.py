"""M7b 分段器：银甲虫 task-blocks 规则移植 + TaskTracer 任务-资源绑定。"""
from datetime import datetime, timedelta

from paistation.intent.segmenter import (
    blocks_from_events,
    build_blocks,
    samples_from_events,
)
from paistation.sense.voice_events import validate_event

_T0 = datetime(2026, 9, 15, 10, 0, 0)


def _ev(ev_type, ts, text="", meta=None, source="sense", evidence=None):
    ev = {"ts": ts.isoformat(timespec="milliseconds"), "type": ev_type,
          "source": source, "text": text, "speaker": "",
          "evidence": evidence or {}, "meta": meta or {}}
    assert validate_event(ev), f"事件不合规: {ev}"
    return ev


def _win(ts, process, title, minute=0):
    return _ev("window.focus", ts, title, meta={"process": process})


def test_samples_from_events_domain_attach():
    """window.focus 采样 + 同刻 browser.url 补域名。"""
    evs = [
        _win(_T0, "chrome.exe", "某页 - Google Chrome"),
        _ev("browser.url", _T0, "github.com"),
        _win(_T0 + timedelta(minutes=1), "Code.exe", "main.py"),
    ]
    rows = samples_from_events(evs)
    assert rows[0]["domain"] == "github.com"
    assert rows[1]["process"] == "Code.exe"
    assert rows[1]["domain"] == ""


def test_afk_boundary_splits():
    """AFK 边界双向切：编码→离席→编码 = 3 块。"""
    evs = [_win(_T0 + timedelta(minutes=m), "Code.exe", "main.py")
           for m in range(4)]
    evs.append(_ev("presence.afk", _T0 + timedelta(minutes=4, seconds=5),
                   meta={"phase": "start"}))
    evs += [_win(_T0 + timedelta(minutes=20), "Code.exe", "main.py")]
    blocks = build_blocks(samples_from_events(evs))
    assert len(blocks) == 3
    assert blocks[1]["category"] == "idle"
    assert blocks[2]["category"] == "project"


def test_hard_switch_splits():
    """硬类别切换：project → chat 立即断块（不足票数也断）。"""
    evs = [_win(_T0 + timedelta(minutes=m), "Code.exe", "main.py")
           for m in range(3)]
    evs.append(_win(_T0 + timedelta(minutes=3, seconds=10), "WeChat.exe",
                    "微信"))
    blocks = build_blocks(samples_from_events(evs))
    assert len(blocks) == 2
    assert [b["category"] for b in blocks] == ["project", "chat"]


def test_gap_over_5min_splits():
    evs = [
        _win(_T0, "Code.exe", "main.py"),
        _win(_T0 + timedelta(minutes=7), "Code.exe", "main.py"),
    ]
    blocks = build_blocks(samples_from_events(evs))
    assert len(blocks) == 2


def test_category_switch_needs_6_votes():
    """非硬类别切换需 ≥6 样本投票：3 个样本后换类别 → 不切（容忍噪声）。"""
    evs = [_win(_T0 + timedelta(minutes=m), "Code.exe", "main.py")
           for m in range(3)]
    evs.append(_win(_T0 + timedelta(minutes=3, seconds=10), "chrome.exe",
                    "知乎"))
    blocks = build_blocks(samples_from_events(evs))
    assert len(blocks) == 1                    # 3 样本 < 6 票 → 并块
    assert blocks[0]["category_counts"]["project"] == 3
    assert blocks[0]["category_counts"]["research"] == 1


def test_category_switch_after_6_votes():
    evs = [_win(_T0 + timedelta(minutes=m), "Code.exe", "main.py")
           for m in range(6)]
    evs.append(_win(_T0 + timedelta(minutes=6, seconds=10), "chrome.exe",
                    "知乎"))
    blocks = build_blocks(samples_from_events(evs))
    assert len(blocks) == 2


def test_block_aggregation_fields():
    """块聚合：主导类别/覆盖率/置信度/时长/标题窗。"""
    evs = [
        _win(_T0, "Code.exe", "main.py"),
        _ev("browser.url", _T0, "github.com"),
        _win(_T0 + timedelta(minutes=4), "Code.exe", "tests.py"),
        _win(_T0 + timedelta(minutes=8), "chrome.exe", "知乎"),
    ]
    blocks = build_blocks(samples_from_events(evs))
    b = blocks[0]
    assert b["category"] == "project"          # 2/3 主导（browser.url 只补
    assert b["coverage"] == 0.67               # 域名不产采样）
    assert b["samples"] == 3
    assert b["duration_min"] == 8.0
    assert b["domains"] == ["github.com"]
    assert "main.py" in b["titles"]


def test_resources_attached_by_time_window():
    """TaskTracer 绑定：fs.change/clipboard.change 落窗 → related_files。"""
    evs = [_win(_T0 + timedelta(minutes=m), "Code.exe", "main.py")
           for m in range(3)]
    evs.append(_ev("fs.change", _T0 + timedelta(minutes=1),
                   meta={"paths": ["main.py", "tests.py"]}))
    evs.append(_ev("clipboard.change", _T0 + timedelta(minutes=2),
                   meta={"kind": "text", "length": 10}))
    evs.append(_ev("fs.change", _T0 + timedelta(hours=3),
                   meta={"paths": ["无关文件.py"]}))          # 窗外不挂
    blocks = blocks_from_events(evs)
    assert blocks[0]["related_files"] == ["main.py", "tests.py"]
    assert blocks[0]["related_clipboard"] == ["text"]


def test_full_pipeline_empty_input():
    assert blocks_from_events([]) == []
    assert blocks_from_events([_ev("net.state", _T0, "Home",
                                   meta={"online": True})]) == []
