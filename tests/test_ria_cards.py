"""B2「书→记忆闭环」测试：RIA 出题 / 人改写关卡 / fsrs 分档 / Anki 导出。

制卡纪律吸收自生态共识（AnkiGPT 人审 / genanki GUID 幂等 / Lute 带语境）。
"""
import json

import pytest

from paistation.learn.fsrs_queue import FsrsQueue
from paistation.learn.ria_cards import (
    card_retention,
    commit_cards,
    export_apkg,
    generate_cards,
    guid_for,
    stage_cards,
)


def _book():
    return {
        "bookId": "B1", "title": "智能商业",
        "chapters": [
            {"chapterUid": 1, "title": "第一章 智能商业", "level": 1,
             "html": "", "text": "网络协同带来复利。"},
            {"chapterUid": 2, "title": "第二章", "level": 1,
             "html": "", "text": "数据智能。"},
        ],
    }


_RAW = [
    {"type": "concept", "quote": "网络协同带来复利",
     "question": "书中说“网络协同带来复利”，指的是什么？",
     "retell": "多个参与者在线协作产生复利", "action": ""},
    {"type": "concept", "quote": "协同与数据", "question": "协同与数据的关系？",
     "retell": "双螺旋", "action": ""},
    {"type": "concept", "quote": "多余", "question": "多余卡", "retell": "x", "action": ""},
    {"type": "action", "quote": "先协同后智能", "question": "如何应用先协同后智能？",
     "retell": "顺序", "action": "本周画一次自己业务的双螺旋图"},
]


def _deep(prompt, reasoning=True):
    return {"text": json.dumps(_RAW, ensure_ascii=False)}


# ---------- 出题 ----------

def test_generate_cards_quota_controlled():
    cards = generate_cards(_book(), _deep, quotas={"concept": 2, "action": 1})
    kinds = [c["type"] for c in cards]
    assert kinds.count("concept") == 2 and kinds.count("action") == 1
    assert cards[0]["card_id"] == "B1-1-01"
    assert cards[0]["source"] == "智能商业·第一章 智能商业"
    assert cards[0]["quote"]                    # Lute 纪律：卡带原文语境
    assert cards[0]["staged"] is False


def test_generate_cards_model_failure_empty():
    cards = generate_cards(_book(), lambda p, reasoning=True: 1 / 0,  # noqa
                           quotas={"concept": 1, "action": 0})
    assert cards == []


# ---------- 人改写关卡 ----------

def test_stage_and_commit_gate(tmp_path):
    cards = generate_cards(_book(), _deep, quotas={"concept": 3, "action": 1})
    staged = stage_cards(cards, str(tmp_path))
    assert json.loads(open(staged, encoding="utf-8").read())["cards"][0]["card_id"] == "B1-1-01"

    queue = FsrsQueue(str(tmp_path / "q.json"), daily_limit=3,
                      now_fn=lambda: __import__("datetime").datetime(2026, 9, 10,
                                                                     tzinfo=__import__("datetime").UTC))
    edits = {"B1-1-01": {"retell": "我自己的话：协作出复利", "approved": True}}
    out = commit_cards(staged, queue, edits)
    assert out["committed"] == ["B1-1-01"]
    assert out["remaining"] == 3                       # 未改写/未批准的留在关卡
    entry = queue._cards[0]                            # noqa: SLF001 - 测试窥探
    assert entry["front"].startswith("书中说")
    assert entry["back"] == "我自己的话：协作出复利"
    assert entry["retention"] == 0.9                   # concept 0.9 分档


def test_commit_requires_explicit_approval(tmp_path):
    cards = generate_cards(_book(), _deep, quotas={"concept": 2, "action": 0})
    staged = stage_cards(cards, str(tmp_path))
    queue = FsrsQueue(str(tmp_path / "q.json"))
    assert commit_cards(staged, queue, {})["committed"] == []


def test_action_card_retention_and_back(tmp_path):
    cards = generate_cards(_book(), _deep, quotas={"concept": 0, "action": 1})
    staged = stage_cards(cards, str(tmp_path))
    queue = FsrsQueue(str(tmp_path / "q.json"))
    action_id = cards[0]["card_id"]
    commit_cards(staged, queue, {action_id: {"approved": True}})
    entry = queue._cards[0]                            # noqa: SLF001
    assert entry["retention"] == 0.8                   # action 0.8 分档
    assert entry["back"].startswith("行动：")


def test_card_retention_mapping():
    assert card_retention({"type": "concept"}) == 0.9
    assert card_retention({"type": "action"}) == 0.8


# ---------- fsrs 分档与日志（FsrsQueue 扩展） ----------

def test_fsrs_retention_and_review_log(tmp_path):
    queue = FsrsQueue(str(tmp_path / "q.json"),
                      now_fn=lambda: __import__("datetime").datetime(
                          2026, 9, 10, tzinfo=__import__("datetime").UTC))
    cid = queue.add("Q", "A", "src", retention=0.8)
    assert queue._cards[0]["retention"] == 0.8         # noqa: SLF001
    out = queue.review(cid, 3)
    assert out["due"] and out["stability"] >= 0
    assert queue._cards[0]["logs"][0]["rating"] == 3   # noqa: SLF001 - ReviewLog 落库


def test_fsrs_add_without_retention_backward_compat(tmp_path):
    queue = FsrsQueue(str(tmp_path / "q.json"))
    queue.add("Q", "A")
    assert "retention" not in queue._cards[0]          # noqa: SLF001


# ---------- Anki 导出 ----------

def test_guid_stable_and_distinct():
    c1 = {"book_id": "B1", "chapter_uid": 1, "seq": 1}
    assert guid_for(c1) == guid_for(dict(c1))
    assert guid_for(c1) != guid_for({**c1, "seq": 2})


def test_export_apkg(tmp_path):
    pytest.importorskip("genanki")
    cards = generate_cards(_book(), _deep, quotas={"concept": 2, "action": 1})
    out = export_apkg(cards, str(tmp_path / "deck.apkg"), deck_name="智能商业")
    data = (tmp_path / "deck.apkg").read_bytes()
    assert len(data) > 1000 and data[:2] == b"PK"      # .apkg 是 zip
    assert out.endswith("deck.apkg")
