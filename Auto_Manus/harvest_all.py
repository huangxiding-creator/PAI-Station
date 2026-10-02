# -*- coding: utf-8 -*-
"""全量采集总循环 — 供断点恢复复用 (15:00 让路暂停后的夜间自动接续).

防崩穿: 每账号文件独立子进程, 单文件崩溃不拖垮全链; 末尾 rescan
对账补漏 + downloader 文件本体收割. 跑完写 ALL_DONE.flag 供巡检汇报.

用法: python harvest_all.py   (幂等: manifest 去重, 已采秒跳)
"""
import subprocess
import sys
import time
from pathlib import Path

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except AttributeError:
    pass  # pythonw 无 stdout — 输出走句柄继承

# 0922 用户令: 以完整名单为准 (原 7 个分散名单废弃)
ACCOUNT_FILES = (
    "Manus账号（全部）260922_干净版.txt",
)

CREATIONFLAGS = 0x08000000  # CREATE_NO_WINDOW — 不弹窗铁律


def run_step(args, label):
    print(f"\n===== {label} =====", flush=True)
    t0 = time.time()
    try:
        r = subprocess.run(args, creationflags=CREATIONFLAGS)
        mins = (time.time() - t0) / 60
        print(f"[all] {label} 退出码 {r.returncode} ({mins:.1f} 分钟)",
              flush=True)
        return r.returncode
    except Exception as e:
        print(f"[all] {label} 异常: {type(e).__name__}: {e}", flush=True)
        return -1


def main():
    for f in ACCOUNT_FILES:
        rc = run_step([sys.executable, "session_harvester.py",
                       "--account-file", f], f)
        if rc != 0:
            print(f"[all] {f} 崩溃/未完成 (rc={rc}), 继续下一文件", flush=True)
    run_step([sys.executable, "session_rescan.py"], "rescan 对账补漏")
    run_step([sys.executable, "session_downloader.py"], "downloader 文件收割")
    flag = Path("harvest_sessions/ALL_DONE.flag")
    flag.write_text(time.strftime("%Y-%m-%d %H:%M:%S"), encoding="utf-8")
    print(f"[all] 全链完成, 标记 {flag}", flush=True)


if __name__ == "__main__":
    main()
