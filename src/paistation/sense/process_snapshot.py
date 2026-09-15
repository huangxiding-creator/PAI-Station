"""M7a 进程快照流（UFO/OS-Copilot 式系统上下文）。

tasklist CSV 解析与 top-N 聚合为纯逻辑（可单测）；薄壳子进程
CREATE_NO_WINDOW（Windows 不弹窗铁律）。缺席不崩：tasklist 失败零产出。
"""
from __future__ import annotations

import csv
import io
import subprocess
from datetime import datetime

_CREATE_NO_WINDOW = 0x08000000


def parse_tasklist(output: str) -> list[dict]:
    """tasklist /fo csv /nh 输出 → [{"name","pid","mem_kb"}]。"""
    rows = []
    for row in csv.reader(io.StringIO(output or "")):
        if len(row) < 5 or not row[0].strip():
            continue
        try:
            mem_kb = int(row[4].replace(",", "").replace(" K", "")
                          .replace("\xa0", "").strip() or 0)
        except ValueError:
            continue
        try:
            pid = int(row[1])
        except ValueError:
            continue
        rows.append({"name": row[0].strip().lower(), "pid": pid,
                     "mem_kb": mem_kb})
    return rows


def top_by_memory(procs: list[dict], n: int = 10) -> list[dict]:
    """按进程名合并内存求和 → 降序 top-N [{name, mem_mb}]。"""
    totals: dict[str, int] = {}
    for p in procs:
        totals[p["name"]] = totals.get(p["name"], 0) + p["mem_kb"]
    merged = sorted(totals.items(), key=lambda kv: kv[1], reverse=True)
    return [{"name": name, "mem_mb": round(kb / 1024, 1)}
            for name, kb in merged[:n]]


def run_tasklist() -> str:
    """薄壳：tasklist 只读快照（隐藏窗口，15s 超时）。"""
    try:
        out = subprocess.run(
            ["tasklist", "/fo", "csv", "/nh"], capture_output=True,
            timeout=15, creationflags=_CREATE_NO_WINDOW)
        return out.stdout.decode(errors="replace")
    except Exception:  # noqa: BLE001 - 缺席不崩
        return ""


def snapshot_event(top: list[dict], now_fn=None) -> dict:
    now = now_fn or datetime.now
    return {
        "ts": now().isoformat(timespec="milliseconds"),
        "type": "process.snapshot",
        "source": "tasklist",
        "text": "",
        "evidence": {"count": len(top)},
        "meta": {"top": top},
    }
