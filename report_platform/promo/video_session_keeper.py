# -*- coding: utf-8 -*-
"""video_session_keeper — 视频号 9222 会话每日保活 (1030 免打扰链收官件).

职责 (每日一次, schtasks 09:05 错峰永动机 07:00 保活):
  1. ensure(): 强探测 9222 channels 登录态 → 死则 S367 快捷登录自动复活
     (PC 微信在场即零扫码零人工; 永动机发布中自动让路)
  2. 台账 video_session_state.json (alive/via/sid 剩寿/连续死计数)
  3. 连续 ≥2 天 dead → 企微通知一次 (不轰炸; 复活成功即清零)

不做的事 (铁律):
  - 不 kill/重启 9222, 不动永动机 tab
  - 永不弹码 (扫码兜底=人工跑 video_relogin.py, 通知里指路)
  - 不发布任何视频 (发布腿=video_upload.py --go)

部署: schtasks /Create /TN "AI-Station\video_session_keeper"
      /TR "pythonw.exe -X utf8 <本文件>" /SC DAILY /ST 09:05
日志: promo/logs/video_session_keeper.log (pythonw 静默跑也留痕)
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

PROMO = Path(__file__).resolve().parent
sys.path.insert(0, str(PROMO))
import video_channel_session as vcs

LOG = PROMO / "logs" / "video_session_keeper.log"
NOTIFY = Path(r"E:\AI-Station\tools\notify_approval_wecom.py")
DEAD_NOTIFY_THRESHOLD = 2               # 连续死≥2天才通知


def _notify_wecom(title: str, detail: str) -> None:
    try:
        subprocess.run(
            [sys.executable, "-X", "utf8", str(NOTIFY), title, detail],
            capture_output=True, timeout=60)
    except Exception as exc:
        print(f"[keeper] 企微通知失败(不阻断): {exc}", flush=True)


def main() -> int:
    print(f"\n===== keeper run {time.strftime('%Y-%m-%d %H:%M:%S')} =====",
          flush=True)
    res = vcs.ensure()
    print(f"[keeper] ensure → alive={res['alive']} via={res['via']}",
          flush=True)

    ledger = {}
    try:
        ledger = json.loads(
            vcs.SESSION_LEDGER.read_text(encoding="utf-8"))
    except Exception:
        ledger = {}
    dead_streak = int(ledger.get("dead_streak", 0))
    notified = bool(ledger.get("dead_notified", False))
    if res["alive"]:
        dead_streak, notified = 0, False
    else:
        dead_streak += 1
        # 连续死且未通知过 → 通知一次 (busy 让路不算真死信号轰炸)
        if (dead_streak >= DEAD_NOTIFY_THRESHOLD and not notified
                and res["via"] != "busy"):
            _notify_wecom(
                "视频号登录态连续失效",
                f"9222 channels 会话已连续 {dead_streak} 天未复活 "
                f"(via={res['via']}, PC微信需在线供快捷登录)。"
                "人工兜底: 跑 video_relogin.py 扫一次码。")
            notified = True

    vcs.write_ledger({
        "keeper_last_run": time.strftime("%Y-%m-%d %H:%M:%S"),
        "alive": res["alive"],
        "via": res["via"],
        "sessionid_left_h": (res.get("weak") or {}).get(
            "sessionid_left_h"),
        "dead_streak": dead_streak,
        "dead_notified": notified,
    })
    print(f"[keeper] 台账已落 dead_streak={dead_streak}", flush=True)
    return 0 if res["alive"] else 1


if __name__ == "__main__":
    LOG.parent.mkdir(parents=True, exist_ok=True)
    with LOG.open("a", encoding="utf-8") as f:
        sys.stdout = f
        sys.stderr = f
        rc = main()
    sys.exit(rc)
