"""B5 上下文预算表（M2）：任务级 token 预算 + 超支检测 + fresh-context 复盘。

预算=授权花销：无登记的任务每笔都算超（无预算=无授权）。
budget.jsonl / context_reviews.jsonl append-only。
"""
from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path


def _ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


def _append(path: Path, row: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(row, ensure_ascii=False) + "\n")


def _read(path: Path) -> list[dict]:
    if not path.is_file():
        return []
    return [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]


def _budget_path(data_dir: str | Path) -> Path:
    return Path(data_dir) / "evolve" / "budget.jsonl"


class BudgetLedger:
    def __init__(self, data_dir: str | Path):
        self._data_dir = Path(data_dir)

    def plan(self, task_id: str, budget_tokens: int) -> None:
        _append(_budget_path(self._data_dir),
                {"event": "plan", "task_id": task_id, "ts": _ts(),
                 "budget": budget_tokens})

    def spend(self, task_id: str, used_tokens: int, note: str = "") -> None:
        _append(_budget_path(self._data_dir),
                {"event": "spend", "task_id": task_id, "ts": _ts(),
                 "used": used_tokens, "note": note})

    def status(self, task_id: str) -> dict:
        budget = 0
        used = 0
        for r in _read(_budget_path(self._data_dir)):
            if r.get("task_id") != task_id:
                continue
            if r["event"] == "plan":
                budget += r["budget"]
            elif r["event"] == "spend":
                used += r["used"]
        return {"budget": budget, "used": used, "over": used > budget}


def overspent(data_dir: str | Path) -> list[dict]:
    rows = _read(_budget_path(data_dir))
    tasks = {r["task_id"] for r in rows}
    led = BudgetLedger(data_dir)
    return [{"task_id": t, **led.status(t)} for t in sorted(tasks)
            if led.status(t)["over"]]


def record_review(data_dir: str | Path, task_id: str, summary: str) -> None:
    _append(Path(data_dir) / "evolve" / "context_reviews.jsonl",
            {"task_id": task_id, "ts": _ts(), "summary": summary})


def review_pending(data_dir: str | Path) -> list[dict]:
    """超支且未复盘的任务=fresh-context 复盘候选。"""
    reviewed = {r["task_id"] for r in _read(
        Path(data_dir) / "evolve" / "context_reviews.jsonl")}
    return [o for o in overspent(data_dir) if o["task_id"] not in reviewed]
