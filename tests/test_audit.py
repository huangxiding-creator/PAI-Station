"""M0.4 审计日志：只追加、可查询、装饰器成败两态。"""
import os
import time

import pytest

from paistation.security.audit import AuditLog, audited


@pytest.fixture
def audit(tmp_path):
    a = AuditLog(str(tmp_path / "audit.db"))
    yield a
    a.close()


def test_record_and_query_roundtrip(audit):
    audit.record("fs.read", module="sense", path="a.md", bytes_n=10)
    rows = audit.query(action="fs.read")
    assert len(rows) == 1
    assert rows[0]["detail"]["path"] == "a.md"
    assert rows[0]["module"] == "sense"
    assert rows[0]["ts"] <= time.time()


def test_query_filters_by_module(audit):
    audit.record("x", module="sense")
    audit.record("x", module="llm")
    assert len(audit.query(action="x", module="llm")) == 1


def test_query_limit_newest_first(audit):
    for i in range(5):
        audit.record("x", module="m", i=i)
    rows = audit.query(action="x", limit=3)
    assert len(rows) == 3
    assert rows[0]["detail"]["i"] == 4  # 最新在前


def test_chinese_detail_not_escaped(audit):
    audit.record("x", module="m", 中文="密钥操作")
    assert audit.query()[0]["detail"]["中文"] == "密钥操作"


def test_db_dir_auto_created(tmp_path):
    db = tmp_path / "sub" / "dir" / "audit.db"
    a = AuditLog(str(db))
    a.record("x", module="m")
    a.close()
    assert os.path.isfile(db)


def test_audited_decorator_success_and_failure(audit):
    @audited("job.run", module="proactive", audit=audit)
    def ok_job():
        return 42

    @audited("job.run", module="proactive", audit=audit)
    def bad_job():
        raise RuntimeError("炸了")

    assert ok_job() == 42
    with pytest.raises(RuntimeError):
        bad_job()
    rows = audit.query(action="job.run")
    assert {r["detail"]["ok"] for r in rows} == {True, False}
    assert any(r["detail"].get("error") for r in rows)


def test_audited_without_audit_is_noop():
    @audited("x", audit=None)
    def fn():
        return "v"

    assert fn() == "v"
