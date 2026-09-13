"""D3 跨标准适配器（E4）：Anthropic skills/MCP/agents.md/OpenClaw 双向转换。

导入为主（逆向思维：做适配器接入现有生态，不自造生态）。导入即 eval：
frontmatter 完整（name+description）+body 非空才算通过——空壳技能拒收。
"""
from __future__ import annotations

import re
import shutil
from pathlib import Path

_FRONT = re.compile(r"\A---\s*\n(.*?)\n---", re.DOTALL)


def _frontmatter(skill_md: Path) -> dict:
    text = skill_md.read_text(encoding="utf-8")
    m = _FRONT.match(text)
    meta: dict = {}
    if m:
        for line in m.group(1).splitlines():
            if ":" in line:
                k, _, v = line.partition(":")
                meta[k.strip()] = v.strip()
    return meta


def _eval_skill(skill_md: Path) -> tuple[bool, str]:
    """导入即 eval：结构完整+有正文（空壳拒收）。"""
    if not skill_md.is_file():
        return False, "缺 SKILL.md"
    meta = _frontmatter(skill_md)
    if not meta.get("name") or not meta.get("description"):
        return False, "frontmatter 缺 name/description（eval 不过）"
    body = _FRONT.sub("", skill_md.read_text(encoding="utf-8")).strip()
    if len(body) < 10:
        return False, "正文过空（eval 不过）"
    return True, ""


def import_anthropic_skill(src: str | Path, data_dir: str | Path) -> dict:
    """Anthropic skills 目录一键导入 → data/skills/<name>/。"""
    src = Path(src)
    skill_md = src / "SKILL.md"
    ok, why = _eval_skill(skill_md)
    if not ok:
        return {"imported": False, "reason": why, "eval_passed": False}
    name = _frontmatter(skill_md)["name"]
    target = Path(data_dir) / "skills" / name
    if target.exists():
        shutil.rmtree(target)
    shutil.copytree(src, target)
    return {"imported": True, "reason": "", "eval_passed": True, "name": name}


def from_openclaw(src: str | Path, data_dir: str | Path) -> dict:
    """OpenClaw skill → 本项目（补 version 字段）。"""
    src = Path(src)
    skill_md = src / "SKILL.md"
    ok, why = _eval_skill(skill_md)
    if not ok:
        return {"imported": False, "reason": why}
    meta = _frontmatter(skill_md)
    name = meta["name"]
    target = Path(data_dir) / "skills" / name
    if target.exists():
        shutil.rmtree(target)
    shutil.copytree(src, target)
    tmd = target / "SKILL.md"
    text = tmd.read_text(encoding="utf-8")
    if "version:" not in text.split("---")[1]:
        text = text.replace("---\n", f"---\nversion: {meta.get('version', '1.0')}\n", 1)
        tmd.write_text(text, encoding="utf-8")
    return {"imported": True, "reason": "", "name": name}


def to_mcp_manifest(skill_dir: str | Path) -> dict:
    """技能 → MCP server manifest（工具面=技能本体）。"""
    skill_md = Path(skill_dir) / "SKILL.md"
    meta = _frontmatter(skill_md)
    name = meta.get("name", Path(skill_dir).name)
    return {
        "name": name,
        "version": meta.get("version", "1.0"),
        "description": meta.get("description", ""),
        "tools": [{"name": name,
                   "description": meta.get("description", "")}],
    }


def to_agents_md(skills_dir: str | Path) -> str:
    """技能清单 → AGENTS.md（跨 harness 通用说明文件）。"""
    lines = ["# AGENTS", "", "可用技能：", ""]
    for d in sorted(Path(skills_dir).iterdir()):
        md = d / "SKILL.md"
        if md.is_file():
            meta = _frontmatter(md)
            desc = meta.get("description", "")
            lines.append(f"- **{meta.get('name', d.name)}**：{desc}")
    return "\n".join(lines) + "\n"
