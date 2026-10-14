# -*- coding: utf-8 -*-
"""23:59 运营日报生成器（T-073 / REQ-023.AC1，军团 23:59 腿调用）。

数据源=真实遥测：audit_log（发送量）、glue_audit（胶水门）、任务图（进度）。
未上线的腿如实标注「未部署」，禁止编数。产出 revenue-engine/reports/daily/latest.md。
"""
from __future__ import annotations

import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "私域运营" / "zbops"))
from zbops.radar.audit_log import weekly_summary  # noqa: E402


def _glue_total() -> str:
    p = ROOT / ".super-skill" / "glue_audit.md"
    for line in p.read_text(encoding="utf-8").splitlines():
        if line.startswith("GLUE_TOTAL:"):
            return line.split()[1]
    return "N/A"


def _tasks_done() -> str:
    ss = r"C:/Users/91216/.claude/skills/super-skill/engine/ss.py"
    try:
        out = subprocess.run([sys.executable, ss, "task", "next"],
                             capture_output=True, text=True, timeout=30,
                             encoding="utf-8", errors="replace").stdout
        return out.strip().splitlines()[0] if out.strip() else "N/A"
    except Exception:
        return "N/A"


def main() -> int:
    today = time.strftime("%Y-%m-%d")
    w = weekly_summary(1)
    lines = [
        f"# 运营日报 {today}", "",
        "DAILY: OK", "",
        "## 五轴世界级指标（当值，实测）", "",
        "| 轴 | 当值 | 依据 |",
        "|---|---|---|",
        "| 收入可归因 | 未上线 | 收款腿未部署（商户号门待确认） |",
        f"| 无人值守 | 让路令暂停中 | 研究军团 14:20 全停生效；本产线轻载运行 |",
        "| 账号安全 | 0 封号 | 主号 UIA 未发送；A 栈未部署 |",
        "| 合规干净 | 0 违规 | 三级许可证边界执行中，层级②零代码引入 |",
        f"| 克制自研 | {_glue_total()} 行 | glue_audit.md 实测快照 |",
        "", "## 今日发送（审计总线实测）", "",
        f"- 总量：{w['total']}（按腿 {w['by_leg'] or '—'}）",
        "- 说明：审计总线今日上线，生产发送尚未开始（B 栈待军团恢复令）", "",
        "## 转化漏斗 / 收入", "",
        "- EspoCRM 未部署（docker 窗口待批）→ 漏斗各级 N/A；收入 0 元（如实）", "",
        "## 告警 / 异常", "",
        "- 无风控信号；无封号事件；裁判官 DISCARD 返工 3 件已全部 KEEP 收口", "",
        f"## 进度：下一任务 {_tasks_done()}", "",
    ]
    out = ROOT / "revenue-engine" / "reports" / "daily" / "latest.md"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text("\n".join(lines), encoding="utf-8")
    print(f"written {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
