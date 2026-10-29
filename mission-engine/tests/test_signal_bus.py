# -*- coding: utf-8 -*-
"""tests/test_signal_bus.py — Signal契约+总线内核测试（W3.1 验收）。

私有账本目录 tests/.signal-bus-work/（只增不删，站规）；重跑幂等靠 RID
唯一后缀隔离残留数据（evidence.id 每次运行不同→天然全新信号）+ 相对 seq 断言。
覆盖：六件套契约正反例 / dedup_key 稳定 / pull 落账 / 幂等去重 /
坏信号拒收留痕 / normalize 多态(None|单|列表) / 源崩溃隔离 /
read 过滤 / 进程外持久性 / CLI 退出码。
运行: py -X utf8 tests\\test_signal_bus.py
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from signals.contract import Signal, ContractError   # noqa: E402
from signals.bus import SignalBus                     # noqa: E402
from signals.adapters.base import Adapter             # noqa: E402

WORK = Path(__file__).resolve().parent / ".signal-bus-work"
RID = time.strftime("%H%M%S")          # 本次运行唯一后缀（残留隔离）


def rid(x: str) -> str:
    return f"{RID}-{x}"


def sig(**kw) -> Signal:
    base = {"source_type": "fake", "payload": {"text": "冒烟信号"},
            "evidence": {"id": rid("t1")}, "jtbd_tags": ["冒烟"],
            "ts": "2026-10-23 15:00:00", "confidence": 0.8}
    base.update(kw)
    return Signal(**base)


class FakeAdapter(Adapter):
    source_type = "fake"

    def __init__(self, raws):
        self.raws = raws

    def discover(self):
        return self.raws

    def normalize(self, raw):
        return Signal(source_type="fake", payload={"text": raw["text"]},
                      evidence={"id": raw["id"]}, jtbd_tags=raw.get("tags", []),
                      ts=raw["ts"], confidence=raw.get("confidence", 0.8))


class CrashAdapter(Adapter):
    source_type = "crash"

    def discover(self):
        raise RuntimeError("源崩了（模拟）")

    def normalize(self, raw):
        raise AssertionError("不应到达")


def fresh_bus() -> SignalBus:
    return SignalBus(WORK / "ledger")


def max_seq(bus: SignalBus) -> int:
    recs = bus.read(limit=100000)
    return recs[-1]["seq"] if recs else 0


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def main() -> int:
    WORK.mkdir(exist_ok=True)
    bus = fresh_bus()

    # 1) 契约正向：六件套齐全过校验
    expect("契约正向", sig().validate() is not None)

    # 2) 契约反向：八类违例全拒
    for label, bad in [
        ("source_type空", {"source_type": " "}),
        ("payload非dict", {"payload": "文本"}),
        ("payload空dict", {"payload": {}}),
        ("evidence空", {"evidence": {}}),
        ("jtbd_tags非list", {"jtbd_tags": "需求"}),
        ("ts不可解析", {"ts": "昨天"}),
        ("confidence越界", {"confidence": 1.5}),
        ("evidence不可序列化", {"evidence": {"x": object()}}),
    ]:
        try:
            sig(**bad).validate()
            expect(f"拒·{label}", False, "未抛 ContractError")
        except ContractError as e:
            expect(f"拒·{label}", True, str(e)[:80])

    # 3) dedup_key：同证据同键；异源/异证据异键
    k1, k2 = sig().dedup_key(), sig().dedup_key()
    expect("dedup稳定", k1 == k2 and len(k1) == 40)
    expect("dedup分源", sig(source_type="other").dedup_key() != k1)
    expect("dedup分证据", sig(evidence={"id": rid("t2")}).dedup_key() != k1)

    # 4) 首拉落账：2条→emitted=2，seq 相对连续，账本行含六件套
    prev = max_seq(bus)
    r = bus.pull(FakeAdapter([
        {"id": rid("a1"), "text": "耳机提了标书需求", "ts": "2026-10-23 14:00:00"},
        {"id": rid("a2"), "text": "群里问报价工具", "ts": "2026-10-23 14:05:00"},
    ]))
    expect("首拉emitted", r["emitted"] == 2 and r["dup"] == 0, json.dumps(r))
    seqs = [x["seq"] for x in bus.read(since_seq=prev)]
    expect("账本增量2行", seqs == [prev + 1, prev + 2], str(seqs))
    expect("六件套落账", all(set(x["signal"]) == set(Signal.__dataclass_fields__)
                          for x in bus.read(since_seq=prev)))

    # 5) 幂等：同数据再拉 → 全 dup
    r = bus.pull(FakeAdapter([
        {"id": rid("a1"), "text": "耳机提了标书需求", "ts": "2026-10-23 14:00:00"},
        {"id": rid("a2"), "text": "群里问报价工具", "ts": "2026-10-23 14:05:00"},
    ]))
    expect("幂等去重", r["emitted"] == 0 and r["dup"] == 2, json.dumps(r))

    # 6) 混合：旧1+新1 → 只新入账
    r = bus.pull(FakeAdapter([
        {"id": rid("a1"), "text": "耳机提了标书需求", "ts": "2026-10-23 14:00:00"},
        {"id": rid("a3"), "text": "新录音", "ts": "2026-10-23 15:00:00"},
    ]))
    expect("混合增量", r["emitted"] == 1 and r["dup"] == 1, json.dumps(r))
    expect("seq续接", [x["seq"] for x in bus.read(since_seq=prev)]
           == [prev + 1, prev + 2, prev + 3])

    # 7) 拒收留痕：坏 normalize 输出（空evidence）→ rejected=1 且好信号照常
    class HalfBadAdapter(FakeAdapter):
        def normalize(self, raw):
            if raw["id"] == rid("bad"):
                return Signal(source_type="fake", payload={"text": raw["text"]},
                              evidence={}, jtbd_tags=[], ts=raw["ts"],
                              confidence=0.9)
            return super().normalize(raw)

    r = bus.pull(HalfBadAdapter([
        {"id": rid("bad"), "text": "无证据信号", "ts": "2026-10-23 15:01:00"},
        {"id": rid("a4"), "text": "好信号", "ts": "2026-10-23 15:02:00"},
    ]))
    expect("拒收留痕", r["rejected"] == 1 and r["emitted"] == 1, json.dumps(r))
    rej = [json.loads(l) for l in
           (WORK / "ledger" / "signals.jsonl").read_text(encoding="utf-8").splitlines()
           if json.loads(l).get("reject")]
    expect("reject行", rej and rej[-1]["seq"] is None
           and "evidence" in rej[-1]["reason"], json.dumps(rej[-1])[:160])

    # 8) normalize 多态：None=跳过；list=多信号
    class MultiAdapter(FakeAdapter):
        def normalize(self, raw):
            if raw["id"] == rid("skip"):
                return None
            if raw["id"] == rid("multi"):
                return [super().normalize({"id": rid("m1"), "text": raw["text"],
                                           "ts": raw["ts"]}),
                        super().normalize({"id": rid("m2"), "text": raw["text"],
                                           "ts": raw["ts"]})]
            return super().normalize(raw)

    r = bus.pull(MultiAdapter([
        {"id": rid("skip"), "text": "跳过我", "ts": "2026-10-23 15:03:00"},
        {"id": rid("multi"), "text": "一拖二", "ts": "2026-10-23 15:04:00"},
    ]))
    expect("None跳过", r["skipped"] == 1, json.dumps(r))
    expect("list多信号", r["emitted"] == 2 and r["dup"] == 0, json.dumps(r))

    # 9) 源崩溃隔离：crash 源 errors=1 不抛；fake 源随后照常
    r = bus.pull(CrashAdapter())
    expect("源崩隔离", r["errors"] == 1 and "discover" in r.get("err", ""),
           json.dumps(r))
    r = bus.pull(FakeAdapter([{"id": rid("a5"), "text": "灾后照常",
                               "ts": "2026-10-23 15:05:00"}]))
    expect("灾后照常", r["emitted"] == 1, json.dumps(r))

    # 10) read 过滤：since_seq + limit
    last = max_seq(bus)
    expect("since过滤", [x["seq"] for x in bus.read(since_seq=last - 1)] == [last])
    expect("limit过滤", len(bus.read(limit=1)) == 1)

    # 11) 进程外持久性：新实例（同账本）重拉旧数据 → 全 dup
    r = fresh_bus().pull(FakeAdapter([{"id": rid("a1"), "text": "耳机提了标书需求",
                                       "ts": "2026-10-23 14:00:00"}]))
    expect("持久去重", r["emitted"] == 0 and r["dup"] == 1, json.dumps(r))

    # 12) CLI 子进程：--read 只读信号行；未注册源 → rc=2 错误行
    p = subprocess.run(
        [sys.executable, "-X", "utf8", "-m", "signals.bus", "--read",
         "--ledger-dir", str(WORK / "ledger")],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        cwd=str(ROOT))
    cli_recs = json.loads(p.stdout.strip())
    expect("CLI读账", p.returncode == 0
           and all(isinstance(x.get("seq"), int) for x in cli_recs),
           f"rc={p.returncode} n={len(cli_recs)}")
    p = subprocess.run(
        [sys.executable, "-X", "utf8", "-m", "signals.bus", "--pull",
         "--adapter", "notexist", "--ledger-dir", str(WORK / "ledger")],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        cwd=str(ROOT))
    expect("CLI未注册", p.returncode == 2 and "未注册" in p.stdout,
           f"rc={p.returncode} out={p.stdout.strip()[:120]}")

    mine = len(bus.read(since_seq=prev, limit=100000))
    print(f"PASS: W3.1 契约+内核全绿（本次新增信号 {mine} 条，reject 留痕 "
          f"{len(rej)} 条，账本只增未删）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
