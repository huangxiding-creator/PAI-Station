# -*- coding: utf-8 -*-
"""tests/test_refund_score_adapter.py — 退款评分适配器契约测试（W3.2 第7源验收）。

离线层不碰引擎（fixture=实测fid/scores_json结构）；--live 实弹 GET pending。
运行: py -X utf8 tests\test_refund_score_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                                  # noqa: E402
from signals.adapters.refund_score import RefundScoreAdapter           # noqa: E402
from signals.bus import SignalBus                                      # noqa: E402
from signals.contract import Signal                                    # noqa: E402

# 实测契约: fid=fb_{unix秒}_{SKU短码}（fb_1792236286_BID26-20 来自需求台账
# source_ref 实证）; scores_json=JSON串含 total_score/feedback_category
FID = "fb_1792236286_BID26-20"
RAW_SAMPLE = {"fid": FID, "openid": "oX9k_prod_buyer_a1b2c3",
              "scores_json": json.dumps(
                  {"total_score": 40, "feedback_category": "数据有误"},
                  ensure_ascii=False)}


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    expect("已注册", ADAPTERS.get("refund_score") is RefundScoreAdapter)

    adapter = RefundScoreAdapter()
    sig = adapter.normalize(RAW_SAMPLE)               # dict 直入（discover产物）
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "refund_score")
    expect("evidence主键", sig.evidence["fid"] == FID
           and sig.evidence["sku_short"] == "BID26-20")
    expect("ts从fid解析", sig.ts ==
           datetime.fromtimestamp(1792236286).strftime("%Y-%m-%d %H:%M:%S"),
           sig.ts)
    expect("评分映射confidence", sig.confidence == 0.4, str(sig.confidence))
    expect("jtbd_tags", "退款评分" in sig.jtbd_tags
           and "sku-BID26-20" in sig.jtbd_tags
           and "category-数据有误" in sig.jtbd_tags, str(sig.jtbd_tags))
    expect("openid只留尾6", sig.payload["openid_tail"] == "a1b2c3"
           and "openid" not in sig.payload)

    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    WORK = Path(__file__).resolve().parent / ".signal-bus-work"
    WORK.mkdir(exist_ok=True)
    tmp_bus = SignalBus(WORK / "ledger")

    import time as _t
    uniq = {**RAW_SAMPLE,
            "fid": "fb_" + str(int(_t.time())) + "_TEST26-99"}  # 运行唯一fid：重跑幂等

    class TriAdapter(RefundScoreAdapter):
        def discover(self):
            return [uniq, dict(uniq)]
    r = tmp_bus.pull(TriAdapter())
    expect("重复行收敛", r["emitted"] == 1 and r["dup"] == 1, json.dumps(r))

    class BadAdapter(RefundScoreAdapter):
        def discover(self):
            return [{"fid": "nope", "openid": "oX", "scores_json": "{}"}]
    r = tmp_bus.pull(BadAdapter())
    expect("坏fid拒收", r["rejected"] == 0 and r["errors"] == 1, json.dumps(r))

    # scores_json 坏串容忍: fid合法即收，scores={}，confidence兜底0.5
    sig2 = adapter.normalize({"fid": "fb_1792236287_BID26-20",
                              "openid": "oX", "scores_json": "not-json"})
    expect("坏scores容忍", sig2.confidence == 0.5, str(sig2.confidence))

    if "--live" not in sys.argv:
        print("PASS: 退款评分适配器离线契约全绿（--live 实弹引擎 pending）")
        return 0

    live_bus = SignalBus()
    r = live_bus.pull(RefundScoreAdapter())
    expect("实弹pull", r["errors"] == 0 and r["emitted"] >= 0, json.dumps(r))
    r2 = live_bus.pull(RefundScoreAdapter())
    expect("实弹幂等", r2["emitted"] == 0
           and r2["dup"] == r["emitted"] + r["dup"]
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: 退款评分实弹全绿（首拉 emitted={r['emitted']} dup={r['dup']}）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
