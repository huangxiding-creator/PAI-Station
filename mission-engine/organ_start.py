# -*- coding: utf-8 -*-
"""organ_start.py — 引擎器官幂等启动器（W2.2）。

读 organs.json；逐器官先探针，健康→跳过；不健康→按 start_cmd 拉起
（DETACHED_PROCESS|CREATE_NO_WINDOW，stdout 追加到器官日志），3s 后复探。
幂等：器官自带单例锁（zqg daemon.lock），重复拉起由器官自弃权退出。

复活语义：进程死亡但心跳未过期(<stale_sec)时，zqg 自身拒绝接管，最长等
心跳自然过期——点火/守护(guard 5min)/循环启动三路节奏兜底；器官层不代删
锁文件（站规删除铁律）。退出码：0=全健康或已尽力拉起  2=拉起失败或复探仍不健康。
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

from organ_probe import ROOT, probe_organ

FLAGS = (getattr(subprocess, "DETACHED_PROCESS", 0)
         | getattr(subprocess, "CREATE_NO_WINDOW", 0)
         | getattr(subprocess, "CREATE_NEW_PROCESS_GROUP", 0))


def start_organ(organ: dict) -> dict:
    before = probe_organ(organ)
    if before["healthy"]:
        return {"organ": organ["id"], "action": "skip_healthy",
                "verdict": before["verdict"], "pid": before.get("pid")}
    workdir = Path(organ["workdir"])
    log_path = workdir / organ.get("stdout_log", "state/daemon_stdout.log")
    log_path.parent.mkdir(parents=True, exist_ok=True)
    try:
        with open(log_path, "ab") as lf:
            subprocess.Popen(organ["start_cmd"], cwd=str(workdir),
                             stdin=subprocess.DEVNULL, stdout=lf,
                             stderr=subprocess.STDOUT,
                             creationflags=FLAGS, close_fds=True)
    except OSError as e:
        return {"organ": organ["id"], "action": "start_failed", "err": str(e)[:200]}
    time.sleep(3)                           # 等器官写锁落地（弃权/接管均在秒级）
    after = probe_organ(organ)
    return {"organ": organ["id"], "action": "spawned",
            "before": before["verdict"], "after": after["verdict"],
            "pid": after.get("pid"), "healthy": after["healthy"]}


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="organ_start")
    ap.add_argument("--organ", action="append", help="只启指定器官（可重复；默认全部）")
    ap.add_argument("--registry", default=str(ROOT / "organs.json"))
    args = ap.parse_args(argv)
    try:
        reg = json.loads(Path(args.registry).read_text(encoding="utf-8"))
        organs = [o for o in reg.get("organs", [])
                  if not args.organ or o.get("id") in args.organ]
    except (OSError, ValueError) as e:
        print(json.dumps({"start_error": str(e)[:200]}, ensure_ascii=False))
        return 1
    worst = 0
    for o in organs:
        r = start_organ(o)
        if r.get("action") == "start_failed" or r.get("healthy") is False:
            worst = 2
        print(json.dumps(r, ensure_ascii=False, separators=(",", ":")))
    return worst


if __name__ == "__main__":
    sys.exit(main())
