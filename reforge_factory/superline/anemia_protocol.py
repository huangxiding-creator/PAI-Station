# -*- coding: utf-8 -*-
"""anemia_protocol — P1-2 S3 贫血章处置协议 (补扫预算三态终止+结构转向梯子).

对账器 (S3-1) 处置建议上加两层闸, 防两种死法:
  死法一 临门一文不产 — 补扫预算无界: 85/15 分配 (基数=弹药门 t12 需求,
    15% 封顶给补扫, 与弹药门 v3 「转产/机动补弹」章法同构), 超帽即转
    pivot 绝不再扫;
  死法二 无限补扫 — 结构转向梯子: 同章零有效新增 ≥2 轮 → pivot
    (合并/降级/换维, 建议取自矩阵处置与章间 Jaccard), ≥4 轮 → 升用户
    裁决 (waivers 通道: 挂起+企微呈报, 绝不静默拖死).
三态终止 = CONTINUE / PIVOT / ESCALATE (章级补扫生命周期硬边界).
超期告警 = 贫血滞留 > OVERDUE_DAYS → overdue_warn 入账+呈报
  (「无战役因补扫拖死」的最后保险丝).

判定源: chapter_matrix (manifest valid×dedup 同语义) + rescan_ledger
(S3-1 补扫单) + 本件 anemia_ledger — 全盘上账本, 不信模型自评.

用法:
  python anemia_protocol.py --battle-dir D --cid C --observe
  python anemia_protocol.py --battle-dir D --cid C --budget
  python anemia_protocol.py --battle-dir D --cid C --gate --chapter ch04
  python anemia_protocol.py --battle-dir D --cid C --resolve \
      --chapter ch04 --decision exempt --note "用户裁决豁免演练"
"""
from __future__ import annotations

import ast
import json
import subprocess
import sys
import time
from pathlib import Path

import superline as _sl
from superline import chapter_matrix as MC
from superline import contracts as C
from superline import framework_gen as FG

# ---- 协议参数 (v1 校准 — 改动须留快照对照) ----
PIVOT_ROUNDS = 2          # 零有效新增 ≥2 轮 → 结构 pivot
ESCALATE_ROUNDS = 4       # ≥4 轮 → 升用户裁决 (waivers 通道)
RESCAN_SHARE = 0.15       # 补扫预算 85/15 的 15% 帽
OVERDUE_DAYS = 3          # 贫血滞留超期线 (天)
TRISTATE = ("CONTINUE", "PIVOT", "ESCALATE")
BANDS = ("outline_wide", "section_narrow", "gap")
DECISIONS = ("continue", "pivot", "lock", "exempt")

LEDGER = "anemia_ledger.jsonl"                 # 与 rescan_ledger 同居 _pipeline
_TS_FMT = "%Y-%m-%dT%H:%M:%S"


# ---------------------------------------------------------------- 落位
def _pipe(battle_dir: str) -> Path:
    p = Path(battle_dir) / "_pipeline"
    p.mkdir(parents=True, exist_ok=True)
    return p


def _ts() -> str:
    return time.strftime(_TS_FMT)


def _log(pipe: Path, event: str, **kw) -> None:
    with (pipe / LEDGER).open("a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": _ts(), "event": event, **kw},
                           ensure_ascii=False) + "\n")


def _ledger(pipe: Path) -> list[dict]:
    p = pipe / LEDGER
    if not p.is_file():
        return []
    try:
        return [json.loads(x) for x in
                p.read_text(encoding="utf-8").splitlines() if x.strip()]
    except Exception:
        return []


def _push_wecom(text: str) -> bool:
    """企微个人 OAuth 免费通道 (best-effort, injectable, 失败只留痕)."""
    try:
        r = subprocess.run(["wecom-cli", "message", "aibot", "send",
                            "--text", text], capture_output=True, text=True,
                           timeout=60, check=False,
                           creationflags=getattr(
                               subprocess, "CREATE_NO_WINDOW", 0))
        return r.returncode == 0
    except Exception:
        return False


# ---------------------------------------------------------------- 状态重放
def _states(led: list[dict]) -> dict[str, dict]:
    """重放 anemia_ledger → 每章梯子态 (轮连击/基线/首见/挂起/闭合)."""
    st: dict[str, dict] = {}
    for e in led:
        ch = e.get("chapter")
        if not ch:
            continue
        s = st.setdefault(ch, {"zero_streak": 0, "last_chars": None,
                               "first_seen": "", "pending_user": False,
                               "closed": False, "last_verdict": "CONTINUE"})
        ev = e.get("event")
        if ev == "round":
            s["zero_streak"] = e.get("zero_streak", 0)
            s["last_chars"] = e.get("chars")
            s["last_verdict"] = e.get("verdict", "CONTINUE")
            if not s["first_seen"]:
                s["first_seen"] = e.get("ts", "")
        elif ev == "escalate":
            s["pending_user"] = True
            s["last_verdict"] = "ESCALATE"
        elif ev == "resolve":
            d = e.get("decision")
            s["pending_user"] = False
            if d in ("pivot", "lock", "exempt"):
                s["closed"] = True          # 章级处置终局 (S3-2 正门接管)
            else:                            # continue → 新窗口
                s["zero_streak"] = 0
                s["last_verdict"] = "CONTINUE"
        elif ev == "resolved":               # 回饱和自然终局
            s["closed"] = True
            s["pending_user"] = False
    return st


# ---------------------------------------------------------------- 梯子 (纯函数)
def ladder(zero_streak: int, budget_exhausted: bool = False) -> str:
    """三态终止: 预算耗尽即转 pivot (死法一); 连击 2→pivot, 4→escalate
    (死法二). 章级补扫生命周期硬边界."""
    if zero_streak >= ESCALATE_ROUNDS:
        return "ESCALATE"
    if zero_streak >= PIVOT_ROUNDS or budget_exhausted:
        return "PIVOT"
    return "CONTINUE"


def _partner(matrix: dict, chapter_id: str) -> tuple[str, float]:
    """章间 Jaccard 最大搭子 (合并建议的落点; keys 从矩阵格重建)."""
    sets = {}
    for c in matrix.get("chapters", []):
        ks = set()
        for cell in (c.get("cells") or {}).values():
            ks.update(k for k in cell.get("keys", []) if k)
        sets[c["id"]] = ks
    mine = sets.get(chapter_id, set())
    best, best_j = "", 0.0
    for cid_, ks in sets.items():
        if cid_ == chapter_id or not ks or not mine:
            continue
        j = len(mine & ks) / max(1, len(mine | ks))
        if j > best_j:
            best, best_j = cid_, j
    return best, round(best_j, 3)


def _pivot_suggestion(matrix: dict, chapter: dict) -> str:
    """结构 pivot 建议: 合并(有搭子) / 降级(仅T3) / 换维(切换补扫层)."""
    if chapter.get("action") == "合并" or \
            (chapter.get("max_overlap") or 0) > MC.MERGE_OVERLAP:
        p, j = _partner(matrix, chapter["id"])
        if p:
            return f"合并→{p} (Jaccard {j})"
    if chapter.get("action") == "降级":
        return "降级 (仅 T3 面, 收窄口径)"
    return "换维 (切换补扫层/词表, 当前层已榨干)"


# ---------------------------------------------------------------- 85/15 分桶账
def budget(battle_dir: str, cid: str) -> dict:
    """补扫预算 85/15 分桶账 (执行率可查).

    基数 = 弹药门 t12 需求 (contracts.gate_defaults 动态同源);
    补扫帽 = 15%; 花销两腿 = rescan_ledger 已出队 planned + 池内
    budget_band=gap 行真实到账 chars (判定源=盘上账本)."""
    gd = C.gate_defaults()
    base = int(gd.get("t12_min_chars", 0))
    rescan_cap = int(base * RESCAN_SHARE)
    planned = plan_only = 0
    rl = Path(battle_dir) / "_pipeline" / "rescan_ledger.jsonl"
    if rl.is_file():
        for x in rl.read_text(encoding="utf-8").splitlines():
            if not x.strip():
                continue
            try:
                r = json.loads(x)
            except json.JSONDecodeError:
                continue
            if r.get("queued"):
                planned += r.get("planned_chars") or 0
            else:
                plan_only += r.get("planned_chars") or 0
    ing = {"gap": 0, "outline_wide": 0, "section_narrow": 0, "存量": 0}
    for r in MC.load_rows(cid):
        b = r.get("budget_band") or ""
        ing[b if b in BANDS else "存量"] += r.get("chars") or 0
    rescan_ing = ing["gap"]
    prod_ing = ing["outline_wide"] + ing["section_narrow"]
    return {"schema": "anemia_budget_v1", "base_chars": base,
            "rescan_cap": rescan_cap, "rescan_planned": planned,
            "rescan_plan_only": plan_only, "rescan_ingested": rescan_ing,
            "rescan_execution_rate": round(planned / rescan_cap, 4)
            if rescan_cap else None,
            "production_share_cap": int(base * (1 - RESCAN_SHARE)),
            "production_ingested": prod_ing, "legacy_ingested": ing["存量"],
            "rescan_remaining": max(0, rescan_cap - planned),
            "budget_exhausted": planned >= rescan_cap if rescan_cap else True}


# ---------------------------------------------------------------- 观察轮
def observe(battle_dir: str, cid: str, now: float | None = None) -> dict:
    """每补扫周期一次: 记轮+梯子迁移+超期检查+回饱和归档."""
    pipe = _pipe(battle_dir)
    fw, _meta = FG.load_framework(battle_dir)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席 — 先跑 S1-1")
    matrix = MC.build(fw, MC.load_rows(cid))
    bud = budget(battle_dir, cid)
    st = _states(_ledger(pipe))
    seen_now: set[str] = set()
    transitions: list[dict] = []
    for c in matrix["chapters"]:
        if c["state"] != "贫血":
            continue
        cid_, ch = c["id"], c
        seen_now.add(cid_)
        s = st.get(cid_)
        if s and s["closed"]:
            continue                          # 已终局处置 (S3-2 正门接管)
        chars = c["union"]["chars"]
        prev = s["zero_streak"] if s else 0
        last_chars = s["last_chars"] if s else None
        delta = None if last_chars is None else chars - last_chars
        streak = 0 if (delta is None or delta > 0) else prev + 1
        verdict = ladder(streak, bud["budget_exhausted"])
        rec = {"chapter": cid_, "title": ch.get("title"),
               "chars": chars, "delta_valid": delta,
               "zero_streak": streak, "verdict": verdict}
        _log(pipe, "round", **rec)
        last_v = s["last_verdict"] if s else "CONTINUE"
        if verdict != last_v:
            if verdict == "ESCALATE":
                ok = _push_wecom(
                    f"[升裁决] {cid} 贫血章 {cid_} 零有效新增已达 "
                    f"{streak} 轮 — 补扫梯子到顶, 待用户裁决 "
                    f"(continue/pivot/lock/exempt)")
                _log(pipe, "escalate", chapter=cid_, rounds=streak,
                     suggestion=_pivot_suggestion(matrix, ch), push_ok=ok)
                transitions.append({"chapter": cid_, "to": "ESCALATE"})
            elif verdict == "PIVOT":
                _log(pipe, "pivot", chapter=cid_, rounds=streak,
                     suggestion=_pivot_suggestion(matrix, ch))
                transitions.append({"chapter": cid_, "to": "PIVOT"})
            else:
                _log(pipe, "recovered", chapter=cid_, streak=streak)
                transitions.append({"chapter": cid_, "to": "CONTINUE"})
    # 回饱和/缺口 归档 (在册但已非贫血)
    for cid_, s in st.items():
        if cid_ in seen_now or s["closed"]:
            continue
        cur = next((c for c in matrix["chapters"] if c["id"] == cid_), None)
        to = cur["state"] if cur else "离场"
        if to == "饱和":
            _log(pipe, "resolved", chapter=cid_, to_state="饱和")
            transitions.append({"chapter": cid_, "to": "饱和"})
        elif to == "缺口":
            _log(pipe, "state_change", chapter=cid_, to_state="缺口")
    # 超期告警 (首见起算, 每周期至多一条)
    now = time.time() if now is None else now
    st2 = _states(_ledger(pipe))
    for cid_, s in st2.items():
        if not s["first_seen"] or s["closed"] or cid_ not in seen_now:
            continue
        led = _ledger(pipe)
        if any(e.get("event") == "overdue_warn" and e.get("chapter") == cid_
               for e in led):
            continue
        age = (now - time.mktime(time.strptime(s["first_seen"], _TS_FMT))) \
            / 86400
        if age > OVERDUE_DAYS:
            ok = _push_wecom(f"[超期] {cid} 贫血章 {cid_} 滞留 "
                             f"{age:.1f} 天 (> {OVERDUE_DAYS}) — "
                             f"补扫拖死风险, 请裁决")
            _log(pipe, "overdue_warn", chapter=cid_, days=round(age, 1),
                 first_seen=s["first_seen"], push_ok=ok)
            transitions.append({"chapter": cid_, "to": "OVERDUE_WARN"})
    return {"schema": "anemia_observe_v1", "campaign_id": cid,
            "anemic_now": sorted(seen_now), "transitions": transitions,
            "budget": {k: bud[k] for k in ("rescan_cap", "rescan_planned",
                                           "budget_exhausted")}}


# ---------------------------------------------------------------- 补扫前置闸
def may_rescan(battle_dir: str, cid: str, chapter_id: str) -> dict:
    """dispatch_rescan 前置闸: ESCALATE/PIVOT/预算耗尽全拦 (拦截入账)."""
    pipe = _pipe(battle_dir)
    fw, _ = FG.load_framework(battle_dir)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席 — 先跑 S1-1")
    if not any(c["id"] == chapter_id for c in fw["chapters"]):
        raise KeyError(f"章不存在: {chapter_id}")
    matrix = MC.build(fw, MC.load_rows(cid))
    mc = next(c for c in matrix["chapters"] if c["id"] == chapter_id)
    if mc["state"] == "饱和":
        return {"ok": False, "verdict": "CONTINUE", "why": "饱和章无需补扫"}
    s = _states(_ledger(pipe)).get(chapter_id, {})
    streak = s.get("zero_streak", 0)
    bud = budget(battle_dir, cid)
    v = ladder(streak, bud["budget_exhausted"])
    if s.get("pending_user"):
        why = "已升用户裁决 (escalate 在案) — resolve 前禁补扫"
    elif v == "ESCALATE":
        why = f"零有效新增 {streak} 轮 ≥ {ESCALATE_ROUNDS} — 升裁决"
    elif v == "PIVOT":
        why = (f"补扫预算耗尽 ({bud['rescan_planned']:,}/"
               f"{bud['rescan_cap']:,}) — 转 pivot" if bud[
                   "budget_exhausted"]
               else f"零有效新增 {streak} 轮 ≥ {PIVOT_ROUNDS} — 先 pivot")
    else:
        return {"ok": True, "verdict": "CONTINUE",
                "why": f"streak {streak} < {PIVOT_ROUNDS} 且预算余 "
                       f"{bud['rescan_remaining']:,}"}
    _log(pipe, "rescan_blocked", chapter=chapter_id, verdict=v, why=why)
    return {"ok": False, "verdict": v, "why": why}


# ---------------------------------------------------------------- 用户裁决
def resolve(battle_dir: str, cid: str, chapter_id: str, decision: str,
            note: str = "") -> dict:
    """裁决回执: continue(再给窗口)/pivot/lock/exempt(waivers 同构须 note)."""
    pipe = _pipe(battle_dir)
    if decision not in DECISIONS:
        raise ValueError(f"decision 非法: {decision!r} (值域 {DECISIONS})")
    if decision == "exempt" and not note:
        _log(pipe, "resolve_blocked", chapter=chapter_id,
             why="豁免必须给 note")
        raise ValueError("exempt 必须给 note (waivers 同构: 豁免留痕绝不静默)")
    _log(pipe, "resolve", chapter=chapter_id, decision=decision, note=note)
    if decision == "exempt":
        _log(pipe, "push", ok=_push_wecom(
            f"[豁免留痕] {cid} 贫血章 {chapter_id} 用户裁决豁免: "
            f"{note[:120]} (WARN 态, 补扫梯子终局)"))
    return {"chapter": chapter_id, "decision": decision,
            "note": note, "ts": _ts()}


def status(battle_dir: str, cid: str) -> dict:
    pipe = _pipe(battle_dir)
    led = _ledger(pipe)
    return {"schema": "anemia_status_v1", "campaign_id": cid,
            "ledger_n": len(led),
            "events": [e["event"] for e in led],
            "chapters": _states(led), "budget": budget(battle_dir, cid)}


# ---------------------------------------------------------------- CLI
def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="P1-2 贫血章处置协议")
    ap.add_argument("--battle-dir", required=True)
    ap.add_argument("--cid", required=True)
    ap.add_argument("--observe", action="store_true")
    ap.add_argument("--budget", action="store_true")
    ap.add_argument("--gate", action="store_true")
    ap.add_argument("--resolve", action="store_true")
    ap.add_argument("--status", action="store_true")
    ap.add_argument("--chapter", default="")
    ap.add_argument("--decision", default="", choices=DECISIONS)
    ap.add_argument("--note", default="")
    args = ap.parse_args(argv)
    print(f"[p1-2] superline {_sl.__version__} 贫血章处置协议 "
          f"(85/15 补扫帽 + {PIVOT_ROUNDS}/{ESCALATE_ROUNDS} 轮梯子)")
    if args.observe:
        r = observe(args.battle_dir, args.cid)
        print(f"[p1-2] 贫血章 {len(r['anemic_now'])}: "
              f"{', '.join(r['anemic_now']) or '无'} | 迁移 "
              f"{r['transitions'] or '无'} | 补扫帽 "
              f"{r['budget']['rescan_planned']:,}/"
              f"{r['budget']['rescan_cap']:,}"
              f"{' (耗尽)' if r['budget']['budget_exhausted'] else ''}")
        return 0
    if args.budget:
        b = budget(args.battle_dir, args.cid)
        print(f"[p1-2] 85/15 分桶账: 基数 {b['base_chars']:,} | 补扫帽 "
              f"{b['rescan_cap']:,} (已出队 {b['rescan_planned']:,} / "
              f"plan-only {b['rescan_plan_only']:,} / 到账 "
              f"{b['rescan_ingested']:,} / 执行率 "
              f"{b['rescan_execution_rate']}) | 生产帽 "
              f"{b['production_share_cap']:,} (到账 "
              f"{b['production_ingested']:,}) | 存量 {b['legacy_ingested']:,}")
        return 0
    if args.gate:
        if not args.chapter:
            print("[p1-2] --gate 须 --chapter", file=sys.stderr)
            return 2
        g = may_rescan(args.battle_dir, args.cid, args.chapter)
        print(f"[p1-2] 补扫闸 {args.chapter}: "
              f"{'放行 ✅' if g['ok'] else '拦截 ❌'} ({g['verdict']}) "
              f"{g['why']}")
        return 0 if g["ok"] else 1
    if args.resolve:
        if not (args.chapter and args.decision):
            print("[p1-2] --resolve 须 --chapter+--decision", file=sys.stderr)
            return 2
        r = resolve(args.battle_dir, args.cid, args.chapter,
                    args.decision, args.note)
        print(f"[p1-2] 裁决 {r['chapter']} → {r['decision']} "
              f"{('(note: ' + r['note'][:60] + ')') if r['note'] else ''}")
        return 0
    st = status(args.battle_dir, args.cid)
    print(f"[p1-2] ledger {st['ledger_n']} 事件: "
          f"{', '.join(st['events'][:12]) or '空'}…")
    for cid_, s in st["chapters"].items():
        print(f"  {cid_}: streak {s['zero_streak']} / {s['last_verdict']}"
              f"{' [挂起用户]' if s['pending_user'] else ''}"
              f"{' [已终局]' if s['closed'] else ''}")
    return 0


if __name__ == "__main__":
    # ast 零付费机检: 网络根模块禁入 (企微腿走 CLI 免费面)
    _mods = set()
    for _n in ast.walk(ast.parse(Path(__file__).read_text(encoding="utf-8"))):
        if isinstance(_n, ast.Import):
            _mods.update(a.name.split(".")[0] for a in _n.names)
        elif isinstance(_n, ast.ImportFrom) and _n.module:
            _mods.add(_n.module.split(".")[0])
    assert not (_mods & {"urllib", "requests", "httpx", "curl_cffi",
                         "socket"}), f"anemia_protocol 禁网络根模块: {_mods}"
    sys.exit(main())
