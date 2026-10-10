# -*- coding: utf-8 -*-
"""watch_tech_review_task.py — 总包科技 v1.2.0 审核盯哨 OS 级常驻腿（schtasks TechVerWatch, 每3h）.

与 QianwenCatWatch 同骨架（指令必须严格持久执行铁律: 会话级 cron 会随会话死, OS 层才可靠）:
  PASS/REJECT/SESSION_LOST → 企微通知（只在新旧状态翻转的那一次发）
  CHECKING/ERROR/RELEASED  → 静默只记日志（RELEASED 是终态告知, 首见也发一次）

哨兵纪律: 不盲发外向动作——发布留给会话腿（用户回话后 /wxa/release 或控制台点发布）。
状态: data/state/tech_ver_watch_state.json（last_verdict 翻转判据）
日志: data/state/tech_ver_watch.log
"""
import json
import os
import subprocess
import sys
from datetime import datetime, timedelta, timezone

HERE = os.path.dirname(os.path.abspath(__file__))
STATE = "E:/AI-Station/data/state/tech_ver_watch_state.json"
LOG = "E:/AI-Station/data/state/tech_ver_watch.log"
FLAG = "E:/AI-Station/data/state/tech_ver_pass.flag"
NOTIFY = "E:/AI-Station/tools/notify_wecom.py"
WATCH = os.path.join(HERE, "watch_tech_review_api.py")
CST = timezone(timedelta(hours=8))


def log(line):
    stamp = datetime.now(CST).strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(f"{stamp} {line}\n")


def notify(title, body):
    try:
        subprocess.run(
            [sys.executable, NOTIFY, title, body],
            capture_output=True, timeout=60,
            creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
        )
        log(f"notified: {title}")
    except Exception as e:  # noqa: BLE001 — 通知腿失败如实降级
        log(f"notify-fail {type(e).__name__}: {e}")


def run_watch():
    r = subprocess.run(
        [sys.executable, WATCH],
        capture_output=True, timeout=180,
        creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
    )
    out = (r.stdout or b"").decode("utf-8", errors="replace").strip()
    try:
        return json.loads(out.splitlines()[-1])
    except (IndexError, ValueError):
        return {"verdict": "ERROR", "detail": out[-300:] or f"exit={r.returncode}"}


def main():
    res = run_watch()
    verdict = res.get("verdict", "ERROR")
    log(f"verdict={verdict} detail={res.get('detail', '')[:160]}")

    try:
        with open(STATE, encoding="utf-8") as f:
            prev = json.load(f).get("last_verdict", "")
    except (OSError, ValueError):
        prev = ""

    if verdict == "PASS" and prev != "PASS":
        with open(FLAG, "w", encoding="utf-8") as f:
            json.dump({"at": datetime.now(CST).isoformat(),
                       "detail": res.get("detail", "")}, f, ensure_ascii=False)
        notify("总包科技 v1.2.0 审核通过",
               "总包科技小程序 v1.2.0 审核通过了，待发布！\n"
               "回我一声即发布（发布后线上 1.1.0→1.2.0，旗舰直达带+眼镜页上线）。")
    elif verdict == "REJECT" and prev != "REJECT":
        notify("总包科技 v1.2.0 审核被驳回",
               f"驳回详情：{res.get('detail', '')[:180]}\n需要整改后重提，我等你指令。")
    elif verdict == "SESSION_LOST" and prev != "SESSION_LOST":
        notify("总包科技盯哨登录态失效",
               "版本管理页登录态过期，盯哨暂时失明。需要重新登录 mp 控制台（可能要扫码）。")
    elif verdict == "RELEASED" and prev != "RELEASED":
        notify("总包科技 v1.2.0 已发布", "线上版本已是 1.2.0，收工。")

    with open(STATE, "w", encoding="utf-8") as f:
        json.dump({"last_verdict": verdict,
                   "at": datetime.now(CST).isoformat()}, f, ensure_ascii=False)
    return 0


if __name__ == "__main__":
    sys.exit(main())
