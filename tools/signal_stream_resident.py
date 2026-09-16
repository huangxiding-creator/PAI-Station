# -*- coding: utf-8 -*-
"""M7a 七路信号源常驻上电（pythonw 零弹窗载体）。

- 幂等：已在跑（wmic 命令行探测）即退出；pid 落 data/signal_stream/service.pid
- PAUSE 旗标：data/signal_stream/PAUSE 存在则 tick(paused=True) 只空转
- 事件流：EventStream 按日滚动 data/signal_stream/events/YYYY-MM-DD.jsonl
- 看护：schtasks「PAIStation-signal-stream-watchdog」每 5 分钟调本文件
"""
import os
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
DATA = ROOT / "data" / "signal_stream"
PIDF = DATA / "service.pid"
PAUSE = DATA / "PAUSE"


def _flags() -> int:
    return 0x08000000 | 0x00000008  # CREATE_NO_WINDOW | DETACHED_PROCESS


def _acquire_mutex() -> bool:
    """命名互斥量防双开（venv python shim 双进程同 cmdline，wmic 探测不可用）。"""
    import ctypes
    ERROR_ALREADY_EXISTS = 183
    ctypes.windll.kernel32.CreateMutexW(None, False, "PAIStationSignalStream")
    return ctypes.windll.kernel32.GetLastError() != ERROR_ALREADY_EXISTS


def main() -> None:
    sys.path.insert(0, str(ROOT / "src"))
    from paistation.sense.signal_service import SignalService
    from paistation.sense.voice_events import EventStream

    DATA.mkdir(parents=True, exist_ok=True)
    stream = EventStream(DATA)
    svc = SignalService(stream)
    svc.start()
    PIDF.write_text(str(os.getpid()), encoding="utf-8")
    try:
        while True:
            svc.tick(PAUSE.exists())
            time.sleep(1.0)
    finally:
        svc.stop()
        PIDF.unlink(missing_ok=True)


if __name__ == "__main__":
    try:
        if not _acquire_mutex():
            sys.exit(0)  # 已在跑
        main()
    except SystemExit:
        raise
    except Exception:
        import traceback
        DATA.mkdir(parents=True, exist_ok=True)
        with open(DATA / "crash.log", "a", encoding="utf-8") as f:
            f.write(traceback.format_exc() + "\n")
