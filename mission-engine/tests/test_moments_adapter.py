# -*- coding: utf-8 -*-
"""tests/test_moments_adapter.py — 朋友圈适配器契约测试（W3.2 第3源验收）。

离线层：实测字段结构 raw 样本 → normalize → 六字段契约 + bus 幂等收敛。
--live 层：真 sensing 目录 → 主账本（face=group 行应被过滤不入账）。
运行: py -X utf8 tests\test_moments_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                                  # noqa: E402
from signals.adapters.moments import MomentsAdapter                    # noqa: E402
from signals.bus import SignalBus                                      # noqa: E402
from signals.contract import Signal                                    # noqa: E402

# sensing/20261018.jsonl 实测结构样本（face=moments，字段以此为准）
RAW_SAMPLE = json.dumps({
    "ts": "2026-10-18T12:27:14", "face": "moments",
    "ref": {"wxid": "wx_moment_peer", "mine": "sns_feed"},
    "quote": "求推荐好用的资料归档工具，纸质图纸太多翻不动了",
    "quote_full_hash": "b06d972e740a89efbc08bcf89f6ba8cd",
    "score0": 70, "private_level": "public",
    "key": "4eef3262981d7f59b5aa0839ecd7b5ed",
}, ensure_ascii=False)
RAW_GROUP = json.dumps({                        # 群面行=已知过滤（归 rion 线）
    "ts": "2026-10-18T12:27:14", "face": "group",
    "ref": {"group": "x", "wxid": "y", "mine": "full_history"},
    "quote": "群消息", "score0": 70, "key": "grp1"}, ensure_ascii=False)


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    expect("已注册", ADAPTERS.get("moments") is MomentsAdapter)

    adapter = MomentsAdapter()
    sig = adapter.normalize(RAW_SAMPLE)
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "moments")
    expect("evidence主键", sig.evidence["key"] == "4eef3262981d7f59b5aa0839ecd7b5ed")
    expect("ts归一", sig.ts == "2026-10-18 12:27:14", sig.ts)
    expect("score0映射confidence", sig.confidence == 0.7, str(sig.confidence))
    expect("jtbd_tags", "朋友圈" in sig.jtbd_tags
           and "sns_feed" in sig.jtbd_tags, str(sig.jtbd_tags))
    expect("群面过滤", adapter.normalize(RAW_GROUP) is None)

    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    WORK = Path(__file__).resolve().parent / ".signal-bus-work"
    WORK.mkdir(exist_ok=True)
    tmp_bus = SignalBus(WORK / "ledger")

    import time as _t
    uniq = json.dumps({**json.loads(RAW_SAMPLE),
                       "key": "test_" + _t.strftime("%H%M%S")},
                      ensure_ascii=False)   # 运行唯一key：重跑幂等（账本只增不删）

    class TriAdapter(MomentsAdapter):
        def discover(self):
            return [uniq, uniq, uniq]
    r = tmp_bus.pull(TriAdapter())
    expect("重复行收敛", r["emitted"] == 1 and r["dup"] == 2, json.dumps(r))

    class BadAdapter(MomentsAdapter):
        def discover(self):
            return ["{不是json", json.dumps({"face": "moments",
                                             "ts": "2026-10-18 12:00:00",
                                             "quote": "x"}, ensure_ascii=False)]
    r = tmp_bus.pull(BadAdapter())
    expect("坏行拒收", r["rejected"] == 0 and r["errors"] == 2, json.dumps(r))

    if "--live" not in sys.argv:
        print("PASS: 朋友圈适配器离线契约全绿（--live 可实弹收敛真库存）")
        return 0

    live_bus = SignalBus()
    r = live_bus.pull(MomentsAdapter())
    expect("实弹pull", r["errors"] == 0 and r["emitted"] >= 0, json.dumps(r))
    r2 = live_bus.pull(MomentsAdapter())
    expect("实弹幂等", r2["emitted"] == 0
           and r2["dup"] == r["emitted"] + r["dup"]
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: 朋友圈实弹全绿（首拉 emitted={r['emitted']} dup={r['dup']}）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
