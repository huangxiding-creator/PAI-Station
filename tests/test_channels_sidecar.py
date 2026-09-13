"""Phase D4 IM 侧挂：IM 消息→任务→回执（先企微语义；AstrBot 可挂同协议）。

侧挂=寄生现有 IM，不自造入口（Humane 尸检对策）。
"""
import pytest

from paistation.channels.sidecar import format_receipt, handle_message
from paistation.control.gateway import Gateway
from paistation.control.registry import ActionSpec, Registry


@pytest.fixture()
def gw(tmp_path):
    reg = Registry()
    reg.register(ActionSpec(name="report.weekly", path="read",
                            reversible=True,
                            handler=lambda args: f"周报已生成：{args}"))
    reg.register(ActionSpec(name="fs.purge", path="irreversible",
                            reversible=False))
    return Gateway(reg, tmp_path, auto_confirm=False)


def test_help_command(gw):
    r = handle_message("/help", gw)
    assert "report.weekly" in r
    assert "/run" in r


def test_run_executes_and_receipts(gw):
    r = handle_message('/run report.weekly {"week": 37}', gw)
    assert "✅" in r
    assert "周报已生成" in r


def test_run_unknown_action(gw):
    r = handle_message('/run no.such {}', gw)
    assert "❌" in r


def test_run_irreversible_pending_confirm(gw):
    r = handle_message("/run fs.purge {}", gw)
    assert "待确认" in r


def test_status_returns_empty_ledger(gw):
    r = handle_message("/status", gw)
    assert "0" in r                    # 尚无执行记录


def test_receipt_format():
    receipt = format_receipt("T-9", {"ok": True, "result": "done"})
    assert "T-9" in receipt and "done" in receipt
