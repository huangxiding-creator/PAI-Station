"""外部课程库同步器——保持上游开源课与本地萃取库的后续同步。

用法：
    python tools/sync_external.py            # 拉取并报告与基线的差异
    python tools/sync_external.py --status   # 只读检查，不 pull

纪律（05 方法/任鑫AI原生组织转型/README.md）：
- 上游原文 CC BY-NC-ND 4.0：镜像留 external/（gitignored，永不入库）；
- 同步后若 diff 非空 → 人工/AI 重读变动文件 → 增补萃取稿 → 更新基线 → 重签 R14 凭证。
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from datetime import datetime
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION_ROOT = Path(__file__).resolve().parent.parent

# 每条 = 一个受同步的外部库；新增库在此登记即可
EXTERNAL_REPOS: list[dict] = [
    {
        "name": "ai-native-org-transformation",
        "path": STATION_ROOT / "external" / "ai-native-org-transformation",
        "distillate": STATION_ROOT / "05 方法" / "任鑫AI原生组织转型",
    },
]


def _git(repo: Path, *args: str) -> str:
    """跑一条 git 命令，失败抛异常（不静默——红线 R2）。"""
    proc = subprocess.run(
        ["git", "-C", str(repo), *args],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
    )
    if proc.returncode != 0:
        raise RuntimeError(f"git {' '.join(args)} 失败: {proc.stderr.strip()}")
    return proc.stdout.strip()


def _baseline_path(entry: dict) -> Path:
    return entry["distillate"] / "_sync.json"


def read_baseline(entry: dict) -> dict | None:
    path = _baseline_path(entry)
    if not path.exists():
        return None
    return json.loads(path.read_text(encoding="utf-8"))


def write_baseline(entry: dict, commit: str) -> None:
    path = _baseline_path(entry)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps({
        "repo": entry["name"],
        "last_synced": commit,
        "synced_at": datetime.now().isoformat(timespec="seconds"),
    }, ensure_ascii=False, indent=2), encoding="utf-8")


def sync_one(entry: dict, dry: bool) -> None:
    repo: Path = entry["path"]
    if not (repo / ".git").exists():
        print(f"[{entry['name']}] ✗ 镜像不存在: {repo}")
        return

    before = _git(repo, "rev-parse", "HEAD")
    base = read_baseline(entry)
    base_commit = base["last_synced"] if base else None

    if dry:
        remote = _git(repo, "ls-remote", "origin", "HEAD").split()[0]
        state = "最新" if remote == before else f"远端 {remote[:7]} ≠ 本地 {before[:7]}（--status 只读，未拉取）"
        print(f"[{entry['name']}] 本地 {before[:7]}｜基线 {str(base_commit or '无')[:7]}｜{state}")
        return

    _git(repo, "fetch", "origin")
    _git(repo, "pull", "--ff-only", "origin", "main")
    after = _git(repo, "rev-parse", "HEAD")

    if after == before:
        print(f"[{entry['name']}] ✓ 已是最新 {after[:7]}（基线 {str(base_commit or '无')[:7]}）")
        if base_commit != after:
            write_baseline(entry, after)
            print(f"    基线落后于本地，已回写 {after[:7]}")
        return

    write_baseline(entry, after)
    print(f"[{entry['name']}] ↑ {before[:7]} → {after[:7]}，最新提交: {_git(repo, 'log', '-1', '--format=%s')}")
    diff_range = f"{base_commit or before}..{after}"
    stat = _git(repo, "diff", "--stat", diff_range)
    print(f"    变动（{diff_range[:15]}…）:\n    " + stat.replace("\n", "\n    "))
    print(f"    → 下一步：重读变动文件，增补 {entry['distillate'].name}/ 萃取稿，重签 R14 凭证")


def main() -> None:
    parser = argparse.ArgumentParser(description="外部课程库同步器")
    parser.add_argument("--status", action="store_true", help="只读检查，不 pull")
    args = parser.parse_args()
    for entry in EXTERNAL_REPOS:
        try:
            sync_one(entry, dry=args.status)
        except Exception as exc:  # 单库失败不挡其他库，但必须报出来
            print(f"[{entry['name']}] ✗ {exc}")


if __name__ == "__main__":
    main()
