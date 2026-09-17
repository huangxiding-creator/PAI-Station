# -*- coding: utf-8 -*-
"""信号流融合画像：focus.window × 小时 × 日 + 锁屏真值 vs 电源估计。

产出 SELF_PROFILE/cx_信号流融合_<date>.md（本地私有，不入 git）。
用法：python tools/cx_signal_profile.py
"""
from __future__ import annotations

import json
import sqlite3
import sys
from collections import Counter, defaultdict
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
DB = REPO / "data" / "cx" / "timeline.db"
OUT = REPO / "SELF_PROFILE" / f"cx_信号流融合_{datetime.now():%Y%m%d}.md"

PROC_ALIAS = {
    "Code.exe": "VS Code", "python.exe": "Python(脚本/服务)", "explorer.exe": "资源管理器",
    "chrome.exe": "Chrome", "360huabao.exe": "360壁纸(屏保向)", "Weixin.exe": "微信",
    "WeChatAppEx.exe": "微信小程序", "Feishu.exe": "飞书", "wps.exe": "WPS",
    "msedge.exe": "Edge", "360se.exe": "360浏览器", "claude.exe": "Claude Code",
    "Tabbit Browser.exe": "Tabbit浏览器", "cmd.exe": "终端", "powershell.exe": "PowerShell",
    "windowsterminal.exe": "Windows Terminal",
}


def _alias(proc: str | None) -> str:
    if not proc:
        return "(未知)"
    return PROC_ALIAS.get(proc, proc)


def main() -> int:
    conn = sqlite3.connect(DB)
    rows = conn.execute(
        "SELECT start, type, payload FROM events WHERE source='signal_service'"
    ).fetchall()
    focus_by_hour: dict[int, Counter] = defaultdict(Counter)
    focus_by_day: dict[str, Counter] = defaultdict(Counter)
    locks: list[tuple[str, str]] = []  # (local iso, phase)
    afk: Counter = defaultdict(int)
    for start, etype, payload in rows:
        p = json.loads(payload)
        # start 存的是 UTC ISO，转回本地看作息
        local = datetime.fromisoformat(start).astimezone()
        if etype == "focus.window":
            app = _alias(p.get("process"))
            focus_by_hour[local.hour][app] += 1
            focus_by_day[local.strftime("%m-%d")][app] += 1
        elif etype in ("session.lock", "session.unlock"):
            locks.append((local.strftime("%m-%d %H:%M"), etype.split(".")[1]))
        elif etype == "presence.afk" and p.get("phase") == "start":
            afk[local.strftime("%m-%d")] += 1

    lines = ["# 信号流融合画像（focus×小时×日 + 锁屏真值）", ""]
    lines.append(f"> 数据：timeline signal_service {len(rows)} 条（09-16 起）；"
                 f"生成 {datetime.now():%Y-%m-%d %H:%M}（tools/cx_signal_profile.py）")
    lines.append("")
    total_focus = sum(sum(c.values()) for c in focus_by_day.values())
    grand = Counter()
    for c in focus_by_day.values():
        grand.update(c)
    lines.append("## 前台应用总分布（注意力代理）")
    lines.append("")
    lines.append("| 应用 | 切换次数 | 占比 |")
    lines.append("|---|---:|---:|")
    for app, n in grand.most_common(12):
        lines.append(f"| {app} | {n} | {n / total_focus:.1%} |")
    lines.append("")
    lines.append("## 小时 × Top5 应用（注意力节律）")
    lines.append("")
    top5 = [a for a, _ in grand.most_common(5)]
    lines.append("| 时段 | " + " | ".join(top5) + " | 其他 |")
    lines.append("|---|" + "---:|" * (len(top5) + 1))
    for h in range(24):
        c = focus_by_hour.get(h, Counter())
        row = [str(c.get(a, 0)) for a in top5]
        other = sum(c.values()) - sum(int(x) for x in row)
        lines.append(f"| {h:02d} 时 | " + " | ".join(row) + f" | {other} |")
    lines.append("")
    lines.append("## 锁屏/解锁真值（节律维金标准，替代电源推断）")
    lines.append("")
    for ts, phase in sorted(locks):
        lines.append(f"- {ts} {phase}")
    lines.append("")
    lines.append("## AFK 启动次数（按日）")
    lines.append("")
    for d, n in sorted(afk.items()):
        lines.append(f"- {d}: {n} 次")
    lines.append("")
    OUT.write_text("\n".join(lines), encoding="utf-8")
    print(f"画像落盘 {OUT}（{len(rows)} 事件，{total_focus} 次前台切换）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
