"""Phase C4-C6：资源账本（token/秒/元）+ 审批密码学 + METR 旋钮。"""
import pytest

from paistation.control.approval import ApprovalLog, build_approval, verify_approval
from paistation.control.knob import intervention_interval
from paistation.control.meter import Meter, usage

# ---- C4 资源账本 ----

def test_meter_records_three_dimensions(tmp_path):
    m = Meter(tmp_path)
    m.record("T-1", tokens=1200, seconds=3.5, yuan=0.02)
    m.record("T-1", tokens=800, seconds=1.5)
    m.record("T-2", tokens=50, yuan=0.01)
    u = usage(tmp_path)
    assert u["T-1"] == {"tokens": 2000, "seconds": 5.0, "yuan": 0.02}
    assert u["T-2"]["tokens"] == 50


def test_meter_total_sums(tmp_path):
    m = Meter(tmp_path)
    m.record("T-1", tokens=100, yuan=0.1)
    m.record("T-2", tokens=50, yuan=0.2)
    assert usage(tmp_path, total=True)["yuan"] == pytest.approx(0.3)


def test_meter_append_only_file(tmp_path):
    m = Meter(tmp_path)
    m.record("T-1", tokens=1)
    m.record("T-1", tokens=2)
    rows = (tmp_path / "control" / "meter.jsonl").read_text(
        encoding="utf-8").splitlines()
    assert len(rows) == 2


# ---- C5 审批密码学 ----

def test_build_and_verify_approval_roundtrip(tmp_path):
    log = ApprovalLog(tmp_path, secret=b"test-secret")
    appr = build_approval(log, action="cloud.pay", args={"yuan": 99.0},
                          why="超限额需人工批")
    assert verify_approval(log, appr) is True


def test_tampered_approval_fails(tmp_path):
    log = ApprovalLog(tmp_path, secret=b"test-secret")
    appr = build_approval(log, action="cloud.pay", args={"yuan": 99.0},
                          why="x")
    appr["args"]["yuan"] = 1.0                      # 篡改
    assert verify_approval(log, appr) is False


def test_wrong_secret_fails(tmp_path):
    log = ApprovalLog(tmp_path, secret=b"test-secret")
    appr = build_approval(log, action="a", args={}, why="")
    other = ApprovalLog(tmp_path, secret=b"evil")
    assert verify_approval(other, appr) is False


def test_approval_log_append_only(tmp_path):
    log = ApprovalLog(tmp_path, secret=b"s")
    build_approval(log, action="a", args={}, why="")
    build_approval(log, action="b", args={}, why="")
    rows = (tmp_path / "control" / "approvals.jsonl").read_text(
        encoding="utf-8").splitlines()
    assert len(rows) == 2


# ---- C6 METR 旋钮 ----

def test_interval_grows_with_quiet_time():
    """无人干预越久，人审间隔越长（指数后退）：10min→30min→..."""
    seq = [intervention_interval(hours_since_human=0),
           intervention_interval(hours_since_human=4),
           intervention_interval(hours_since_human=24)]
    assert seq[0] < seq[1] < seq[2]


def test_interval_capped():
    assert intervention_interval(hours_since_human=10_000) <= 12 * 60


def test_interval_monotonic_sequence():
    vals = [intervention_interval(hours_since_human=h)
            for h in range(0, 48, 4)]
    assert vals == sorted(vals)
