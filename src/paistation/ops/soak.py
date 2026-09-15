"""M8 无人值守浸泡跑（7 天级长跑基建）：循环 → 日志 → 断点续跑。

原则（长跑任务晚间执行 memory + 红线）：
  - 随时可停：stop_fn 合作式取消，跑完当前轮即收
  - 断点续跑：journal jsonl 只增不删，重启后从最大 cycle+1 续
  - 异常不杀：单轮 step 抛错记 error 行，继续下一轮
  - 坏行容忍：journal 损坏行跳过不炸（缺席不崩）
"""
from __future__ import annotations

import json
import time
from datetime import datetime
from pathlib import Path


class SoakRunner:
    """cycles 轮 step_fn(i) 循环器，全程留痕可续跑。"""

    def __init__(self, cycles: int, step_fn, journal_path,
                 interval_sec: float = 0.0, *, stop_fn=None,
                 sleep_fn=None, now_fn=None):
        self._cycles = int(cycles)
        self._step = step_fn
        self._journal = Path(journal_path)
        self._interval = float(interval_sec)
        self._stop_fn = stop_fn
        self._sleep = sleep_fn or time.sleep
        self._now = now_fn or datetime.now

    def run(self) -> dict:
        start = _resume_cycle(self._journal)
        stopped = False
        for i in range(start, self._cycles):
            status, detail = "ok", ""
            try:
                detail = str(self._step(i) or "")
            except Exception as exc:  # noqa: BLE001 - 单轮异常不杀长跑
                status, detail = "error", f"{type(exc).__name__}: {exc}"
            _append(self._journal, {"cycle": i,
                                    "ts": self._now().isoformat(
                                        timespec="milliseconds"),
                                    "status": status, "detail": detail})
            if self._stop_fn is not None:
                try:
                    stopped = bool(self._stop_fn())
                except Exception:  # noqa: BLE001
                    stopped = True
                if stopped:
                    break
            if i + 1 < self._cycles and self._interval > 0:
                self._sleep(self._interval)
        rep = soak_report(self._journal)
        rep["stopped"] = stopped
        rep["target_cycles"] = self._cycles
        return rep


def soak_report(journal_path) -> dict:
    """journal → 进度报告（done=journal 行数口径，坏行跳过）。"""
    path = Path(journal_path)
    done = errors = 0
    last_cycle = -1
    if path.is_file():
        try:
            lines = path.read_text(encoding="utf-8").splitlines()
        except OSError:
            lines = []
        for line in lines:
            line = line.strip()
            if not line:
                continue
            try:
                row = json.loads(line)
            except ValueError:
                continue
            if not isinstance(row, dict) or "cycle" not in row:
                continue
            done += 1
            if row.get("status") == "error":
                errors += 1
            try:
                last_cycle = max(last_cycle, int(row["cycle"]))
            except (TypeError, ValueError):
                pass
    return {"done": done, "errors": errors, "last_cycle": last_cycle,
            "stopped": False}


def _resume_cycle(journal: Path) -> int:
    return soak_report(journal)["last_cycle"] + 1


def _append(journal: Path, row: dict) -> None:
    journal.parent.mkdir(parents=True, exist_ok=True)
    with journal.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(row, ensure_ascii=False) + "\n")
