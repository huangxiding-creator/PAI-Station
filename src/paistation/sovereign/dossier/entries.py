# -*- coding: utf-8 -*-
"""P0 主权卷宗·OKF 条目（markdown+YAML frontmatter）。

DISRUPTION_PLAN 假设②：卷宗先于站，站只是访客。资产形态=Open Knowledge
Format 风格——一条目一文件，YAML 元数据人可读可 diff 可 git。

条目通用元数据（v1）：
  id / kind / created / effective_to（null=当前有效，双时间线语义）
  / source / tags；其余键自由扩展（layer/key 由 kind=profile 用）。
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

import yaml

_FRONT = re.compile(r"\A---\s*\n(.*?)\n---\s*\n?", re.DOTALL)


@dataclass
class OkfEntry:
    """一条卷宗条目（frontmatter 元数据 + markdown 正文）。"""

    meta: dict
    body: str = ""

    @property
    def id(self) -> str:
        return str(self.meta.get("id", ""))

    def render(self) -> str:
        front = yaml.safe_dump(
            self.meta, allow_unicode=True, sort_keys=False,
            default_flow_style=False).strip()
        return f"---\n{front}\n---\n\n{self.body}"


def parse_entry(text: str) -> OkfEntry | None:
    """text → OkfEntry；无 frontmatter 或 YAML 坏 → None。"""
    match = _FRONT.match(text)
    if not match:
        return None
    try:
        meta = yaml.safe_load(match.group(1))
    except yaml.YAMLError:
        return None
    if not isinstance(meta, dict):
        return None
    return OkfEntry(meta=meta, body=text[match.end():].lstrip("\n"))


def write_entry(path: str | Path, entry: OkfEntry) -> None:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(path.suffix + ".tmp")
    tmp.write_text(entry.render(), encoding="utf-8")
    tmp.replace(path)


def read_entry(path: str | Path) -> OkfEntry | None:
    p = Path(path)
    if not p.is_file():
        return None
    return parse_entry(p.read_text(encoding="utf-8"))


def iter_entries(root: str | Path):
    """目录树内全部合法条目（相对路径, OkfEntry）。"""
    root = Path(root)
    for path in sorted(root.rglob("*.md")):
        entry = read_entry(path)
        if entry is not None and entry.id:
            yield path.relative_to(root).as_posix(), entry
