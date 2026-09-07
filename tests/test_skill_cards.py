"""M2.5 铸造厂：课程 → 技能卡蒸馏（LLM 提炼 + SKILL.md 落盘）。"""
import json

from paistation.forge.skill_cards import (
    card_to_skill_md,
    distill_cards,
    save_cards,
)


def fake_deep_ok(prompt, reasoning=True):
    cards = [{"name": "GEO品牌信息梳理法", "description": "梳理品牌信息让AI理解",
              "when_to_use": "做GEO优化前",
              "steps": ["收集用户真实提问", "梳理全网品牌触点", "统一口径表达"],
              "example": "从官网到门店统一'你是谁、适合谁'",
              "source": "第二章"},
             {"name": "消费三段论定位", "description": "功能/兴趣/表达消费定位",
              "when_to_use": "新品定位", "steps": ["看人群", "看动机", "看表达"],
              "example": "表达消费时代卖身份认同", "source": "第一章"}]
    return {"text": "```json\n" + json.dumps(cards, ensure_ascii=False) + "\n```"}


def fake_deep_garbage(prompt, reasoning=True):
    return {"text": "模型抖动输出非JSON"}


def course():
    return {"course_id": "C1", "title": "GEO课", "teacher": "白鸦",
            "intro": "简介",
            "chapters": [{"title": "第一章", "video_id": "V1", "duration": 100,
                          "transcript": "消费行为变迁" * 50}]}


def test_distill_cards_parses_fenced_json():
    cards = distill_cards(fake_deep_ok, course())
    assert len(cards) == 2
    assert cards[0]["name"] == "GEO品牌信息梳理法"
    assert len(cards[0]["steps"]) == 3


def test_distill_cards_garbage_returns_empty():
    assert distill_cards(fake_deep_garbage, course()) == []


def test_distill_cards_dedup_and_cap():
    def deep(prompt, reasoning=True):
        one = {"name": "同名卡", "description": "d", "when_to_use": "w",
               "steps": ["s1"], "example": "e", "source": "c"}
        return {"text": json.dumps([one] * 8, ensure_ascii=False)}
    cards = distill_cards(deep, course(), max_cards=5)
    assert len(cards) == 1  # 同名去重


def test_card_to_skill_md_frontmatter():
    card = {"name": "GEO品牌信息梳理法", "description": "梳理品牌信息",
            "when_to_use": "做GEO前", "steps": ["一", "二"],
            "example": "示例", "source": "第二章"}
    md = card_to_skill_md(card)
    assert md.startswith("---\n")
    assert "name: GEO品牌信息梳理法" in md
    assert "description: 梳理品牌信息" in md
    assert "## 适用时机" in md and "做GEO前" in md
    assert "1. 一" in md


def test_save_cards_writes_skill_dirs(tmp_path):
    cards = [{"name": "卡A", "description": "d", "when_to_use": "w",
              "steps": ["s"], "example": "e", "source": "c"}]
    written = save_cards(cards, str(tmp_path))
    assert len(written) == 1
    path = tmp_path / "卡A" / "SKILL.md"
    assert path.exists()
    assert "name: 卡A" in path.read_text(encoding="utf-8")
