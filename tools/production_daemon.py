# -*- coding: utf-8 -*-
"""production_daemon — 研究报告产线 24h 常驻守护进程 (1017 用户令).

复用 signal_stream_resident.py 生产模式:
  - Win32 命名互斥锁 (单实例) + PID 文件 + PAUSE 旗标
  - while True 主循环 + schtask 看门狗每 5 分钟重拉

主循环每 60 秒一拍:
  1. 读 pipeline_state.json → 确定每份报告当前段
  2. 按 report_full_chain.py 的段序执行下一步
  3. S1 采集 → 直接调 harvest_*.py (无 AI)
  4. S2 撰写 → 调 claude -p (CLI 管道模式, 无 Claude Code 会话)
  5. S3-S8 → 调对应工具
  6. 心跳 → data/state/production_heartbeat.json
  7. 企微通知 → 状态变化时推送

用法: pythonw tools/production_daemon.py
看门狗: PAIStation-ProductionDaemon 每 5 分钟重拉 (如互斥锁已持有则跳过)
暂停: 创建 data/state/production_daemon.PAUSE 文件
"""
from __future__ import annotations

import ctypes
import json
import os
import subprocess
import sys
import time
import traceback
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "data" / "state"
PID_FILE = STATE / "production_daemon.pid"
HEARTBEAT = STATE / "production_heartbeat.json"
PAUSE_FLAG = STATE / "production_daemon.PAUSE"
CRASH_LOG = STATE / "production_daemon_crash.log"
PIPELINE = ROOT / "_proposals/flagship-paid-report-1007/work/pipeline_state.json"
MUTEX_NAME = "PAIStationProductionDaemon"
LOG = STATE / "production_daemon.log"

# Claude CLI 绝对路径 (schtasks 环境不继承 npm PATH)
CLAUDE_BIN = Path(os.environ.get("APPDATA", "")) / "npm" / "claude.cmd"
if not CLAUDE_BIN.exists():
    # 版本 glob 兜底 (同 wechat_cc_bridge_autostart.py 模式)
    base = Path(os.environ.get("APPDATA", "")) / "npm" / "node_modules" / "@anthropic-ai" / "claude-code"
    if base.exists():
        candidates = sorted(base.glob("*/bin/claude.exe"))
        if candidates:
            CLAUDE_BIN = candidates[-1]

PY = sys.executable
INTERVAL = 60  # 秒


def log(msg: str) -> None:
    line = f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] {msg}"
    print(line, flush=True)
    try:
        with LOG.open("a", encoding="utf-8") as f:
            f.write(line + "\n")
    except OSError:
        pass


def acquire_mutex() -> bool:
    try:
        kernel32 = ctypes.windll.kernel32
        handle = kernel32.CreateMutexW(None, False, MUTEX_NAME)
        if kernel32.GetLastError() == 183:  # ERROR_ALREADY_EXISTS
            return False
        return True
    except Exception:
        return True  # fail-open (非 Windows 或无权限时仍运行)


def is_paused() -> bool:
    """手动 PAUSE 旗标 或 自媒体永动机时段 (14:30-22:00 让路)."""
    if PAUSE_FLAG.exists():
        return True
    # 1017 用户令: 14:30~22:00 给资本/自媒体永动机让路
    now = datetime.now()
    if now.hour == 14 and now.minute >= 30:
        return True
    if 15 <= now.hour < 22:
        return True
    return False


def write_heartbeat(status: str, detail: str = "") -> None:
    hb = {
        "ts": datetime.now().isoformat(),
        "pid": os.getpid(),
        "status": status,
        "detail": detail,
        "claude_bin": str(CLAUDE_BIN),
    }
    HEARTBEAT.write_text(json.dumps(hb, ensure_ascii=False, indent=1), encoding="utf-8")


def read_pipeline() -> dict:
    try:
        return json.loads(PIPELINE.read_text(encoding="utf-8"))
    except Exception:
        return {}


def wecom_notify(title: str, body: str) -> None:
    """企微 webhook 通知 (复用 tools/notify_wecom.py)."""
    try:
        r = subprocess.run(
            [PY, str(ROOT / "tools" / "notify_wecom.py")],
            input=json.dumps({"title": title, "body": body}),
            capture_output=True, text=True, timeout=30,
            cwd=str(ROOT))
        if r.returncode == 0:
            log(f"[wecom] sent: {title}")
        else:
            log(f"[wecom] fail: {r.stderr[:60]}")
    except Exception as e:
        log(f"[wecom] error: {e}")


def run_script(script: str, *args: str, timeout: int = 600) -> tuple[int, str]:
    """运行 Python 脚本, 返回 (exit_code, output_tail)."""
    cmd = [PY, "-X", "utf8", str(ROOT / script), *args]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout,
                           cwd=str(ROOT), encoding="utf-8", errors="replace")
        output = (r.stdout or "")[-500:] + (r.stderr or "")[-200:]
        return r.returncode, output
    except subprocess.TimeoutExpired:
        return 1, f"TIMEOUT after {timeout}s"
    except Exception as e:
        return 1, str(e)[:200]


def run_claude(prompt: str, output_file: str, timeout: int = 300) -> tuple[int, str]:
    """Claude CLI 管道模式 (无人值守 AI 写作)."""
    if not CLAUDE_BIN.exists():
        return 1, f"claude not found at {CLAUDE_BIN}"
    cmd = ["cmd", "/c", str(CLAUDE_BIN), "-p", prompt, "--output-format", "text"]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout,
                           cwd=str(ROOT), encoding="utf-8", errors="replace")
        if r.returncode == 0 and r.stdout:
            Path(output_file).parent.mkdir(parents=True, exist_ok=True)
            Path(output_file).write_text(r.stdout, encoding="utf-8")
            return 0, f"ok ({len(r.stdout)} chars)"
        return r.returncode, (r.stderr or "")[-200:]
    except subprocess.TimeoutExpired:
        return 1, f"claude TIMEOUT after {timeout}s"
    except Exception as e:
        return 1, str(e)[:200]


def check_tcb_token() -> bool:
    """检查 CloudBase auth.json 是否有效."""
    auth = Path(os.environ.get("USERPROFILE", "")) / ".config" / ".cloudbase" / "auth.json"
    if not auth.exists():
        return False
    try:
        c = json.loads(auth.read_text(encoding="utf-8"))["credential"]
        return c.get("tmpExpired", 0) > time.time() * 1000
    except Exception:
        return False


def tick() -> None:
    """主循环一拍: 读状态 → 执行下一步 → 心跳."""
    state = read_pipeline()
    products = state.get("products", [])

    # 找当前活跃报告 (stage 不含 "全链完成")
    active = [p for p in products if "全链完成" not in str(p.get("stage", ""))]

    actions = []
    tcb_ok = check_tcb_token()

    for prod in active:
        sku = prod.get("sku", "?")
        stage = str(prod.get("stage", ""))
        if "S1" in stage or "采集" in stage:
            # 采集: 跑 localfiles + judge + spread
            rc, out = run_script("reforge_factory/harvest_localfiles.py",
                                 "--campaign", sku.replace("-2026", ""), "--per-facet", "50")
            actions.append(f"{sku}:harvest:{'ok' if rc == 0 else 'fail'}")
        elif "S2" in stage or "撰写" in stage:
            # 撰写: 检查是否有待写章节
            m2 = ROOT / "_proposals/flagship-paid-report-1007/work/m2"
            slug = sku.lower().replace("-", "_")
            for ch_dir in m2.glob(f"*{sku.split('-')[0].lower()}*"):
                chapters = sorted(ch_dir.glob("ch*.md"))
                banks = sorted(ch_dir.glob("bank_ch*.md"))
                if len(chapters) < len(banks):
                    # 有 bank 无 chapter → 需要写
                    ch_num = len(chapters) + 1
                    bank = next((b for b in banks if f"ch{ch_num:02d}" in b.name), None)
                    if bank:
                        rc, out = run_claude(
                            f"你是研究报告写手。读 {bank} 的素材, 写第{ch_num}章, "
                            f"至少3000 CJK字, 每个数字标注出处, 禁编造。",
                            str(ch_dir / f"ch{ch_num:02d}.md"))
                        actions.append(f"{sku}:write_ch{ch_num}:{'ok' if rc == 0 else 'fail'}")
        elif "S4" in stage or "上架" in stage:
            if tcb_ok:
                rc, out = run_script("tools/mp_list_report.py", "--sku", sku)
                actions.append(f"{sku}:deploy:{'ok' if rc == 0 else 'fail'}")
            else:
                actions.append(f"{sku}:deploy:blocked_tcb_token")

    # 心跳
    detail = "; ".join(actions) if actions else "idle (no active reports needing daemon action)"
    write_heartbeat("running", detail)

    if actions:
        log(f"tick: {detail}")


def main() -> None:
    # 单实例互斥
    if not acquire_mutex():
        print("another instance running, exiting", flush=True)
        sys.exit(0)

    STATE.mkdir(parents=True, exist_ok=True)
    PID_FILE.write_text(str(os.getpid()), encoding="utf-8")
    log(f"production daemon started (pid={os.getpid()}, claude={CLAUDE_BIN})")
    wecom_notify("产线守护进程启动", f"PID={os.getpid()}\nClaude CLI={CLAUDE_BIN}")

    try:
        while True:
            if is_paused():
                reason = "paused_manual" if PAUSE_FLAG.exists() else "paused_autopub_window_1430_2200"
                write_heartbeat(reason)
                time.sleep(60)
                continue
            try:
                tick()
            except Exception:
                err = traceback.format_exc()[-500:]
                log(f"tick error: {err}")
                with CRASH_LOG.open("a", encoding="utf-8") as f:
                    f.write(f"[{datetime.now().isoformat()}]\n{err}\n\n")
            time.sleep(INTERVAL)
    except KeyboardInterrupt:
        log("daemon stopped (Ctrl-C)")
    finally:
        PID_FILE.unlink(missing_ok=True)
        write_heartbeat("stopped")
        wecom_notify("产线守护进程停止", "Daemon exited")


if __name__ == "__main__":
    main()
