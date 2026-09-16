"""P0 源解析器：activities_cache / git / recent_lnk / power_system。

每个解析器都是纯函数（输入文件文本/路径 → list[EventEnvelope]），
便于单测与断点重跑；实际落库由 tools/cx_ingest.py 驱动。
"""

from __future__ import annotations

import json
import subprocess
from datetime import datetime
from pathlib import Path
from typing import Iterable

from paistation.cx.events import EventEnvelope

CREATE_NO_WINDOW = 0x08000000

# -- Windows 活动时间线（ActivitiesCache 已提取的 jsonl） ------------------

_ACTIVITY_TYPE = {
    10: "app.activity",
    11: "app.activity",
    12: "device.credential",
    16: "app.activity",
}


def parse_activities_jsonl(text: str) -> list[EventEnvelope]:
    events: list[EventEnvelope] = []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        row = json.loads(line)
        start = _parse_dt(row.get("start"))
        if start is None:
            continue
        app = row.get("app") or "unknown"
        ev_type = _ACTIVITY_TYPE.get(row.get("type"), "app.activity")
        payload = {"app": app}
        if row.get("title"):
            payload["title"] = row["title"]
        events.append(
            EventEnvelope(
                source="activities_cache",
                source_id=f"{row['start']}|{app}|{row.get('type')}",
                start=start,
                type=ev_type,
                payload=payload,
            )
        )
    return events


# -- Git 提交时间线 ---------------------------------------------------------

_SKIP_DIRS = {
    "node_modules", ".venv", "venv", "__pycache__", "dist", "build",
    "vendor", ".git", "target", "site-packages",
}


def find_git_repos(roots: Iterable[str], max_depth: int = 3) -> list[str]:
    """有界扫描 git 仓库目录（广度优先，剪掉依赖目录）。"""
    found: list[str] = []
    seen: set[str] = set()
    frontier = [Path(r) for r in roots if Path(r).is_dir()]
    for _ in range(max_depth):
        nxt: list[Path] = []
        for d in frontier:
            if d.name in _SKIP_DIRS:
                continue
            real = str(d.resolve())
            if real in seen:
                continue
            seen.add(real)
            if (d / ".git").exists():
                found.append(str(d))
            try:
                children = sorted(d.iterdir())
            except OSError:
                continue
            for c in children:
                if c.is_dir() and c.name not in _SKIP_DIRS:
                    nxt.append(c)
        frontier = nxt
        if not frontier:
            break
    return sorted(set(found))


def parse_git_log(repo: str, text: str) -> list[EventEnvelope]:
    """解析 `git log --pretty=%H<US>%ad<US>%s` 输出。"""
    name = Path(repo).name
    events: list[EventEnvelope] = []
    for line in text.splitlines():
        parts = line.split("\x1f")
        if len(parts) != 3:
            continue
        sha, ad, subject = parts
        when = _parse_dt(ad)
        if when is None:
            continue
        events.append(
            EventEnvelope(
                source="git",
                source_id=f"{name}/{sha}",
                start=when,
                type="work.commit",
                payload={"repo": name, "subject": subject[:200]},
            )
        )
    return events


def collect_git_events(
    repos: Iterable[str], since: str = "2016-01-01"
) -> list[EventEnvelope]:
    """对仓库列表逐一执行 git log 并汇总事件。"""
    events: list[EventEnvelope] = []
    for repo in repos:
        proc = subprocess.run(
            [
                "git", "-c", "safe.directory=*", "-C", repo,
                "log", "--all", f"--since={since}",
                "--date=iso-strict",
                "--pretty=format:%H%x1f%ad%x1f%s",
            ],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            creationflags=CREATE_NO_WINDOW,
            timeout=120,
        )
        if proc.returncode == 0 and proc.stdout.strip():
            events.extend(parse_git_log(repo, proc.stdout))
    return events


# -- 最近文档（Recent *.lnk 全量导出的 json） -------------------------------

def parse_recent_json(text: str) -> list[EventEnvelope]:
    rows = json.loads(text)
    if isinstance(rows, dict):
        rows = rows.get("items", [])
    events: list[EventEnvelope] = []
    for row in rows:
        last = _parse_dt(row.get("last"))
        if last is None:
            continue
        target = row.get("target") or ""
        events.append(
            EventEnvelope(
                source="recent_lnk",
                source_id=str(row.get("name") or target),
                start=last,
                type="doc.open",
                payload={"target": target},
            )
        )
    return events


# -- 电源/登录事件（PowerShell 导出的 json） --------------------------------

_POWER_TYPES = {
    7001: "session.login",
    7002: "session.logout",
    42: "session.sleep",
    1074: "session.shutdown",
}


def parse_power_json(text: str) -> list[EventEnvelope]:
    rows = json.loads(text)
    if isinstance(rows, dict):
        rows = [rows]
    events: list[EventEnvelope] = []
    for row in rows:
        created = _parse_dt(row.get("TimeCreated") or row.get("time"))
        if created is None:
            continue
        ev_id = row.get("Id") or row.get("id")
        ev_type = _POWER_TYPES.get(int(ev_id)) if ev_id is not None else None
        if ev_type is None:
            continue
        events.append(
            EventEnvelope(
                source="power_system",
                source_id=f"{row.get('RecordId', '')}|{ev_id}|{row['TimeCreated']}",
                start=created,
                type=ev_type,
                payload={"provider": row.get("ProviderName", "")},
            )
        )
    return events


# -- 工具 -------------------------------------------------------------------

def _parse_dt(value) -> datetime | None:
    if value is None:
        return None
    if isinstance(value, datetime):
        return value
    s = str(value).strip()
    if not s:
        return None
    # /Date(1785991466594)/ 形态（PS ConvertTo-Json）
    if s.startswith("/Date("):
        try:
            return datetime.fromtimestamp(int(s[6:-2]) / 1000)
        except (ValueError, OSError):
            return None
    try:
        return datetime.fromisoformat(s.replace("Z", "+00:00"))
    except ValueError:
        return None
