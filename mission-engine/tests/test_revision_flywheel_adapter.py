# -*- coding: utf-8 -*-
"""tests/test_revision_flywheel_adapter.py — 反馈飞轮适配器契约测试（W3.2 第6源验收）。
运行: py -X utf8 tests\test_revision_flywheel_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                                  # noqa: E402
from signals.adapters.revision_flywheel import RevisionFlywheelAdapter  # noqa: E402
from signals.bus import SignalBus                                      # noqa: E402
from signals.contract import Signal                                    # noqa: E402

# data/feedback/revision_ledger.jsonl 实测首行（字段以此为准）
RAW_SAMPLE = json.dumps({
    "ts": "2026-10-17T13:32:18", "sku": "BID26-2026", "rev": 1,
    "fids": ["fb_1792212741_BID26-20"], "status": "done", "pdf_kb": 1410,
}, ensure_ascii=False)


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    expect("已注册", ADAPTERS.get("revision_flywheel") is RevisionFlywheelAdapter)

    adapter = RevisionFlywheelAdapter()
    sig = adapter.normalize(RAW_SAMPLE)
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "revision_flywheel")
    expect("evidence主键", sig.evidence["sku"] == "BID26-2026"
           and sig.evidence["rev"] == 1)
    expect("ts归一", sig.ts == "2026-10-17 13:32:18", sig.ts)
    expect("台账事实confidence", sig.confidence == 1.0, str(sig.confidence))
    expect("jtbd_tags", "反馈飞轮" in sig.jtbd_tags
           and "sku-BID26-2026" in sig.jtbd_tags
           and "rev1" in sig.jtbd_tags, str(sig.jtbd_tags))
    expect("payload", sig.payload["fids_count"] == 1
           and sig.payload["pdf_kb"] == 1410)

    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    WORK = Path(__file__).resolve().parent / ".signal-bus-work"
    WORK.mkdir(exist_ok=True)
    tmp_bus = SignalBus(WORK / "ledger")

    import time as _t
    uniq = json.dumps({**json.loads(RAW_SAMPLE),
                       "rev": int(_t.strftime("%H%M%S"))},
                      ensure_ascii=False)   # 运行唯一rev：重跑幂等

    class TriAdapter(RevisionFlywheelAdapter):
        def discover(self):
            return [uniq, uniq, uniq]
    r = tmp_bus.pull(TriAdapter())
    expect("重复行收敛", r["emitted"] == 1 and r["dup"] == 2, json.dumps(r))

    class BadAdapter(RevisionFlywheelAdapter):
        def discover(self):
            return [json.dumps({"ts": "2026-10-17 13:00:00",
                                "sku": "X"}, ensure_ascii=False)]
    r = tmp_bus.pull(BadAdapter())
    expect("缺rev拒收", r["rejected"] == 0 and r["errors"] == 1, json.dumps(r))

    if "--live" not in sys.argv:
        print("PASS: 反馈飞轮适配器离线契约全绿（--live 可实弹收敛真库存）")
        return 0

    live_bus = SignalBus()
    r = live_bus.pull(RevisionFlywheelAdapter())
    expect("实弹pull", r["errors"] == 0 and r["emitted"] >= 0, json.dumps(r))
    r2 = live_bus.pull(RevisionFlywheelAdapter())
    expect("实弹幂等", r2["emitted"] == 0
           and r2["dup"] == r["emitted"] + r["dup"]
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: 反馈飞轮实弹全绿（首拉 emitted={r['emitted']} dup={r['dup']}）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
