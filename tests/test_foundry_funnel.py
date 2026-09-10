# M7.6 漏斗账本 + 价值账本打通（提案 M7 §5.3）
import json
import os

from paistation.foundry.funnel import Funnel, funnel_report
from paistation.soul.value_ledger import ValueLedger


def _tmp_ledger(tmp_path):
    return ValueLedger(str(tmp_path / "value" / "ledger.json"))


class TestFunnel:
    def test_five_events_tracked(self, tmp_path):
        f = Funnel(str(tmp_path))
        f.track("view", "epc-fde-ai")
        f.track("preview", "epc-fde-ai")
        f.track("purchase", "epc-fde-ai", price=498)
        f.track("feedback", "epc-fde-ai", refund=100, minutes=25)
        f.track("custom_lead", "epc-fde-ai", contact="企微:张工")
        lines = open(os.path.join(str(tmp_path), "funnel_ledger.jsonl"),
                     encoding="utf-8").read().strip().splitlines()
        kinds = [json.loads(x)["event"] for x in lines]
        assert kinds == ["view", "preview", "purchase", "feedback", "custom_lead"]
        assert json.loads(lines[2])["price"] == 498
        assert json.loads(lines[3])["refund"] == 100

    def test_unknown_event_rejected(self, tmp_path):
        f = Funnel(str(tmp_path))
        try:
            f.track("hack", "slug")
            raised = False
        except ValueError:
            raised = True
        assert raised

    def test_report_aggregates(self, tmp_path):
        f = Funnel(str(tmp_path))
        for _ in range(10):
            f.track("view", "s1")
        for _ in range(4):
            f.track("preview", "s1")
        f.track("purchase", "s1", price=298)
        r = funnel_report(str(tmp_path))
        assert r["s1"]["view"] == 10 and r["s1"]["preview"] == 4
        assert r["s1"]["purchase"] == 1
        assert r["s1"]["preview_to_purchase"] == 0.25


class TestSync:
    def test_sync_records_net_income_once(self, tmp_path):
        f = Funnel(str(tmp_path))
        f.track("purchase", "s1", price=298)
        f.track("purchase", "s1", price=298)
        f.track("feedback", "s1", refund=100, minutes=25)
        f.track("custom_lead", "s1", contact="x")
        vl = _tmp_ledger(tmp_path)
        summary = f.sync_to_value_ledger(vl)
        assert summary["income"] == 596 and summary["refunds"] == 100
        assert summary["net"] == 496 and summary["leads"] == 1
        assert vl.totals()["ecosystem"] == 496  # 价值账本有了方案工厂进项

        # 幂等：重复同步不重复记账
        f2 = Funnel(str(tmp_path))
        again = f2.sync_to_value_ledger(vl)
        assert again["net"] == 0
        assert vl.totals()["ecosystem"] == 496

    def test_sync_empty_funnel_noop(self, tmp_path):
        vl = _tmp_ledger(tmp_path)
        summary = Funnel(str(tmp_path)).sync_to_value_ledger(vl)
        assert summary["net"] == 0 and vl.totals()["ecosystem"] == 0
