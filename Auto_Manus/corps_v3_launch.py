# -*- coding: utf-8 -*-
"""军团 v3 每日自动开跑器 (schtask 载荷) — 2026-09-28.

随机漂移 0-60min 后拉起 corps_v3.py (0928 定案最优窗 09:30-10:30 随机起步,
反「每天固定整点满负荷」机器节律画像). HALT 旗标在位时 corps_v3.py 自己
秒退 (fail-safe), 本器无须重复判.

pythonw 无控制台 → sys.stdout 为 None, corps_v3.py 的 io.TextIOWrapper
包装会炸 → 先自重定向日志再跑. 子进程 CREATE_NO_WINDOW (不弹窗铁律).
"""
import random
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).parent
LOG = ROOT / "data" / "corps_v3_auto.log"

if sys.stdout is None:                      # pythonw: 无控制台
    LOG.parent.mkdir(parents=True, exist_ok=True)
    sys.stdout = open(LOG, "a", buffering=1,
                      encoding="utf-8", errors="replace")
    sys.stderr = sys.stdout

drift = random.uniform(0, 3600)
print(f"[auto {time.strftime('%Y-%m-%d %H:%M:%S')}] "
      f"漂移 {drift / 60:.0f}min 后开跑", flush=True)
time.sleep(drift)

p = subprocess.run(
    [sys.executable, str(ROOT / "corps_v3.py")],
    cwd=str(ROOT), stdout=sys.stdout, stderr=subprocess.STDOUT,
    creationflags=0x08000000)               # CREATE_NO_WINDOW
print(f"[auto {time.strftime('%Y-%m-%d %H:%M:%S')}] "
      f"corps_v3 退出码 {p.returncode}", flush=True)
