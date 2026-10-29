# -*- coding: utf-8 -*-
"""tests/test_topic_radar_adapter.py — 雷达原始信号适配器契约测试（W3.2 第5源验收）。
运行: py -X utf8 tests\test_topic_radar_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                                  # noqa: E402
from signals.adapters.topic_radar import TopicRadarAdapter             # noqa: E402
from signals.bus import SignalBus                                      # noqa: E402
from signals.contract import Signal                                    # noqa: E402

# data/demand_signals/radar_signals.jsonl 实测结构样本（70行之一）
RAW_SAMPLE = json.dumps({
    "ts": "2026-09-28 12:09:20", "source": "ask", "channel": "miniprogram:kb",
    "actor": "dev-harness-a-1790…", "text": "联合体投标必备条款？",
    "meta": {}, "intent": "具体问题", "topic": "招投标合规",
}, ensure_ascii=False)
RAW_NOISE = json.dumps({                         # 无关噪声=显式跳过
    "ts": "2026-09-28 09:54:31", "source": "ask", "channel": "miniprogram:kb",
    "actor": "open-smoke-001…", "text": "大体积混凝土浇筑温度控制要点，150字内",
    "meta": {}, "intent": "无关噪声", "topic": None}, ensure_ascii=False)


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    expect("已注册", ADAPTERS.get("topic_radar") is TopicRadarAdapter)

    adapter = TopicRadarAdapter()
    sig = adapter.normalize(RAW_SAMPLE)
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "topic_radar")
    expect("指纹主键", sig.evidence["fingerprint"].startswith("radar_")
           and len(sig.evidence["fingerprint"]) == 18, str(sig.evidence))
    expect("ts直传", sig.ts == "2026-09-28 12:09:20", sig.ts)
    expect("intent映射confidence", sig.confidence == 0.6, str(sig.confidence))
    expect("jtbd_tags", "需求雷达" in sig.jtbd_tags
           and "具体问题" in sig.jtbd_tags
           and "招投标合规" in sig.jtbd_tags, str(sig.jtbd_tags))
    expect("噪声跳过", adapter.normalize(RAW_NOISE) is None)

    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    WORK = Path(__file__).resolve().parent / ".signal-bus-work"
    WORK.mkdir(exist_ok=True)
    tmp_bus = SignalBus(WORK / "ledger")

    import time as _t
    uniq = json.dumps({**json.loads(RAW_SAMPLE),
                       "text": "联合体投标必备条款？" + _t.strftime("%H%M%S")},
                      ensure_ascii=False)   # 运行唯一text：指纹随之唯一，重跑幂等

    class TriAdapter(TopicRadarAdapter):
        def discover(self):
            return [uniq, uniq, RAW_NOISE]
    r = tmp_bus.pull(TriAdapter())
    expect("重复收敛+噪声skip", r["emitted"] == 1 and r["dup"] == 1
           and r["skipped"] == 1, json.dumps(r))

    class BadAdapter(TopicRadarAdapter):
        def discover(self):
            return [json.dumps({"ts": "2026-09-28 12:00:00", "intent": "具体问题"},
                               ensure_ascii=False)]
    r = tmp_bus.pull(BadAdapter())
    expect("缺text拒收", r["rejected"] == 0 and r["errors"] == 1, json.dumps(r))

    if "--live" not in sys.argv:
        print("PASS: 雷达原始适配器离线契约全绿（--live 可实弹收敛真库存）")
        return 0

    live_bus = SignalBus()
    r = live_bus.pull(TopicRadarAdapter())
    expect("实弹pull", r["errors"] == 0 and r["emitted"] >= 0, json.dumps(r))
    r2 = live_bus.pull(TopicRadarAdapter())
    expect("实弹幂等", r2["emitted"] == 0
           and r2["dup"] + r2["skipped"] == r["emitted"] + r["dup"] + r["skipped"]
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: 雷达原始实弹全绿（首拉 emitted={r['emitted']} dup={r['dup']} "
          f"skipped={r['skipped']}）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
