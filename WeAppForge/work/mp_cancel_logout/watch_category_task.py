# -*- coding: utf-8 -*-
"""watch_category_task.py — 类目盯哨 OS 级常驻腿（schtasks QianwenCatWatch, 每3h）.

1008 根治：会话级 cron 890da29a 随上个会话死亡（scheduled_tasks.json 实查为空，
盯哨静默失守一整天），按「指令必须严格持久执行」铁律改 OS 层 schtasks。

判据与 watch_category_api.py 同源（subprocess 复用同一文件，杜绝两份逻辑漂移）：
  GREEN  = 深度合成>AI问答 已生效（类目绿灯）
  PENDING= 未生效（审核中或驳回，绿灯才触发动作，无须登录区分）
  ERROR  = 网络/接口异常（下轮再试）

动作面（静默纪律：绿灯/异常才扰民，且只在新旧状态翻转的那一次发）：
  GREEN        → 企微通知 + 立 flag data/state/mp_category_green.flag
                 （重提审本身留给会话腿做 BOOT-SIM+submit_audit，不盲发外向动作）
  基线类目缺失  → 企微异常报警（同样只发翻转那一次）
  PENDING/ERROR→ 静默，只记日志

状态：data/state/qianwen_cat_watch_state.json（last_verdict，翻转判据）
日志：data/state/qianwen_cat_watch.log（utf-8 追加，~1KB/天，无须轮转）
"""
import json
import os
import subprocess
import sys
from datetime import datetime, timedelta, timezone

HERE = os.path.dirname(os.path.abspath(__file__))
STATE = "E:/AI-Station/data/state/qianwen_cat_watch_state.json"
LOG = "E:/AI-Station/data/state/qianwen_cat_watch.log"
FLAG = "E:/AI-Station/data/state/mp_category_green.flag"
NOTIFY = "E:/AI-Station/tools/notify_wecom.py"
WATCH = os.path.join(HERE, "watch_category_api.py")
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
    cats = ",".join(res.get("categories", [])) or "-"
    baseline_ok = bool(res.get("baseline_ok", True))
    log(f"verdict={verdict} baseline_ok={baseline_ok} cats={cats}"
        + (f" detail={res.get('detail', '')}" if verdict == "ERROR" else ""))

    try:
        with open(STATE, encoding="utf-8") as f:
            prev = json.load(f).get("last_verdict", "")
    except (OSError, ValueError):
        prev = ""

    # 翻转才发：GREEN 进场通知一次；基线异常进场报警一次
    if verdict == "GREEN" and prev != "GREEN":
        with open(FLAG, "w", encoding="utf-8") as f:
            json.dump({"at": datetime.now(CST).isoformat(), "categories": cats}, f,
                      ensure_ascii=False)
        notify("小程序类目绿灯",
               "总包AI顾问的类目「深度合成-AI问答」审核通过了！\n"
               "接下来自动走重提审（BOOT-SIM 自检+提交审核），结果另行汇报。")
    elif not baseline_ok and prev != "ANOMALY":
        verdict = "ANOMALY"  # 记入状态，恢复后 GREEN 仍能再触发通知
        notify("小程序类目异常",
               "类目盯哨发现基线类目缺失（工具/信息查询、资讯/信息资讯），"
               "可能与注销冻结或审核变动有关，建议上控制台复核。")

    with open(STATE, "w", encoding="utf-8") as f:
        json.dump({"last_verdict": verdict,
                   "at": datetime.now(CST).isoformat()}, f, ensure_ascii=False)
    return 0


if __name__ == "__main__":
    sys.exit(main())
