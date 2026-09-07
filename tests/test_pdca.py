"""M4 PDCA 每日复盘：审计/记忆/推送三源数据 → 四段复盘报告。"""
from paistation.learn.pdca import DailyReview


def make_inputs(tmp_path, heartbeats=3, pushes=1, drawer=2, files=7):
    from paistation.security.audit import AuditLog
    audit = AuditLog(str(tmp_path / "audit.db"))
    for i in range(heartbeats):
        audit.record("heartbeat", module="serve", tick=i)
    audit.record("fs.batch", module="sense", count=4)
    audit.record("tool_guard.deny", module="security", command="format C:")
    return {
        "audit": audit,
        "outbox_stats": {"today_sent": pushes, "drawer_items": drawer,
                         "max_per_day": 2},
        "store_stats": {"total": files, "by_suffix": {".md": 5, ".py": 2}},
        "quiet_violations": 0,
    }


class FakeDeep:
    def __init__(self, fail=False):
        self.fail = fail
        self.prompts = []

    def __call__(self, prompt, reasoning=True):
        self.prompts.append(prompt)
        if self.fail:
            raise RuntimeError("down")
        return {"text": "复盘洞察：节奏健康，建议明天上午加一次深度块。"}


def test_review_has_four_sections(tmp_path):
    r = DailyReview(**make_inputs(tmp_path)).review()
    for section in ("Plan", "Done", "Check", "Act"):
        assert section in r
    assert "3" in r["Done"]                       # 心跳数真实入报


def test_review_numbers_grounded(tmp_path):
    r = DailyReview(**make_inputs(tmp_path, pushes=1, drawer=2, files=7)).review()
    body = r["Done"] + r["Check"]
    assert "7" in body and "2" in body             # 索引文件数/抽屉数


def test_review_llm_insight_appended(tmp_path):
    deep = FakeDeep()
    r = DailyReview(**make_inputs(tmp_path), deep_fn=deep).review()
    assert "深度块" in r["Act"]
    assert len(deep.prompts) == 1


def test_review_llm_failure_still_reports(tmp_path):
    r = DailyReview(**make_inputs(tmp_path), deep_fn=FakeDeep(fail=True)).review()
    assert all(r[s] for s in ("Plan", "Done", "Check", "Act"))


def test_review_flags_deny_events(tmp_path):
    r = DailyReview(**make_inputs(tmp_path)).review()
    assert "tool_guard.deny" in r["Check"]         # 越界尝试进 Check 段


def test_review_zero_activity_safe(tmp_path):
    inputs = make_inputs(tmp_path, heartbeats=0, pushes=0, drawer=0, files=0)
    r = DailyReview(**inputs).review()
    assert "0" in r["Done"]
