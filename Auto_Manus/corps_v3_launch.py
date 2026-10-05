# -*- coding: utf-8 -*-
"""军团 v3 班次开跑器 (schtask 载荷) — 2026-09-28 建, 1003 7×24 多班次化.

随机漂移后拉起 corps_v3.py (1003 用户令: 军团 7×24 不间断, 网络让开
WeAIPO/自媒 NB 国外网时段 — 让路逻辑在 corps_v3.py 内: 开窗前闲门 +
班中有界等待). 漂移保留随机性反机器节律画像.

用法 (schtask 传参):
  pythonw corps_v3_launch.py [duration分钟] [drift分钟] [limit单数]
  网格班: 90 20 1   (2h 一班, 每班限 1 单 — 给黄金窗留弹药)
  黄金班: 210 5 0   (北京 11:00 起, 美东深夜 23:00-04:00 风控最松窗,
                     敞开吃; 210min 正好在 WeAIPO DailyRun 14:30 前收官)

HALT 旗标在位时 corps_v3.py 自己秒退 (fail-safe), 本器无须重复判.

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

duration = int(sys.argv[1]) if len(sys.argv) > 1 else 90
drift_max = int(sys.argv[2]) if len(sys.argv) > 2 else 20
limit = int(sys.argv[3]) if len(sys.argv) > 3 else 1
max_today = int(sys.argv[4]) if len(sys.argv) > 4 else 0

drift = random.uniform(0, drift_max * 60)
print(f"[auto {time.strftime('%Y-%m-%d %H:%M:%S')}] "
      f"漂移 {drift / 60:.0f}min 后开班 (dur={duration} limit={limit} "
      f"max_today={max_today})", flush=True)
time.sleep(drift)

cmd = [sys.executable, str(ROOT / "corps_v3.py"),
       "--duration", str(duration)]
if limit > 0:
    cmd += ["--limit", str(limit)]
if max_today > 0:
    cmd += ["--max-today", str(max_today)]
p = subprocess.run(cmd, cwd=str(ROOT), stdout=sys.stdout,
                   stderr=subprocess.STDOUT,
                   creationflags=0x08000000)  # CREATE_NO_WINDOW
print(f"[auto {time.strftime('%Y-%m-%d %H:%M:%S')}] "
      f"corps_v3 退出码 {p.returncode}", flush=True)
