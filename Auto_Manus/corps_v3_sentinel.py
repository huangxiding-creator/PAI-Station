# -*- coding: utf-8 -*-
"""军团间隙哨兵 (1003 精细调度令) — 每 30min 探测, 条件齐则拉 45min 短班.

动态填充 WeAIPO 用网间隙: 网格班+黄金班是骨架, 哨兵逮住
「WeAIPO 不在用国外网 + 军团锁空 + 日帽未尽 + 收官冷却已过」的
间隙自动接棒 — 自媒体一收工, 军团最快 30min 内跟上.

秒退条件 (任一即退, 零成本, 一行决策日志留痕):
  HALT 旗标 / 军团在跑(锁占) / WeAIPO 在用国外网(精细判据) /
  clash=rule (别人的窗) / 日帽已满 / 上次收官冷却 <25min

pythonw 无控制台 → stdout 重定向哨兵日志; 短班子进程 CREATE_NO_WINDOW.
"""
import json
import os
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).parent
LOG = ROOT / "data" / "corps_v3_sentinel.log"
LAST_END = ROOT / "data" / "corps_v3_last_end.json"
COOLDOWN_S = 25 * 60                  # 收官冷却: 留号间喘息

if sys.stdout is None:                # pythonw: 无控制台
    LOG.parent.mkdir(parents=True, exist_ok=True)
    sys.stdout = open(LOG, "a", buffering=1,
                      encoding="utf-8", errors="replace")
    sys.stderr = sys.stdout


def note(msg: str) -> None:
    print(f"[哨兵 {time.strftime('%Y-%m-%d %H:%M:%S')}] {msg}", flush=True)


def decide():
    """七门全过 → 返回 None (可拉班); 否则返回不拉原因."""
    import corps_v3 as cv

    # 1010 用户令: 军团只在美东 23:00–07:00 跑 — 第一道闸, 窗外零成本秒退
    if not cv.et_window_open():
        return f"美东窗口外 (ET {cv.et_now().strftime('%H:%M')}, 铁律 23-07)"
    if cv.V3_HALTED.is_file():
        return "HALT 旗标在位"
    try:
        old = int(cv.LOCK.read_text().strip())
        if old != os.getpid() and cv._tasklist_alive(old):
            return f"军团在跑 (pid {old})"
    except (OSError, ValueError):
        pass
    if cv.weaipo_net_busy():
        return "WeAIPO 在用国外网"
    if cv.get_mode() == "rule":
        return "clash=rule (别人的窗)"
    led = cv.load_ledger()
    total = sum(led["dispatched"].values())
    squad_size = len(cv.load_squad()) or cv.SQUAD_SIZE   # 全账号名册随规模
    if total >= cv.DAILY_CAP * squad_size:
        return f"日帽已满 ({total}/{cv.DAILY_CAP * squad_size})"
    try:
        last = json.loads(LAST_END.read_text(encoding="utf-8"))
        cool = time.time() - float(last.get("ts", 0))
        if cool < COOLDOWN_S:
            return f"收官冷却中 (剩 {int((COOLDOWN_S - cool) / 60)}min)"
    except Exception:
        pass
    return None


def main() -> int:
    reason = decide()
    if reason:
        note(f"不拉班: {reason}")
        return 0
    # 1010 用户令后: 能过 decide() 就已在美东 23-07 窗内 = 整窗皆黄金窗
    # (旧「非 11-14 点限 4 单保弹药」逻辑废止 — 窗口铁律本身就是弹药保护)
    max_today = 0
    note("七门全过 (含美东窗), 拉短班 (45min/1单)")
    with open(ROOT / "data" / "corps_v3_auto.log", "a", buffering=1,
              encoding="utf-8", errors="replace") as mainlog:
        p = subprocess.run(
            [sys.executable, str(ROOT / "corps_v3.py"),
             "--duration", "45", "--limit", "1",
             "--max-today", str(max_today)],
            cwd=str(ROOT), stdout=mainlog, stderr=subprocess.STDOUT,
            creationflags=0x08000000)  # CREATE_NO_WINDOW
    try:
        LAST_END.write_text(
            json.dumps({"ts": time.time(), "rc": p.returncode}),
            encoding="utf-8")
    except Exception:
        pass
    note(f"短班退出码 {p.returncode}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
