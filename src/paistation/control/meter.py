"""C4 资源账本：token/秒/元三维计量（B2 结算轨道的计量底座）。

meter.jsonl append-only；usage() 聚合读。
"""
from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path

DIMS = ("tokens", "seconds", "yuan")


def _ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


class Meter:
    def __init__(self, home: str | Path):
        self._home = Path(home)

    def record(self, task_id: str, tokens: int = 0, seconds: float = 0.0,
               yuan: float = 0.0) -> None:
        path = self._home / "control" / "meter.jsonl"
        path.parent.mkdir(parents=True, exist_ok=True)
        with path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps({"ts": _ts(), "task_id": task_id,
                                 "tokens": tokens, "seconds": seconds,
                                 "yuan": yuan}, ensure_ascii=False) + "\n")


def usage(home: str | Path, total: bool = False) -> dict:
    path = Path(home) / "control" / "meter.jsonl"
    if not path.is_file():
        return {} if not total else {d: 0 for d in DIMS}
    per_task: dict[str, dict[str, float]] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        row = json.loads(line)
        acc = per_task.setdefault(row["task_id"], {d: 0 for d in DIMS})
        for d in DIMS:
            acc[d] += row.get(d, 0)
    if total:
        return {d: sum(v[d] for v in per_task.values()) for d in DIMS}
    return per_task
