# -*- coding: utf-8 -*-
"""collector 常驻腿开跑器 — 2026-10-01 (让路恢复补位用).

epc50_yield_guard / corps_v3 都不拉 collector, 恢复日须手动补位 (0929 手册同款).
pythonw 无控制台 → 先自重定向日志再跑子进程 (corps_v3_launch 同款模式),
CREATE_NO_WINDOW (不弹窗铁律).
"""
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).parent
LOG = ROOT / "data" / "collector_run.log"


def main() -> int:
    LOG.parent.mkdir(parents=True, exist_ok=True)
    with open(LOG, "a", buffering=1, encoding="utf-8", errors="replace") as f:
        f.write(f"[launch {time.strftime('%Y-%m-%d %H:%M:%S')}] "
                "collector --loop 600 启动\n")
        p = subprocess.run(
            [sys.executable, str(ROOT / "epc50_collector.py"), "--loop", "600"],
            cwd=str(ROOT), stdout=f, stderr=subprocess.STDOUT,
            creationflags=0x08000000)          # CREATE_NO_WINDOW
        f.write(f"[launch {time.strftime('%Y-%m-%d %H:%M:%S')}] "
                f"collector 退出码 {p.returncode}\n")
    return p.returncode


if __name__ == "__main__":
    sys.exit(main())
