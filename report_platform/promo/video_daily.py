# -*- coding: utf-8 -*-
"""video_daily — 视频号日更调度腿 (1008 收官后的常驻流量飞轮).

OS 级 schtasks (RP_VideoDaily_1 09:37 / RP_VideoDaily_2 14:37 双槽) 调起:
从队列取下一片 → 调 video_upload.py --go (其自带四件套预检: 日帽/让路/
锁/失败即停). 日帽=幂等闸: 今日已发 → 双槽都静默退出; 上午让路 → 下午槽
自然补位. 队列发空 → 退出并留痕 (等新卡渲染).

护栏全部继承 video_upload.py, 本脚本只做「选片+转发」, 绝不绕过预检.
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

if sys.stdout:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(__file__).resolve().parent
LEDGER = PROMO / "promo_ledger.jsonl"
VENV_PY = Path(r"E:\CPOPC\We-AIPO\.venv\Scripts\python.exe")
QUEUE = ["cnnec_v1_am", "fengcheng_v1_am",
         "ent22_v1_am", "prov07_v1_am"]        # 1008 排队片 (在售双卡视觉审计收官后续尾)


def _sph_done_slugs() -> set[str]:
    done: set[str] = set()
    if LEDGER.exists():
        for line in LEDGER.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            try:
                r = json.loads(line)
            except json.JSONDecodeError:
                continue
            if r.get("src") == "sph":
                done.add(r.get("media_id", ""))
    return done


def main() -> int:
    today = time.strftime("%Y-%m-%d")
    published_today = False
    if LEDGER.exists():
        for line in LEDGER.read_text(encoding="utf-8").splitlines():
            if line.strip():
                try:
                    r = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if r.get("src") == "sph" and r.get("date") == today:
                    published_today = True
    if published_today:
        print("[vd] 今日 sph 日帽已用 — 静默退出")
        return 0
    done = _sph_done_slugs()
    slug = next((s for s in QUEUE
                 if s not in done
                 and (PROMO / "videos" / f"{s}.mp4").is_file()
                 and (PROMO / "videos" / f"{s}.json").is_file()), None)
    if not slug:
        print("[vd] 队列发空 (须渲染新卡续队) — 留痕退出")
        return 0
    log = PROMO / "videos" / f"{slug}_daily_{today.replace('-', '')}.log"
    print(f"[vd] 发布 {slug} → video_upload --go (日志 {log.name})")
    with log.open("w", encoding="utf-8") as f:
        rc = subprocess.call(
            [str(VENV_PY), "-X", "utf8",
             str(PROMO / "video_upload.py"), "--slug", slug, "--go"],
            stdout=f, stderr=subprocess.STDOUT, timeout=1800,
            creationflags=0x08000000)   # CREATE_NO_WINDOW: 隐py控制台不隐浏览器
    print(f"[vd] video_upload rc={rc}")
    return rc


if __name__ == "__main__":
    sys.exit(main())
