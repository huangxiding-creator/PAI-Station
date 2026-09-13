"""M6.3 交付自检补充：git 可用 + 首启向导完成度（doctor 消费）。"""
from __future__ import annotations

import json
import shutil
from pathlib import Path


def git_available() -> bool:
    return shutil.which("git") is not None


def wizard_done(data_dir: str | Path) -> bool:
    """向导健康度：未开始=通过（装后 doctor 先于向导跑，属正常序），
    只把「写了却没完成」的半途状态记为病（原子写被外因打断才可能出现）。"""
    path = Path(data_dir) / "wizard.json"
    if not path.is_file():
        return True
    try:
        return bool(json.loads(path.read_text(encoding="utf-8")).get("done"))
    except (OSError, ValueError):
        return False


def bundle_report(data_dir: str | Path) -> list[tuple[str, bool]]:
    return [("git 可用", git_available()),
            ("首启向导", wizard_done(data_dir))]
