"""技能执行器（提案 4.2 skills）：SKILL.md 加载 → 上下文组装 → 执行。

SKILL.md 约定：YAML frontmatter（name/description/model: fast|deep）+ 正文
（给模型的行为规则）。run() 组装上下文 = SKILL 正文 + 记忆库检索命中，
按 frontmatter 路由 fast/deep。frontmatter 缺失的目录按 broken 跳过但可列出。
"""
import re
from pathlib import Path

_FRONT = re.compile(r"\A---\s*\n(.*?)\n---\s*\n?", re.DOTALL)


class SkillExecutor:
    """目录型技能加载与执行。"""

    def __init__(self, skills_dir, client, store=None, audit=None,
                 memory_hits: int = 5):
        self._dir = Path(skills_dir)
        self._client = client
        self._store = store
        self._audit = audit
        self._hits = memory_hits

    # ---------- 加载 ----------

    def _skill_path(self, name: str) -> Path:
        return self._dir / name / "SKILL.md"

    def list_skills(self) -> list[str]:
        if not self._dir.is_dir():
            return []
        return sorted(d.name for d in self._dir.iterdir()
                      if d.is_dir() and (d / "SKILL.md").exists())

    def load(self, name: str) -> dict:
        path = self._skill_path(name)
        if not path.is_file():
            raise FileNotFoundError(f"技能不存在：{path}")
        raw = path.read_text(encoding="utf-8")
        match = _FRONT.match(raw)
        meta: dict[str, str] = {}
        body = raw
        if match:
            for line in match.group(1).splitlines():
                if ":" in line:
                    key, _, value = line.partition(":")
                    meta[key.strip()] = value.strip()
            body = raw[match.end():]
        return {"name": meta.get("name", name), "description": meta.get("description", ""),
                "model": meta.get("model", "fast"), "body": body.strip()}

    # ---------- 执行 ----------

    def run(self, name: str, user_input: str) -> dict:
        skill = self.load(name)
        context = self._assemble(skill, user_input)
        model = skill["model"]
        if model == "deep":
            result = self._client.deep(user_input, reasoning=True)
            answer = result["text"]
        else:
            result = self._client.fast(user_input, context=context)
            answer = result["text"]
        if self._audit is not None:
            self._audit.record("skill.run", module="skills", skill=name,
                               model=model, context_chars=len(context))
        return {"answer": answer, "skill": skill["name"], "model": model,
                "context_chars": len(context)}

    def _assemble(self, skill: dict, user_input: str) -> str:
        parts = [f"# 技能：{skill['name']}\n{skill['body']}"]
        if self._store is not None:
            try:
                hits = self._store.search(user_input, limit=self._hits)
            except Exception:  # noqa: BLE001 - 记忆库故障不阻塞技能
                hits = []
            for h in hits:
                parts.append(f"# 相关记忆：{h.get('path', '')}\n{h.get('summary', '')}")
        return "\n\n".join(parts)
