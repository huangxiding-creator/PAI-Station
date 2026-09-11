"""液态状态 _state.json：每个器官的新陈代谢账本（PROPOSAL_V2.md 3.1）。

状态字段：水位（watermark，增量采集的"上次读到哪"）、条目计数、
新鲜度、健康度、上次同步时间。全部不可变更新——touch 返回新对象；
水位只前进不后退（advance_watermark 拒绝回退）。
"""
from __future__ import annotations

import json
import os
import tempfile
from dataclasses import asdict, dataclass, field, replace
from datetime import datetime
from pathlib import Path

from .registry import find, organ_dir

STATE_FILENAME = "_state.json"


@dataclass(frozen=True)
class OrganState:
    """一个器官的液态状态快照（不可变）。"""

    organ_id: str
    items: int = 0
    watermark: dict[str, str] = field(default_factory=dict)
    freshness: str = ""
    health: float = 1.0
    last_sync: str = ""
    updated_at: str = ""


def _now_iso() -> str:
    return datetime.now().isoformat(timespec="seconds")


def state_path(root: Path, organ_id: str) -> Path:
    """_state.json 落在器官目录根部。"""
    return organ_dir(Path(root), find(organ_id)) / STATE_FILENAME


def load_state(root: Path, organ_id: str) -> OrganState:
    """读器官状态；文件缺失/损坏时返回默认态（器官健康起步）。"""
    path = state_path(root, organ_id)
    if not path.exists():
        return OrganState(organ_id=organ_id)
    try:
        raw = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return OrganState(organ_id=organ_id)
    raw.setdefault("organ_id", organ_id)
    return OrganState(**{k: v for k, v in raw.items()
                         if k in OrganState.__dataclass_fields__})


def save_state(root: Path, state: OrganState) -> Path:
    """原子落盘（临时文件 + os.replace），返回状态文件路径。"""
    path = state_path(root, state.organ_id)
    path.parent.mkdir(parents=True, exist_ok=True)
    payload = replace(state, updated_at=_now_iso())
    fd, tmp = tempfile.mkstemp(dir=str(path.parent), suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as fh:
            json.dump(asdict(payload), fh, ensure_ascii=False, indent=1)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)
    return path


def touch(state: OrganState, **changes) -> OrganState:
    """不可变更新：返回携带 changes 的新状态，原对象不动。"""
    return replace(state, last_sync=_now_iso(), **changes)


def advance_watermark(state: OrganState, key: str, value: str) -> OrganState:
    """水位前进：value 更新（时间戳字典序）才写入，回退请求静默忽略。

    微信深读/增量采集的基石——只读上次之后的新内容（PROPOSAL_V2.md 6.2）。
    """
    current = state.watermark.get(key, "")
    if value > current:
        return replace(state, watermark={**state.watermark, key: value},
                       last_sync=_now_iso())
    return state
