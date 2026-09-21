# -*- coding: utf-8 -*-
"""推送伴随备份 — 两 GitHub 仓 + We-AIPO 全量备份到百度网盘 (用户令 2026-09-21).

「推送的同时全量备份到百度网盘」的落地形态:
  备份物 = git bundle (全部历史+分支, 可 git clone 直接恢复):
    - 首次/基线超30天/历史改写 → full bundle (--all, 全量基线)
    - 平时每次推送后 → incr bundle (^last_head <branch>, 仅新增量)
  恢复 = clone 最新 full bundle → 依时序 pull incr bundle 链 = 全量还原。

为什么 bundle 而非打 zip: (a) 只含 git 管辖内容 — secrets/运行时态天然
不进备份 (红线: secrets 不出库); (b) 增量链让 2G 级仓库日常只传 KB-MB。

bdpan 坑 (2026-09-21 实测): bash 下远端路径必须 MSYS_NO_PATHCONV=1,
本地路径须 Windows 式; python subprocess 直调无此坑。上传自动建目录。

Usage:
    python repo_baidu_backup.py              # 全部仓库 (增量/按需全量)
    python repo_baidu_backup.py --repo PAI-Station
    python repo_baidu_backup.py --full       # 强制全量基线
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

REPOS: dict[str, str] = {
    "PAI-Station": r"E:\AI-Station",
    "ResearchFactory-Eng": r"E:\AI-Station\ResearchFactory-Eng",
    "We-AIPO": r"E:\CPOPC\We-AIPO",
}
REMOTE_BASE = "/apps/bdpan/repo-backup"
STATE_FILE = Path(r"E:\AI-Station\tools\repo_backup_state.json")
TMP_DIR = Path(r"E:\AI-Station\tools\_repo_backup_tmp")
FULL_REFRESH_DAYS = 30
UPLOAD_TIMEOUT = 5400          # 2G 级全量基线也给足
_CREATE_NO_WINDOW = 0x08000000

_BDPAN = (Path(r"C:\Users\91216\AppData\Local\bdpan\bdpan.exe"))
_SESSION_ID = f"{int(time.time())}-repobk"


def _run(cmd: list[str], timeout: int = 120, cwd: str | None = None):
    return subprocess.run(
        cmd, capture_output=True, timeout=timeout, cwd=cwd,
        creationflags=_CREATE_NO_WINDOW,
    )


def _git(repo: str, *args: str, timeout: int = 120) -> str:
    r = _run(["git", "-C", repo, *args], timeout=timeout)
    if r.returncode != 0:
        raise RuntimeError(
            f"git {' '.join(args)} 失败: "
            f"{r.stderr.decode('utf-8', 'replace')[:200]}")
    return r.stdout.decode("utf-8", "replace").strip()


def _bdpan(*args: str, timeout: int = 120) -> tuple[int, str]:
    """bdpan CLI 调用 (python 直调无 MSYS 路径转换坑)."""
    cmd = [str(_BDPAN), *args, "--agentname", "claude-code",
           "--session-input", "推送伴随备份", "--session-id", _SESSION_ID]
    r = _run(cmd, timeout=timeout)
    out = (r.stdout + r.stderr).decode("utf-8", "replace")
    return r.returncode, out


def _load_state() -> dict:
    try:
        return json.loads(STATE_FILE.read_text(encoding="utf-8"))
    except Exception:
        return {}


def _save_state(state: dict) -> None:
    STATE_FILE.write_text(
        json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")


def _upload_verify(local: Path, remote_dir: str,
                   remote_name: str) -> tuple[bool, str]:
    code, out = _bdpan("upload", str(local), f"{remote_dir}/{remote_name}",
                       timeout=UPLOAD_TIMEOUT)
    if code != 0 or "上传成功" not in out:
        # 单次重试 (网络抖动), 失败如实报
        time.sleep(5)
        code, out = _bdpan("upload", str(local),
                           f"{remote_dir}/{remote_name}",
                           timeout=UPLOAD_TIMEOUT)
        if code != 0 or "上传成功" not in out:
            return False, out.strip()[-300:]

    code, out = _bdpan("ls", remote_dir, "--json")
    if code == 0:
        try:
            entries = json.loads(out)
            for e in (entries if isinstance(entries, list)
                      else entries.get("list", [])):
                if (e.get("server_filename") == remote_name
                        and int(e.get("size", -1)) == local.stat().st_size):
                    return True, e.get("path", "")
        except Exception:
            pass
    return False, f"上传后 ls 校验失败: {out.strip()[-200:]}"


def backup_repo(name: str, repo: str, force_full: bool,
                state: dict) -> dict:
    """单仓备份: 选模式 → bundle → 上传 → 校验 → 状态更新."""
    head = _git(repo, "rev-parse", "HEAD")
    branch = _git(repo, "branch", "--show-current") or "master"
    prev = state.get(name, {})
    last_head = prev.get("last_head", "")

    if head == last_head:
        return {"repo": name, "skipped": "无新提交 (HEAD 未变)"}

    need_full = force_full or not last_head
    if not need_full and prev.get("last_full_at"):
        age = (datetime.now()
               - datetime.fromisoformat(prev["last_full_at"])).days
        need_full = age >= FULL_REFRESH_DAYS
    if not need_full and last_head:
        # 历史改写/强推检测: last_head 必须仍是 HEAD 祖先, 否则全量重来
        anc = _run(["git", "-C", repo, "merge-base",
                    "--is-ancestor", last_head, head])
        need_full = anc.returncode != 0

    mode = "full" if need_full else "incr"
    stamp = datetime.now().strftime("%Y%m%d_%H%M")
    fname = f"{mode}_{stamp}_{head[:8]}.bundle"
    remote_dir = f"{REMOTE_BASE}/{name}"
    TMP_DIR.mkdir(parents=True, exist_ok=True)
    local = TMP_DIR / fname

    if mode == "full":
        args = ["bundle", "create", str(local), "--all"]
    else:
        args = ["bundle", "create", str(local), f"^{last_head}", branch]
    # 2G 级仓库打包远超默认 120s (We-AIPO 2026-09-21 实锤超时), 给足 90 分钟
    _git(repo, *args, timeout=5400)       # 失败直接抛 (含 last_head 丢失)

    ok, detail = _upload_verify(local, remote_dir, fname)
    local.unlink(missing_ok=True)
    if not ok:
        return {"repo": name, "status": "failed", "mode": mode,
                "file": fname, "error": detail}

    entry = {"last_head": head, "last_mode": mode, "last_file": fname,
             "last_backup_at": datetime.now().isoformat(timespec="seconds")}
    if mode == "full":
        entry["last_full_at"] = entry["last_backup_at"]
    else:
        entry["last_full_at"] = prev.get("last_full_at")
    state[name] = entry
    return {"repo": name, "status": "ok", "mode": mode, "file": fname,
            "branch": branch, "detail": detail}


def main() -> int:
    ap = argparse.ArgumentParser(description="推送伴随百度网盘 bundle 备份")
    ap.add_argument("--repo", choices=list(REPOS), help="只备份指定仓库")
    ap.add_argument("--full", action="store_true", help="强制全量基线")
    args = ap.parse_args()

    targets = {args.repo: REPOS[args.repo]} if args.repo else REPOS
    state = _load_state()
    results, failed = [], []
    for name, repo in targets.items():
        print(f"[备份] {name} ...", flush=True)
        try:
            r = backup_repo(name, repo, args.full, state)
        except Exception as e:
            r = {"repo": name, "status": "failed", "error": str(e)[:300]}
        results.append(r)
        if r.get("status") == "failed":
            failed.append(name)
        elif not r.get("skipped"):
            _save_state(state)            # 每仓成功即落状态 (断点续)
        tag = r.get("status") or "skipped"
        print(f"  -> {tag} {r.get('mode', '')} "
              f"{r.get('file', r.get('skipped', r.get('error', '')[:80]))}",
              flush=True)

    print(f"\n[备份] 完成: {len(results) - len(failed)}/{len(results)} 成功"
          + (f", 失败: {', '.join(failed)}" if failed else ""))
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
