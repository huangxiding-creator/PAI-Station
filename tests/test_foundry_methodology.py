# M7.0 方法论卡库：36 张三层卡 + 选卡检索（提案 M7 §3.3）
from paistation.foundry.methodology import (
    CARDS, card_count, cards_by_level, find_cards, get_card, validate_cards,
)


class TestCardLibrary:
    def test_36_cards_three_levels(self):
        assert card_count() == 36
        assert len(cards_by_level("L1")) == 12
        assert len(cards_by_level("L2")) == 12
        assert len(cards_by_level("L3")) == 12

    def test_card_fields_complete(self):
        for c in CARDS:
            assert c["id"] and c["name"] and c["one_liner"]
            assert c["level"] in ("L1", "L2", "L3")
            assert isinstance(c["structure"], str) and c["structure"]
            assert c["source"], f"{c['name']} 缺智库来源"

    def test_ids_unique(self):
        ids = [c["id"] for c in CARDS]
        assert len(ids) == len(set(ids))

    def test_validate_cards_passes(self):
        assert validate_cards() == []

    def test_transcript_sources_covered(self):
        """09-09 转录指定的智库清单必须落进卡库。"""
        names = " ".join(c["name"] + c["source"] for c in CARDS)
        for kw in ("麦肯锡", "金字塔", "芒格", "毛选", "混沌", "曾鸣", "一堂", "德鲁克"):
            assert kw in names, f"智库来源缺失: {kw}"


class TestRetrieval:
    def test_find_by_keyword(self):
        hits = find_cards("诊断")
        assert hits and all("诊断" in (c["name"] + c["one_liner"] + c["scenarios"])
                            or "诊断" in c["structure"] for c in hits)

    def test_find_level_filter(self):
        hits = find_cards("分析", level="L1")
        assert hits and all(c["level"] == "L1" for c in hits)

    def test_get_card(self):
        c = get_card("ooda")
        assert c and c["name"] == "OODA 循环"

    def test_get_card_missing_returns_none(self):
        assert get_card("no-such-card") is None

    def test_find_no_hit_empty(self):
        assert find_cards("量子涨落场论") == []
