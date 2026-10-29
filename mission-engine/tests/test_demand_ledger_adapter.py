# -*- coding: utf-8 -*-
"""tests/test_demand_ledger_adapter.py — 需求台账适配器契约测试（W3.2 第4源验收）。
运行: py -X utf8 tests\test_demand_ledger_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                                  # noqa: E402
from signals.adapters.demand_ledger import DemandLedgerAdapter         # noqa: E402
from signals.bus import SignalBus                                      # noqa: E402
from signals.contract import Signal                                    # noqa: E402

# data/demand_ledger/signals.jsonl 实测结构样本（408行之首，字段以此为准）
RAW_SAMPLE = json.dumps({
    "signal_id": "dl_20744_b76524d19a79", "ts": "2026-10-18T22:33:18",
    "source_face": "mp_feedback", "source_ref": "fb:fb_1792236286_BID26-20",
    "demand_quote": "第8章判例谱系建议按争议类型再分一层索引，方便按需检索。",
    "jtbd": {"trigger": "买家反馈", "job_statement": "对BID26-2026提出改进要求",
             "outcome": "报告迭代"},
    "frequency": 1, "urgency": "mid", "score": 50,
}, ensure_ascii=False)


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    expect("已注册", ADAPTERS.get("demand_ledger") is DemandLedgerAdapter)

    adapter = DemandLedgerAdapter()
    sig = adapter.normalize(RAW_SAMPLE)
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "demand_ledger")
    expect("evidence主键", sig.evidence["signal_id"] == "dl_20744_b76524d19a79")
    expect("ts归一", sig.ts == "2026-10-18 22:33:18", sig.ts)
    expect("score映射confidence", sig.confidence == 0.5, str(sig.confidence))
    expect("jtbd_tags", "需求台账" in sig.jtbd_tags
           and "mp_feedback" in sig.jtbd_tags
           and "urgency-mid" in sig.jtbd_tags, str(sig.jtbd_tags))
    expect("payload带JTBD", sig.payload["jtbd"].get("outcome") == "报告迭代")

    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    WORK = Path(__file__).resolve().parent / ".signal-bus-work"
    WORK.mkdir(exist_ok=True)
    tmp_bus = SignalBus(WORK / "ledger")

    import time as _t
    uniq = json.dumps({**json.loads(RAW_SAMPLE),
                       "signal_id": "dl_99999_" + _t.strftime("%H%M%S")},
                      ensure_ascii=False)   # 运行唯一id：重跑幂等

    class TriAdapter(DemandLedgerAdapter):
        def discover(self):
            return [uniq, uniq, uniq]
    r = tmp_bus.pull(TriAdapter())
    expect("重复行收敛", r["emitted"] == 1 and r["dup"] == 2, json.dumps(r))

    class BadAdapter(DemandLedgerAdapter):
        def discover(self):
            return [json.dumps({"signal_id": "nope", "ts": "2026-10-18 22:00:00",
                                "demand_quote": "x"}, ensure_ascii=False)]
    r = tmp_bus.pull(BadAdapter())
    expect("非法id拒收", r["rejected"] == 0 and r["errors"] == 1, json.dumps(r))

    if "--live" not in sys.argv:
        print("PASS: 需求台账适配器离线契约全绿（--live 可实弹收敛真库存）")
        return 0

    live_bus = SignalBus()
    r = live_bus.pull(DemandLedgerAdapter())
    expect("实弹pull", r["errors"] == 0 and r["emitted"] >= 0, json.dumps(r))
    r2 = live_bus.pull(DemandLedgerAdapter())
    expect("实弹幂等", r2["emitted"] == 0
           and r2["dup"] == r["emitted"] + r["dup"]
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: 需求台账实弹全绿（首拉 emitted={r['emitted']} dup={r['dup']}）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
