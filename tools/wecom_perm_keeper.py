# -*- coding: utf-8 -*-
"""wecom_perm_keeper — 企微机器人权限守门 (1106 用户令: 授权持久化, 避免反复).

权限模型: 企微「智能机器人」的消息(type=6)/微盘(type=8)使用授权会周期性过期
(服务端策略, 无法免授权续期)。本守门做两件事:
  1. 每12h静默探活两项权限 (读操作零打扰):
     - 消息: message aibot sessions list
     - 微盘: disk files search(独家研究报告 folder)
  2. 任一项过期 → 立即webhook通知用户带两条再授权链接(链接实测稳定)
日志: data/logs/wecom_perm_keeper.log
计划任务: wecom_perm_keeper (每12h, schtasks注册)
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
LOG = REPO / "data" / "logs" / "wecom_perm_keeper.log"
NPX = r"D:\Program Files\nodejs\npx.cmd"
LINK_MSG = ("https://work.weixin.qq.com/ai/aiHelper/authorizationList?from=chat"
            "&forceInnerBrowser=1&aibotid=33776999304282019"
            "&str_aibotid=aibG4ZzGTfuzEIXCF_Dr1f100LL7jcRC0lY&type=6"
            "&ww_vw=640&ww_vh=640&for_native=true&bar_style_type=3"
            "&pc_bar_bg=f6f6f7%2C202021&hide_more_btn=true")
LINK_DISK = ("https://work.weixin.qq.com/ai/aiHelper/authorizationList?from=chat"
             "&forceInnerBrowser=1&aibotid=33776999304282019"
             "&str_aibotid=aibG4ZzGTfuzEIXCF_Dr1f100LL7jcRC0lY&type=8"
             "&ww_vw=640&ww_vh=640&for_native=true&bar_style_type=3"
             "&pc_bar_bg=f6f6f7%2C202021&hide_more_btn=true")


def log(msg: str) -> None:
    LOG.parent.mkdir(parents=True, exist_ok=True)
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(f"[{time.strftime('%m-%d %H:%M')}] {msg}\n")


def run(args: list) -> str:
    r = subprocess.run([NPX, "-y", "@wecom/cli", *args],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=180,
                       cwd=str(REPO))
    return (r.stdout or "") + (r.stderr or "")


def probe_msg() -> bool:
    out = run(["message", "aibot", "sessions", "list"])
    ok = "sessions_count" in out and "850003" not in out
    return ok


def probe_disk() -> bool:
    out = run(["disk", "files", "search", "--json",
               json.dumps({"keywords": ["独家研究报告"],
                           "search_type": "folder", "limit": 1})])
    ok = "files_count" in out and "850003" not in out
    return ok


def notify(text: str) -> None:
    subprocess.run([sys.executable, "-X", "utf8",
                    str(REPO / "tools" / "notify_approval_wecom.py"),
                    "企微机器人权限守门", text],
                   capture_output=True, timeout=120, cwd=str(REPO))


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    m, d = probe_msg(), probe_disk()
    log(f"探活: 消息={'活' if m else '过期'} 微盘={'活' if d else '过期'}")
    if m and d:
        print("[keeper] 两项权限均活")
        return 0
    dead = []
    if not m:
        dead.append(f"消息(type=6): {LINK_MSG}")
    if not d:
        dead.append(f"微盘(type=8): {LINK_DISK}")
    notify("企微机器人权限过期(自动检测): " + " | ".join(dead)
           + " — 各点一次即可恢复, 守门每12h自动复探")
    print(f"[keeper] 过期项: {len(dead)} — 已webhook通知")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
