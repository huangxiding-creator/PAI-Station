"""文件监听（提案 4.2 sense）：watchdog Observer + 过滤 + 去抖批处理。

EventFilter/BatchBuffer 为纯逻辑（可单测）；FsWatcher 薄壳负责把
watchdog 事件推进缓冲，窗口到期整批回调（防编辑器风暴）。
感知红线：本模块对被监听目录只读。
"""
import fnmatch
import logging
import os
import threading
import time

_log = logging.getLogger("paistation.sense.fs")


class EventFilter:
    """后缀白名单 + 忽略模式（fnmatch，任一段命中即拒）。"""

    def __init__(self, suffixes: set[str], ignore_patterns: list[str] | tuple):
        self._suffixes = {s.lower() for s in suffixes}
        self._ignore = list(ignore_patterns or [])

    def accept(self, path: str) -> bool:
        norm = str(path).replace("\\", "/").lower()
        for pattern in self._ignore:
            if fnmatch.fnmatch(norm, f"*{pattern.lower()}*"):
                return False
        return os.path.splitext(norm)[1] in self._suffixes


class BatchBuffer:
    """去抖批处理：窗口内去重合并，超容量丢最旧（防风暴）。"""

    def __init__(self, window: float = 2.0, cap: int = 200):
        self._window = window
        self._cap = cap
        self._lock = threading.Lock()
        self._events: dict[str, float] = {}

    def add(self, path: str, now: float | None = None) -> None:
        with self._lock:
            self._events[path] = time.time() if now is None else now
            while len(self._events) > self._cap:  # 丢最旧
                oldest = min(self._events, key=self._events.get)
                del self._events[oldest]

    def drain(self, now: float | None = None) -> list[str]:
        """窗口到期：按入库顺序整批出货；未到期返回空。"""
        current = time.time() if now is None else now
        with self._lock:
            if not self._events:
                return []
            oldest = min(self._events.values())
            if current - oldest < self._window:
                return []
            batch = sorted(self._events, key=self._events.get)
            self._events.clear()
            return batch

    @property
    def pending(self) -> int:
        with self._lock:
            return len(self._events)


class FsWatcher:
    """watchdog 薄壳：递归监听白名单目录，整批回调 on_batch(paths)。"""

    def __init__(self, watch_dirs: list[str], event_filter: EventFilter,
                 on_batch, audit=None, window: float = 2.0):
        self._dirs = list(watch_dirs)
        self._filter = event_filter
        self._buffer = BatchBuffer(window=window)
        self._on_batch = on_batch
        self._audit = audit
        self._observer = None
        self._timer = None
        self._stopping = threading.Event()

    def _handle(self, path: str):
        if self._filter.accept(path):
            self._buffer.add(path)

    def _tick(self):
        batch = self._buffer.drain()
        if batch and self._audit:
            self._audit.record("fs.batch", module="sense", count=len(batch),
                               paths=[os.path.basename(p) for p in batch[:10]])
        if batch:
            try:
                self._on_batch(batch)
            except Exception as exc:  # noqa: BLE001 - 回调失败不杀监听
                _log.warning("on_batch 回调异常（忽略）: %s", exc)
        if not self._stopping.is_set():
            self._timer = threading.Timer(0.5, self._tick)
            self._timer.daemon = True
            self._timer.start()

    def start(self):
        from watchdog.events import FileSystemEventHandler
        from watchdog.observers import Observer

        watcher = self

        class Handler(FileSystemEventHandler):
            def on_any_event(self, event):
                if not event.is_directory:
                    watcher._handle(event.dest_path if event.event_type == "moved"
                                    else event.src_path)

        self._observer = Observer()
        for d in self._dirs:
            self._observer.schedule(Handler(), d, recursive=True)
        self._observer.start()
        self._tick()
        _log.info("FsWatcher 启动：%d 个目录", len(self._dirs))

    def stop(self):
        self._stopping.set()
        if self._timer:
            self._timer.cancel()
        if self._observer:
            self._observer.stop()
            self._observer.join(timeout=5)
