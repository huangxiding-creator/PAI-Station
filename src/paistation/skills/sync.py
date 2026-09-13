"""M6.6 GitHub 备份同步（FR14）：用户自配仓库，本地进化始终有远端备份。

- configure：用户自己填 remote/branch（密钥走系统凭据管理器或 ssh，
  本模块永不接触凭据内容）
- 硬排除：.gitignore 强制注入 secrets/凭据/事件流模式 + 推送前
  ls-files 守卫（已被追踪的敏感文件直接拒推）
- 断网积压：push 失败进 backlog，恢复后下一次 push 自动补推清账
"""
from __future__ import annotations

import json
import subprocess
from datetime import datetime
from pathlib import Path

EXCLUDE_PATTERNS = (
    "*credential*", "*secret*", "*authkey*", "*.vault", "*.env", "events/")
_BLACKLIST_SUBSTR = ("credential", "secret", "authkey", ".vault", ".env")


class BackupSync:
    """configure→push（守卫+积压补推）。git 缺席或网络断=排队不炸。"""

    def __init__(self, data_dir: str | Path, repo_dir: str | Path):
        self._dir = Path(data_dir)
        self._repo_dir = Path(repo_dir)
        self._cfg_path = self._dir / "sync_config.json"
        self._backlog_path = self._dir / "sync_backlog.json"

    def configure(self, remote: str, branch: str = "main") -> None:
        self._dir.mkdir(parents=True, exist_ok=True)
        self._cfg_path.write_text(
            json.dumps({"remote": remote, "branch": branch},
                       ensure_ascii=False, indent=1),
            encoding="utf-8")

    def _config(self) -> dict:
        if not self._cfg_path.is_file():
            return {}
        try:
            return json.loads(self._cfg_path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return {}

    def _git(self, *args: str) -> subprocess.CompletedProcess:
        return subprocess.run(
            ["git", "-C", str(self._repo_dir), *args],
            capture_output=True, text=True, encoding="utf-8",
            errors="replace")

    # ---- 守卫 ----

    def ensure_gitignore(self) -> None:
        gi = self._repo_dir / ".gitignore"
        existing = gi.read_text(encoding="utf-8") if gi.is_file() else ""
        missing = [p for p in EXCLUDE_PATTERNS if p not in existing]
        if missing:
            gi.write_text(existing + ("\n" if existing else "")
                          + "\n".join(missing) + "\n", encoding="utf-8")

    def _guard_no_tracked_secrets(self) -> None:
        proc = self._git("ls-files")
        tracked = proc.stdout.split()
        bad = [f for f in tracked
               if any(b in f.lower() for b in _BLACKLIST_SUBSTR)]
        if bad:
            raise RuntimeError(
                f"拒绝推送：以下敏感文件已被 git 追踪，先移出再同步：{bad}")

    # ---- 积压 ----

    def _backlog(self) -> list[dict]:
        if not self._backlog_path.is_file():
            return []
        try:
            return json.loads(self._backlog_path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return []

    def _queue(self, error: str) -> None:
        items = self._backlog()
        items.append({"ts": datetime.now().isoformat(timespec="seconds"),
                      "error": error[:300]})
        self._backlog_path.write_text(
            json.dumps(items, ensure_ascii=False, indent=1), encoding="utf-8")

    # ---- 推送 ----

    def push(self) -> dict:
        cfg = self._config()
        if not cfg.get("remote"):
            return {"pushed": False, "queued": False,
                    "reason": "未配置远端（先 configure）"}
        self._repo_dir.mkdir(parents=True, exist_ok=True)
        if not (self._repo_dir / ".git").is_dir():
            self._git("init", "-q")
            self._git("config", "user.name", "PAI-Station")
            self._git("config", "user.email", "pai@local")
        self.ensure_gitignore()
        self._git("add", "-A")
        if self._git("status", "--porcelain").stdout.strip():
            self._git("commit", "-q", "-m", "sync: 备份快照")
        self._guard_no_tracked_secrets()

        self._git("remote", "remove", "origin")
        self._git("remote", "add", "origin", cfg["remote"])
        proc = self._git("push", "origin", f"HEAD:refs/heads/{cfg.get('branch', 'main')}")
        if proc.returncode != 0:
            self._queue(proc.stderr.strip() or "push 失败")
            return {"pushed": False, "queued": True,
                    "reason": proc.stderr.strip()[:200]}

        flushed = len(self._backlog())
        if flushed:
            self._backlog_path.unlink(missing_ok=True)
        return {"pushed": True, "flushed": flushed}
