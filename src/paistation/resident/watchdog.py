"""M1.3 看护器（ADR-1）：判活铁律 v3 移植 + 死→杀残尸→分离重拉→告警。

生产形态：schtasks MINUTE 触发 `python -m paistation.resident.watchdog --once`
（判一次即退，无自身常驻进程可挂）；开发/测试可用 run_forever()。
判活铁律（NJSupervisor 三版教训直系移植）：
  v1 死法：同名脚本进程计数不可信（腿互顶）；
  v2 死法：日志新鲜度可被挂起腿的启动头行骗过；
  v3 铁律：进程存在 ∧ 心跳新鲜 ∧ 尾行进展证据，缺一即判死。
paused 心跳=人工熔断，永不重拉（熔断不能被机器顶掉）。
"""
from __future__ import annotations

import ctypes
import json
import logging
import os
import subprocess
import time
from enum import Enum

from paistation.resident.daemon import Heartbeat

_log = logging.getLogger("paistation.resident.watchdog")

STILL_ACTIVE = 259
PROCESS_QUERY_LIMITED_INFORMATION = 0x1000
ALERT_FILE = "watchdog_alert.json"
FAIL_CAP = 3
COOLDOWN_S = 1800.0  # 连败熔断后的冷却期（半小时内不重拉只告警）


class Verdict(Enum):
    ALIVE = "alive"
    PAUSED = "paused"
    DEAD_STALE = "dead_stale"            # 进程在但心跳过期=挂死
    DEAD_NO_EVIDENCE = "dead_no_evidence"  # 只有启动头行，无进展
    DEAD_NO_HEARTBEAT = "dead_no_heartbeat"  # 心跳文件都没有
    DEAD_PROC_GONE = "dead_proc_gone"    # 心跳在但进程没了


class ProcInfo:
    """OpenProcess+GetExitCodeProcess 探活（不依赖 psutil）。"""

    @staticmethod
    def exists(pid: int) -> bool:
        if pid <= 0:
            return False
        handle = ctypes.windll.kernel32.OpenProcess(
            PROCESS_QUERY_LIMITED_INFORMATION, False, pid)
        if not handle:
            return False
        try:
            code = ctypes.c_ulong()
            if not ctypes.windll.kernel32.GetExitCodeProcess(handle,
                                                             ctypes.byref(code)):
                return False
            return code.value == STILL_ACTIVE
        finally:
            ctypes.windll.kernel32.CloseHandle(handle)

    @staticmethod
    def kill_tree(pid: int) -> None:
        subprocess.run(["taskkill", "/PID", str(pid), "/T", "/F"],
                       capture_output=True)


class LivenessJudge:
    def __init__(self, limit: float = 150.0):
        self._limit = limit

    def judge(self, hb_path, proc_alive: bool) -> Verdict:
        try:
            data = Heartbeat.read(hb_path)
        except (OSError, json.JSONDecodeError, ValueError):
            return Verdict.DEAD_NO_HEARTBEAT
        if data.get("note") == "paused":
            return Verdict.PAUSED if proc_alive else Verdict.DEAD_PROC_GONE
        if not Heartbeat.is_fresh(hb_path, limit=self._limit):
            return Verdict.DEAD_STALE
        if not Heartbeat.evidence_ok(data):
            return Verdict.DEAD_NO_EVIDENCE
        return Verdict.ALIVE if proc_alive else Verdict.DEAD_PROC_GONE


class Watchdog:
    """单次判定+按需重拉。fails 连达 FAIL_CAP → 告警+冷却。"""

    def __init__(self, data_dir, relaunch_cmd: list, limit: float = 150.0,
                 fail_cap: int = FAIL_CAP, cooldown_s: float = COOLDOWN_S):
        self.data_dir = str(data_dir)
        self.relaunch_cmd = list(relaunch_cmd)
        self._judge = LivenessJudge(limit=limit)
        self._fail_cap = fail_cap
        self._cooldown_s = cooldown_s
        self._last_relaunch = 0.0
        self.fails = 0
        self.relaunch_count = 0
        self._hb_path = os.path.join(self.data_dir, "heartbeat.json")

    def check_once(self) -> Verdict:
        pid = self._heartbeat_pid()
        proc_alive = ProcInfo.exists(pid) if pid else False
        verdict = self._judge.judge(self._hb_path, proc_alive)
        if verdict in (Verdict.ALIVE, Verdict.PAUSED):
            if verdict == Verdict.ALIVE:
                self.fails = 0  # 真活才清零；PAUSED 期间保持原计数
            return verdict
        # 判死：先清残尸（进程在但挂死），再分离重拉
        if verdict in (Verdict.DEAD_STALE, Verdict.DEAD_NO_EVIDENCE) and pid:
            _log.warning("残尸清理: pid=%s verdict=%s", pid, verdict.value)
            ProcInfo.kill_tree(pid)
        if self._in_cooldown():
            _log.warning("冷却期内不重拉（fails=%d）", self.fails)
            return verdict
        self._relaunch()
        return verdict

    def _in_cooldown(self) -> bool:
        if self.relaunch_count < self._fail_cap:
            return False
        return time.time() - self._last_relaunch < self._cooldown_s

    def _relaunch(self) -> None:
        self.fails += 1
        self.relaunch_count += 1
        self._last_relaunch = time.time()
        _log.warning("daemon 判死，第 %d 次分离重拉", self.fails)
        subprocess.Popen(
            self.relaunch_cmd,
            creationflags=(subprocess.DETACHED_PROCESS
                           | subprocess.CREATE_NEW_PROCESS_GROUP
                           | subprocess.CREATE_BREAKAWAY_FROM_JOB),
            close_fds=True,
            cwd=os.path.dirname(self.relaunch_cmd[0]) or None,
        )
        if self.fails >= self._fail_cap:
            self._alert()

    def _alert(self) -> None:
        payload = {"ts": time.time(), "fails": self.fails,
                   "relaunch_count": self.relaunch_count,
                   "note": "看护器连续重拉失败，进入冷却期——需要人工介入"}
        path = os.path.join(self.data_dir, ALERT_FILE)
        with open(path, "w", encoding="utf-8") as fh:
            json.dump(payload, fh, ensure_ascii=False)
        _log.error("告警落盘: %s", path)

    def _heartbeat_pid(self) -> int | None:
        try:
            return int(Heartbeat.read(self._hb_path).get("pid", 0))
        except (OSError, json.JSONDecodeError, ValueError, TypeError):
            return None

    def run_forever(self, interval: float = 60.0) -> None:
        while True:
            try:
                self.check_once()
            except Exception as exc:  # noqa: BLE001 - 看护器自身绝不退出
                _log.exception("看护轮异常（继续）: %s", exc)
            time.sleep(interval)


def main() -> int:
    """schtasks 入口：判一次即退。`--interval` 供开发自跑。"""
    import argparse
    import sys

    parser = argparse.ArgumentParser(description="PAI-Station 看护器")
    parser.add_argument("--data-dir", default=None)
    parser.add_argument("--interval", type=float, default=None,
                        help="给定时进入常驻轮询（开发用）；缺省判一次即退")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO,
                        format="%(asctime)s %(levelname)s %(name)s %(message)s")
    data_dir = args.data_dir or os.environ.get(
        "PAI_STATION_DATA_DIR",
        os.path.join(os.environ.expandvars("%APPDATA%"), "PAI-Station"))
    # 重拉命令：模块方式启动 daemon（数据目录随环境走）
    relaunch = [sys.executable, "-m", "paistation.resident.entry", "daemon",
                "--data-dir", data_dir]
    wd = Watchdog(data_dir, relaunch)
    if args.interval:
        wd.run_forever(args.interval)
        return 0
    return 0 if wd.check_once() in (Verdict.ALIVE, Verdict.PAUSED) else 1
