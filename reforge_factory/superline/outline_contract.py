# -*- coding: utf-8 -*-
"""outline_contract — S3-2 大纲锁定合同化 (outline-as-contract + 章级4态状态机).

大纲 (framework.json) 即合同: 一切变更必须过 apply_change (锁章拒改, 每次
变更 before/after 指纹+diff 落 outline_changes.jsonl — 变更零静默); 绕过
合同手改 framework.json → reconcile 指纹失配当场检出.

章级 4 态 (只进不退, 退=显式 unlock 留痕):
  gap_scan (缺口补扫) → collecting (贫血扩写) → locked (饱和锁定, 禁改
  章大纲) → writing (门全过交撰写: 弹药门 gate_ok ∧ 完备门 passed)

三方一致 (reconcile): 章态 ↔ 章节矩阵 (manifest valid×dedup 派生) ↔
战役门 (ammo tier_report × completeness_v2.json) — 任一漂移点名在案.

用法:
  python outline_contract.py --battle-dir D --cid C establish
  python outline_contract.py --battle-dir D --cid C refresh|reconcile
  python outline_contract.py --battle-dir D --cid C promote --chapter ch01
  python outline_contract.py --battle-dir D --cid C edit --op retitle \
      --chapter ch04 --value 新题 [--reason 依据]
  python outline_contract.py --battle-dir D --cid C unlock --chapter ch04 \
      --reason 证据面重薄
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

_SL = Path(__file__).resolve().parent.parent
if str(_SL) not in sys.path:
    sys.path.insert(0, str(_SL))
from superline import chapter_matrix as CX    # noqa: E402
from superline import contracts as C          # noqa: E402
from superline import framework_gen as FG     # noqa: E402
import ammo_pool as AP                        # noqa: E402

if sys.stdout:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATES = ("gap_scan", "collecting", "locked", "writing")
MATRIX_TO_STATE = {"缺口": "gap_scan", "贫血": "collecting", "饱和": "locked"}
CONTRACT_F = "outline_contract.json"
CHANGES_F = "outline_changes.jsonl"
# 完备门账本位 (EPC49/EPC50 真战役 _pipeline; 注入点=test/异战役)
COMPLETENESS_DIRS = {
    "EPC49-SEPDC": _SL.parent / "ResearchFactory-Eng" / "ResearchTopics"
    / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》/_pipeline",
    "EPC50-SNEI": _SL.parent / "ResearchFactory-Eng" / "ResearchTopics"
    / "《中石化南京工程有限公司怎么干EPC总承包？》/_pipeline",
}


# ---------------------------------------------------------------- 指纹锚
def fingerprint(fw: dict) -> str:
    """大纲指纹: 章序+题目+分层词表+分档 规范串 sha1 — 任何大纲变更必变."""
    canon = json.dumps(
        [[c.get("id"), c.get("title"), c.get("budget_band"),
          {t: sorted(w) for t, w in sorted(
              (c.get("tier_map") or {}).items())}]
         for c in fw.get("chapters", [])],
        ensure_ascii=False, sort_keys=True)
    return hashlib.sha1(canon.encode("utf-8")).hexdigest()[:16]


def _out(battle_dir: str) -> Path:
    return FG.CG._out_dir(battle_dir)


def _load_contract(battle_dir: str) -> dict | None:
    p = _out(battle_dir) / CONTRACT_F
    if not p.is_file():
        return None
    return json.loads(p.read_text(encoding="utf-8"))


def _log_change(battle_dir: str, rec: dict) -> None:
    with (_out(battle_dir) / CHANGES_F).open("a", encoding="utf-8") as f:
        f.write(json.dumps({**rec, "ts": time.strftime("%Y-%m-%dT%H:%M:%S")},
                           ensure_ascii=False) + "\n")


def _read_gates(cid: str) -> dict:
    """战役门快照: 弹药分层门 (tier_report) × 完备门 (completeness_v2)."""
    tr = AP.tier_report(cid)
    comp_p = COMPLETENESS_DIRS.get(cid, Path("")) / "completeness_v2.json"
    try:
        comp = json.loads(comp_p.read_text(encoding="utf-8"))
        comp_passed = bool(comp.get("passed"))
        comp_counts = comp.get("counts")
    except Exception:
        comp_passed, comp_counts = None, None            # 账本缺位≠门过
    return {"ammo_gate_ok": tr.get("gate_ok", False),
            "completeness_passed": comp_passed,
            "completeness_counts": comp_counts,
            "snapshot_at": time.strftime("%Y-%m-%dT%H:%M:%S")}


# ---------------------------------------------------------------- 建立/刷新
def establish(battle_dir: str, cid: str) -> dict:
    """建合同 (或已存在→走 refresh, 绝不静默重建)."""
    old = _load_contract(battle_dir)
    if old is not None:
        return refresh(battle_dir, cid)
    fw, meta = FG.load_framework(battle_dir)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席 — 先跑 S1-1")
    m = CX.build(fw, CX.load_rows(cid))
    chs = {c["id"]: {"state": MATRIX_TO_STATE[c["state"]],
                     "matrix_state": c["state"],
                     "action": c["action"],
                     "score": c["union"]["score"]["total"],
                     "items": c["union"]["items"],
                     "since": time.strftime("%Y-%m-%dT%H:%M:%S")}
           for c in m["chapters"]}
    con = {"schema": "outline_contract_v1", "campaign_id": cid,
           "fingerprint": fingerprint(fw), "framework_mode": meta["mode"],
           "chapters": chs, "gates": _read_gates(cid),
           "established_at": time.strftime("%Y-%m-%dT%H:%M:%S")}
    _write(battle_dir, con)
    _log_change(battle_dir, {"op": "establish", "actor": "outline_contract",
                             "fingerprint_before": None,
                             "fingerprint_after": con["fingerprint"],
                             "applied": True, "detail": {
                                 "states": {k: v["state"]
                                            for k, v in chs.items()}}})
    return con


def refresh(battle_dir: str, cid: str) -> dict:
    """矩阵重算 → 章态只进不退推进 (每次推进/拒退都留痕)."""
    con = _load_contract(battle_dir)
    if con is None:
        return establish(battle_dir, cid)
    fw, _ = FG.load_framework(battle_dir)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席")
    m = CX.build(fw, CX.load_rows(cid))
    fp = fingerprint(fw)
    moves, blocks = {}, {}
    fw_ids = set()
    for c in m["chapters"]:
        fw_ids.add(c["id"])
        want = MATRIX_TO_STATE[c["state"]]
        cur = con["chapters"].get(c["id"])
        if cur is None:                        # 新章 (add 正门后进场)
            con["chapters"][c["id"]] = {
                "state": want, "matrix_state": c["state"],
                "action": c["action"],
                "score": c["union"]["score"]["total"],
                "items": c["union"]["items"],
                "since": time.strftime("%Y-%m-%dT%H:%M:%S")}
            moves[c["id"]] = f"new:{want}"
            continue
        if cur.get("held_from"):
            # 操作员钉住章 (unlock 显式降态): refresh 不自动回升 —
            # unlock 若被下轮 refresh 秒回, 降态就是假的; 回升须显式 relock.
            blocks[c["id"]] = (f"{cur['state']} 钉住"
                               f"(held_from={cur['held_from']}) 不自动回升")
            cur.update(matrix_state=c["state"], action=c["action"],
                       score=c["union"]["score"]["total"],
                       items=c["union"]["items"])
            continue
        if STATES.index(want) > STATES.index(cur["state"]):
            moves[c["id"]] = f"{cur['state']}→{want}"
            cur.update(state=want, matrix_state=c["state"],
                       action=c["action"],
                       score=c["union"]["score"]["total"],
                       items=c["union"]["items"],
                       since=time.strftime("%Y-%m-%dT%H:%M:%S"))
            cur.pop("held_from", None)          # 升态销显式降态痕
        else:
            if want != cur["state"]:                   # 矩阵回退 (罕见)
                blocks[c["id"]] = f"{cur['state']}>{want} 保持(只进不退)"
            cur.update(matrix_state=c["state"], action=c["action"],
                       score=c["union"]["score"]["total"],
                       items=c["union"]["items"])
    for gone in [k for k in con["chapters"] if k not in fw_ids]:
        blocks[gone] = f"{con['chapters'][gone]['state']}>removed 退场"
        con["chapters"].pop(gone)
    con["fingerprint"] = fp
    con["gates"] = _read_gates(cid)
    _write(battle_dir, con)
    if moves or blocks:
        _log_change(battle_dir, {"op": "refresh", "actor": "outline_contract",
                                 "fingerprint_before": None,
                                 "fingerprint_after": fp, "applied": True,
                                 "detail": {"moves": moves,
                                            "held": blocks}})
    return con


# ---------------------------------------------------------------- 变更 (零静默)
def apply_edit(battle_dir: str, cid: str, op: str, chapter: str,
               value: str = "", reason: str = "",
               actor: str = "operator") -> dict:
    """大纲变更唯一正门: retitle/retier/remove/add/unlock/promote.

    锁章 (locked/writing) 拒结构性变更 (须先 unlock); 每次尝试 (含拒)
    全留痕 outline_changes.jsonl, 指纹 before/after 锚定."""
    con = _load_contract(battle_dir)
    if con is None:
        raise FileNotFoundError("先 establish")
    fw, _ = FG.load_framework(battle_dir)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席")
    fp_before = fingerprint(fw)

    def _rec(applied: bool, detail: dict, fp_after: str = "") -> dict:
        rec = {"op": op, "actor": actor, "chapter": chapter,
               "reason": reason, "applied": applied, "detail": detail,
               "fingerprint_before": fp_before,
               "fingerprint_after": fp_after or fp_before}
        _log_change(battle_dir, rec)
        return rec

    st = con["chapters"].get(chapter, {}).get("state", "")
    if op in ("retitle", "retier", "remove"):
        tgt = next((c for c in fw["chapters"] if c["id"] == chapter), None)
        if tgt is None:
            return _rec(False, {"error": f"章不存在: {chapter}"})
        if st in ("locked", "writing"):
            return _rec(False, {"error": f"{chapter} 已 {st}, 结构变更须先 "
                                         f"unlock (留痕)"})
        before = {k: tgt.get(k) for k in ("title", "tier_map")}
        if op == "retitle":
            tgt["title"] = value
        elif op == "retier":
            words = [w.strip() for w in value.split(",") if w.strip()]
            tgt["tier_map"] = {"T1": words}
        else:                                    # remove
            fw["chapters"] = [c for c in fw["chapters"] if c["id"] != chapter]
        errs = C.validate_framework(fw)
        if errs:
            return _rec(False, {"error": f"变更后契约不过: {errs[:2]}"})
        FG.render(fw, battle_dir)
        con = refresh(battle_dir, cid)
        return _rec(True, {"before": before, "after": value},
                    con["fingerprint"])
    if op == "add":
        nid = value or f"ch{len(fw['chapters']) + 1:02d}"
        title = reason or nid
        fw["chapters"].append({"id": nid, "title": title,
                               "description": title,
                               "tier_map": {"T1": [cid]},
                               "channels": ["current_increment"],
                               "budget_band": "gap",
                               "evidence_density": "low"})
        errs = C.validate_framework(fw)
        if errs:
            return _rec(False, {"error": f"变更后契约不过: {errs[:2]}"})
        FG.render(fw, battle_dir)
        con = refresh(battle_dir, cid)
        return _rec(True, {"added": nid}, con["fingerprint"])
    if op == "unlock":
        if st not in ("locked", "writing"):
            return _rec(False, {"error": f"{chapter} 态 {st}, 无需 unlock"})
        if not reason:
            return _rec(False, {"error": "unlock 必须给 reason (绝不静默降态)"})
        con["chapters"][chapter].update(state="collecting", held_from=st)
        _write(battle_dir, con)
        return _rec(True, {"state": f"{st}→collecting (held_from={st})"},
                    fp_before)
    if op == "relock":
        cur = con["chapters"].get(chapter)
        if not cur or not cur.get("held_from"):
            return _rec(False, {"error": f"{chapter} 无钉住痕, 无需 relock"})
        fw2, _ = FG.load_framework(battle_dir)
        m2 = CX.build(fw2, CX.load_rows(cid))
        mc = next((x for x in m2["chapters"] if x["id"] == chapter), None)
        if mc is None or mc["state"] != "饱和":
            return _rec(False, {"error": "矩阵未回饱和, relock 拒 (先补证据)"})
        held = cur.pop("held_from")
        cur["state"] = "locked"
        _write(battle_dir, con)
        return _rec(True, {"state": f"collecting→locked "
                                    f"(解钉 held_from={held})"}, fp_before)
    if op == "promote":
        return _promote(battle_dir, cid, chapter, con, fp_before,
                        reason, actor)
    return _rec(False, {"error": f"未知 op: {op}"})


def _promote(battle_dir: str, cid: str, chapter: str, con: dict,
             fp_before: str, reason: str, actor: str) -> dict:
    st = con["chapters"].get(chapter, {}).get("state", "")
    g = _read_gates(cid)
    if st != "locked":
        return _log_rec(battle_dir, "promote", chapter, actor, reason,
                        fp_before, {"error": f"态 {st}≠locked"})
    if not (g["ammo_gate_ok"] and g["completeness_passed"]):
        return _log_rec(battle_dir, "promote", chapter, actor, reason,
                        fp_before, {"error": "战役门未全过",
                                    "gates": {k: g[k] for k in (
                                        "ammo_gate_ok",
                                        "completeness_passed")}})
    con["chapters"][chapter].update(
        state="writing", since=time.strftime("%Y-%m-%dT%H:%M:%S"))
    con["chapters"][chapter].pop("held_from", None)
    con["gates"] = g
    _write(battle_dir, con)
    return _log_rec(battle_dir, "promote", chapter, actor, reason,
                    fp_before, {"state": "locked→writing"}, fp_before,
                    True)


def _log_rec(battle_dir: str, op: str, chapter: str, actor: str,
             reason: str, fp: str, detail: dict, fp_after: str = "",
             applied: bool = False) -> dict:
    rec = {"op": op, "actor": actor, "chapter": chapter, "reason": reason,
           "applied": applied, "detail": detail, "fingerprint_before": fp,
           "fingerprint_after": fp_after or fp}
    _log_change(battle_dir, rec)
    return rec


# ---------------------------------------------------------------- 三方对账
def reconcile(battle_dir: str, cid: str) -> dict:
    """章态 ↔ 章节矩阵 (manifest 派生) ↔ 战役门 三方一致性报告."""
    con = _load_contract(battle_dir)
    if con is None:
        return {"ok": False, "error": "合同缺席 — 先 establish"}
    fw, _ = FG.load_framework(battle_dir)
    m = CX.build(fw, CX.load_rows(cid)) if fw is not None else {"chapters": []}
    state_mm, missing = [], []
    for c in m["chapters"]:
        want = MATRIX_TO_STATE[c["state"]]
        cur = con["chapters"].get(c["id"])
        if cur is None:
            missing.append(c["id"])              # 大纲有章合同无=静默变更
        elif want != cur["state"]:
            sanctioned = (STATES.index(want) > STATES.index(cur["state"])
                          and cur.get("held_from"))   # 显式降态在案≠漂移
            if not sanctioned:
                state_mm.append({"chapter": c["id"], "contract": cur["state"],
                                 "matrix": want})
    orphan = [k for k in con["chapters"] if k not in
              {c["id"] for c in m["chapters"]}]
    fp_ok = fw is not None and fingerprint(fw) == con["fingerprint"]
    g = _read_gates(cid)
    gate_drift = []
    if con.get("gates", {}).get("ammo_gate_ok") != g["ammo_gate_ok"]:
        gate_drift.append("ammo_gate_ok")
    if con.get("gates", {}).get("completeness_passed") \
            != g["completeness_passed"]:
        gate_drift.append("completeness_passed")
    ok = (not state_mm and not missing and not orphan and fp_ok
          and not gate_drift)
    return {"ok": ok, "fingerprint_ok": fp_ok,
            "state_mismatches": state_mm, "missing_in_contract": missing,
            "orphan_in_contract": orphan, "gate_drift": gate_drift,
            "gates": g,
            "state_dist": {s: sum(1 for v in con["chapters"].values()
                                  if v["state"] == s) for s in STATES}}


def _write(battle_dir: str, con: dict) -> None:
    p = _out(battle_dir) / CONTRACT_F
    p.write_text(json.dumps(con, ensure_ascii=False, indent=1),
                 encoding="utf-8")


def main() -> int:
    ap = argparse.ArgumentParser(description="S3-2 大纲锁定合同化")
    ap.add_argument("--battle-dir", required=True)
    ap.add_argument("--cid", required=True)
    ap.add_argument("cmd", choices=["establish", "refresh", "reconcile",
                                    "promote", "unlock", "relock", "retitle",
                                    "retier", "remove", "add"])
    ap.add_argument("--chapter", default="")
    ap.add_argument("--value", default="")
    ap.add_argument("--reason", default="")
    args = ap.parse_args()
    bd, cid = args.battle_dir, args.cid
    if args.cmd == "establish":
        con = establish(bd, cid)
        dist = {s: sum(1 for v in con["chapters"].values()
                       if v["state"] == s) for s in STATES}
        print(f"[s3-2] 合同立 {cid}: {len(con['chapters'])} 章 "
              f"指纹 {con['fingerprint']} | 态分布 {dist}")
    elif args.cmd == "refresh":
        con = refresh(bd, cid)
        n_lock = sum(1 for v in con["chapters"].values()
                     if v["state"] == "locked")
        print(f"[s3-2] 刷新: 指纹 {con['fingerprint']} {n_lock} 锁")
    elif args.cmd == "reconcile":
        r = reconcile(bd, cid)
        print(f"[s3-2] 对账: {'三方一致 ✅' if r['ok'] else '漂移 ❌'} "
              f"指纹{'✓' if r.get('fingerprint_ok') else '✗'} "
              f"章态失配 {len(r['state_mismatches'])} 门漂移 "
              f"{r['gate_drift']} | {r.get('state_dist')}")
        if r["state_mismatches"]:
            print(json.dumps(r["state_mismatches"], ensure_ascii=False))
        return 0 if r["ok"] else 1
    else:
        rec = apply_edit(bd, cid, args.cmd, args.chapter, args.value,
                         args.reason)
        print(f"[s3-2] {args.cmd} {args.chapter}: "
              f"{'✅' if rec['applied'] else '❌'} {rec['detail']}")
        return 0 if rec["applied"] else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
