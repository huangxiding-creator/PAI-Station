# -*- coding: utf-8 -*-
"""微信消息常态化提取·每日任务载体（pythonw 零弹窗，schtasks 00:40 调）。

计算昨天日期 → 调 .claude/skills/wechat-cli/scripts/daily_extract.py →
追加日志 data/wechat_export/_daily.log。幂等：目标日 all_<date>.json
已存在即跳过。
"""
import datetime
import subprocess
import sys
from pathlib import Path

SCRIPT = Path(r"E:\AI-Station\.claude\skills\wechat-cli\scripts\daily_extract.py")
PY = Path(r"E:\AI-Station\.venv\Scripts\python.exe")
OUT_ROOT = Path(r"E:\AI-Station\data\wechat_export")
LOG = OUT_ROOT / "_daily.log"


def main() -> int:
    y = datetime.date.today() - datetime.timedelta(days=1)
    stamp = y.isoformat()
    if (OUT_ROOT / stamp / f"all_{stamp}.json").exists():
        LOG.parent.mkdir(parents=True, exist_ok=True)
        with open(LOG, "a", encoding="utf-8") as f:
            f.write(f"{datetime.datetime.now():%F %T} {stamp} 已存在，跳过\n")
        return 0
    proc = subprocess.run(
        [str(PY), str(SCRIPT), stamp],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=3600)
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(f"{datetime.datetime.now():%F %T} {stamp} rc={proc.returncode}\n"
                f"{proc.stdout[-2000:]}\n{proc.stderr[-500:]}\n")
    return proc.returncode


if __name__ == "__main__":
    sys.exit(main())
