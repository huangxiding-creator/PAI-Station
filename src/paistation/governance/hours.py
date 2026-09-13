"""E2 替你完成的小时数报表（结果计费前置件，不先收钱）。

数据源=机器账本（exits.jsonl done token + meter.jsonl seconds），
非自述——报表经机器判据背书（Phase E 验收判据）。
"""
from __future__ import annotations

import json
from pathlib import Path


def _read_jsonl(path: Path) -> list[dict]:
    if not path.is_file():
        return []
    return [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]


def hours_report(home: str | Path, render: bool = False):
    home = Path(home)
    exits = _read_jsonl(home / "gate" / "exits.jsonl")
    done_ids = {r["task_id"] for r in exits if r.get("done")}
    seconds_by_task: dict[str, float] = {}
    for row in _read_jsonl(home / "control" / "meter.jsonl"):
        seconds_by_task[row["task_id"]] = (seconds_by_task.get(row["task_id"], 0)
                                           + row.get("seconds", 0))
    done_seconds = sum(sec for tid, sec in seconds_by_task.items()
                       if tid in done_ids)
    report = {
        "done_tasks": len(done_ids),
        "human_hours": round(done_seconds / 3600, 2),
        "total_tasks": len({r["task_id"] for r in exits}),
        "done_seconds": done_seconds,
    }
    if not render:
        return report
    return ("# 替你完成的小时数\n\n"
            f"- 收口任务：{report['done_tasks']} / {report['total_tasks']}\n"
            f"- 替你完成的小时数：**{report['human_hours']}h**\n"
            f"- 依据：exits.jsonl（done token）× meter.jsonl（seconds）\n")


def write_report(home: str | Path, dest: str | Path | None = None) -> Path:
    home = Path(home)
    dest = Path(dest) if dest else home / "gate" / "HOURS.md"
    dest.write_text(hours_report(home, render=True), encoding="utf-8")
    return dest
