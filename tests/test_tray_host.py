"""M1.8 托盘宿主：IPC 状态镜像+菜单命令映射+断线退避（纯逻辑）。"""
import pytest

from paistation.resident.tray import TrayHost, map_menu_action


class FakeTransport:
    """可编程 IPC 桩：记录调用，返回预设响应。"""

    def __init__(self, responses=None, fail=False):
        self.calls = []
        self._responses = responses or {}
        self._fail = fail

    def call(self, cmd, payload, timeout=5.0):
        self.calls.append((cmd, payload))
        if self._fail:
            from paistation.resident.ipc import PipeError
            raise PipeError("daemon 不在")
        return self._responses.get(cmd, {"ok": True, "data": {}})


def test_map_menu_action_to_ipc_cmd():
    assert map_menu_action("TOGGLE_PAUSE") == "events.pause"
    assert map_menu_action("TOGGLE_PAUSE", paused=True) == "events.resume"
    assert map_menu_action("QUIT") == "shutdown"
    assert map_menu_action("SETTINGS") is None  # 设置=拉面板，不走 IPC


def test_host_refresh_mirrors_daemon_status():
    t = FakeTransport({"status": {"ok": True, "data": {"paused": True,
                                                       "services": [{"name": "sense", "healthy": True}]}}})
    host = TrayHost(transport=t)
    host.refresh()
    assert host.paused is True
    assert host.daemon_alive is True
    assert host.services == [{"name": "sense", "healthy": True}]


def test_host_toggle_pause_dispatches_ipc():
    t = FakeTransport()
    host = TrayHost(transport=t)
    host.paused = False
    host.toggle_pause()
    assert t.calls[0] == ("events.pause", {})  # 后随 status 刷新不算
    host.paused = True
    host.toggle_pause()
    assert t.calls[-2] == ("events.resume", {})


def test_host_quit_sends_shutdown():
    t = FakeTransport()
    host = TrayHost(transport=t)
    host.quit()
    assert t.calls[0] == ("shutdown", {})


def test_host_backoff_on_daemon_down():
    """daemon 不在：不炸，标记离线，退避计数递增。"""
    t = FakeTransport(fail=True)
    host = TrayHost(transport=t, base_backoff_s=0.0)
    for _ in range(5):
        host.refresh()
    assert host.daemon_alive is False
    assert host.consecutive_failures == 5
    assert host.should_retry_at is not None


def test_host_recovers_after_backoff():
    t = FakeTransport(fail=True)
    host = TrayHost(transport=t, base_backoff_s=0.0)
    host.refresh()
    host.refresh()
    # 网络恢复
    t._fail = False
    t._responses = {"status": {"ok": True, "data": {"paused": False}}}
    host.refresh()
    assert host.daemon_alive is True
    assert host.consecutive_failures == 0


def test_host_menu_reflects_state():
    t = FakeTransport()
    host = TrayHost(transport=t)
    labels = [m.label for m in host.build_menu()]
    assert "暂停感知" in labels and "退出" in labels
    host.paused = True
    labels = [m.label for m in host.build_menu()]
    assert "恢复感知" in labels
