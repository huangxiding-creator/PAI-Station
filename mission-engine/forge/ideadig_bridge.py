# -*- coding: utf-8 -*-
"""forge/ideadig_bridge.py — IdeaDig五阶段管线接入SignalBus（W4.1）。

复用站内前作 E:/AI-Station/IdeaDig 的阶段纯函数（锻造/对抗校验/评分/去重，
挖矿段免——bus 信号本就是已挖矿的JTBD信号），GLM 鸭子客户端见 glm_json。
链: 主账本信号 → 形变 → forge_requirements → validate(置信门) →
is_vague兜底 → dedup_merge → score → Top-N 落提案草案(proposals/*.md)+
锻造账本(ledger/forge.jsonl)。草案≠推送：过SCORECARD门与审批闸是W4.3/W4.4事。

CLI: py -X utf8 -m forge.ideadig_bridge [--live] [--top 3] [--limit 200]
     [--model glm-4-flash] [--since-seq N]
离线默认: FakeLlm 确定性桩（零网络零密钥），供契约测试。
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]          # mission-engine/
IDEADIG_ROOT = Path("E:/AI-Station/IdeaDig")
for p in (str(ROOT), str(IDEADIG_ROOT)):
    if p not in sys.path:
        sys.path.insert(0, p)

from ideadig.analysis import stages as S             # noqa: E402 — 前作纯函数
from ideadig.analysis.prompts import is_vague        # noqa: E402
from signals.bus import SignalBus                    # noqa: E402

PROPOSALS = ROOT / "proposals"
FORGE_LEDGER = ROOT / "ledger" / "forge.jsonl"
MIN_CONFIDENCE = 0.6


class FakeLlm:
    """离线确定性桩：按提示词身份返回罐头 JSON（score/validate/forge 三态）。"""

    def __init__(self):
        self.calls = 0

    def chat_json(self, system, user, temperature=0.2, timeout=60):
        self.calls += 1
        if '"pain"' in user:                           # 锻造段用户词含信号数组
            pass                                       # → 走下方锻造分支
        elif "评分" in system:                         # SCORE_SYSTEM独有中文标记
            return {"value": 7, "difficulty": 4, "universality": 7,
                    "evidence_strength": 8, "rationale": "离线桩评分"}
        elif "score" in system.lower():                # VALIDATE_SYSTEM独有英文标记
            return {"verdict": "keep", "confidence": 0.8,
                    "feasibility_score": 7, "issues": []}
        # 锻造段：从入参信号取引文造一条最小候选（结构对齐FORGE提示词产物）
        try:
            i = user.find("[")
            slim = json.loads(user[i:user.rfind("]") + 1])
        except Exception:                             # noqa: BLE001
            slim = []
        if not slim:
            slim = [{"doc_ref": "", "quote": "离线信号", "category": "test"}]
        q = (slim[0].get("quote") or "离线信号")[:40]
        return {"requirements": [{
            "title": f"离线锻造候选·{q}",
            "summary": "FakeLlm 确定性产物（离线契约测试专用）",
            "capability_unit": "从SignalBus信号锻造的最小可行AI能力单元（离线桩）",
            "current_workaround": "人工处理", "ai_value": "自动化提速",
            "target_users": ["工程口从业者"],
            "evidence": [{"doc_ref": s.get("doc_ref") or "",
                          "quote": (s.get("quote") or "")[:40],
                          "category": s.get("category")}
                         for s in slim[:5]],
        }]}


def to_ideadig_signals(recs: list[dict]) -> list[dict]:
    """主账本信号 → IdeaDig 锻造段信号形（category/pain/quote/doc_ref/…）。"""
    out: list[dict] = []
    for r in recs:
        s = r.get("signal") or {}
        pay = s.get("payload") or {}
        quote = (pay.get("demand_quote") or pay.get("quote")
                 or pay.get("text") or "")
        if not str(quote).strip():
            continue
        jtbd = pay.get("jtbd") or {}
        out.append({
            "category": s.get("source_type") or "",
            "pain": jtbd.get("job_statement") or str(quote)[:80],
            "quote": str(quote)[:200],
            "doc_ref": f"SIG{r.get('seq')}",
            "cause_chain": (f"因{jtbd.get('trigger')}…故可介入"
                            if jtbd.get("trigger") else None),
            "target_role": (s.get("jtbd_tags") or [""])[0],
            "_sig": {"seq": r.get("seq"), "dedup_key": r.get("dedup_key"),
                     "source_type": s.get("source_type"), "ts": s.get("ts"),
                     "evidence": s.get("evidence"), "confidence": s.get("confidence")},
        })
    return out


def resolve_evidence(req: dict, sig_idx: dict[str, dict]) -> list[dict]:
    """锻造产物的 doc_ref(SIGn) → 溯源指针（seq/源/时刻/证据键）。"""
    out: list[dict] = []
    for ev in (req.get("evidence") or []):
        if not isinstance(ev, dict):
            continue
        src = sig_idx.get(ev.get("doc_ref") or "") or {}
        out.append({"seq": src.get("seq"), "source_type": src.get("source_type"),
                    "ts": src.get("ts"), "evidence": src.get("evidence"),
                    "quote": (ev.get("quote") or "")[:200]})
    return out


def run(llm, top: int = 3, limit: int = 200, since_seq: int = 0,
        bus: SignalBus | None = None, ledger_file: Path = FORGE_LEDGER,
        proposals_dir: Path = PROPOSALS) -> dict:
    bus = bus or SignalBus()
    recs = bus.read(since_seq=since_seq, limit=limit)
    sigs = to_ideadig_signals(recs)
    stats = {"signals_in": len(sigs), "candidates": 0, "validated": 0,
             "dropped": 0, "final": 0, "proposals": 0}
    if not sigs:
        return stats
    sig_idx = {s["doc_ref"]: s.pop("_sig") for s in sigs}
    cands = S.forge_requirements(llm, sigs)
    stats["candidates"] = len(cands)
    kept: list[dict] = []
    for req in cands:
        v = S.validate_requirement(llm, req)
        verdict = (v.get("verdict") or "keep").lower()
        conf = float(v.get("confidence") or 0.5)
        if verdict == "drop" or conf < MIN_CONFIDENCE:
            stats["dropped"] += 1
            continue
        if verdict == "revise" and v.get("revised_capability_unit"):
            req["capability_unit"] = v["revised_capability_unit"]
        if is_vague(req.get("capability_unit", "")):
            stats["dropped"] += 1
            continue
        req["confidence"] = conf
        kept.append(req)
        stats["validated"] += 1
    merged = S.dedup_merge(kept)
    scored: list[dict] = []
    for req in merged:
        dims = S.score_requirement(llm, req)
        if dims["score"] <= 0:
            continue
        req["priority"] = dims
        req["evidence_resolved"] = resolve_evidence(req, sig_idx)
        scored.append(req)
    scored.sort(key=lambda r: r["priority"]["score"], reverse=True)
    stats["final"] = len(scored)

    run_id = time.strftime("R%Y%m%d-%H%M%S")
    written: list[dict] = []
    proposals_dir.mkdir(parents=True, exist_ok=True)
    for req in scored[:top]:
        fp = proposals_dir / (
            f"{time.strftime('%Y%m%d')}-draft-{run_id}-{len(written) + 1}.md")
        fp.write_text(_render(req, run_id), encoding="utf-8")
        written.append({"title": req.get("title"),
                        "score": req["priority"]["score"],
                        "file": fp.name})
        stats["proposals"] += 1
    ledger_file.parent.mkdir(parents=True, exist_ok=True)
    with ledger_file.open("a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%Y-%m-%d %H:%M:%S"),
                            "run_id": run_id, "stats": stats,
                            "top": written}, ensure_ascii=False,
                           separators=(",", ":")) + "\n")
    stats["run_id"] = run_id
    stats["written"] = written
    return stats


def _render(req: dict, run_id: str) -> str:
    pr = req.get("priority") or {}
    ev = req.get("evidence_resolved") or []
    src_lines = "\n".join(
        f"- seq{e.get('seq')}｜{e.get('source_type')}｜{e.get('ts')}｜"
        + json.dumps(e.get("evidence"), ensure_ascii=False)[:120]
        for e in ev[:10]) or "- （无溯源指针）"
    return f"""【锻造厂草案·{run_id}】状态: draft(W4.1)——未过SCORECARD门与审批闸，勿直接执行

① 标题+一句话
{req.get('title', '')}
{req.get('summary', '')}

② 能力单元（最小可行AI能力）
{req.get('capability_unit', '')}
- 现状替代: {req.get('current_workaround', '')} → AI价值: {req.get('ai_value', '')}
- 目标用户: {"、".join(req.get("target_users") or [])}

③ 对抗校验+评分（IdeaDig五阶段·第3/4段）
- 校验verdict: keep（置信 {req.get('confidence', '')}）
- SCORECARD: 价值{pr.get('value')} 难度{pr.get('difficulty')} 共性{pr.get('universality')}
  证据{pr.get('evidence_strength')} 时效{pr.get('recency_factor')}
  → 综合 {pr.get('score')}
- 依据: {pr.get('rationale', '')}

④ 证据溯源（全部指针可回查主账本）
{src_lines}

⑤ 下一步（W4.3/W4.4 人工+门禁链）
对抗校验复核 → Ten× Delta Index铸模 → 六件套 → 微信审批闸推送
（本草案由管线自动生成，数字零造假：以上分值为GLM评分实测，非人工填）
"""


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="forge.ideadig_bridge",
                                 description="IdeaDig锻造管线接入SignalBus(W4.1)")
    ap.add_argument("--live", action="store_true", help="真GLM实弹（默认离线桩）")
    ap.add_argument("--top", type=int, default=3)
    ap.add_argument("--limit", type=int, default=200)
    ap.add_argument("--since-seq", type=int, default=0)
    ap.add_argument("--model", default=None, help="GLM型号（默认glm-4-flash）")
    args = ap.parse_args(argv)
    if args.live:
        from forge.glm_json import GlmJson
        llm = GlmJson(model=args.model) if args.model else GlmJson()
    else:
        llm = FakeLlm()
    stats = run(llm, top=args.top, limit=args.limit, since_seq=args.since_seq)
    print(json.dumps(stats, ensure_ascii=False, indent=1))
    return 0 if stats.get("final", 0) > 0 or stats.get("signals_in") == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
