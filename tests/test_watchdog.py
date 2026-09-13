"""M1.3 看护器：判活铁律 v3 移植 + 死→杀残尸→分离重拉 + 3 轮告警。"""
import json
import os
import subprocess
import sys
import time

import pytest

from paistation.resident.watchdog import (
    LivenessJudge,
    ProcInfo,
    Verdict,
    Watchdog,
)

# 弹窗/泄漏教训（2026-09-13）：mintty 下无控制台父进程 spawn 的 python.exe
# 会各自新开可见控制台；venv python.exe 是蹦床（再 spawn 基础解释器），
# 心跳 pid ≠ Popen pid，teardown 只杀一方就漏一串永生进程+常驻窗口。
# 对策：①daemon 直接用基础解释器（单进程，pid 可对上）；
# ②全部子进程 CREATE_NO_WINDOW（弹窗绝迹）；③teardown 重试读心跳 +
# 双 pid 无条件 /T 整树击杀 + 断言死透（再泄漏直接红测试）。
_BASE_PY = getattr(sys, "_base_executable", sys.executable)
_NO_WINDOW = subprocess.CREATE_NO_WINDOW if os.name == "nt" else 0


def _write_hb(path, seq=1, note="tick#1", pid=None, age=0.0):
    data = {"pid": pid or os.getpid(), "ts": time.time() - age,
            "seq": seq, "note": note, "leg": "pai-daemon"}
    path.write_text(json.dumps(data), encoding="utf-8")
    old = time.time() - age
    os.utime(path, (old, old))


# ---- 判活矩阵（纯逻辑）----

def test_judge_alive_when_fresh_evidence_proc(tmp_path):
    p = tmp_path / "heartbeat.json"
    _write_hb(p, seq=5, note="tick#5")
    assert LivenessJudge().judge(p, proc_alive=True) == Verdict.ALIVE


def test_judge_stale_heartbeat_means_hung(tmp_path):
    """进程在但心跳过期=挂死（v2 教训：挂起腿骗不过新鲜度）。"""
    p = tmp_path / "heartbeat.json"
    _write_hb(p, seq=5, note="tick#5", age=9999)
    assert LivenessJudge().judge(p, proc_alive=True) == Verdict.DEAD_STALE


def test_judge_boot_note_without_progress_is_dead(tmp_path):
    """启动头行无进展证据=判死（v3 教训：挂起腿刷 mtime 骗过新鲜度）。"""
    p = tmp_path / "heartbeat.json"
    _write_hb(p, seq=0, note="boot")
    assert LivenessJudge().judge(p, proc_alive=True) == Verdict.DEAD_NO_EVIDENCE


def test_judge_no_heartbeat_dead(tmp_path):
    assert LivenessJudge().judge(tmp_path / "nope.json",
                                 proc_alive=False) == Verdict.DEAD_NO_HEARTBEAT


def test_judge_paused_note_counts_alive(tmp_path):
    """paused 心跳=人工熔断中，进程健在——绝不重拉。"""
    p = tmp_path / "heartbeat.json"
    _write_hb(p, seq=7, note="paused")
    assert LivenessJudge().judge(p, proc_alive=True) == Verdict.PAUSED


def test_judge_dead_heartbeat_with_live_proc_still_dead(tmp_path):
    p = tmp_path / "heartbeat.json"
    _write_hb(p, seq=9, note="tick#9", age=9999)
    v = LivenessJudge().judge(p, proc_alive=True)
    assert v == Verdict.DEAD_STALE  # 残尸也要清（kill 后重拉）


# ---- 进程存在探测 ----

def test_proc_exists_true_for_current():
    assert ProcInfo.exists(os.getpid()) is True


def test_proc_exists_false_after_reap():
    proc = subprocess.Popen([sys.executable, "-c", "import sys; sys.exit(0)"],
                            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP
                            | _NO_WINDOW)
    pid = proc.pid
    proc.wait(timeout=10)
    # 已退出的 PID：Windows 会残留句柄直到 reap；OpenProcess 可能仍成功
    # 但 GetExitCodeProcess != STILL_ACTIVE → 判不存在
    assert ProcInfo.exists(pid) is False


# ---- 真进程自愈（WBS 1.3 验收：杀进程→看护器重拉）----

HB_CHILD = (
    "import json,os,time,sys\n"
    "p=sys.argv[1]\n"
    "seq=0\n"
    "while True:\n"
    "    seq+=1\n"
    "    d={'pid':os.getpid(),'ts':time.time(),'seq':seq,'note':'tick#%d'%seq,"
    "'leg':'pai-daemon'}\n"
    "    open(p,'w',encoding='utf-8').write(json.dumps(d))\n"
    "    time.sleep(0.05)\n"
)


@pytest.fixture()
def child_env(tmp_path):
    hb = tmp_path / "heartbeat.json"
    cmd = [_BASE_PY, "-c", HB_CHILD, str(hb)]
    proc = subprocess.Popen(cmd, creationflags=_NO_WINDOW)
    deadline = time.time() + 10
    while not hb.exists() and time.time() < deadline:
        time.sleep(0.05)
    yield hb, cmd, proc
    # 收尾：心跳并发非原子写（50ms 一刷）——重试解析防半截 JSON 竞态；
    # 双 pid 无条件 /T 整树击杀（含看护器重拉的新 daemon）
    pid = None
    for _ in range(6):
        try:
            pid = json.loads(hb.read_text(encoding="utf-8"))["pid"]
            break
        except (OSError, json.JSONDecodeError, ValueError):
            time.sleep(0.05)
    for victim in {proc.pid, pid}:
        if victim:
            subprocess.run(["taskkill", "/PID", str(victim), "/F", "/T"],
                           capture_output=True, creationflags=_NO_WINDOW)
    deadline = time.time() + 3
    while time.time() < deadline and (ProcInfo.exists(proc.pid)
                                      or (pid and ProcInfo.exists(pid))):
        time.sleep(0.1)
    assert not ProcInfo.exists(proc.pid), "daemon 未死透（弹窗泄漏复现）"
    if pid:
        assert not ProcInfo.exists(pid), "重拉 daemon 未死透（弹窗泄漏复现）"


def test_watchdog_relanches_killed_daemon(child_env):
    hb, cmd, proc = child_env
    wd = Watchdog(data_dir=hb.parent, relaunch_cmd=cmd, limit=30.0)
    # 健在：不动
    assert wd.check_once() == Verdict.ALIVE
    assert wd.fails == 0
    # 杀死
    subprocess.run(["taskkill", "/PID", str(proc.pid), "/F", "/T"],
                   capture_output=True, creationflags=_NO_WINDOW)
    proc.wait(timeout=10)
    # 心跳拨旧避免竞态判活
    old = time.time() - 999
    os.utime(hb, (old, old))
    verdict = wd.check_once()
    assert verdict == Verdict.DEAD_STALE
    assert wd.fails == 1
    # 重拉的新进程开始写心跳
    deadline = time.time() + 15
    relaunched = False
    while time.time() < deadline:
        try:
            data = json.loads(hb.read_text(encoding="utf-8"))
            if data["pid"] != proc.pid and data["seq"] > 0:
                relaunched = True
                break
        except Exception:  # noqa: BLE001
            pass
        time.sleep(0.1)
    assert relaunched, "看护器未重拉死亡 daemon"


def test_watchdog_fail_cap_alerts_and_cools_down(tmp_path):
    """连续 3 次重拉失败 → 告警文件 + 冷却期不再拉。"""
    never = [sys.executable, "-c", HB_CHILD.replace("while True", "sys.exit(1)\nwhile True")]
    # 更直接：一个立刻退出、永不写心跳的命令
    never = [sys.executable, "-c", "import sys; sys.exit(1)"]
    wd = Watchdog(data_dir=tmp_path, relaunch_cmd=never, limit=30.0)
    for _ in range(3):
        wd.check_once()
    assert wd.fails >= 3
    assert (tmp_path / "watchdog_alert.json").exists()
    # 冷却期内：即使再判死也不重拉
    before = wd.relaunch_count
    wd.check_once()
    assert wd.relaunch_count == before


def test_watchdog_paused_daemon_not_relaunched(tmp_path):
    """PAUSE 心跳：永不重拉（人工熔断不能被机器顶掉）。"""
    hb = tmp_path / "heartbeat.json"
    _write_hb(hb, seq=2, note="paused")
    wd = Watchdog(data_dir=tmp_path, relaunch_cmd=["cmd", "/c", "exit"], limit=30.0)
    assert wd.check_once() == Verdict.PAUSED
    assert wd.relaunch_count == 0
