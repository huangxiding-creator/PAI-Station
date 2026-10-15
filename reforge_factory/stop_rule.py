# -*- coding: utf-8 -*-
"""边际增益停时器 (T-005, REQ-041) — 调研采集轮次的主停止规则.

规则 (REQ-041, 参数权威源 gates.json → stopping, 经 gates_loader 现读):
    1. 绝对时长保险丝 (红线, 优先于一切裁量): elapsed_hours > fuse_hours
       → "stop_fuse";
    2. 边际信息增益主规则: 最近连续 rounds 轮每轮增益均 < gain_threshold_pct
       → "stop_gain" (尾部逐轮连续, 中断一轮即重新数);
    3. 否则 → "continue".

参数在**决策时**读 gates_loader.load_gates()["stopping"], 绝不在 import 时
快照 (与 gates_loader 无缓存设计一致, 改 gates.json 即时生效). 键名兼容:
优先 gain_threshold_pct, 缺失时回退 REQ-041.AC1 短键 gain_threshold.

落账: campaign 传入时每次 decide() 自动 record_decision(research_rounds 域)
写入 ammo_pool/<campaign>/decision_ledger.jsonl, 停时记录含每轮增益数
(round_gain_history 入 context, REQ-041.AC1). campaign 缺省 = 纯决策模式
不落账 (供无副作用调用); 测试一律传 pool_root=tmp 夹具.

纯标准库, 无第三方依赖.
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import gates_loader                                    # noqa: E402
import decision_ledger as DL                           # noqa: E402

CONTINUE = "continue"
STOP_GAIN = "stop_gain"
STOP_FUSE = "stop_fuse"

#: 兜底缺省 = gates.json 权威值镜像 (stopping 键整体缺失时才逐键兜底)
_FALLBACK_STOPPING = {"gain_threshold_pct": 2.0, "rounds": 3, "fuse_hours": 72}


def read_stopping() -> dict:
    """决策时读 stopping 三参数 (float/int 归一, 短键 gain_threshold 兜底)."""
    raw = gates_loader.load_gates().get("stopping") or {}
    gain = raw.get("gain_threshold_pct", raw.get("gain_threshold",
                                                 _FALLBACK_STOPPING["gain_threshold_pct"]))
    return {
        "gain_threshold_pct": float(gain),
        "rounds": int(raw.get("rounds", _FALLBACK_STOPPING["rounds"])),
        "fuse_hours": float(raw.get("fuse_hours", _FALLBACK_STOPPING["fuse_hours"])),
    }


def decide(round_gain_history: list[float], elapsed_hours: float,
           campaign=None, pool_root=None, stopping=None) -> str:
    """停时判定, 返回 "continue" | "stop_gain" | "stop_fuse".

    round_gain_history: 每轮新增信息增益 (%), 按轮次升序;
    elapsed_hours:      战役已历时 (小时), 保险丝判据;
    stopping:           缺省 None → 决策时现读 gates.json (推荐);
    campaign:           传入则自动落 research_rounds 决策账.
    """
    gains = [float(g) for g in (round_gain_history or [])]
    elapsed = float(elapsed_hours)
    if elapsed < 0:
        raise ValueError(f"elapsed_hours 不得为负, 实得 {elapsed}")
    p = stopping if stopping is not None else read_stopping()
    threshold, rounds, fuse = (p["gain_threshold_pct"], p["rounds"],
                               p["fuse_hours"])

    tail = gains[-rounds:] if rounds > 0 else []
    if elapsed > fuse:                                 # 保险丝红线优先
        verdict = STOP_FUSE
        rationale = (f"绝对时长保险丝: elapsed={elapsed}h > fuse={fuse}h "
                     f"(红线不可裁) → 强制停采")
    elif len(tail) == rounds and all(g < threshold for g in tail):
        verdict = STOP_GAIN
        rationale = (f"连续{rounds}轮边际增益{tail}均<{threshold}% "
                     f"(REQ-041 主规则) → 停采; elapsed={elapsed}h<fuse={fuse}h")
    else:
        verdict = CONTINUE
        rationale = (f"尾部{len(tail)}轮增益{tail}未连续{rounds}轮<{threshold}%, "
                     f"elapsed={elapsed}h<fuse={fuse}h → 继续采集")

    if campaign:
        context = {
            "campaign": campaign,
            "round_gain_history": gains,               # 每轮增益数 (REQ-041.AC1)
            "rounds_elapsed": len(gains),
            "elapsed_hours": elapsed,
            "gain_threshold_pct": threshold,
            "rounds": rounds,
            "fuse_hours": fuse,
        }
        DL.record_decision(
            campaign=campaign,
            decision_type="research_rounds",
            context=context,
            options=[
                {"k": CONTINUE, "v": "再采一轮"},
                {"k": STOP_GAIN, "v": "边际增益停时"},
                {"k": STOP_FUSE, "v": "时长保险丝停时"},
            ],
            chosen=verdict,
            rationale=rationale,
            pool_root=pool_root,
        )
    return verdict
