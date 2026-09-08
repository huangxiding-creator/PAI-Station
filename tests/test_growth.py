"""R6 T14 FSRS 队列+成长周报(PGI/UGI) + T15 教学三档。"""
from datetime import UTC, datetime, timedelta

from paistation.learn.fsrs_queue import FsrsQueue
from paistation.learn.growth import pgi_score, ugi_score, weekly_report
from paistation.learn.teaching import minute_recap, scaffold_feedback, socratic_questions


def _now():
    return datetime(2026, 9, 8, 10, 0, tzinfo=UTC)


# ---- T14 FSRS 队列 ----

def test_add_card_becomes_due_immediately(tmp_path):
    q = FsrsQueue(str(tmp_path / "fsrs.json"), now_fn=_now)
    q.add(front="周报三段式是哪三段", back="产出/学习/计划", source="周报v3.docx")
    due = q.due_cards()
    assert len(due) == 1 and due[0]["front"].startswith("周报")


def test_daily_limit_three(tmp_path):
    q = FsrsQueue(str(tmp_path / "fsrs.json"), now_fn=_now, daily_limit=3)
    for i in range(6):
        q.add(front=f"卡{i}", back="答", source="doc")
    assert len(q.due_cards()) == 3  # 每日 3 张上限（防退化机制之一）


def test_review_good_schedules_future(tmp_path):
    clock = {"t": datetime.now(UTC)}
    q = FsrsQueue(str(tmp_path / "fsrs.json"), now_fn=lambda: clock["t"])
    cid = q.add(front="Q", back="A", source="s")
    q.review(cid, rating=3)  # Good → 学习步（分钟级）后排未来
    assert q.due_cards() == []  # 立即不再到期
    clock["t"] += timedelta(days=1)  # 一天后重新到期
    assert len(q.due_cards()) == 1


def test_review_again_redue_in_learning_step(tmp_path):
    clock = {"t": datetime.now(UTC)}
    q = FsrsQueue(str(tmp_path / "fsrs.json"), now_fn=lambda: clock["t"])
    cid = q.add(front="Q", back="A", source="s")
    q.review(cid, rating=1)  # Again → 1 分钟学习步内再见
    assert q.due_cards() == []
    clock["t"] += timedelta(minutes=2)
    assert len(q.due_cards()) == 1


def test_persistence_roundtrip(tmp_path):
    path = str(tmp_path / "fsrs.json")
    q = FsrsQueue(path, now_fn=_now)
    q.add(front="Q", back="A", source="s")
    q2 = FsrsQueue(path, now_fn=_now)
    assert len(q2.due_cards()) == 1


def test_review_unknown_card_raises(tmp_path):
    import pytest
    q = FsrsQueue(str(tmp_path / "fsrs.json"), now_fn=_now)
    with pytest.raises(KeyError):
        q.review(999999, rating=3)


# ---- T14 成长周报 PGI/UGI ----

def test_pgi_score_bounds_and_direction():
    low = pgi_score(skill_cards=0, immune_rules=0, jobs_done=0, kb_docs=0)
    high = pgi_score(skill_cards=13, immune_rules=5, jobs_done=20, kb_docs=100)
    assert 0 <= low < high <= 100


def test_ugi_score_direction():
    low = ugi_score(adopted=0, fsrs_reviews=0, corrections=0, challenges=0)
    high = ugi_score(adopted=8, fsrs_reviews=15, corrections=3, challenges=2)
    assert 0 <= low < high <= 100


def test_weekly_report_four_sections():
    metrics = {"kb_docs": 120, "skill_cards": 13, "immune_rules": 2,
               "jobs_done": 18, "fsrs_reviews": 12, "adopted": 6,
               "corrections": 2, "hot_topic": "投标文件"}
    text = weekly_report(metrics)
    for sec in ("本周产出", "本周学习", "用户成长", "下周聚焦"):
        assert sec in text
    assert "投标文件" in text


def test_weekly_report_empty_metrics_honest():
    text = weekly_report({})
    assert "暂无" in text or "0" in text  # 空数据诚实展示，不编造


# ---- T15 教学三档 ----

def test_l1_socratic_questions():
    qs = socratic_questions(topic="FSRS 间隔重复", depth=3)
    assert len(qs) >= 3 and qs[0].endswith("？")


def test_l2_scaffold_feedback_diff():
    fb = scaffold_feedback(draft="先做A再做C", exemplar="先做A再做B再做C",
                           checklist=("A", "B", "C"))
    assert "B" in fb["missing"]  # 找出缺步
    assert "C" in fb["draft_steps"]


def test_l2_scaffold_all_covered():
    fb = scaffold_feedback(draft="A B C", exemplar="A B C",
                           checklist=("A", "B", "C"))
    assert fb["missing"] == [] and fb["covered"] == ["A", "B", "C"]


def test_l3_minute_recap_template():
    recap = minute_recap(task="写了周报", outcome="完成",
                         lesson="数据要当天记")
    assert "一分钟复盘" in recap and "写了周报" in recap
    assert "数据要当天记" in recap
