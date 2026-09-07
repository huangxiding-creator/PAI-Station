"""M3 技能执行器：SKILL.md 加载 → 上下文组装 → 执行。"""

import pytest

from paistation.skills.executor import SkillExecutor

SKILL_MD = """---
name: weekly-report
description: 把零散笔记整理成结构化周报
model: fast
---

你是周报助手。规则：
1. 按本周完成/风险/下周计划三段输出
2. 引用具体文件名
"""


@pytest.fixture
def skills_dir(tmp_path):
    d = tmp_path / "skills" / "weekly-report"
    d.mkdir(parents=True)
    (d / "SKILL.md").write_text(SKILL_MD, encoding="utf-8")
    other = tmp_path / "skills" / "broken"
    other.mkdir()
    (other / "SKILL.md").write_text("没有 frontmatter 的技能", encoding="utf-8")
    return str(tmp_path / "skills")


class FakeClient:
    def __init__(self):
        self.calls = []

    def fast(self, prompt, context="", json_mode=False):
        self.calls.append({"prompt": prompt, "context": context})
        return {"text": f"回答<{len(context)}>", "usage": {}, "confidence": 1.0}

    def deep(self, prompt, reasoning=True):
        self.calls.append({"prompt": prompt, "context": ""})
        return {"text": "深度回答", "chain": "m1", "confidence": 0.9}


class FakeStore:
    def __init__(self, hits):
        self._hits = hits
        self.queries = []

    def search(self, query, limit=10):
        self.queries.append(query)
        return self._hits


def test_list_and_load(skills_dir):
    ex = SkillExecutor(skills_dir=skills_dir, client=FakeClient())
    assert sorted(ex.list_skills()) == ["broken", "weekly-report"]
    skill = ex.load("weekly-report")
    assert skill["name"] == "weekly-report"
    assert skill["model"] == "fast"
    assert "周报助手" in skill["body"]


def test_load_missing_raises(skills_dir):
    ex = SkillExecutor(skills_dir=skills_dir, client=FakeClient())
    with pytest.raises(FileNotFoundError):
        ex.load("不存在")


def test_run_fast_assembles_context(skills_dir):
    client = FakeClient()
    hits = [{"path": "d:/周报.md", "summary": "本周完成风险排查", "score": 0.9}]
    ex = SkillExecutor(skills_dir=skills_dir, client=client, store=FakeStore(hits))
    r = ex.run("weekly-report", "帮我整理本周周报")
    assert r["answer"].startswith("回答<") and r["context_chars"] > 0
    ctx = client.calls[0]["context"]
    assert "周报助手" in ctx            # SKILL 正文进了上下文
    assert "风险排查" in ctx            # 记忆命中进了上下文
    assert "帮我整理本周周报" in client.calls[0]["prompt"]


def test_run_deep_model_routed(skills_dir):
    client = FakeClient()
    ex = SkillExecutor(skills_dir=skills_dir, client=client)
    # 临时改 frontmatter model=deep
    p = ex._skill_path("weekly-report")
    p.write_text(SKILL_MD.replace("model: fast", "model: deep"), encoding="utf-8")
    r = ex.run("weekly-report", "x")
    assert r["answer"] == "深度回答"


def test_run_without_store_still_works(skills_dir):
    ex = SkillExecutor(skills_dir=skills_dir, client=FakeClient())
    r = ex.run("weekly-report", "问题")
    assert r["answer"].startswith("回答<")


def test_run_returns_usage_meta(skills_dir):
    ex = SkillExecutor(skills_dir=skills_dir, client=FakeClient())
    r = ex.run("weekly-report", "q")
    assert r["skill"] == "weekly-report" and r["model"] == "fast"
