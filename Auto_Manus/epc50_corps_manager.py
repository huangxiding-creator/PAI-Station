# -*- coding: utf-8 -*-
"""EPC50 Manus 军团管理器 — 用户 0927 令「必须把 Manus 军团专业地管起来」.

军团主链 (epc50_corps.py 派发 / epc50_collector.py 回收) 只管干活不管账.
本管理器补管理层, 三个子命令:

  reconcile    四账勾稽: corps_log(下发) ↔ harvest_sessions(原始金矿)
               ↔ 35_Manus军团(蒸馏成果) ↔ TREE/TREE2(任务树状态)
               → data/corps_dashboard.json + 大白话简报 (单一真相源)
  reset-gaps   真缺口 T 的 TREE2 子问题 status 重置 pending (军团饥饿
               优先队列自动补发; 写前自动备份 tree2.bak_<ts>.json)
  check        守卫腿活性 + 账号积分水位 + 断点账健康

纪律: 只读军团主链文件不动其逻辑; reset 只改 status 字段 (原子写);
账号操作(登录/派发)全部交还主链, 管理器零浏览器零登录.
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data"
BATTLE = Path(r"E:/AI-Station/ResearchFactory-Eng/ResearchTopics"
              r"/《中石化南京工程有限公司怎么干EPC总承包？》")
PIPELINE = BATTLE / "_pipeline"
DISTILL = BATTLE / "02 初次网络调研" / "35_Manus军团"

CORPS_LOG = DATA / "epc50_corps_log.jsonl"
HARVEST = ROOT / "harvest_sessions" / "epc50"
TREE = PIPELINE / "epc50_topic_tree.json"
TREE2 = PIPELINE / "epc50_topic_tree_v2.json"
SAT = PIPELINE / "epc50_saturation.json"
DASH = DATA / "corps_dashboard.json"


def _j(p: Path, default=None):
    if not p.exists():
        return default
    return json.loads(p.read_text(encoding="utf-8"))


def _harvested_sids() -> set:
    sids = set()
    if not HARVEST.exists():
        return sids
    for acc in HARVEST.iterdir():
        if not acc.is_dir():
            continue
        for f in acc.glob("*.v2.json"):
            sids.add(f.stem)
        for f in acc.glob("*.files.json"):
            sids.add(f.name.replace(".files.json", ""))
    return sids


def _distilled_by_t() -> dict:
    """35 目录蒸馏成果: T → [文件名] (军团成果的单一引用面)."""
    out: dict[str, list] = {}
    if not DISTILL.exists():
        return out
    import re
    for f in DISTILL.iterdir():
        m = re.match(r"(T\d+)", f.name)
        if m:
            out.setdefault(m.group(1), []).append(f.name)
    return out


def reconcile() -> int:
    log_lines = [json.loads(l) for l in CORPS_LOG.read_text(
        encoding="utf-8").splitlines() if l.strip()] if CORPS_LOG.exists() else []
    by_sid = {l["sid"]: l for l in log_lines}
    harv = _harvested_sids()
    dist = _distilled_by_t()

    tree = _j(TREE, {"topics": []})
    t_ids = [t["id"] for t in tree.get("topics", [])]

    # 三层状态: 每个T → dispatched(下发sid数) / harvested(回收sid数) / distilled(成果文件数)
    # 归属判据: Q 级行 q=TxxxQyy 才是问题真归属 (topic 字段=派发任务位,
    # 轮转派发时恒指 T001 等, 记它头上会造成假缺口); q=None(T级种子行)才用 topic
    per_t: dict[str, dict] = {}
    import re as _re
    for sid, l in by_sid.items():
        q = l.get("q") or ""
        m = _re.match(r"^(T\d{3})Q\d+", q)
        t = m.group(1) if m else (l.get("topic") or "?")
        d = per_t.setdefault(t, {"disp": 0, "harv": 0, "dist": 0})
        d["disp"] += 1
        if sid in harv:
            d["harv"] += 1
    for t, files in dist.items():
        per_t.setdefault(t, {"disp": 0, "harv": 0, "dist": 0})["dist"] = len(files)

    gap_t = sorted(t for t, d in per_t.items()
                   if d["harv"] == 0 and d["dist"] == 0 and t in t_ids)
    never_t = sorted(t for t in t_ids
                     if t not in per_t and t not in dist)
    covered_t = sorted(t for t in t_ids if t in dist)

    dash = {
        "ts": datetime.now().isoformat(timespec="seconds"),
        "dispatch_total": len(log_lines),
        "dispatch_unique_sids": len(by_sid),
        "harvest_sids": len(harv),
        "accounts_harvested": sum(1 for a in HARVEST.iterdir() if a.is_dir())
        if HARVEST.exists() else 0,
        "distilled_files": sum(len(v) for v in dist.values()),
        "tree_tasks": len(t_ids),
        "covered_t": covered_t,
        "gap_t": gap_t,          # 下发未收且无成果
        "never_dispatched_t": never_t,  # 从未下发的T (含 seeds 轮覆盖判定)
        "per_t": per_t,
    }
    DASH.write_text(json.dumps(dash, ensure_ascii=False, indent=1),
                    encoding="utf-8")
    print(f"[reconcile] 勾稽完成 → {DASH.name}")
    print(f"  任务树 {len(t_ids)} T | 有成果 {len(covered_t)} | "
          f"真缺口 {len(gap_t)}: {' '.join(gap_t) or '无'}")
    print(f"  从未下发: {' '.join(never_t) or '无'}")
    print(f"  下发 {dash['dispatch_total']} 条/唯一sid {dash['dispatch_unique_sids']}"
          f" | 金矿 {dash['accounts_harvested']} 账号 {dash['harvest_sids']} sid"
          f" | 蒸馏 {dash['distilled_files']} 文件")
    # 退出码: 有真缺口 → 1 (供调度方感知)
    return 1 if gap_t else 0


def reset_gaps() -> int:
    """缺口 T 对应的 TREE2 子问题重置 pending → 军团饥饿队列自动补发."""
    dash = _j(DASH)
    if not dash or not dash.get("gap_t"):
        print("[reset-gaps] 无真缺口 (先跑 reconcile)")
        return 0
    gaps = set(dash["gap_t"])
    tree2 = _j(TREE2)
    if not tree2:
        print("[reset-gaps] TREE2 缺失")
        return 2
    # 问级对象在 topics[].questions[]: {id:"T001Q01", status, sid, ...}
    questions = [q for tp in tree2.get("topics", [])
                 for q in (tp.get("questions") or [])]
    out04 = BATTLE / "04 网络调研搜集的资料" / "35_Manus军团"
    bak = TREE2.with_name(
        f"epc50_topic_tree_v2.bak_{datetime.now():%Y%m%d_%H%M%S}.json")
    bak.write_text(json.dumps(tree2, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    reset_n = 0
    skipped = 0
    for q in questions:
        qid = str(q.get("id", ""))
        if qid[:4] in gaps and q.get("status") in (
                "dispatched", "collected", "failed"):
            # 成果已在 04 战场落地 → 不重置 (省积分)
            if out04.exists() and any(out04.glob(f"{qid}__*")):
                skipped += 1
                continue
            q["status"] = "pending"
            q.pop("sid", None)
            reset_n += 1
    TREE2.write_text(json.dumps(tree2, ensure_ascii=False, indent=1),
                     encoding="utf-8")
    print(f"[reset-gaps] 重置 {reset_n} 问 → pending "
          f"(跳过已落战场 {skipped}; 备份 {bak.name})")
    print("[reset-gaps] 军团下轮自动优先补发 (饥饿优先队列)")
    return 0


def boost() -> int:
    """缺口 T 的 pending 问注入饱和饥饿清单 → 军团 fill 优先补发.

    _next_question 遍历 TREE2 时 hungry 集命中即返回 (epc50_corps.py:187),
    故注入后下轮 fill 优先吃缺口问. 注: 饱和引擎重跑会按 zero/single
    判据重建 hungry, 注入条目会被冲掉 (届时缺口应已补齐, 可接受).
    """
    dash = _j(DASH)
    if not dash or not dash.get("gap_t"):
        print("[boost] 无真缺口 (先跑 reconcile)")
        return 0
    gaps = set(dash["gap_t"])
    tree2 = _j(TREE2) or {"topics": []}
    sat = _j(SAT) or {"hungry": []}
    hungry = sat.setdefault("hungry", [])
    have = {h.get("id") for h in hungry}
    added = 0
    for tp in tree2.get("topics", []):
        if tp.get("id") not in gaps:
            continue
        for q in (tp.get("questions") or []):
            if q.get("status") == "pending" and q.get("id") not in have:
                hungry.append({"id": q["id"], "dim": tp.get("dimension", ""),
                               "text": q.get("text", ""),
                               "status": "gap_topup"})
                added += 1
    if added:
        notes = sat.get("notes")
        note = (f"{datetime.now():%m-%d %H:%M} corps_manager 注入 "
                f"{added} 缺口问({' '.join(sorted(gaps))})")
        if isinstance(notes, list):
            notes.append(note)
        else:
            sat["notes"] = [note]
        SAT.write_text(json.dumps(sat, ensure_ascii=False, indent=1),
                       encoding="utf-8")
    print(f"[boost] 注入 {added} 问 → 饥饿清单 (现共 {len(hungry)})")
    print("[boost] 军团 fill 下轮优先补发 5 家缺口")
    return 0


def check() -> int:
    """守卫腿活性 + 积分水位 + 断点账健康."""
    print("[check] === 军团体检 ===")
    # 1) 腿活性 (CIM 并发失明 → tasklist 判据)
    out = subprocess.run(["tasklist", "/FO", "CSV"],
                         capture_output=True, text=True).stdout.lower()
    legs = {
        "corps(派发)": "epc50_corps.py" in out,
        "yield_guard(衔接)": "epc50_yield_guard.py" in out,
        "collector(回收)": "epc50_collector.py" in out,
    }
    for k, v in legs.items():
        print(f"  腿 {k}: {'✓ 在跑' if v else '✗ 停'}")
    # 2) 积分水位
    low = _j(DATA / "epc50_credits_low.json", {})
    day = low.get("day")
    stale = day != datetime.now().strftime("%Y-%m-%d")
    n_low = len(low.get("low", {})) if isinstance(low.get("low"), dict) else len(
        low.get("low", []))
    print(f"  积分低位账: {n_low} 账号 (day={day}"
          f"{' 过期' if stale else ''})")
    # 3) 断点账
    mani = _j(DATA / "epc50_collect_manifest.json", {})
    print(f"  回收断点账: {len(mani)} sid")
    # 4) 最近下发/回收时间
    if CORPS_LOG.exists():
        lines = CORPS_LOG.read_text(encoding="utf-8").splitlines()
        if lines:
            last = json.loads(lines[-1])
            print(f"  最近下发: {last.get('ts')} {last.get('q') or last.get('topic')}")
    hw = DATA / "harvest_watch.log"
    if hw.exists():
        ts = hw.stat().st_mtime
        age_h = (time.time() - ts) / 3600
        print(f"  收割心跳: {age_h:.1f}h 前"
              f"{' ⚠ 停摆' if age_h > 26 else ''}")
    return 0


def main() -> int:
    cmd = sys.argv[1] if len(sys.argv) > 1 else "reconcile"
    return {"reconcile": reconcile, "reset-gaps": reset_gaps,
            "boost": boost, "check": check}.get(cmd, reconcile)()


if __name__ == "__main__":
    sys.exit(main())
