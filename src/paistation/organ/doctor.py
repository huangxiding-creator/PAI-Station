"""器官健康巡检：12 器官完整性体检（宪法/状态/凭证目录）。

供 7×24 服务自检与里程碑验收用——器官缺宪法/缺状态即 unhealthy。
"""
from __future__ import annotations

from pathlib import Path

from .registry import ORGANS, organ_dir
from .state import STATE_FILENAME, load_state

CREDENTIALS_DIRNAME = "_credentials"


def check(root: Path) -> dict:
    """巡检全部器官，返回体检报告（只读，不修复）。"""
    root = Path(root)
    missing_readme: list[str] = []
    missing_state: list[str] = []
    missing_credentials: list[str] = []
    items_total = 0
    for spec in ORGANS:
        directory = organ_dir(root, spec)
        if not (directory / "README.md").exists():
            missing_readme.append(spec.dirname)
        if not (directory / STATE_FILENAME).exists():
            missing_state.append(spec.dirname)
        if not (directory / CREDENTIALS_DIRNAME).exists():
            missing_credentials.append(spec.dirname)
        items_total += load_state(root, spec.id).items
    healthy = not (missing_readme or missing_state)
    return {
        "organs": len(ORGANS),
        "items_total": items_total,
        "missing_readme": missing_readme,
        "missing_state": missing_state,
        "missing_credentials": missing_credentials,
        "healthy": healthy,
    }
