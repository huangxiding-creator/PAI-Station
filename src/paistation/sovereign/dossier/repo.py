# -*- coding: utf-8 -*-
"""P0 主权卷宗·git 版本化（独立仓库，防泄公开 GitHub）。

卷宗=用户人生资产：本地 data/dossier/ 内 `git init` 独立版本化（主仓
gitignore 天然隔离）；远端备份位预留给用户自配私有远端（绝不自动推公开仓）。
commit 语义=快照留痕（每次 build 后调用；无变更零提交）。
"""
from __future__ import annotations

import subprocess
from pathlib import Path

_CO_AUTHOR = "Co-Authored-By: PAI-Station Dossier <dossier@local>"


def _git(cwd: Path, *args: str) -> subprocess.CompletedProcess:
    return subprocess.run(["git", "-C", str(cwd), *args],
                          capture_output=True, text=True,
                          encoding="utf-8", errors="replace", timeout=120)


def init_repo(dossier_dir: str | Path) -> bool:
    """初始化卷宗独立仓库（幂等）。返回是否新建。"""
    d = Path(dossier_dir)
    if (d / ".git").exists():
        return False
    d.mkdir(parents=True, exist_ok=True)
    _git(d, "init", "-q")
    _git(d, "config", "user.name", "PAI-Station Dossier")
    _git(d, "config", "user.email", "dossier@local")
    _git(d, "config", "commit.gpgsign", "false")
    return True


def commit_snapshot(dossier_dir: str | Path, message: str) -> str:
    """快照提交（无变更返回空串）。"""
    d = Path(dossier_dir)
    init_repo(d)
    _git(d, "add", "-A")
    status = _git(d, "status", "--porcelain")
    if not status.stdout.strip():
        return ""
    result = _git(d, "commit", "-q", "-m", f"{message}\n\n{_CO_AUTHOR}")
    if result.returncode != 0:
        raise RuntimeError(f"dossier commit failed: {result.stderr.strip()}")
    return _git(d, "rev-parse", "--short", "HEAD").stdout.strip()


def repo_status(dossier_dir: str | Path) -> dict:
    """{initialized, commits, dirty, last}。"""
    d = Path(dossier_dir)
    if not (d / ".git").exists():
        return {"initialized": False, "commits": 0, "dirty": False, "last": ""}
    count = _git(d, "rev-list", "--count", "HEAD")
    status = _git(d, "status", "--porcelain")
    last = _git(d, "log", "-1", "--format=%h %ad %s", "--date=short")
    return {"initialized": True,
            "commits": int(count.stdout.strip() or 0),
            "dirty": bool(status.stdout.strip()),
            "last": last.stdout.strip()}
