"""M1.2 主控 daemon（ADR-1/ADR-2）：Mutex 防双开 + 心跳契约 + IPC 调度。

判活铁律 v3（移植自 NJSupervisor 三版教训）：形态进程存在 ∧ 心跳文件
新鲜 ∧ 尾行进展证据——三者缺一不可；挂起进程不再刷心跳、僵尸进程无
证据行，均被判死。PAUSE 旗标=人工熔断：服务不起但心跳照写（看护器
要能区分"人在暂停"与"进程挂死"）。
"""
from __future__ import annotations

import ctypes
import faulthandler
import json
import logging
import os
import tempfile
import threading
import time

from paistation.resident.ipc import PipeServer

_log = logging.getLogger("paistation.resident.daemon")

DEFAULT_MUTEX = r"Local\PAI-Station-Daemon"
BOOT_NOTE = "boot"
ERROR_ALREADY_EXISTS = 183


class AlreadyRunningError(RuntimeError):
    """已有 daemon 实例持有互斥体。"""


class SingleInstance:
    """ctypes CreateMutexW——不引入 pywin32 依赖（M6 打包瘦身）。"""

    def __init__(self, name: str = DEFAULT_MUTEX):
        self._name = name
        self._handle = None

    def acquire(self) -> None:
        handle = ctypes.windll.kernel32.CreateMutexW(None, False, self._name)
        if not handle:
            raise OSError(f"CreateMutexW 失败: {ctypes.GetLastError()}")
        if ctypes.windll.kernel32.GetLastError() == ERROR_ALREADY_EXISTS:
            ctypes.windll.kernel32.CloseHandle(handle)
            raise AlreadyRunningError(f"互斥体已存在: {self._name}")
        self._handle = handle

    def release(self) -> None:
        if self._handle:
            ctypes.windll.kernel32.ReleaseMutex(self._handle)
            ctypes.windll.kernel32.CloseHandle(self._handle)
            self._handle = None


class Heartbeat:
    """心跳契约：{pid, ts, seq, note, leg}；tmp+rename 原子落盘。"""

    def __init__(self, path, leg: str = "pai-daemon"):
        self._path = str(path)
        self._leg = leg

    def beat(self, seq: int, note: str) -> None:
        data = {"pid": os.getpid(), "ts": time.time(), "seq": seq,
                "note": note, "leg": self._leg}
        d = os.path.dirname(self._path) or "."
        fd, tmp = tempfile.mkstemp(dir=d, suffix=".tmp")
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as fh:
                json.dump(data, fh, ensure_ascii=False)
            os.replace(tmp, self._path)
        except BaseException:
            if os.path.exists(tmp):
                os.unlink(tmp)
            raise

    @staticmethod
    def read(path) -> dict:
        with open(path, encoding="utf-8") as fh:
            return json.load(fh)

    @staticmethod
    def is_fresh(path, limit: float = 150.0) -> bool:
        try:
            return time.time() - os.stat(path).st_mtime < limit
        except OSError:
            return False

    @staticmethod
    def evidence_ok(data: dict) -> bool:
        """进展证据：seq>0 且 note 非启动头行（防挂起进程骗过新鲜度）。"""
        return data.get("seq", 0) > 0 and data.get("note") != BOOT_NOTE


class PauseFlag:
    """PAUSE 文件旗标（人工熔断，V2 EngOpp 同款语义）。"""

    def __init__(self, data_dir):
        self._path = os.path.join(str(data_dir), "PAUSE")

    @property
    def paused(self) -> bool:
        return os.path.exists(self._path)

    def clear(self) -> None:
        if os.path.exists(self._path):
            os.unlink(self._path)


class Daemon:
    """装配：互斥体 → IPC 调度 → 服务启停 → 心跳事件环。

    服务协议：start()/stop()/tick(paused: bool)——tick 每环调用一次，
    paused 由 IPC/PAUSE 共同决定（合作式暂停）。
    """

    def __init__(self, data_dir, services: list, pipe_name: str,
                 authkey: bytes, tick_interval: float = 30.0,
                 mutex_name: str = DEFAULT_MUTEX):
        self.data_dir = str(data_dir)
        self._services = list(services)
        self._tick_interval = tick_interval
        self.pipe_name = pipe_name
        self.pipe_address = rf"\\.\pipe\{pipe_name}"
        self._authkey = authkey
        self._mutex_name = mutex_name
        self._heartbeat = Heartbeat(os.path.join(self.data_dir, "heartbeat.json"))
        self._pause_flag = PauseFlag(self.data_dir)
        self._stop = threading.Event()
        self._ipc_pause = False
        self._seq = 0
        self._started_at = 0.0
        self.ready = False
        self._thread: threading.Thread | None = None
        self._ipc: PipeServer | None = None
        self._mutex: SingleInstance | None = None

    # ---- 生命周期 ----

    def start_in_thread(self) -> None:
        self._thread = threading.Thread(target=self.run, name="pai-daemon",
                                        daemon=True)
        self._thread.start()

    def join_thread(self, timeout: float = 10.0) -> None:
        if self._thread:
            self._thread.join(timeout=timeout)

    def call_shutdown(self) -> None:
        self._stop.set()

    def run(self) -> None:
        os.makedirs(self.data_dir, exist_ok=True)
        faulthandler.enable(open(os.path.join(self.data_dir, "faults.log"),
                                 "w", encoding="utf-8"),
                            all_threads=True)
        try:
            self._mutex = SingleInstance(self._mutex_name)
            self._mutex.acquire()
        except AlreadyRunningError:
            _log.warning("已有 daemon 实例，本实例退出")
            return
        self._started_at = time.time()
        self._seq = 0
        self._heartbeat.beat(self._seq, BOOT_NOTE)
        if self._pause_flag.paused or self._ipc_pause:
            _log.warning("PAUSE 熔断生效：服务不起，心跳照写")
        else:
            for svc in self._services:
                try:
                    svc.start()
                except Exception as exc:  # noqa: BLE001 - 单服务启动失败不连坐
                    _log.error("服务启动失败 %s: %s", svc.name, exc)
        self._ipc = PipeServer(self.pipe_name, authkey=self._authkey,
                               handler=self._dispatch)
        self._ipc.start()
        self.ready = True
        _log.info("daemon 就绪: pipe=%s services=%d",
                  self.pipe_name, len(self._services))
        try:
            self._loop()
        finally:
            self._teardown()

    def _loop(self) -> None:
        while not self._stop.is_set():
            paused = self._ipc_pause or self._pause_flag.paused
            for svc in self._services:
                if not getattr(svc, "started", True):
                    continue  # PAUSE 熔断下未启动的服务不参与
                try:
                    svc.tick(paused=paused)
                except Exception as exc:  # noqa: BLE001 - 单服务故障不杀环
                    _log.warning("服务 tick 异常 %s: %s", svc.name, exc)
            if paused:
                self._heartbeat.beat(self._seq, "paused")
            else:
                self._seq += 1
                self._heartbeat.beat(self._seq, f"tick#{self._seq}")
            self._stop.wait(self._tick_interval)

    def _teardown(self) -> None:
        self.ready = False
        if self._ipc:
            self._ipc.stop()
        for svc in self._services:
            try:
                if getattr(svc, "started", True):
                    svc.stop()
            except Exception as exc:  # noqa: BLE001 - 收尾尽力而为
                _log.warning("服务 stop 异常 %s: %s", getattr(svc, "name", "?"), exc)
        if self._mutex:
            self._mutex.release()
        _log.info("daemon 已退出")

    # ---- IPC 调度 ----

    def _dispatch(self, cmd: str, payload: dict) -> dict:
        if cmd == "ping":
            return {"pong": True, "uptime_s": round(time.time() - self._started_at, 1)}
        if cmd == "status":
            return {
                "services": [{"name": s.name, "healthy": True} for s in self._services],
                "paused": self._ipc_pause or self._pause_flag.paused,
                "seq": self._seq,
                "pid": os.getpid(),
            }
        if cmd == "events.pause":
            self._ipc_pause = True
            return {"paused": True}
        if cmd == "events.resume":
            self._ipc_pause = False
            return {"paused": False}
        if cmd == "shutdown":
            self._stop.set()
            return {"shutting_down": True}
        raise KeyError(f"未知命令: {cmd}")
