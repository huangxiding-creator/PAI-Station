# -*- coding: utf-8 -*-
"""framework_gate — P1-1 S1 出口呈审门 (框架呈批三态复用 S0 通道).

S2 是重资源阶段 (渠道配额/账号面/班次腿), HITL 关卡卡在成本拐点 —
S1 是最后廉价止损点. framework.json 渲染 markdown 呈审, 批/改批/豁免
三态留痕 (豁免对齐 S5 waivers 机制: FAIL→WARN 留痕, 须给 reason 绝不
静默); 不开 deer-flow 式 auto_accepted 配置项级跳过.

流水:
  ① build: 读 framework.json (走 S1-3 回炉环) → contracts 校验零错 +
     S3-2 指纹锚 → 机器可读 framework_submitted.json + 人读
     framework_review.md
  ② submit: 企微呈批 (injectable `_push_wecom`, 免费面) + ledger 留痕
  ③ receipt 三态: APPROVED→framework_approved.json / EDIT→改批 (≤2 轮,
     第 3 次 escalate 详单回呈) / EXEMPT→豁免留痕 (waivers 同构)
  ④ s2_gate: 积分制/账号面渠道首次出队前须有 approved framework 记录
     (免费面渠道不受此闸 — 止损点在成本拐点, 不在零成本面).

判定源: contracts.validate_framework + outline_contract.fingerprint,
呈批件机检零错才许出门; 批准记录带指纹锚 (框架后续变更走 S3-2 正门,
reconcile 另有漂移检出, 本门只锚批准时点).

用法:
  python framework_gate.py --battle-dir D --cid C --submit
  python framework_gate.py --battle-dir D --cid C --receipt \
      --verdict APPROVED|EDIT|EXEMPT [--feedback "…"]
  python framework_gate.py --battle-dir D --cid C --status
  python framework_gate.py --battle-dir D --cid C --gate-check \
      --channel-json '{"id":"x","credits":true}'
"""
from __future__ import annotations

import ast
import json
import re
import subprocess
import sys
import time
from pathlib import Path

import superline as _sl
from superline import contracts as C
from superline import framework_gen as FG
from superline import outline_contract as OC

STATION = Path(r"E:\AI-Station")

MAX_EDIT_ROUNDS = 2          # 与 S0-3 同规: 改批往返 ≤2 轮, 第 3 次 escalate
VERDICTS = ("APPROVED", "EDIT", "EXEMPT")
_TS_RE = re.compile(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$")

LEDGER = "framework_gate_ledger.jsonl"
REVIEW_JSON = "framework_submitted.json"
REVIEW_MD = "framework_review.md"
APPROVED_F = "framework_approved.json"


# ---------- 落位 (S0-3 同惯例: 战役目录首个 00 前缀子目录) ----------
def _out(battle_dir: str) -> Path:
    return FG.CG._out_dir(battle_dir)


def _read_json(p: Path) -> dict:
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except Exception:
        return {}


def _ts() -> str:
    return time.strftime("%Y-%m-%dT%H:%M:%S")


def _log(out: Path, event: str, **kw) -> None:
    """全链时间戳留痕 (呈批/回执/批准/豁免 逐事件落账)."""
    rec = {"ts": _ts(), "event": event, **kw}
    with open(out / LEDGER, "a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def _ledger(out: Path) -> list[dict]:
    p = out / LEDGER
    if not p.is_file():
        return []
    try:
        return [json.loads(ln) for ln in
                p.read_text(encoding="utf-8").splitlines() if ln.strip()]
    except Exception:
        return []


# ---------- 企微呈批 (免费面, injectable; 与 S0-3 同锚) ----------
def _push_wecom(text: str) -> bool:
    """企微个人 OAuth 免费通道 (best-effort, 失败只留痕不阻断)."""
    try:
        r = subprocess.run(["wecom-cli", "message", "aibot", "send",
                            "--text", text], capture_output=True, text=True,
                           timeout=60, check=False,
                           creationflags=getattr(
                               subprocess, "CREATE_NO_WINDOW", 0))
        return r.returncode == 0
    except Exception:
        return False


# ---------- ① 组装 (呈审摘要 = 机器可读 + 人读) ----------
def _digest(fw: dict, cid: str, round_: int) -> dict:
    chapters = []
    for ch in fw.get("chapters", []):
        tm = ch.get("tier_map") or {}
        chapters.append({
            "id": ch.get("id"), "title": ch.get("title"),
            "budget_band": ch.get("budget_band"),
            "evidence_density": ch.get("evidence_density"),
            "channels": ch.get("channels") or [],
            "tiers": {t: len(tm.get(t) or []) for t in ("T1", "T2", "T3")},
            "n_words": sum(len(v or []) for v in tm.values())})
    return {"schema": "framework_review_v1", "campaign_id": cid,
            "report_title": fw.get("report_title"),
            "family": fw.get("family"), "fingerprint": OC.fingerprint(fw),
            "chapters": chapters, "volume_ref": fw.get("volume_ref") or {},
            "n_chapters": len(chapters),
            "total_tier_words": sum(c["n_words"] for c in chapters),
            "round": round_, "approval": "pending", "built": _ts(),
            "version": _sl.__version__}


def _review_md(d: dict) -> str:
    v = d.get("volume_ref") or {}
    lines = [
        f"# 框架呈审件 (第 {d['round']} 轮) — {d['report_title']}", "",
        f"- 战役: {d['campaign_id']} | 框架族: {d['family']} | "
        f"指纹锚: `{d['fingerprint']}`",
        f"- 章数: {d['n_chapters']} | 分层词总计: "
        f"{d['total_tier_words']} 词 | 体量参考: "
        f"{v.get('chapters', '?')}章×{v.get('sections', '?')}节"
        f"/{v.get('total_chars', 0):,}字",
        "", "## 章节路由表 (每章: 词数/分档/密度/渠道)", "",
        "| # | 章 | T1/T2/T3 词 | 分档 | 密度 | 渠道 |",
        "|---|---|---|---|---|---|",
    ]
    for i, c in enumerate(d["chapters"], 1):
        t = c["tiers"]
        lines.append(
            f"| {i} | {c['title']} | {t['T1']}/{t['T2']}/{t['T3']} | "
            f"{c['budget_band']} | {c['evidence_density']} | "
            f"{', '.join(c['channels'])} |")
    lines += [
        "", "> S2 是重资源阶段 — 此门为最后廉价止损点.",
        "> 回复三态: 批 (APPROVED) / 改 (EDIT+意见) / 豁免 (EXEMPT+理由, "
        "waivers 同构留痕)",
    ]
    return "\n".join(lines) + "\n"


def build(battle_dir: str, cid: str) -> tuple[dict, Path, list[str]]:
    """framework.json → 呈审摘要. 返回 (digest, 落位目录, 校验错误清单)."""
    out = _out(battle_dir)
    fw, meta = FG.load_framework(battle_dir)      # S1-3 回炉环 (clean/reworked/…)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席或降级失败 — 先跑 S1-1")
    errs = C.validate_framework(fw)
    prev = _read_json(out / REVIEW_JSON)
    round_ = (prev.get("round") or 0) + 1 if prev else 1
    d = _digest(fw, cid, round_)
    d["framework_mode"] = meta["mode"]
    (out / REVIEW_JSON).write_text(
        json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8")
    _log(out, "built", round=round_, errors=len(errs),
         fingerprint=d["fingerprint"], mode=meta["mode"],
         n_chapters=d["n_chapters"])
    return d, out, errs


# ---------- ② 呈批 ----------
def submit(battle_dir: str, cid: str) -> tuple[dict, Path, bool]:
    """呈审出门: 校验零错才许出 + 人读 MD + 企微推送 + ledger."""
    out = _out(battle_dir)
    d = _read_json(out / REVIEW_JSON)
    if not d:
        d, out, errs = build(battle_dir, cid)     # 幂等: 无摘要先建
        if errs:
            _log(out, "submit_blocked", errors=errs)
            raise ValueError(f"framework 校验 {len(errs)} 错, 禁呈批: "
                             f"{errs[:3]}")
    fw, _ = FG.load_framework(battle_dir)
    errs = C.validate_framework(fw) if fw else ["framework.json 缺席"]
    if errs:
        _log(out, "submit_blocked", errors=errs)
        raise ValueError(f"framework 校验 {len(errs)} 错, 禁呈批: {errs[:3]}")
    d["approval"], d["submitted"] = "pending", _ts()
    (out / REVIEW_JSON).write_text(
        json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8")
    (out / REVIEW_MD).write_text(_review_md(d), encoding="utf-8")
    text = (f"[呈审] 战役 {cid} 框架第{d['round']}轮 "
            f"{d['n_chapters']}章/{d['total_tier_words']}词 "
            f"指纹{d['fingerprint'][:8]} — S2 成本拐点前最后止损. "
            f"回: 批/改/豁免")
    ok = _push_wecom(text)
    _log(out, "submitted", round=d["round"], push_ok=ok)
    return d, out, ok


# ---------- ③ 三态回执 ----------
def _escalate(out: Path, d: dict, feedback: str) -> dict:
    d["approval"], d["escalated"] = "edit", True
    (out / REVIEW_JSON).write_text(
        json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8")
    detail = (f"[框架呈审 escalated] {d['campaign_id']} 改批往返已达 "
              f"{MAX_EDIT_ROUNDS} 轮未锁定: {feedback} — 详单回呈, 须用户裁决")
    ok = _push_wecom(detail)
    _log(out, "escalated", round=d["round"], feedback=feedback[:200],
         push_ok=ok)
    return d


def receipt(battle_dir: str, cid: str, verdict: str,
            feedback: str = "") -> dict:
    """三态回执: APPROVED→批准 / EDIT→改批(≤2轮) / EXEMPT→豁免留痕."""
    out = _out(battle_dir)
    d = _read_json(out / REVIEW_JSON)
    if not d:
        raise FileNotFoundError("无呈审摘要在案 (先 --submit)")
    if verdict not in VERDICTS:
        raise ValueError(f"verdict 非法: {verdict!r} (值域 {VERDICTS})")
    _log(out, "receipt", verdict=verdict, round=d.get("round", 1),
         feedback=feedback[:200])
    if verdict == "APPROVED":
        rec = {"schema": "framework_approval_v1", "campaign_id": cid,
               "verdict": "approved", "round": d.get("round"),
               "fingerprint": d.get("fingerprint"),
               "report_title": d.get("report_title"),
               "n_chapters": d.get("n_chapters"), "ts": _ts(),
               "feedback": feedback}
        (out / APPROVED_F).write_text(
            json.dumps(rec, ensure_ascii=False, indent=1), encoding="utf-8")
        d["approval"] = "approved"
        (out / REVIEW_JSON).write_text(
            json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8")
        _log(out, "approved", round=d.get("round"),
             fingerprint=d.get("fingerprint", "")[:12])
        _log(out, "push", ok=_push_wecom(
            f"[批准] {cid} 框架已批准 (第{d.get('round')}轮锁定), "
            f"S2 积分制/账号面渠道出队放行"), kind="approved")
    elif verdict == "EXEMPT":
        if not feedback:
            _log(out, "exempt_blocked", why="豁免必须给 reason")
            raise ValueError("EXEMPT 必须给 feedback/reason "
                             "(waivers 同构: 豁免留痕绝不静默)")
        rec = {"schema": "framework_approval_v1", "campaign_id": cid,
               "verdict": "exempt", "round": d.get("round"),
               "fingerprint": d.get("fingerprint"),
               "report_title": d.get("report_title"),
               "n_chapters": d.get("n_chapters"), "ts": _ts(),
               "reason": feedback, "waiver": True}
        (out / APPROVED_F).write_text(
            json.dumps(rec, ensure_ascii=False, indent=1), encoding="utf-8")
        d["approval"] = "exempt"
        (out / REVIEW_JSON).write_text(
            json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8")
        _log(out, "exempt", round=d.get("round"), reason=feedback[:200],
             fingerprint=d.get("fingerprint", "")[:12])
        _log(out, "push", ok=_push_wecom(
            f"[豁免留痕] {cid} 框架呈审用户裁决豁免: {feedback[:120]} "
            f"(WARN 态放行, 非 approved)"), kind="exempt")
    else:                                          # EDIT
        d["approval"], d["edit_feedback"] = "edit", feedback
        if d.get("round", 1) >= MAX_EDIT_ROUNDS:
            return _escalate(out, d, feedback)
        d["round"] = d.get("round", 1) + 1
        (out / REVIEW_JSON).write_text(
            json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8")
        _log(out, "revise_to_draft", round=d["round"])
    return d


# ---------- ④ S2 出队闸 (验收锚: 积分制/账号面首出队前须有批准记录) ----------
def s2_gate(battle_dir: str, channel: dict | None = None) -> dict:
    """积分制/账号面渠道出队闸: approved framework 记录在案才放行.

    channel 取渠道注册表条目 (dict); credits/account_bound 判 regulated.
    免费面不受此闸 — 止损点在成本拐点."""
    out = _out(battle_dir)
    ch = channel or {}
    regulated = bool(ch.get("credits")) or bool(ch.get("account_bound"))
    if not regulated:
        return {"ok": True, "regulated": False,
                "why": "免费面渠道不受此闸 (成本拐点止损, 零成本面直行)"}
    appr = _read_json(out / APPROVED_F)
    if not appr:
        return {"ok": False, "regulated": True,
                "why": "framework_approved.json 缺失 — S1 呈审门未过, "
                       "积分制/账号面渠道禁出队"}
    v = appr.get("verdict")
    if v not in ("approved", "exempt"):
        return {"ok": False, "regulated": True, "why": f"verdict={v!r} 非放行态"}
    return {"ok": True, "regulated": True, "verdict": v,
            "why": f"{v}@{appr.get('ts', '')} round{appr.get('round')} "
                   f"fp={str(appr.get('fingerprint'))[:12]}"}


def status(battle_dir: str) -> dict:
    out = _out(battle_dir)
    led = _ledger(out)
    appr = _read_json(out / APPROVED_F)
    g = s2_gate(battle_dir, {"id": "probe", "credits": True})
    return {"dir": str(out), "ledger_n": len(led),
            "events": [e["event"] for e in led],
            "all_ts_iso": all(_TS_RE.match(e.get("ts", "")) for e in led),
            "approved": {"verdict": appr.get("verdict"),
                         "round": appr.get("round"),
                         "fingerprint": appr.get("fingerprint")},
            "gate_simulated_regulated": g}


# ---------- CLI ----------
def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="P1-1 S1 出口呈审门")
    ap.add_argument("--battle-dir", required=True)
    ap.add_argument("--cid", required=True)
    ap.add_argument("--submit", action="store_true")
    ap.add_argument("--receipt", action="store_true")
    ap.add_argument("--status", action="store_true")
    ap.add_argument("--gate-check", action="store_true")
    ap.add_argument("--verdict", default="", choices=VERDICTS)
    ap.add_argument("--feedback", default="")
    ap.add_argument("--channel-json", default="")
    args = ap.parse_args(argv)
    print(f"[p1-1] superline {_sl.__version__} 框架呈审门 "
          f"(S2 成本拐点前最后止损)")
    if args.submit:
        d, out, ok = submit(args.battle_dir, args.cid)
        print(f"[p1-1] 呈审件落 {out / REVIEW_JSON} + {out / REVIEW_MD} | "
              f"{d['n_chapters']}章/{d['total_tier_words']}词 "
              f"指纹 {d['fingerprint']} | 企微 "
              f"{'✓' if ok else '推送失败(已留痕)'}")
        return 0
    if args.receipt:
        if not args.verdict:
            print("[p1-1] --receipt 须 --verdict", file=sys.stderr)
            return 2
        d = receipt(args.battle_dir, args.cid, args.verdict, args.feedback)
        print(f"[p1-1] 回执 {args.verdict} → approval={d['approval']} "
              f"round={d.get('round')}"
              + (" | ESCALATED 详单回呈" if d.get("escalated") else ""))
        return 0
    if args.gate_check:
        ch = json.loads(args.channel_json) if args.channel_json else {}
        g = s2_gate(args.battle_dir, ch)
        print(f"[p1-1] 出队闸: {'放行 ✅' if g['ok'] else '拦截 ❌'} "
              f"(regulated={g['regulated']}) {g['why']}")
        return 0 if g["ok"] else 1
    st = status(args.battle_dir)
    print(f"[p1-1] {st['dir']} | ledger {st['ledger_n']} 事件 "
          f"(ts 全ISO: {st['all_ts_iso']}) | 批准态: "
          f"{st['approved'].get('verdict') or '未批准'}")
    print(f"[p1-1] 事件链: {' → '.join(st['events']) or '空'} | "
          f"regulated 闸模拟: {st['gate_simulated_regulated']['ok']}")
    return 0


if __name__ == "__main__":
    # ast 零付费机检: 网络根模块禁入 (与 S0-3 同锚; 企微腿走 CLI 免费面)
    _mods = set()
    for _n in ast.walk(ast.parse(Path(__file__).read_text(encoding="utf-8"))):
        if isinstance(_n, ast.Import):
            _mods.update(a.name.split(".")[0] for a in _n.names)
        elif isinstance(_n, ast.ImportFrom) and _n.module:
            _mods.add(_n.module.split(".")[0])
    assert not (_mods & {"urllib", "requests", "httpx", "curl_cffi",
                         "socket"}), f"framework_gate 禁网络根模块: {_mods}"
    sys.exit(main())
