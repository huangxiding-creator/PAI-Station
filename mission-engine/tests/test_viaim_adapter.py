# -*- coding: utf-8 -*-
"""tests/test_viaim_adapter.py — viaim 适配器契约测试（W3.2a 验收，插件模板首例）。

离线层（默认跑）：实测字段结构的 raw 样本 → normalize → Signal 六字段契约，
不触网不依赖登录态。--live 层（显式传入才跑）：真 CLI discover → bus.pull
→ 引擎主账本 ledger/signals.jsonl 首批真实信号落账（幂等可重跑）。
运行: py -X utf8 tests\\test_viaim_adapter.py [--live]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.adapters import ADAPTERS                       # noqa: E402
from signals.adapters.viaim import ViaimAdapter             # noqa: E402
from signals.bus import SignalBus                           # noqa: E402
from signals.contract import Signal                         # noqa: E402

# 2026-10-23 record list 实测样本（字段结构以此为准，数字零造假）
RAW_SAMPLE = {
    "record_id": "0d35b64db1b3439a846b684fc1e99afa",
    "title": "10-23 自主派活引擎",
    "overview": "构建自动派活引擎，同步讯飞录音与微信需求，结合资源清单生成变现方案。",
    "sub_title": "目前的话我做开发，还有包括完成一些工作，",
    "record_time": 1792726199858,
    "duration": 469520,
    "languages": ["cn"],
    "state": 0,
}


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    # 1) 注册表接线：新源=文件+注册一行（开闭原则实证）
    expect("已注册", ADAPTERS.get("viaim") is ViaimAdapter)

    # 2) normalize：实测样本 → Signal 六字段契约全过
    adapter = ViaimAdapter()
    sig = adapter.normalize(RAW_SAMPLE)
    sig.validate()
    expect("六件套契约", set(sig.to_dict()) == set(Signal.__dataclass_fields__))
    expect("源标识", sig.source_type == "viaim")
    expect("evidence主键", sig.evidence["record_id"] == RAW_SAMPLE["record_id"])
    expect("ts毫秒转本地", sig.ts == "2026-10-23 14:09:59"
           or sig.ts.startswith("2026-10-23 1"), sig.ts)   # 时区随机器，日期+小时段锚定
    expect("时长秒", isinstance(sig.payload["duration_sec"], float))

    # 3) dedup 稳定：同 record_id 同键（重拉不重复入账的地基）
    expect("dedup稳定", sig.dedup_key() == adapter.normalize(RAW_SAMPLE).dedup_key())
    other = dict(RAW_SAMPLE, record_id="x" * 32, title="另一条")
    expect("dedup分记录", sig.dedup_key() != adapter.normalize(other).dedup_key())

    # 4) 缺 record_time 的坏条目 → ts 空 → 契约拒收（留痕不拖垮）
    bad = dict(RAW_SAMPLE, record_time=None)
    try:
        adapter.normalize(bad).validate()
        expect("坏条目拒收", False, "未抛 ContractError")
    except Exception as e:
        expect("坏条目拒收", "ts" in str(e), str(e)[:120])

    if "--live" not in sys.argv:
        print("PASS: viaim 适配器离线契约全绿（--live 可实弹拉新入主账本）")
        return 0

    # --live 实弹：真 CLI → bus.pull → 引擎主账本首批真实信号
    bus = SignalBus()
    r = bus.pull(adapter)
    expect("实弹pull", r["emitted"] >= 0 and r["errors"] == 0, json.dumps(r))
    recs = bus.read(source_type="viaim", limit=3)
    expect("主账本读回", all(x["signal"]["source_type"] == "viaim" for x in recs),
           f"n={len(recs)}")
    r2 = bus.pull(adapter)               # 幂等：立即重拉应全 dup
    expect("实弹幂等", r2["emitted"] == 0 and r2["dup"] == r["emitted"]
           and r2["errors"] == 0, json.dumps(r2))
    print(f"PASS: viaim 实弹全绿（首拉 emitted={r['emitted']}，重拉全dup）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
