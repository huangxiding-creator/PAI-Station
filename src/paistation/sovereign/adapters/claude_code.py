"""Claude Code 适配器：CLAUDE.md + memory/*.md（对齐官方记忆消费习惯）。

产物落 `.claude/` 即生效：CLAUDE.md 常驻上下文（画像+决策索引+记忆索引），
memory/ 一条记忆一文件（frontmatter 带 ts/source/tags 溯源）。
"""
from __future__ import annotations

import re
from pathlib import Path

from ._common import first_line, memory_entries, render_identity_md

_SAFE = re.compile(r"[^\w一-鿿-]+")


def export(data_dir: str | Path, dest: str | Path, clock=None) -> dict:
    dest = Path(dest)
    (dest / "memory").mkdir(parents=True, exist_ok=True)
    entries = memory_entries(data_dir)
    body = render_identity_md(data_dir, title="CLAUDE.md — 主权画像导入")
    body += f"\n## 记忆索引（{len(entries)} 条，全文见 memory/ 目录）\n\n"
    body += "\n".join(f"- `memory/{_fname(i, e)}`：{first_line(e.text)}"
                      for i, e in enumerate(entries, 1)) + "\n"
    (dest / "CLAUDE.md").write_text(body, encoding="utf-8")
    for i, entry in enumerate(entries, 1):
        tags = " ".join(f"#{t}" for t in entry.tags)
        head = (f"---\nts: {entry.ts}\nsource: {entry.source}\n"
                f"tags: {tags}\n---\n\n")
        (dest / "memory" / _fname(i, entry)).write_text(
            head + entry.text + "\n", encoding="utf-8")
    return {"memories": len(entries)}


def _fname(index: int, entry) -> str:
    slug = (_SAFE.sub("-", first_line(entry.text))[:24].strip("-")
            or "mem")
    return f"REC-{index:03d}-{slug}.md"


def validate(dest: str | Path) -> bool:
    """产物结构自检（即用前检查）。"""
    main = Path(dest) / "CLAUDE.md"
    return main.is_file() and "用户画像" in main.read_text(encoding="utf-8")
