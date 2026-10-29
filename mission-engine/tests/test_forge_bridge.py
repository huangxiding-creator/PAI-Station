# -*- coding: utf-8 -*-
"""tests/test_forge_bridge.py — 锻造厂桥契约测试（W4.1 验收，离线零网络）。

FakeLlm 确定性桩 → 信号形变 → 五阶段(锻造/校验/去重/评分) → 草案落盘+
锻造账本。全程私有目录，不碰主账本/真proposals/网络。
运行: py -X utf8 tests\\test_forge_bridge.py
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from forge.ideadig_bridge import (FakeLlm, to_ideadig_signals,   # noqa: E402
                                  resolve_evidence, run)
from signals.bus import SignalBus                                      # noqa: E402


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def _seed_bus(work: Path) -> SignalBus:
    """私有账本喂3条异源信号（含JTBD全形+薄形各一）；键带运行唯一后缀防重跑dup。"""
    uniq = time.strftime("%H%M%S")
    bus = SignalBus(work / "ledger")
    from signals.adapters.moments import MomentsAdapter

    class SeedMoments(MomentsAdapter):
        def discover(self):
            return [json.dumps({
                "ts": "2026-10-20T09:00:00", "face": "moments",
                "ref": {"wxid": "peer_a", "mine": "sns_feed"},
                "quote": "年底要交信息化总结，去年数据翻半天对不上",
                "quote_full_hash": "h1", "score0": 70,
                "private_level": "public", "key": f"forge_t1_{uniq}"},
                ensure_ascii=False)]

    from signals.adapters.demand_ledger import DemandLedgerAdapter

    class SeedLedger(DemandLedgerAdapter):
        def discover(self):
            return [json.dumps({
                "signal_id": f"dl_99990_forge{uniq}", "ts": "2026-10-20T10:00:00",
                "source_face": "mp_feedback", "source_ref": "fb:x",
                "demand_quote": "第8章判例谱系建议按争议类型再分一层索引",
                "jtbd": {"trigger": "买家反馈", "job_statement": "按需检索判例",
                         "outcome": "报告迭代"},
                "frequency": 2, "urgency": "high", "score": 100},
                ensure_ascii=False)]

    r1 = bus.pull(SeedMoments())
    r2 = bus.pull(SeedLedger())
    assert r1["emitted"] == 1 and r2["emitted"] == 1, "播种失败"
    return bus


def main() -> int:
    WORK = Path(__file__).resolve().parent / ".forge-work" / (
        "run" + time.strftime("%H%M%S"))      # 每跑全新目录：天然幂等零残留
    WORK.mkdir(parents=True, exist_ok=True)
    bus = _seed_bus(WORK)
    recs = bus.read()
    expect("播种2条", len(recs) == 2, str(len(recs)))

    # 1) 信号形变: 六面 → IdeaDig 锻造信号形（doc_ref=SIGn 稳定）
    sigs = to_ideadig_signals(recs)
    expect("形变保量", len(sigs) == 2)
    s0 = next(s for s in sigs if s["category"] == "moments")
    expect("quote映射", "信息化总结" in s0["quote"], s0["quote"])
    expect("doc_ref稳定", s0["doc_ref"].startswith("SIG")
           and s0["_sig"]["seq"] is not None, s0["doc_ref"])
    s1 = next(s for s in sigs if s["category"] == "demand_ledger")
    expect("JTBD进pain", "按需检索判例" in (s1["pain"] or ""), str(s1["pain"]))
    expect("cause_chain", str(s1.get("cause_chain")).startswith("因买家反馈"))

    # 2) 溯源回解: doc_ref → 指针齐全（seq/源/时刻/证据键）
    sig_idx = {s["doc_ref"]: s.pop("_sig") for s in sigs}
    ev = resolve_evidence({"evidence": [{"doc_ref": "SIG2", "quote": "x"}]},
                          sig_idx)
    expect("溯源指针", ev[0]["seq"] == 2 and ev[0]["source_type"] == "demand_ledger"
           and ev[0]["ts"], json.dumps(ev[0], ensure_ascii=False)[:120])

    # 3) 全管线离线跑: FakeLlm → 草案落盘 + 锻造账本（私有目录）
    pdir = WORK / f"props_{time.strftime('%H%M%S')}"
    stats = run(FakeLlm(), top=2, bus=bus,
                ledger_file=WORK / "forge.jsonl", proposals_dir=pdir)
    expect("候选≥1", stats["candidates"] >= 1, json.dumps(stats))
    expect("校验通过", stats["validated"] >= 1, json.dumps(stats))
    expect("草案落盘", stats["proposals"] >= 1
           and any(p.suffix == ".md" for p in pdir.glob("*.md")), json.dumps(stats))
    draft = next(pdir.glob("*.md")).read_text(encoding="utf-8")
    expect("草案标draft", "draft(W4.1)" in draft and "勿直接执行" in draft)
    expect("草案带溯源", "seq" in draft and "demand_ledger" in draft, draft[:200])
    expect("草案带SCORECARD", "SCORECARD" in draft and "综合" in draft)
    expect("锻造账本落账", (WORK / "forge.jsonl").is_file()
           and '"run_id"' in (WORK / "forge.jsonl").read_text(encoding="utf-8"))

    # 4) 草案不含密钥/无外发痕迹（红线自检）
    expect("无密钥泄露", "api_key" not in draft and "Bearer" not in draft)

    print("PASS: 锻造厂桥离线契约全绿（--live 层走 CLI 实弹，见指南）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except AssertionError as e:
        print(f"FAIL: {e}")
        sys.exit(2)
