"""Phase B5 上下文预算表（M2）：任务级 token 预算 + 超支检测 + fresh-context
复盘候选（预算表是硬资产：花超=需要复盘的信号，不靠感觉）。"""
from paistation.evolve.budget import BudgetLedger, overspent, record_review, review_pending


def test_plan_and_spend_within_budget(tmp_path):
    led = BudgetLedger(tmp_path)
    led.plan("T-1", budget_tokens=100_000)
    led.spend("T-1", 60_000)
    led.spend("T-1", 30_000)
    s = led.status("T-1")
    assert s["budget"] == 100_000
    assert s["used"] == 90_000
    assert s["over"] is False


def test_over_budget_detected(tmp_path):
    led = BudgetLedger(tmp_path)
    led.plan("T-1", budget_tokens=50_000)
    led.spend("T-1", 60_000)
    assert led.status("T-1")["over"] is True
    assert [o["task_id"] for o in overspent(tmp_path)] == ["T-1"]


def test_spend_without_plan_defaults_unbudgeted(tmp_path):
    """无预算登记的任务：每笔都算超（无预算=无授权花销）。"""
    led = BudgetLedger(tmp_path)
    led.spend("T-2", 100)
    assert led.status("T-2")["over"] is True
    assert led.status("T-2")["budget"] == 0


def test_append_only_multiple_tasks(tmp_path):
    led = BudgetLedger(tmp_path)
    led.plan("T-1", 100)
    led.plan("T-2", 200)
    assert len(overspent(tmp_path)) == 0
    rows = (tmp_path / "evolve" / "budget.jsonl").read_text(
        encoding="utf-8").splitlines()
    assert len(rows) == 2


def test_review_pending_lists_overspent(tmp_path):
    led = BudgetLedger(tmp_path)
    led.plan("T-1", 100)
    led.spend("T-1", 200)
    led.plan("T-2", 100)
    led.spend("T-2", 50)
    pending = review_pending(tmp_path)
    assert [p["task_id"] for p in pending] == ["T-1"]


def test_record_review_and_pending_excludes_reviewed(tmp_path):
    led = BudgetLedger(tmp_path)
    led.plan("T-1", 100)
    led.spend("T-1", 200)
    record_review(tmp_path, task_id="T-1", summary="上下文污染，压缩后达成")
    assert review_pending(tmp_path) == []
    rows = (tmp_path / "evolve" / "context_reviews.jsonl").read_text(
        encoding="utf-8").splitlines()
    assert "上下文污染" in rows[0]
