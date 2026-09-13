"""M1.8 托盘宿主（05 卷）：pystray 纯客户端，复用 V2 ui/tray 菜单资产。

托盘=薄视图：状态从 daemon IPC 镜像，动作转发 IPC——自身无常驻状态，
崩溃由 daemon 侧重拉（或用户手点）。断线退避：daemon 不在时不炸，
指数退避到 should_retry_at 再试（网络/启动竞态友好）。
"""
from __future__ import annotations

import logging
import time

_log = logging.getLogger("paistation.resident.tray")


def map_menu_action(action: str, paused: bool = False) -> str | None:
    """菜单动作 → IPC 命令（SETTINGS 不走 IPC，由宿主拉面板）。"""
    if action == "TOGGLE_PAUSE":
        return "events.resume" if paused else "events.pause"
    if action == "QUIT":
        return "shutdown"
    return None


class TrayHost:
    """状态镜像+命令转发（transport 可注入，GUI 壳在 run_gui）。"""

    def __init__(self, transport, base_backoff_s: float = 1.0,
                 max_backoff_s: float = 60.0):
        self._transport = transport
        self._base = base_backoff_s
        self._max = max_backoff_s
        self.paused = False
        self.daemon_alive = False
        self.services: list = []
        self.consecutive_failures = 0
        self.should_retry_at: float | None = None

    # ---- 状态镜像 ----

    def refresh(self) -> None:
        now = time.time()
        if self.should_retry_at and now < self.should_retry_at:
            return  # 退避窗口内不重试
        try:
            resp = self._transport.call("status", {})
        except Exception as exc:  # noqa: BLE001 - 断线是常态不是异常
            self._on_failure(exc)
            return
        data = resp.get("data", {}) if resp.get("ok") else {}
        self.daemon_alive = True
        self.consecutive_failures = 0
        self.should_retry_at = None
        self.paused = bool(data.get("paused"))
        self.services = data.get("services", [])

    def _on_failure(self, exc) -> None:
        self.daemon_alive = False
        self.consecutive_failures += 1
        backoff = min(self._base * (2 ** (self.consecutive_failures - 1)),
                      self._max)
        self.should_retry_at = time.time() + backoff
        _log.debug("daemon 离线（第 %d 次，退避 %.1fs）: %s",
                   self.consecutive_failures, backoff, exc)

    # ---- 动作 ----

    def toggle_pause(self) -> None:
        cmd = map_menu_action("TOGGLE_PAUSE", self.paused)
        self._dispatch(cmd)

    def quit(self) -> None:
        self._dispatch("shutdown")

    def _dispatch(self, cmd: str | None) -> None:
        if not cmd:
            return
        try:
            self._transport.call(cmd, {})
        except Exception as exc:  # noqa: BLE001
            _log.warning("托盘命令失败 %s: %s", cmd, exc)
        self.refresh()

    # ---- 菜单（复用 V2 菜单语义）----

    def build_menu(self):
        from paistation.ui.tray import build_menu

        class _State:  # 适配 V2 TrayState 形状
            def __init__(self, paused):
                self.paused = paused

            def toggle_pause(self):
                pass

        return build_menu(_State(self.paused))


def run_gui(pipe_name: str = "pai-station", authkey: bytes = b"") -> int:
    """GUI 壳：pystray 图标+定时 refresh（tray extra：pystray+Pillow）。"""
    import threading

    import pystray

    from paistation.resident.ipc import PipeClient
    from paistation.ui.tray import MenuAction, TrayState, build_menu, make_icon_image

    if not authkey:
        import os

        from paistation.resident.ipc import load_or_create_authkey
        data_dir = os.path.expandvars(r"%APPDATA%\PAI-Station")
        os.makedirs(data_dir, exist_ok=True)
        authkey = load_or_create_authkey(data_dir)

    client = PipeClient(rf"\\.\pipe\{pipe_name}", authkey=authkey)
    host = TrayHost(transport=client)
    state = TrayState()

    def on_click(icon, item):
        action = getattr(item, "action", None)
        if action == MenuAction.TOGGLE_PAUSE:
            host.toggle_pause()
            state.toggle_pause()
        elif action == MenuAction.QUIT:
            host.quit()
            icon.stop()

    def poll():
        while True:
            host.refresh()
            state.paused = host.paused
            time.sleep(5.0)

    menu_items = [pystray.MenuItem(entry.label, on_click)
                  for entry in build_menu(state)]
    icon = pystray.Icon("pai-station", make_icon_image(64), "PAI-Station",
                        tuple(menu_items))
    threading.Thread(target=poll, daemon=True).start()
    icon.run()
    return 0


def _icon_image():
    from paistation.ui.tray import make_icon_image
    return make_icon_image(64)
