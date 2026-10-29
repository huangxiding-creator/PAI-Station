# -*- coding: utf-8 -*-
"""tests/organ_smoke.py — 器官层生命周期冒烟（W2.2 验收）。

自建假器官(极简心跳daemon)+私有注册表，走完整生命周期：
  no_lock → spawn → healthy → kill → process_dead → respawn → healthy
全程不触碰真实 zqg 器官。产物目录 tests/.organ-smoke-work/ 只增不删（站规）。
运行: py -X utf8 tests\\organ_smoke.py
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
WORK = Path(__file__).resolve().parent / ".organ-smoke-work"
PYTHONW = "E:/AI-Station/.venv/Scripts/pythonw.exe"

FAKE_ORGAN = '''\
# -*- coding: utf-8 -*-
import json, os, time
from pathlib import Path
lock = Path(__file__).resolve().parent / "state" / "daemon.lock"
lock.parent.mkdir(exist_ok=True)
while True:
    lock.write_text(json.dumps({"pid": os.getpid(), "hb": time.time()}), encoding="utf-8")
    time.sleep(5)
'''


def _py(args, **kw):
    return subprocess.run([sys.executable, "-X", "utf8", *args],
                          capture_output=True, text=True, encoding="utf-8",
                          errors="replace", **kw)


def _probe(reg, expect_rc, label):
    r = _py([str(ROOT / "organ_probe.py"), "--registry", str(reg), "--organ", "fake"])
    ok = r.returncode == expect_rc and r.stdout.strip()
    print(f"[probe:{label}] rc={r.returncode} out={r.stdout.strip()[:160]}")
    assert ok, f"{label}: 期望rc={expect_rc} 实得rc={r.returncode} err={r.stderr[:200]}"
    return json.loads(r.stdout.strip().splitlines()[-1])


def _start(reg, label):
    r = _py([str(ROOT / "organ_start.py"), "--registry", str(reg), "--organ", "fake"])
    print(f"[start:{label}] rc={r.returncode} out={r.stdout.strip()[:200]}")
    assert r.returncode in (0, 2), f"{label}: organ_start 异常退出 rc={r.returncode}"
    return json.loads(r.stdout.strip().splitlines()[-1])


def _kill_fake(lock: Path):
    pid = json.loads(lock.read_text(encoding="utf-8"))["pid"]
    subprocess.run(["taskkill", "/F", "/PID", str(pid)], capture_output=True)
    time.sleep(1)
    return pid


def main() -> int:
    if not Path(PYTHONW).exists():
        print(f"SKIP: 假器官解释器不存在 {PYTHONW}")
        return 0
    WORK.mkdir(exist_ok=True)
    (WORK / "state").mkdir(exist_ok=True)
    (WORK / "ledger").mkdir(exist_ok=True)
    (WORK / "fake_organ.py").write_text(FAKE_ORGAN, encoding="utf-8")
    reg = WORK / "reg.json"
    reg.write_text(json.dumps({"organs": [{
        "id": "fake", "name": "冒烟假器官", "workdir": str(WORK).replace("\\", "/"),
        "start_cmd": [PYTHONW, "-X", "utf8", "fake_organ.py"],
        "lock_file": "state/daemon.lock", "ledger_dir": "ledger",
        "stdout_log": "state/daemon_stdout.log", "stale_sec": 20,
    }]}, ensure_ascii=False), encoding="utf-8")
    lock = WORK / "state" / "daemon.lock"

    # 1) 未启动 → no_lock（重跑容忍上次残留的 hb_stale 锁）, 探针退出码 2
    r1 = _probe(reg, 2, "未启动")
    assert r1["verdict"] in ("no_lock", "hb_stale"), r1

    # 2) 幂等拉起 → spawned → healthy
    s1 = _start(reg, "首次拉起")
    assert s1["action"] == "spawned" and s1["healthy"], s1
    r2 = _probe(reg, 0, "拉起后")
    assert r2["verdict"] == "healthy" and r2["pid"], r2

    # 3) 健康时再拉起 → skip_healthy（幂等不重复spawn）
    s2 = _start(reg, "健康复拉")
    assert s2["action"] == "skip_healthy", s2

    # 4) 杀进程 → process_dead（hb新鲜<20s但pid不在）
    killed = _kill_fake(lock)
    r3 = _probe(reg, 2, "进程死亡")
    assert r3["verdict"] == "process_dead" and r3["pid"] == killed, r3

    # 5) 守护节奏复活 → respawn → healthy
    s3 = _start(reg, "崩溃复活")
    assert s3["action"] == "spawned" and s3["healthy"], s3
    r4 = _probe(reg, 0, "复活后")
    assert r4["verdict"] == "healthy", r4

    # 6) --summary 人读短串可用
    r5 = _py([str(ROOT / "organ_probe.py"), "--registry", str(reg),
              "--organ", "fake", "--summary"])
    print(f"[probe:summary] {r5.stdout.strip()}")
    assert "fake:healthy" in r5.stdout, r5.stdout

    _kill_fake(lock)                        # 收尾：停掉假器官（进程管理，非文件删除）
    print("PASS: 器官层生命周期 no_lock→spawn→healthy→kill→process_dead→respawn→healthy 全绿")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
