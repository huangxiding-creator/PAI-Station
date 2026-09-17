"""第二波图片 OCR 回队：把已按 metadata-only 登记的图片打回 pending。

背景：OCR 白名单扩容（公众号配图等）后，早前被旧路由 metadata 化的
图片不会自动回队（cache_hit 的 parser_id 不匹配新路由本身就会失效，
只差 status 回 pending 这一步）。本脚本一次性补刀，幂等可重跑。

时序纪律：必须在常驻提取任务退出后跑——否则旧代码进程把这批行
再拿走仍走 metadata-only，白回队。脚本自查任务状态，Running 时拒跑。
"""
from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\src")

from paistation.sense.localfiles.triage import ocr_image_eligible

DB = Path(r"E:\AI-Station\data\local_index\inventory.db")
TASK = "PAIStation-localfiles-extract-0916"


def task_running() -> bool:
    import subprocess

    r = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         f"(Get-ScheduledTask -TaskName '{TASK}').State"],
        capture_output=True, text=True)
    return "Running" in (r.stdout or "")


def main(dry: bool = False) -> int:
    if task_running():
        print(f"[拒跑] 常驻任务 {TASK} 仍在 Running——等它磨完队列退出后"
              "再回队（旧代码进程会把这些行再 metadata 化，白回）")
        return 1
    db = sqlite3.connect(DB)
    db.row_factory = sqlite3.Row
    rows = db.execute(
        "SELECT path, size FROM files WHERE status='ok'"
        " AND parser_id='metadata-only'").fetchall()
    targets = [r["path"] for r in rows
               if ocr_image_eligible(r["path"], r["size"])]
    print(f"metadata-only 存量 {len(rows):,} → 符合 OCR 白名单 {len(targets):,}")
    if dry or not targets:
        db.close()
        return 0
    with db:
        db.executemany(
            "UPDATE files SET status='pending' WHERE path=?",
            [(p,) for p in targets])
    db.close()
    print(f"已回队 {len(targets):,} 行（下轮提取走 image-ocr 路由）")
    import subprocess
    subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         f"Start-ScheduledTask -TaskName '{TASK}'"],
        capture_output=True)  # 新代码进程载入第二波白名单开磨
    _self_uninstall()
    return 0


def _self_uninstall() -> None:
    """回队成功即自删系统任务（幂等巡检形态：反复跑无副作用，
    完成使命即退场——09-17 会话重启丢 session-cron 的教训，
    触发执行层必须系统级化）。"""
    import subprocess

    subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "Unregister-ScheduledTask -TaskName 'PAIStation-wave2-promote'"
         " -Confirm:$false"],
        capture_output=True)


if __name__ == "__main__":
    sys.exit(main(dry="--dry" in sys.argv))
