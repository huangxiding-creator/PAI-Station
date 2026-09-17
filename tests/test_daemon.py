"""M1.2 主控 daemon：Mutex 防双开 + 心跳契约 + IPC 调度 + PAUSE 熔断。"""
import os
import time

import pytest

from paistation.resident.daemon import (
    AlreadyRunningError,
    Daemon,
    Heartbeat,
    PauseFlag,
    SingleInstance,
)

# ---- 心跳契约（判活铁律 v3：进程∧新鲜∧证据）----

def test_heartbeat_write_read_roundtrip(tmp_path):
    hb = Heartbeat(tmp_path / "heartbeat.json")
    hb.beat(seq=42, note="tick#42 events=7")
    data = Heartbeat.read(tmp_path / "heartbeat.json")
    assert data["seq"] == 42 and data["note"] == "tick#42 events=7"
    assert data["leg"] == "pai-daemon" and data["pid"] == os.getpid()


def test_heartbeat_atomic_no_partial_file(tmp_path):
    """崩溃中写入不留半截 JSON（tmp+rename）。"""
    hb = Heartbeat(tmp_path / "heartbeat.json")
    for i in range(20):
        hb.beat(seq=i, note=f"tick#{i}")
    data = Heartbeat.read(tmp_path / "heartbeat.json")
    assert data["seq"] == 19  # 最后一次完整落盘


def test_heartbeat_is_alive_requires_all_three(tmp_path):
    path = tmp_path / "heartbeat.json"
    hb = Heartbeat(path)
    # 证据不足：启动头行不算进展
    hb.beat(seq=0, note="boot")
    assert Heartbeat.evidence_ok(Heartbeat.read(path)) is False
    # 进展证据：seq>0 且 note 非启动行
    hb.beat(seq=3, note="tick#3 events=1")
    assert Heartbeat.evidence_ok(Heartbeat.read(path)) is True
    # 新鲜度过期：mtime 拨回 1 小时前
    old = time.time() - 3600
    os.utime(path, (old, old))
    assert Heartbeat.is_fresh(path, limit=150) is False
    assert Heartbeat.is_fresh(path, limit=7200) is True
    # 文件不存在
    assert Heartbeat.is_fresh(tmp_path / "nope.json", limit=60) is False


# ---- Mutex 防双开（真 Windows 互斥体）----

def test_mutex_double_acquire_rejected():
    first = SingleInstance("pai-station-test-mutex")
    first.acquire()
    try:
        second = SingleInstance("pai-station-test-mutex")
        with pytest.raises(AlreadyRunningError):
            second.acquire()
    finally:
        first.release()


def test_mutex_release_allows_reacquire():
    first = SingleInstance("pai-station-test-mutex-r")
    first.acquire()
    first.release()
    again = SingleInstance("pai-station-test-mutex-r")
    again.acquire()
    again.release()


# ---- PAUSE 旗标（人工熔断）----

def test_pause_flag_file_toggles(tmp_path):
    flag = PauseFlag(tmp_path)
    assert flag.paused is False
    (tmp_path / "PAUSE").write_text("manual", encoding="utf-8")
    assert flag.paused is True
    flag.clear()
    assert flag.paused is False


# ---- Daemon 装配：IPC 调度 + 生命周期 ----

class FakeService:
    def __init__(self, name="fake"):
        self.name = name
        self.started = False
        self.stopped = False
        self.pause_seen = False

    def start(self):
        self.started = True

    def stop(self):
        self.stopped = True

    def tick(self, paused):
        if paused:
            self.pause_seen = True


_CTR = [0]


def _free_pipe():
    _CTR[0] += 1
    return f"pai-daemon-test-{int(time.time() * 1000)}-{_CTR[0]}"


def _free_mutex():
    _CTR[0] += 1
    return f"pai-mutex-test-{_CTR[0]}"


def test_daemon_lifecycle_ping_pause_shutdown(tmp_path):
    svc = FakeService("sense")
    daemon = Daemon(data_dir=tmp_path, services=[svc], pipe_name=_free_pipe(),
                    authkey=b"k", tick_interval=0.05, mutex_name=_free_mutex())
    daemon.start_in_thread()
    deadline = time.time() + 5
    while not daemon.ready and time.time() < deadline:
        time.sleep(0.02)
    assert daemon.ready and svc.started

    from paistation.resident.ipc import PipeClient
    client = PipeClient(daemon.pipe_address, authkey=b"k")

    pong = client.call("ping", {})
    assert pong["ok"] and pong["data"]["pong"] is True

    status = client.call("status", {})
    assert status["ok"]
    assert status["data"]["services"] == [{"name": "sense", "healthy": True}]
    assert status["data"]["paused"] is False

    client.call("events.pause", {})
    time.sleep(0.2)  # 至少一个 tick 观察到暂停
    assert svc.pause_seen is True
    assert client.call("status", {})["data"]["paused"] is True

    resp = client.call("shutdown", {})
    assert resp["ok"]
    daemon.join_thread(timeout=15)  # 全量套件高负载下 5s 关停窗偶发不够（09-17 实锤）
    assert svc.stopped and daemon.ready is False


def test_daemon_heartbeat_advances_while_running(tmp_path):
    svc = FakeService()
    daemon = Daemon(data_dir=tmp_path, services=[svc], pipe_name=_free_pipe(),
                    authkey=b"k", tick_interval=0.05, mutex_name=_free_mutex())
    daemon.start_in_thread()
    deadline = time.time() + 5
    while not daemon.ready and time.time() < deadline:
        time.sleep(0.02)
    time.sleep(0.3)
    hb_path = tmp_path / "heartbeat.json"
    data = Heartbeat.read(hb_path)
    daemon.call_shutdown()
    daemon.join_thread(timeout=5)
    final = Heartbeat.read(hb_path)
    assert data["seq"] >= 1
    assert final["seq"] >= data["seq"]
    assert Heartbeat.evidence_ok(final) is True


def test_daemon_pause_flag_blocks_service_start(tmp_path):
    (tmp_path / "PAUSE").write_text("manual", encoding="utf-8")
    svc = FakeService()
    daemon = Daemon(data_dir=tmp_path, services=[svc], pipe_name=_free_pipe(),
                    authkey=b"k", tick_interval=0.05, mutex_name=_free_mutex())
    daemon.start_in_thread()
    deadline = time.time() + 5
    while not daemon.ready and time.time() < deadline:
        time.sleep(0.02)
    daemon.call_shutdown()
    daemon.join_thread(timeout=5)
    assert svc.started is False  # PAUSE 熔断：服务不起
    hb = Heartbeat.read(tmp_path / "heartbeat.json")
    assert hb["note"] == "paused"  # 心跳照写（看护器要能区分 paused vs 挂死）


def test_daemon_double_start_rejected(tmp_path):
    mutex = _free_mutex()
    d1 = Daemon(data_dir=tmp_path, services=[], pipe_name=_free_pipe(),
                authkey=b"k", tick_interval=0.05, mutex_name=mutex)
    d1.start_in_thread()
    deadline = time.time() + 5
    while not d1.ready and time.time() < deadline:
        time.sleep(0.02)
    try:
        d2 = Daemon(data_dir=tmp_path, services=[], pipe_name=_free_pipe(),
                    authkey=b"k", tick_interval=0.05, mutex_name=mutex)
        d2.start_in_thread()
        d2.join_thread(timeout=5)
        assert d2.ready is False  # 第二实例自杀退出而非双开
    finally:
        d1.call_shutdown()
        d1.join_thread(timeout=5)
