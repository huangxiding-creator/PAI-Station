"""B1 出口闸：确定性 done token。

「谁定义 done，谁拥有定价单位」（VISION_V4 P4）。done 不靠自述：
机器可查完成条件=测试全绿+ruff 0+evidence 文件存在+status==done。
exits.jsonl 只增不删（R 红线），写入口自动裁决 done 防手填绿。
"""
from __future__ import annotations

import json
from dataclasses import asdict, dataclass, field
from pathlib import Path


@dataclass
class ExitToken:
    task_id: str
    ts: str
    status: str                    # done | failed | running
    evidence: list[str] = field(default_factory=list)
    commit: str = ""
    tests_total: int = 0
    tests_failed: int = 0
    ruff_ok: bool = True
    note: str = ""
    done: bool = False             # 由 validate 裁决，落盘时自动填


def validate_token(token: ExitToken, root: str | Path = ".") -> dict:
    """机器可查完成条件：返回 {done, reasons}。"""
    root = Path(root)
    reasons: list[str] = []
    if token.status != "done":
        reasons.append(f"status={token.status} != done")
    if token.tests_failed:
        reasons.append(f"tests_failed={token.tests_failed}")
    if token.tests_total <= 0:
        reasons.append("tests_total=0（无测试证据）")
    if not token.ruff_ok:
        reasons.append("ruff 未过")
    for ev in token.evidence:
        if not (root / ev).exists():
            reasons.append(f"evidence 不存在: {ev}")
    return {"done": not reasons, "reasons": reasons}


def write_exit_token(data_dir: str | Path, token: ExitToken,
                     root: str | Path = ".") -> dict:
    """append-only 落盘；done 由 validate 裁决后写入（防手填）。"""
    verdict = validate_token(token, root=root)
    token.done = verdict["done"]
    path = Path(data_dir) / "gate" / "exits.jsonl"
    path.parent.mkdir(parents=True, exist_ok=True)
    row = asdict(token)
    with path.open("a", encoding="ascii", errors="ignore") as fh:
        fh.write(json.dumps(row, ensure_ascii=True) + "\n")
    return verdict


def read_exits(data_dir: str | Path) -> list[dict]:
    path = Path(data_dir) / "gate" / "exits.jsonl"
    if not path.is_file():
        return []
    rows = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            rows.append(json.loads(line))
    return rows


def last_token(data_dir: str | Path, task_id: str | None = None) -> dict | None:
    rows = read_exits(data_dir)
    if task_id is not None:
        rows = [r for r in rows if r.get("task_id") == task_id]
    return rows[-1] if rows else None
