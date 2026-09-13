"""OpenClaw 适配器：skills/ 结构 + AGENTS.md。

技能目录整体复制（SKILL.md + 附属文件），frontmatter 自动补 version
（OpenClaw 技能元数据习惯）；AGENTS.md 为画像+记忆摘要的常驻说明书。
"""
from __future__ import annotations

import shutil
from pathlib import Path

from ._common import first_line, memory_entries, render_identity_md


def export(data_dir: str | Path, dest: str | Path, clock=None) -> dict:
    dest = Path(dest)
    skills_src = Path(data_dir) / "skills"
    count = 0
    if skills_src.is_dir():
        for skill in sorted(p for p in skills_src.iterdir() if p.is_dir()):
            if not (skill / "SKILL.md").is_file():
                continue
            target_dir = dest / "skills" / skill.name
            target_dir.mkdir(parents=True, exist_ok=True)
            for extra in sorted(skill.rglob("*")):
                if not extra.is_file():
                    continue
                rel = extra.relative_to(skill)
                (target_dir / rel).parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(extra, target_dir / rel)
            _ensure_version(target_dir / "SKILL.md")
            count += 1
    body = render_identity_md(data_dir, title="AGENTS.md — 主权画像导入")
    entries = memory_entries(data_dir)
    body += "\n## 记忆摘要\n\n" + "\n".join(
        f"- {first_line(e.text)}" for e in entries) + "\n"
    (dest / "AGENTS.md").write_text(body, encoding="utf-8")
    return {"skills": count}


def _ensure_version(path: Path) -> None:
    raw = path.read_text(encoding="utf-8")
    if not raw.startswith("---"):
        return
    parts = raw.split("---", 2)
    if len(parts) >= 2 and "version:" in parts[1]:
        return
    path.write_text(raw.replace("---\n", "---\nversion: 1.0\n", 1),
                    encoding="utf-8")


def validate(dest: str | Path) -> bool:
    dest = Path(dest)
    if not (dest / "AGENTS.md").is_file():
        return False
    skills = dest / "skills"
    return skills.is_dir() and any(skills.glob("*/SKILL.md"))
