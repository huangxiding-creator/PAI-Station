# -*- coding: utf-8 -*-
"""S0-3 Charter 呈批门 + 两级输入协议 (超级生产线).

流水:
  ① build: 报告名 → charter_v1 (消费 S0-2 tiers 草稿 + S0-1 判级报告 +
     F2 六栏卡 + 章×节×字体量 + 设问式核心问题 + 反例问题 ≥3 + 弹药预算 +
     渠道组合三类分标) — contracts.validate_charter 零错才算草案成立
  ② 两级输入: L1 用户详单 (research_config 覆盖) / L2 仅报告名
     (解析腿规则自产研究问题后走同一门)
  ③ submit: 企微呈批 (injectable `_push_wecom`; 生产=wecom-cli 免费面)
     + 机器可读 charter_submitted.json (下游 S1 直接消费) + 全链 ledger
  ④ receipt: 三态回执 ACCEPTED/EDIT/REJECT — EDIT 往返 ≤2 轮,
     第 3 次 EDIT 自动 escalate 详单回呈 (绝不静默拉锯); 批准前 S1 不动工
     (s1_may_start → contracts.charter_ready_for_s1 同源判定).

纪律:
- 批准制同构 S5 waivers (批准进战役目录, 全链时间戳留痕).
- 判定源=contracts 校验器, 呈批件必须机检零错才许出门.
- 零付费: 呈批走企微个人 OAuth 免费通道; ast 机检无网络根模块.

用法:
  python superline/charter_gate.py --build --title "《X怎么干EPC总承包？》" \
      --battle-dir D [--pool CID] [--level L2]
  python superline/charter_gate.py --submit --battle-dir D
  python superline/charter_gate.py --receipt --battle-dir D \
      --verdict ACCEPTED|EDIT|REJECT [--feedback "…"]
  python superline/charter_gate.py --status --battle-dir D
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
from superline import tier_expander as TE

# ---------- 补丁口 (单测 monkeypatch 这三个) ----------
STATION = Path(r"E:\AI-Station")
REPLAY_OUT = Path(__file__).resolve().parent / "replay_out_charter"

MAX_EDIT_ROUNDS = 2          # 验收: 改批往返 ≤2 轮锁定, 第 3 次 EDIT=escalate
DEFAULT_VOLUME = {"chapters": 15, "sections": 3, "total_chars": 300000}
DEFAULT_READER = "总包企业管理层与业务负责人"
F2_SIX_COLUMNS = ("research_object", "report_type", "motivation",
                  "focus_points", "genre", "byline")
RECEIPTS = ("ACCEPTED", "EDIT", "REJECT")
_TS_RE = re.compile(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$")

LEDGER = "charter_ledger.jsonl"
DRAFT = "charter_draft.json"
SUBMITTED = "charter_submitted.json"
ACCEPTED_F = "charter_accepted.json"
REJECTED_F = "charter_rejected.json"
BRIEF = "charter_brief.md"


# ---------- 落位 ----------
def _out_dir(battle_dir: str) -> Path:
    """战役目录首个 00 前缀子目录 (S0-1/S0-2 同惯例; 无则战役根)."""
    bd = Path(battle_dir) if battle_dir else Path(".")
    if bd.is_dir():
        hit = next((s for s in sorted(bd.iterdir())
                    if s.is_dir() and s.name.startswith("00")), None)
        return hit or bd
    bd.mkdir(parents=True, exist_ok=True)
    return bd


def _read_json(p: Path) -> dict:
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except Exception:
        return {}


def _ts() -> str:
    return time.strftime("%Y-%m-%dT%H:%M:%S")


def _log(out: Path, event: str, **kw) -> None:
    """全链时间戳留痕 (呈批/回执/批准 逐事件落账)."""
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


# ---------- 企微呈批 (免费面, injectable) ----------
def _push_wecom(text: str) -> bool:
    """企微个人 OAuth 免费通道呈批 (best-effort, 失败只留痕不阻断)."""
    try:
        r = subprocess.run(["wecom-cli", "message", "aibot", "send",
                            "--text", text], capture_output=True, text=True,
                           timeout=60, check=False,
                           creationflags=getattr(
                               subprocess, "CREATE_NO_WINDOW", 0))
        return r.returncode == 0
    except Exception:
        return False


# ---------- ① 组装 ----------
def _family(title: str, company: str) -> str:
    if any(k in title for k in ("公司", "集团", "院", "局")) or company:
        return "enterprise"
    if any(k in title for k in ("行业", "市场", "产业")):
        return "industry"
    if any(k in title for k in ("政策", "办法", "条例")):
        return "policy"
    return "topic"


def _counter_questions(company: str, topic: str) -> list[str]:
    """反例问题 ≥3 (Skepticalist 预埋: S2 ACH 假设对抗的对立面弹药)."""
    x = company or topic
    return [
        f"{x} 的 EPC 总承包模式为什么可能是错的——最强的反方论据是什么？",
        f"{x} 被谁取代/边缘化过——哪些对手在同一赛道赢走了什么？",
        f"{x} 有哪些公开的失败案例、纠纷处罚与质疑声音？",
    ]


def _core_question_l1(title: str, company: str) -> str:
    m = re.match(r"^(?:《)?(?P<n>.+?)(?P<v>怎么干|如何做|怎么做|如何干)(?P<r>.*)",
                 title)
    if m:
        rest = m.group("r").rstrip("？?").strip("，, ")
        return f"{m.group('n')}{rest}，到底{m.group('v')}成？"
    return f"{company or title.strip('《》')}的核心问题是什么？"


def _core_questions_l2(topic: str) -> list[str]:
    """L2 解析腿自产研究问题 (规则模板, 免费零检索; 走同一呈批门)."""
    return [
        f"{topic} 的真实运作模式是什么——谁在什么约束下怎么交付与赚钱？",
        f"{topic} 为什么现在成立、此前为什么不成立？",
        f"{topic} 最大的瓶颈与最强的反方论据是什么？",
    ]


def _channel_plan(pool_id: str) -> list[dict]:
    """渠道组合三类分标 (默认档; 批准件里人工可改)."""
    return [
        {"class": "stock_harvest",
         "note": "共性库存量仓+先前战役本收割 (共现门内免费复用)"},
        {"class": "current_increment",
         "note": f"当期增量腿 (池 {pool_id or '未建'} 派单, 走 tier_router)"},
        {"class": "on_demand",
         "note": "按需单查 (免费面 zh-search-pro/anysearch; 付费仅 Jev 原语位)"},
    ]


def _campaign_id(pool_id: str, battle: str, title: str) -> str:
    """池名>战役名>标题ASCII净化 兜底 sha1 (须过 ^[A-Za-z0-9][A-Za-z0-9_-]*$)."""
    import hashlib
    for cand in (pool_id, battle):
        s = re.sub(r"[^A-Za-z0-9_-]+", "", cand or "")
        if re.match(r"^[A-Za-z0-9]", s):
            return s[:32]
    s = re.sub(r"[^A-Za-z0-9_-]+", "", title or "")
    return s[:24] if s else "AUTO-" + hashlib.sha1(
        (title or "adhoc").encode("utf-8")).hexdigest()[:8]


def build(title: str, battle: str = "", battle_dir: str = "",
          pool_id: str = "", level: str = "L1") -> tuple[dict, Path, list[str]]:
    """报告名 → charter_v1 草案. 返回 (charter, 落位目录, 校验错误清单).

    消费链: S0-2 tiers 草稿 (在则读, 无则离线 expand) + S0-1 判级报告
    (在则引) + research_config L1 覆盖 + 规则默认档 (逐项溯源)."""
    out = _out_dir(battle_dir)
    company = TE.extract_company_name(title) or title
    cfg = _read_json(Path(battle_dir) / "research_config.json") if battle_dir \
        else {}

    # tiers: S0-2 草稿优先, 缺则离线展开 (确定性, 同判据)
    draft = _read_json(out / "tiers_draft.json")
    if draft.get("t1_draft"):
        t1, t2 = draft["t1_draft"], draft.get("t2_draft") or []
        tiers_src = "s0-2:tiers_draft"
    else:
        doc = TE.expand(title, battle=battle, battle_dir=battle_dir,
                        pool_id=pool_id, online=False)
        t1, t2 = doc["t1_draft"], doc["t2_draft"]
        tiers_src = "s0-2:offline-expand"

    topic = title.strip("《》")
    l2 = level == "L2"
    core_q = (_core_questions_l2(topic)[0] if l2
              else _core_question_l1(title, company))
    cid = _campaign_id(pool_id, battle, title)
    charter = {
        "schema": "charter_v1", "campaign_id": cid,
        "report_title": title, "company": company,
        "family": _family(title, company), "input_level": "L2" if l2 else "L1",
        "restatement": f"复述: 这份报告回答「{core_q}」, 读者与体量见下;"
                       " 答非所问的章节整章砍 (F2 范围对齐).",
        "reader": cfg.get("reader") or DEFAULT_READER,
        "volume": {**DEFAULT_VOLUME, **{k: v for k, v in
                                        (cfg.get("volume") or {}).items()
                                        if isinstance(v, int)}},
        "core_question": core_q,
        "counter_questions": _counter_questions(company, topic),
        "tiers": {"T1": t1, "T2": t2, "T3": ["EPC总承包", "工程总承包"]},
        "tiers_source": tiers_src,
        "six_columns": {   # F2 六栏范围对齐卡 (关卡一)
            "research_object": cfg.get("research_target") or company,
            "report_type": "深度研究报告",
            "motivation": cfg.get("motivation")
            or "回答企业怎么干成 EPC 总承包, 可对标可行动",
            "focus_points": list(cfg.get("focus_points") or [])[:10],
            "genre": cfg.get("genre") or "深度报告",
            "byline": cfg.get("byline") or "总包之声出品",
        },
        "ammo_budget": {**C.gate_defaults(),
                        "note": "分层门 v3 主判 (T1≥300万 ∧ T1+T2≥3000万)"},
        "channel_plan": _channel_plan(pool_id),
        "approval": "pending", "round": 1,
        "battle_dir": str(battle_dir or ""), "pool": pool_id,
        "created": _ts(), "version": _sl.__version__,
    }
    gate = _read_json(out / "s0_gatekeeper.json")
    if gate:
        charter["gate_report"] = {
            "verdict": gate.get("verdict"), "path": str(out / "s0_gatekeeper.json"),
            "missing": gate.get("missing") or []}
    errs = C.validate_charter(charter)
    (out / DRAFT).write_text(json.dumps(charter, ensure_ascii=False, indent=1),
                             encoding="utf-8")
    _log(out, "built", round=1, errors=len(errs), campaign=charter["campaign_id"])
    return charter, out, errs


# ---------- ③ 呈批 ----------
def _brief_md(ch: dict) -> str:
    v, sc = ch["volume"], ch["six_columns"]
    lines = [
        f"# Charter 呈批件 (第 {ch['round']} 轮) — {ch['report_title']}", "",
        f"- 核心问题: **{ch['core_question']}**",
        f"- 读者: {ch['reader']} | 体量: {v['chapters']}章 × "
        f"{v['sections']}节 × {v['total_chars']:,}字",
        f"- 输入档: {ch['input_level']} | 词表: T1 {len(ch['tiers']['T1'])} 词"
        f" ({ch['tiers_source']})",
        f"- 弹药预算: T1≥{ch['ammo_budget']['t1_min_chars']:,} ∧ "
        f"T1+T2≥{ch['ammo_budget']['t12_min_chars']:,}",
        f"- 判级: {(ch.get('gate_report') or {}).get('verdict', '未跑')}",
        "", "## F2 六栏范围卡",
        f"- 调研对象: {sc['research_object']} | 类型: {sc['report_type']}",
        f"- 核心动机: {sc['motivation']} | 体裁: {sc['genre']} | "
        f"署名: {sc['byline']}",
        f"- 特别关注: {'; '.join(sc['focus_points']) or '无'}",
        "", "## 反例问题 (预埋 ACH 对立面)",
        *[f"- {q}" for q in ch["counter_questions"]],
        "", "## 渠道组合 (三类分标)",
        *[f"- {p['class']}: {p['note']}" for p in ch["channel_plan"]],
        "", "> 回复三态: 批 (ACCEPTED) / 改 (EDIT+意见) / 驳 (REJECT)",
    ]
    return "\n".join(lines) + "\n"


def submit(battle_dir: str) -> tuple[dict, Path, bool]:
    """草案呈批出门: 机器可读 JSON + 人读 MD + 企微推送 + ledger 留痕."""
    out = _out_dir(battle_dir)
    ch = _read_json(out / DRAFT)
    if not ch:
        raise FileNotFoundError(f"{out / DRAFT} 缺失, 先 --build")
    errs = C.validate_charter(ch)
    if errs:                       # 机检零错才许出门
        _log(out, "submit_blocked", errors=errs)
        raise ValueError(f"charter 校验 {len(errs)} 错, 禁呈批: {errs[:3]}")
    ch["approval"], ch["submitted"] = "pending", _ts()
    (out / SUBMITTED).write_text(
        json.dumps(ch, ensure_ascii=False, indent=1), encoding="utf-8")
    (out / BRIEF).write_text(_brief_md(ch), encoding="utf-8")
    text = (f"[呈批] 战役 {ch['campaign_id']} Charter 第{ch['round']}轮 "
            f"已呈批: {ch['core_question']} "
            f"({v_str(ch)}词表T1×{len(ch['tiers']['T1'])}) "
            f"回: 批/改/驳")
    ok = _push_wecom(text)
    _log(out, "submitted", round=ch["round"], push_ok=ok)
    return ch, out, ok


def v_str(ch: dict) -> str:
    v = ch.get("volume") or {}
    return f"{v.get('chapters')}章×{v.get('sections')}节, "


# ---------- ④ 三态回执 ----------
def _escalate(out: Path, ch: dict, feedback: str) -> dict:
    ch["approval"] = "edit"
    ch["escalated"] = True
    (out / DRAFT).write_text(json.dumps(ch, ensure_ascii=False, indent=1),
                             encoding="utf-8")
    detail = (f"[Charter escalated] {ch['campaign_id']} 改批往返已达 "
              f"{MAX_EDIT_ROUNDS} 轮未锁定: {feedback} — 详单回呈, 须用户裁决")
    ok = _push_wecom(detail)
    _log(out, "escalated", round=ch["round"], feedback=feedback[:200],
         push_ok=ok)
    return ch


def receipt(battle_dir: str, verdict: str, feedback: str = "") -> dict:
    """三态回执: ACCEPTED→批准进战役目录 / EDIT→改批 (≤2轮) / REJECT→驳回."""
    out = _out_dir(battle_dir)
    ch = _read_json(out / SUBMITTED) or _read_json(out / DRAFT)
    if not ch:
        raise FileNotFoundError("无呈批件在案 (先 --build + --submit)")
    if verdict not in RECEIPTS:
        raise ValueError(f"verdict 非法: {verdict!r} (值域 {RECEIPTS})")
    _log(out, "receipt", verdict=verdict, round=ch.get("round", 1),
         feedback=feedback[:200])
    if verdict == "ACCEPTED":
        ch["approval"], ch["accepted"] = "approved", _ts()
        ch["fingerprint"] = C.fingerprint(ch)
        (out / ACCEPTED_F).write_text(
            json.dumps(ch, ensure_ascii=False, indent=1), encoding="utf-8")
        _log(out, "accepted", round=ch["round"],
             fingerprint=ch["fingerprint"][:12])
        ok = _push_wecom(f"[批准] {ch['campaign_id']} Charter 已批准 "
                         f"(第{ch['round']}轮锁定), S1 可动工")
        _log(out, "push", ok=ok, kind="accepted")
    elif verdict == "REJECT":
        ch["approval"], ch["rejected"] = "edit", _ts()
        (out / REJECTED_F).write_text(
            json.dumps(ch, ensure_ascii=False, indent=1), encoding="utf-8")
        _log(out, "rejected", feedback=feedback[:200])
    else:                                   # EDIT
        ch["approval"] = "edit"
        ch["edit_feedback"] = feedback
        if ch.get("round", 1) >= MAX_EDIT_ROUNDS:
            return _escalate(out, ch, feedback)
        ch["round"] = ch.get("round", 1) + 1
        (out / DRAFT).write_text(
            json.dumps(ch, ensure_ascii=False, indent=1), encoding="utf-8")
        _log(out, "revise_to_draft", round=ch["round"])
    return ch


def s1_may_start(battle_dir: str) -> tuple[bool, str]:
    """批准前 S1 不动工 (判定源=contracts.charter_ready_for_s1 同源)."""
    out = _out_dir(battle_dir)
    ch = _read_json(out / ACCEPTED_F)
    if not ch:
        return False, "charter_accepted.json 缺失 — 未批准, S1 禁动工"
    if not C.charter_ready_for_s1(ch):
        return False, f"charter 未达 S1 准入: {C.validate_charter(ch)[:3]}"
    return True, f"approved@{ch.get('accepted')} round{ch.get('round')}"


def status(battle_dir: str) -> dict:
    out = _out_dir(battle_dir)
    led = _ledger(out)
    ok, why = s1_may_start(battle_dir)
    return {"dir": str(out), "ledger_n": len(led),
            "events": [e["event"] for e in led],
            "all_ts_iso": all(_TS_RE.match(e.get("ts", "")) for e in led),
            "s1": {"ok": ok, "why": why}}


# ---------- CLI ----------
def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="S0-3 Charter 呈批门")
    ap.add_argument("--build", action="store_true")
    ap.add_argument("--submit", action="store_true")
    ap.add_argument("--receipt", action="store_true")
    ap.add_argument("--status", action="store_true")
    ap.add_argument("--title", default="")
    ap.add_argument("--battle", default="")
    ap.add_argument("--battle-dir", default="")
    ap.add_argument("--pool", default="")
    ap.add_argument("--level", default="L1", choices=("L1", "L2"))
    ap.add_argument("--verdict", default="", choices=RECEIPTS)
    ap.add_argument("--feedback", default="")
    args = ap.parse_args(argv)
    print(f"[s0-3] superline {_sl.__version__} Charter 呈批门 "
          f"(批准前 S1 不动工)")
    if args.build:
        if not args.title:
            print("[s0-3] --build 须 --title", file=sys.stderr)
            return 2
        ch, out, errs = build(args.title, battle=args.battle,
                              battle_dir=args.battle_dir, pool_id=args.pool,
                              level=args.level)
        print(f"[s0-3] 草案落 {out / DRAFT} | 校验 "
              f"{'零错 ✓' if not errs else f'{len(errs)} 错 ✗'}"
              f" | T1 {len(ch['tiers']['T1'])} 词 | "
              f"core: {ch['core_question'][:40]}")
        return 0 if not errs else 1
    if args.submit:
        ch, out, ok = submit(args.battle_dir)
        print(f"[s0-3] 呈批件落 {out / SUBMITTED} (机器可读) + "
              f"{out / BRIEF} | 企微 {'✓' if ok else '推送失败(已留痕)'}")
        return 0
    if args.receipt:
        if not args.verdict:
            print("[s0-3] --receipt 须 --verdict", file=sys.stderr)
            return 2
        ch = receipt(args.battle_dir, args.verdict, args.feedback)
        print(f"[s0-3] 回执 {args.verdict} → approval={ch['approval']} "
              f"round={ch.get('round')}"
              + (" | ESCALATED 详单回呈" if ch.get("escalated") else ""))
        return 0
    st = status(args.battle_dir)
    print(f"[s0-3] {st['dir']} | ledger {st['ledger_n']} 事件 "
          f"(ts 全ISO: {st['all_ts_iso']}) | S1 准入: {st['s1']['ok']} "
          f"({st['s1']['why']})")
    print(f"[s0-3] 事件链: {' → '.join(st['events']) or '空'}")
    return 0


if __name__ == "__main__":
    # ast 零付费机检: 网络根模块禁入 (与 S0-1/S0-2 同锚)
    _mods = set()
    for _n in ast.walk(ast.parse(Path(__file__).read_text(encoding="utf-8"))):
        if isinstance(_n, ast.Import):
            _mods.update(a.name.split(".")[0] for a in _n.names)
        elif isinstance(_n, ast.ImportFrom) and _n.module:
            _mods.add(_n.module.split(".")[0])
    assert not (_mods & {"urllib", "requests", "httpx", "curl_cffi", "socket"}), \
        f"charter_gate 禁网络根模块: {_mods}"
    sys.exit(main())
