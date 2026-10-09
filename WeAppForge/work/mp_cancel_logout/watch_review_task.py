# -*- coding: utf-8 -*-
"""watch_review_task.py — 提审结果盯哨 OS 级常驻腿（schtasks QianwenReviewWatch, 每2h）.

克隆 watch_category_task.py 骨架（「指令必须严格持久执行」铁律：OS 层 schtasks）。
判据与 watch_review_browser.py 同源（subprocess 复用同一文件，杜绝两份逻辑漂移；
get_latest_auditstatus 是第三方平台专属端点 86000 实证 → 自研号只能浏览器腿读版本行）：
  APPROVED = 审核通过/已发布（发布六步清单在 HANDOFF §六）
  REJECTED = 审核被拒
  PENDING  = 审核中 / SKIP=9336 不在跑 / AUTH_EXPIRED=mp 登录态失效
  ERROR    = 异常（均静默，下轮再试；AUTH_EXPIRED 进 state 供会话腿看到）

动作面（静默纪律：终态才扰民，且只在状态翻转的那一次发；发布是外向不可逆动作，
绝不由盯哨盲发——APPROVED 只通知，六步清单留给会话腿逐字执行）：
  APPROVED 翻转 → 企微通知 + 立 flag data/state/mp_review_approved.flag
  REJECTED 翻转 → 企微通知（指引控制台看原因）+ flag data/state/mp_review_rejected.flag

状态：data/state/qianwen_review_watch_state.json（last_verdict，翻转判据）
日志：data/state/qianwen_review_watch.log（utf-8 追加，~1KB/天，无须轮转）
"""
import json
import os
import subprocess
import sys
from datetime import datetime, timedelta, timezone

HERE = os.path.dirname(os.path.abspath(__file__))
STATE = "E:/AI-Station/data/state/qianwen_review_watch_state.json"
LOG = "E:/AI-Station/data/state/qianwen_review_watch.log"
NOTIFY = "E:/AI-Station/tools/notify_wecom.py"
WATCH = os.path.join(HERE, "watch_review_browser.py")
CST = timezone(timedelta(hours=8))


def log(line):
    stamp = datetime.now(CST).strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(f"{stamp} {line}\n")


def notify(title, body):
    """企微通知（外发失败不阻断主流程，日志留痕）。"""
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
        capture_output=True, timeout=120,
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
    log(f"verdict={verdict} status={res.get('status', '-')}"
        + (f" detail={res.get('detail', '')}" if verdict == "ERROR" else ""))

    try:
        with open(STATE, encoding="utf-8") as f:
            prev = json.load(f).get("last_verdict", "")
    except (OSError, ValueError):
        prev = ""

    if verdict == "APPROVED" and prev != "APPROVED":
        with open("E:/AI-Station/data/state/mp_review_approved.flag", "w", encoding="utf-8") as f:
            json.dump({"at": datetime.now(CST).isoformat(),
                       "row": res.get("row", "")}, f, ensure_ascii=False)
        notify("小程序审核通过",
               "总包AI顾问 v0.9.12 审核通过！\n"
               "发布六步清单已就位（HANDOFF §六：灰度复查→发布→道具现网×6→env 切换→海报切轨→冒烟），"
               "随时可以执行发布上线。")
    elif verdict == "REJECTED" and prev != "REJECTED":
        with open("E:/AI-Station/data/state/mp_review_rejected.flag", "w", encoding="utf-8") as f:
            json.dump({"at": datetime.now(CST).isoformat(),
                       "row": res.get("row", "")}, f, ensure_ascii=False)
        notify("小程序审核被拒",
               "总包AI顾问 v0.9.12 审核被拒。\n"
               "原因上 mp 控制台「版本管理」看该版本行详情（截图指引已存 filing/）；"
               "按拒审理由修复后自动重提（拒审→修复→重提循环在案：v0.7.7 先例）。")

    with open(STATE, "w", encoding="utf-8") as f:
        json.dump({"last_verdict": verdict,
                   "at": datetime.now(CST).isoformat()}, f, ensure_ascii=False)
    return 0


if __name__ == "__main__":
    sys.exit(main())
