"""B3 任务级进化代谢（Learning While Acting）。

任务结束→技能变异候选（diff 即梯度）→同类任务 A/B 验证→KEEP/DISCARD
自动裁决。候选≠生效：生效必须 A/B 胜出（变异洪水防线）。

mutations.jsonl / ab_runs.jsonl 均 append-only（R 只增不删）：
状态变迁=追加新事件行，读侧按 candidate_id 取末事件（双时态语义）。
"""
from __future__ import annotations

import hashlib
import json
from datetime import datetime
from pathlib import Path


def _ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


def _cid(skill: str, diff: str, task_id: str) -> str:
    material = f"{skill}|{diff}|{task_id}".encode()
    return "MUT-" + hashlib.sha1(material).hexdigest()[:10]


def _append(path: Path, row: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(row, ensure_ascii=False) + "\n")


def _read(path: Path) -> list[dict]:
    if not path.is_file():
        return []
    return [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]


def propose(data_dir: str | Path, skill: str, diff: str, task_id: str,
            origin: str = "task") -> str:
    """登记变异候选；同 (skill,diff,task) 幂等。返回 candidate_id。"""
    cid = _cid(skill, diff, task_id)
    if any(r.get("event") == "propose" and r.get("candidate_id") == cid
           for r in _read(Path(data_dir) / "evolve" / "mutations.jsonl")):
        return cid
    _append(Path(data_dir) / "evolve" / "mutations.jsonl", {
        "event": "propose", "candidate_id": cid, "ts": _ts(),
        "skill": skill, "diff": diff, "task_id": task_id,
        "origin": origin, "status": "candidate",
    })
    return cid


def judge(data_dir: str | Path, candidate_id: str, verdict: str,
          evidence: str) -> dict:
    """KEEP→effective / DISCARD→discarded；可复判翻案（末事件行语义）。"""
    if verdict not in ("KEEP", "DISCARD"):
        raise ValueError(f"verdict 只允许 KEEP/DISCARD：{verdict}")
    row = {"event": "judge", "candidate_id": candidate_id, "ts": _ts(),
           "verdict": verdict, "evidence": evidence,
           "status": "effective" if verdict == "KEEP" else "discarded"}
    _append(Path(data_dir) / "evolve" / "mutations.jsonl", row)
    return row


def record_ab(data_dir: str | Path, skill: str, task_id: str,
              baseline: dict, variant: dict) -> None:
    """A/B 运行记录（裁决的证据源）。"""
    _append(Path(data_dir) / "evolve" / "ab_runs.jsonl", {
        "ts": _ts(), "skill": skill, "task_id": task_id,
        "baseline": baseline, "variant": variant,
    })


def history(data_dir: str | Path) -> list[dict]:
    return _read(Path(data_dir) / "evolve" / "mutations.jsonl")


def ab_runs(data_dir: str | Path) -> list[dict]:
    return _read(Path(data_dir) / "evolve" / "ab_runs.jsonl")


def _latest_by_candidate(rows: list[dict]) -> dict[str, dict]:
    latest: dict[str, dict] = {}
    for r in rows:
        cid = r.get("candidate_id")
        if cid:
            latest[cid] = r
    return latest


def pending(data_dir: str | Path) -> list[dict]:
    """未裁决候选（按末事件行仍为 candidate）。"""
    latest = _latest_by_candidate(history(data_dir))
    return [r for r in latest.values() if r.get("status") == "candidate"]
