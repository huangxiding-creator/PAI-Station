# -*- coding: utf-8 -*-
"""M9 三云感知连接器测试：腾讯会议/百度网盘/微信情报 + 授权持久化 + 装配。

假件铁律：全部注入假 transport/runner/目录，绝不打真平台（账号安全）。
"""
from __future__ import annotations

import json
import os
import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from paistation.sense.cloud.base import ConnectorRegistry
from paistation.sense.cloud.grants import GrantsStore
from paistation.sense.voice_events import ALLOWED_TYPES, validate_event


# ---------------------------------------------------------------- 腾讯会议

class FakeTencentTransport:
    """按 tools/call 参数返回预置会议列表；记录调用序列。"""

    def __init__(self, live_meetings=None, ended_meetings=None, fail=False):
        self.calls: list[dict] = []
        self._live = live_meetings or []
        self._ended = ended_meetings or []
        self._fail = fail

    def request(self, method, url, *, headers=None, params=None, json_body=None):
        self.calls.append({"method": method, "url": url, "body": json_body,
                           "headers": headers or {}})
        if self._fail:
            return 0, None
        name = (json_body or {}).get("params", {}).get("name", "")
        items = self._live if name == "get_user_meetings" else self._ended
        text = json.dumps({"meetings": items}, ensure_ascii=False)
        return 200, {"result": {"content": [{"type": "text", "text": text}]}}


def _mk_meeting(mid, subject, status="MEETING_STATUS_ING"):
    return {"meeting_id": mid, "subject": subject, "status": status}


def test_tencent_unconfigured_token_inactive():
    from paistation.sense.cloud.tencent import TencentMeetingConnector
    conn = TencentMeetingConnector(token="", transport=FakeTencentTransport())
    events, wm = conn.collect(None)
    assert events == [] and wm is None
    assert conn.login_flow() is False


def test_tencent_collect_emits_meeting_events():
    from paistation.sense.cloud.tencent import TencentMeetingConnector
    tp = FakeTencentTransport(live_meetings=[_mk_meeting("m1", "周会")],
                              ended_meetings=[_mk_meeting("m0", "评审", "MEETING_STATUS_END")])
    conn = TencentMeetingConnector(token="tok", transport=tp)
    assert conn.login_flow() is True
    assert conn.test_session() is True
    events, wm = conn.collect(None)
    texts = " | ".join(e["text"] for e in events)
    assert "周会" in texts and "评审" in texts
    assert all(e["type"] == "cloud.meeting.list" for e in events)
    # 水位线=已见 (id,status) 集合；重复 collect 无新事件
    events2, _ = conn.collect(wm)
    assert events2 == []


def test_tencent_transport_failure_keeps_watermark():
    from paistation.sense.cloud.tencent import TencentMeetingConnector
    conn = TencentMeetingConnector(token="tok",
                                   transport=FakeTencentTransport(fail=True))
    events, wm = conn.collect({"seen": [["m1", "ING"]]})
    assert events == [] and wm == {"seen": [["m1", "ING"]]}


def test_tencent_token_header_present():
    from paistation.sense.cloud.tencent import TencentMeetingConnector
    tp = FakeTencentTransport()
    conn = TencentMeetingConnector(token="tok123", transport=tp)
    conn.collect(None)
    assert all(c["headers"].get("X-Tencent-Meeting-Token") == "tok123"
               for c in tp.calls)


# ---------------------------------------------------------------- 百度网盘

class FakeBdpanRunner:
    """按 argv[0] 返回预置结果：(rc, stdout)。"""

    def __init__(self, ls_json=None, whoami_rc=0, ls_rc=0):
        self._ls = ls_json
        self._whoami_rc = whoami_rc
        self._ls_rc = ls_rc
        self.calls: list[list[str]] = []

    def __call__(self, argv, timeout=20.0):
        self.calls.append(argv)
        if argv[0] == "whoami":
            return self._whoami_rc, ""
        if argv[0] == "ls":
            if self._ls_rc != 0:
                return self._ls_rc, ""
            return 0, json.dumps(self._ls, ensure_ascii=False)
        return 1, ""


def test_bdpan_cli_absent_inactive():
    from paistation.sense.cloud.bdpan import BaiduDriveConnector
    conn = BaiduDriveConnector(cli_path=None, runner=FakeBdpanRunner())
    events, wm = conn.collect(None)
    assert events == [] and wm is None
    assert conn.test_session() is False


def test_bdpan_diff_emits_new_and_updated():
    from paistation.sense.cloud.bdpan import BaiduDriveConnector
    runner = FakeBdpanRunner(ls_json={"list": [
        {"path": "/apps/bdpan/a.md", "size": 10},
        {"path": "/apps/bdpan/b.md", "size": 20},
    ]})
    conn = BaiduDriveConnector(cli_path="bdpan", runner=runner)
    events, wm = conn.collect(None)
    texts = " | ".join(e["text"] for e in events)
    assert "a.md" in texts and "b.md" in texts
    assert all(e["type"] == "cloud.drive.change" for e in events)
    # 第二轮：a 变大、c 新增、b 不变
    runner._ls = {"list": [
        {"path": "/apps/bdpan/a.md", "size": 99},
        {"path": "/apps/bdpan/b.md", "size": 20},
        {"path": "/apps/bdpan/c.md", "size": 1},
    ]}
    events2, _ = conn.collect(wm)
    texts2 = " | ".join(e["text"] for e in events2)
    assert "c.md" in texts2 and "a.md" in texts2 and "b.md" not in texts2


def test_bdpan_ls_failure_keeps_watermark():
    from paistation.sense.cloud.bdpan import BaiduDriveConnector
    conn = BaiduDriveConnector(cli_path="bdpan",
                               runner=FakeBdpanRunner(ls_rc=3))
    events, wm = conn.collect({"files": {"/apps/bdpan/x": 1}})
    assert events == [] and wm == {"files": {"/apps/bdpan/x": 1}}


def test_bdpan_default_runner_executes_cli_path(tmp_path):
    """cli_path 指向真实可执行体时，默认 runner 必须执行它（而非裸名 bdpan）。"""
    from paistation.sense.cloud.bdpan import BaiduDriveConnector
    fake = tmp_path / "fake_bdpan.cmd"
    fake.write_text('@echo off\r\necho {"list": []}\r\n', encoding="ascii")
    conn = BaiduDriveConnector(cli_path=str(fake))
    assert conn.test_session() is True
    events, wm = conn.collect(None)
    assert events == [] and wm == {"files": {}}


def test_bdpan_runner_missing_exe_safe():
    from paistation.sense.cloud.bdpan import _make_runner
    runner = _make_runner("Z:/definitely/missing/bdpan.exe")
    assert runner(["whoami"]) == (1, "")


# ---------------------------------------------------------------- 微信情报

def test_wih_no_dir_inactive(tmp_path):
    from paistation.sense.cloud.wih import WeChatIntelConnector
    conn = WeChatIntelConnector(out_dir=tmp_path / "nope")
    events, wm = conn.collect(None)
    assert events == [] and wm is None
    assert conn.test_session() is False


def test_wih_new_artifact_emits_event(tmp_path):
    from paistation.sense.cloud.wih import WeChatIntelConnector
    out = tmp_path / "wih"
    out.mkdir()
    (out / "daily.md").write_text("d1", encoding="utf-8")
    conn = WeChatIntelConnector(out_dir=out)
    assert conn.test_session() is True
    events, wm = conn.collect(None)
    assert len(events) == 1 and "daily.md" in events[0]["text"]
    assert events[0]["type"] == "cloud.wih.insight"
    # 未变化→无新事件
    events2, wm2 = conn.collect(wm)
    assert events2 == [] and wm2 == wm
    # 新产物→新事件
    time.sleep(0.02)
    (out / "deals.jsonl").write_text("{}", encoding="utf-8")
    events3, _ = conn.collect(wm)
    assert len(events3) == 1 and "deals.jsonl" in events3[0]["text"]


# ---------------------------------------------------------------- 授权持久化

def _three_connectors(tmp_path):
    from paistation.sense.cloud.tencent import TencentMeetingConnector
    from paistation.sense.cloud.bdpan import BaiduDriveConnector
    from paistation.sense.cloud.wih import WeChatIntelConnector
    return (TencentMeetingConnector(token="t"),
            BaiduDriveConnector(cli_path=None),
            WeChatIntelConnector(out_dir=tmp_path))


def test_grants_store_roundtrip(tmp_path):
    store = GrantsStore(tmp_path / "grants.json")
    reg = ConnectorRegistry()
    for c in _three_connectors(tmp_path):
        reg.register(c)
    assert not any(reg.is_enabled(c) for c in reg.all())  # 默认 opt-in 关

    store.grant(reg, "cloud.tencent-meeting", ["cloud.meeting.read"])
    store.grant(reg, "cloud.baidu-drive", ["cloud.drive.read"])
    assert store.path.is_file()

    # 新实例从盘回灌=授权持久化
    reg2 = ConnectorRegistry()
    for c in _three_connectors(tmp_path):
        reg2.register(c)
    GrantsStore(tmp_path / "grants.json").load_into(reg2)
    enabled = {c.name for c in reg2.all() if reg2.is_enabled(c)}
    assert enabled == {"cloud.tencent-meeting", "cloud.baidu-drive"}

    store2 = GrantsStore(tmp_path / "grants.json")
    store2.revoke(reg2, "cloud.baidu-drive")
    assert "cloud.baidu-drive" not in {c.name for c in reg2.all()
                                       if reg2.is_enabled(c)}


def test_event_types_registered():
    assert {"cloud.meeting.list", "cloud.drive.change",
            "cloud.wih.insight"} <= ALLOWED_TYPES
    ok = {"ts": "2026-09-15T00:00:00", "type": "cloud.meeting.list",
          "source": "cloud.tencent-meeting", "text": "x",
          "speaker": "cloud", "evidence": {}, "meta": {}}
    assert validate_event(ok) is True


# ---------------------------------------------------------------- 装配冒烟

def test_build_daemon_wires_cloud_service(tmp_path):
    from paistation.resident.entry import build_daemon
    daemon = build_daemon(str(tmp_path), with_mic=False)
    names = [getattr(s, "name", "") for s in daemon._services]
    assert "sense.cloud" in names
    cloud = next(s for s in daemon._services
                 if getattr(s, "name", "") == "sense.cloud")
    reg_names = {c.name for c in cloud._registry.all()}
    assert {"cloud.tencent-meeting", "cloud.baidu-drive",
            "cloud.wechat-intel"} <= reg_names
    # 默认 opt-in：未授权连接器 tick 零调用
    assert cloud._limiters == {}
