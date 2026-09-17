"""秒级文件事件守护（watchdog ReadDirectoryChangesW 事件驱动）。

USN 15 分钟水位是兜底；本守护是秒级主力：15 个扫描根各挂递归
监听句柄，变更事件毫秒级到达 → 1s 防抖批量 → usn_queue.jsonl。
提取循环 drain 该队列（inventory.apply_event 单行接口），实现
「文件落地 → 秒级进大脑待处理队列」。

进程形态：pythonw 常驻零弹窗 + PID 文件防双实例；schtask 每分钟
幂等补拉（崩溃至多 1 分钟空窗）。事件中途丢失由每晚全量 walk 与
USN 水位双兜底——秒级是锦上添花，不是唯一真理源。
"""
from __future__ import annotations

import json
import os
import sys
import time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\src")

from watchdog.events import FileSystemEvent, FileSystemEventHandler
from watchdog.observers import Observer

OUT_DIR = Path(r"E:\AI-Station\data\local_index")
QUEUE = OUT_DIR / "usn_queue.jsonl"
PIDF = OUT_DIR / "live_watch.pid"
LOG = OUT_DIR / "live_watch.log"
FLUSH_S = 1.0
ROOTS = (
    r"C:\Users\91216\Desktop", r"C:\Users\91216\Documents",
    r"C:\Users\91216\Downloads", r"C:\Users\91216\Pictures",
    r"C:\Users\91216\Videos", r"C:\Users\91216\Music",
    r"E:\AI-Station", r"D:\20 白龟湖项目", r"D:\WEMedia",
    r"D:\WEMediaOutput", r"F:\工程知识库超市", r"D:\MemoTrace",
    r"D:\BaiduSyncdisk", r"D:\360Downloads", r"D:\360安全浏览器下载",
    r"D:\md2wechat-skill",
)
EXCLUDE_NAMES = {
    "appdata", "windows", "program files", "program files (x86)",
    "node_modules", "$recycle.bin", "system volume information",
    ".git", "__pycache__", ".venv", "site-packages", ".mypy_cache",
    ".pytest_cache", "dist", "build",
}


def _covered(path: str) -> bool:
    p = path.replace("\\", "/").lower()
    # 自指免疫：索引库自身产物（队列/日志/PID）不进事件流——
    # 否则每次 flush 都触发自己的 modified 事件（1 条/秒空转）
    if p.startswith("e:/ai-station/data/local_index/"):
        return False
    if not any(p.startswith(r.replace("\\", "/").lower() + "/")
               for r in ROOTS):
        return False
    segs = p.split("/")
    return not (set(map(str.lower, segs[2:-1])) & EXCLUDE_NAMES)


def _log(msg: str) -> None:
    with LOG.open("a", encoding="utf-8") as fh:
        fh.write(f"{time.strftime('%F %T')} {msg}\n")


class Collector(FileSystemEventHandler):
    """事件 → 防抖聚合表；1s 批量落 jsonl（高频写盘免疫）。"""

    def __init__(self) -> None:
        self.pending: dict[str, dict] = {}
        self.count = 0

    def on_any_event(self, event: FileSystemEvent) -> None:
        if event.is_directory:
            return
        src = str(event.src_path)
        if not _covered(src):
            return
        op = {
            "FileCreatedEvent": "created",
            "FileModifiedEvent": "modified",
            "FileDeletedEvent": "deleted",
            "FileMovedEvent": "moved",
        }.get(type(event).__name__)
        if op is None:
            return
        item = {"ts": time.time(), "op": op, "path": src}
        if op == "moved":
            item["dest"] = str(getattr(event, "dest_path", ""))
        self.pending[src] = item  # 同文件多事件取最后一次语义

    def flush(self) -> int:
        if not self.pending:
            return 0
        items = list(self.pending.values())
        self.pending.clear()
        with QUEUE.open("a", encoding="utf-8") as fh:
            for it in items:
                fh.write(json.dumps(it, ensure_ascii=False) + "\n")
        self.count += len(items)
        return len(items)


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    # 内核级独占锁（msvcrt）：补拉任务与本进程启动撞窗口时，PID
    # 探活有 check-then-act 竞态（实测双实例），锁由内核原子授予、
    # 进程死自动释放——补拉幂等的可靠形态
    import msvcrt
    lockf = OUT_DIR / "live_watch.lock"
    fh = lockf.open("w")
    try:
        msvcrt.locking(fh.fileno(), msvcrt.LK_NBLCK, 1)
    except OSError:
        fh.close()
        return 0  # 已有活实例
    fh.write(str(os.getpid()))
    fh.flush()
    col = Collector()
    obs = Observer()
    live = 0
    for r in ROOTS:
        if os.path.isdir(r):
            obs.schedule(col, r, recursive=True)
            live += 1
    obs.start()
    _log(f"守护启动：{live}/{len(ROOTS)} 根监听中 pid={os.getpid()}")
    try:
        while True:
            time.sleep(FLUSH_S)
            n = col.flush()
            if n and col.count % 500 < n:  # 每 ~500 事件记一笔
                _log(f"累计事件 {col.count}")
    except KeyboardInterrupt:
        pass
    finally:
        obs.stop()
        obs.join()
        col.flush()
        PIDF.unlink(missing_ok=True)
        _log(f"守护退出：累计事件 {col.count}")
        try:
            msvcrt.locking(fh.fileno(), msvcrt.LK_UNLCK, 1)
        except OSError:
            pass
        fh.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
