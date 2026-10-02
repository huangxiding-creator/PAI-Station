# -*- coding: utf-8 -*-
"""收割衔接器 — 军团闲窗自动触发 harvest_all (0926).

背景: 昨夜 63 单 collect 完成件欠收 (webhook 通道 09-24 11:45 后断流,
hook_harvest 无米下锅), 须走 API 面收割. 但 session_harvester 与军团
共用 9333 浏览器, 军团在跑时收割 = 互踩 (0926 晨 probe×corps 同款事故).

触发条件 (用户 0917 令「预备就位+自动触发」): 守卫 state 显示
mode=direct 且 corps_running=false, 连续 2 拍 (10min) 确认 — direct 态
= 守卫已收线 (额度尽/登录墙收官/让路), 轮间隙不会误触 (间隙期 mode
仍为 rule). 触发后一次性跑 harvest_all.py, 写 done 旗标, 退出.
幂等: done 旗标在即退出, 重跑无副作用.
"""
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).parent
STATE = ROOT / "data" / "yield_guard_state.json"
DONE = ROOT / "harvest_sessions" / "HARVEST_AFTER_QUOTA.done"
LOG = ROOT / "data" / "harvest_watch.log"
POLL_S = 300
PY = sys.executable


def log(msg: str) -> None:
    with LOG.open("a", encoding="utf-8") as f:
        f.write(f"[{time.strftime('%m-%d %H:%M:%S')}] {msg}\n")
    print(msg, flush=True)


def idle_state() -> bool:
    """守卫 direct + 军团停 = 收线态 (浏览器闲窗)."""
    try:
        st = json.loads(STATE.read_text(encoding="utf-8"))
        return st.get("mode") == "direct" and st.get("corps_running") is False
    except Exception:
        return False


def main() -> int:
    if DONE.is_file():
        log("done 旗标在, 无事可做")
        return 0
    log("收割衔接器上岗: 等 direct+停 双拍确认")
    streak = 0
    while True:
        if idle_state():
            streak += 1
        else:
            streak = 0
        if streak >= 2:
            break
        time.sleep(POLL_S)
    log("闲窗确认 → harvest_all 启动 (manifest 幂等, 断点续跑)")
    r = subprocess.run([PY, str(ROOT / "harvest_all.py")], cwd=str(ROOT))
    log(f"harvest_all 退出码 {r.returncode}")
    DONE.parent.mkdir(parents=True, exist_ok=True)
    DONE.write_text(time.strftime("%Y-%m-%d %H:%M:%S"), encoding="utf-8")
    log("done 旗标落盘, 衔接器退岗")
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
