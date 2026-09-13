"""M6.7 成果反推技能（FR16）：扫历史成果→反推方法论→SKILL.md 候选。

全自动形成（不需用户安排）；激活走晨报一键确认（R15 永不自批）。
LLM 升级位：注入 llm(prompt)->str 反推方法论；缺席或失败降级为
模板法（标题+章节→步骤），反推永不空手。
"""
from __future__ import annotations

import re
from pathlib import Path

_DATE_PREFIX = re.compile(r"^\d{4}-\d{2}-\d{2}_")
_TITLE = re.compile(r"^#\s+(.+)$")
_SECTION = re.compile(r"^##\s+(.+)$", re.MULTILINE)
_BAD_CHARS = re.compile(r"[<>:\"/\\|?*\s]")

_PROMPT = (
    "以下是用户的一份历史成果文档。请反推完成此类任务的方法论，"
    "输出可直接用作 SKILL.md 正文的步骤清单（每步一行，含关键要点），"
    "不超过 12 步。\n\n")


def _clean_name(text: str) -> str:
    return _BAD_CHARS.sub("", text)[:30]


class AchievementSeeder:

    def __init__(self, forge, llm=None):
        self._forge = forge
        self._llm = llm

    def propose(self, achievements_dir: str | Path) -> list[dict]:
        root = Path(achievements_dir)
        if not root.is_dir():
            return []
        out: list[dict] = []
        for md in sorted(root.glob("*.md")):
            name = self._name_of(md)
            if not name or self._already_seeded(name):
                continue
            out.append(self._candidate(md, name))
        return out

    def _name_of(self, md: Path) -> str:
        text = md.read_text(encoding="utf-8", errors="replace")
        m = _TITLE.match(text.strip())
        if m:
            return _clean_name(m.group(1))
        stem = _DATE_PREFIX.sub("", md.stem)
        return _clean_name(stem)

    def _already_seeded(self, name: str) -> bool:
        repo_dir = self._forge.repo._dir
        return (repo_dir / name / "SKILL.md").is_file()

    def _candidate(self, md: Path, name: str) -> dict:
        text = md.read_text(encoding="utf-8", errors="replace")
        sections = [s.strip() for s in _SECTION.findall(text)]
        body = self._reverse_engineer(name, text, sections)
        draft = (
            "---\n"
            f"name: {name}\n"
            f"description: 从成果「{md.stem}」反推的技能\n"
            "version: 0.1.0\n"
            "source: skill-seed（成果反推，SKILL.md 兼容格式）\n"
            "---\n\n"
            f"# {name}\n\n"
            f"> 来源：历史成果反推（{md.name}）。\n"
            f"> 激活方式：晨报一键确认（永不自批）。\n\n"
            f"## 方法论\n{body}\n")
        return {"name": name, "title": name, "kind": "seeded",
                "draft": draft, "evidence": [md.name], "approved": False}

    def _reverse_engineer(self, name: str, text: str,
                          sections: list[str]) -> str:
        if self._llm is not None:
            try:
                body = str(self._llm(_PROMPT + text[:4000])).strip()
                if body:
                    return body
            except Exception:                     # noqa: BLE001 - 降级不空手
                pass
        if not sections:
            return "1. 按「" + name + "」历史成果的成稿结构复刻流程"
        return "\n".join(f"{i}. {s}" for i, s in enumerate(sections, 1))

    def promote(self, candidate: dict, approved: bool = False) -> str:
        if not approved:
            raise PermissionError(
                "成果反推技能未经用户批准（R15 永不自批），"
                "须晨报确认后携带 approved=True 再来")
        return self._forge.promote(candidate, approved=True)
