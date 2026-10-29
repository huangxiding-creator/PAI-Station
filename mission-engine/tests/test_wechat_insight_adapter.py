# -*- coding: utf-8 -*-
"""tests/test_wechat_insight_adapter.py — 微信洞察适配器契约测试（W3.2b 验收）。

离线层（默认跑）：实测字段结构 raw 样本 → normalize → 六字段契约，
不依赖真实微信数据目录。--live 层（显式传入才跑）：真 topic-signals 目录
→ bus.pull → 引擎主账本（上游重复行应被 dedup 收敛）。
运行: py -X utf8 tests\\test_wechat_insight_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                                  # noqa: E402
from signals.adapters.wechat_insight import WechatInsightAdapter       # noqa: E402
from signals.bus import SignalBus                                      # noqa: E402
from signals.contract import ContractError, Signal                     # noqa: E402

# 2026-10-18 topic-signals 实测样本（字段结构以此为准，数字零造假）
RAW_SAMPLE = json.dumps({
    "signal_id": "sig_20261018_233300",
    "demand_quote": "总包读书沙龙︱研读《建设工程造价争议解决指引》",
    "jtbd": {"job_statement": "当编制造价时，总包之声12群想拿到计价依据，这样报得准",
             "job_type": "functional", "trigger": "编制造价时",
             "outcome": "报得准", "demand_quote": "同上"},
    "source_face": "group",
    "source_ref": {"group": "总包之声12群", "mine": "full_v3"},
    "frequency_7d": 3, "urgency": "mid", "score": 50,
    "expert_panel": {"chief_engineer": "否", "cost_engineer": "过"},
    "stats_snapshot": {"trend": "rising", "similar_count": 3},
}, ensure_ascii=False)


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    # 1) 注册表接线（第二个源=纯新增，bus/contract 零改动）
    expect("已注册", ADAPTERS.get("wechat_insight") is WechatInsightAdapter)

    # 2) normalize：实测样本 → Signal 六字段契约全过
    adapter = WechatInsightAdapter()
    sig = adapter.normalize(RAW_SAMPLE)
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "wechat_insight")
    expect("evidence主键", sig.evidence["signal_id"] == "sig_20261018_233300")
    expect("ts从signal_id解析", sig.ts == "2026-10-18 23:33:00", sig.ts)
    expect("score映射confidence", sig.confidence == 0.5, str(sig.confidence))
    expect("jtbd_tags", "微信洞察" in sig.jtbd_tags and "group" in sig.jtbd_tags
           and "urgency-mid" in sig.jtbd_tags, str(sig.jtbd_tags))
    expect("payload带JTBD", sig.payload["jtbd"].get("job_type") == "functional")

    # 3) dedup 稳定 + 重复行收敛（上游 322行→27id 实测常态的缩影）
    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    WORK = Path(__file__).resolve().parent / ".signal-bus-work"
    WORK.mkdir(exist_ok=True)
    tmp_bus = SignalBus(WORK / "ledger")
    import time as _t
    dup_sample = json.dumps(                   # 运行唯一id：重跑幂等（账本只增不删）
        {**json.loads(RAW_SAMPLE),
         "signal_id": "sig_" + _t.strftime("%Y%m%d") + "_" + _t.strftime("%H%M%S")},
        ensure_ascii=False)

    class TriAdapter(WechatInsightAdapter):           # 同 id 三行（私有目录不污染）
        def discover(self):
            return [dup_sample, dup_sample, dup_sample]
    r = tmp_bus.pull(TriAdapter())
    expect("重复行收敛", r["emitted"] == 1 and r["dup"] == 2, json.dumps(r))

    # 4) 坏行拒收留痕：非 JSON 行 / 非法 signal_id
    class BadAdapter(WechatInsightAdapter):
        def discover(self):
            return ["{不是json", json.dumps({"signal_id": "nope",
                                             "demand_quote": "x"}, ensure_ascii=False)]
    r = tmp_bus.pull(BadAdapter())
    expect("坏行拒收", r["rejected"] == 0 and r["errors"] == 2, json.dumps(r))
    # ↑ normalize 抛 ValueError=errors 计数（非契约拒收），reject 行留痕

    # 5) 非法 signal_id 但可解析 JSON：normalize 抛 → 同样留痕不拖垮
    try:
        adapter.normalize(json.dumps({"signal_id": "bad", "demand_quote": "x"}))
        expect("非法id拒收", False, "未抛")
    except ValueError as e:
        expect("非法id拒收", "signal_id" in str(e), str(e)[:100])

    if "--live" not in sys.argv:
        print("PASS: 微信洞察适配器离线契约全绿（--live 可实弹收敛真库存）")
        return 0

    # --live 实弹：真 topic-signals 目录 → 主账本，重复行应被 dedup 收敛
    live_bus = SignalBus()
    r = live_bus.pull(WechatInsightAdapter())
    expect("实弹pull", r["errors"] == 0 and r["emitted"] >= 0, json.dumps(r))
    r2 = live_bus.pull(WechatInsightAdapter())
    expect("实弹幂等", r2["emitted"] == 0
           and r2["dup"] == r["emitted"] + r["dup"]      # 全行已见=总行数守恒
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: 微信洞察实弹全绿（首拉 emitted={r['emitted']} dup={r['dup']}，"
          f"重复行已收敛，重拉全dup）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
