# -*- coding: utf-8 -*-
"""G4 ACH 对抗场 — 竞争性假设分析 (Heuer/CIA) 的工程化 v0.

原理: 对每个关键判断列 N 个竞争假设, 用证据矩阵做**排除**而非确认 —
得分最低者先排除. 每条证据按 (立场 stance, 信源等级 grade, 独立源数)
计入假设账. 专杀 LLM 调研两大病: 确认偏误 + 幻觉.

判断链 (三铁律): 本地启发式 v0 (免费); Jev 接线后 Noul/Choice/Score
三原语逐位替换 (矛盾判定/假设路由/兼容性评分) — fail-soft.

用法:
  python ach_arena.py <cid>            # 矩阵+排除排序+结论 (v0 只打印)
  python ach_arena.py <cid> --detail   # 逐证据明细
  python ach_arena.py --campaign <cid> --persistent [--out a.jsonl]
                                      # v1 持久化排除链 (REQ-021, 只增不改 v0)

v1 持久化 (REQ-021 / 百倍V4 V-002):
  run_persistent() 读 question_tree*.json 假设列表 (hypotheses 字段,
  缺则 HYPOTHESIS_SEEDS 三假设兜底) → 对每个假设用挂树反证行
  (judge==valid 且 tree_node 非空 且 stance 含 against/contradict) 做
  排除打分 (复用 v0 的 GRADE_W 权重 + (host, tree_node) 去重) →
  排除链逐行追加落盘 ammo_pool/<cid>/ach_exclusions.jsonl:
    {hypothesis, hypothesis_text, verdict(excluded/supported/inconclusive),
     rival_excluded(bool), evidence_ids, exclusion_reason, score,
     campaign, ts}
  rival_excluded=true 的行 = 该假设被显式排除且有证据绑定 (evidence_ids
  为 manifest 行 dedup_key 列表) — depth_ladder L6 (REQ-020) 的判据源.
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
GRADE_W = {"A": 1.0, "B": 0.7, "C": 0.4}   # Cochrane 分级权重

# ---------- v1 持久化常量 (REQ-021, 只增) ----------
#: 假设兜底种子 (v0 硬编码三假设: 扩张/恶化/分化 — stance_to_compat 同源)
HYPOTHESIS_SEEDS: list[dict] = [
    {"id": "H1", "text": "总量呈扩张态势: 需求与订单增长是主基调"},
    {"id": "H2", "text": "总量已恶化见顶: 增速下滑/在手订单萎缩是主基调"},
    {"id": "H3", "text": "结构分化: 细分领域冷热不均, 总量判断失真"},
]
#: 树文件优先序 (与 depth_ladder 同口径: v2 优先 v1 兜底)
TREE_NAMES = ("question_tree_v2.json", "question_tree.json")
#: 排除线: 排除分 ≤ -0.5 → verdict=excluded (A 级 against 一条即 -1.0)
EXCLUDE_SCORE_MIN = -0.5
#: 支持线: 排除分 ≥ +0.5 → verdict=supported
SUPPORT_SCORE_MIN = 0.5


def load(cid: str) -> tuple[dict, list[dict]]:
    d = POOL_ROOT / cid
    tree = json.loads((d / "question_tree.json").read_text(encoding="utf-8"))
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    return tree, [r for r in rows if r.get("judge") == "valid"]


def stance_to_compat(stance: str) -> dict[str, float]:
    """证据立场 → 对各假设的兼容分 (v0 映射: H1 扩张 / H2 恶化 / H3 分化).
    树超过 3 假设时按序号轮转 (军团参谋升级树后由 Jev Choice 位接管)."""
    if stance == "support":
        return {"H1": 1.0, "H2": -1.0, "H3": 0.3}
    if stance == "against":
        return {"H1": -1.0, "H2": 1.0, "H3": 0.3}
    return {"H1": -0.5, "H2": -0.5, "H3": -0.5}   # contradict=数据矛盾


def run(cid: str, detail: bool) -> int:
    tree, valid = load(cid)
    hyps = {h["id"]: {"text": h["text"], "score": 0.0, "hurt": [],
                      "help": []} for h in tree["hypotheses"]}
    conflicts: list[dict] = []
    # 独立源去重: 同 host 同 EEI 只计一次 (防单站刷量)
    seen: set[tuple] = set()
    for r in valid:
        if not r.get("tree_node"):
            continue
        host = (urlsplit(r.get("url_norm", "")).netloc
                or Path(r["source_path"]).stem)
        kk = (host, r["tree_node"])
        if kk in seen:
            continue
        seen.add(kk)
        w = GRADE_W.get(r.get("grade", "C"), 0.4)
        for hid, c in stance_to_compat(r.get("stance", "support")).items():
            if hid not in hyps:
                continue
            hyps[hid]["score"] += c * w
            label = f"{r['tree_node']}({host[:18]},{r.get('grade', 'C')})"
            (hyps[hid]["hurt"] if c < 0 else hyps[hid]["help"]).append(label)
        if r.get("stance") == "contradict":
            conflicts.append({k: r.get(k) for k in
                              ("tree_node", "source_path", "url_norm")})
    ranked = sorted(hyps.items(), key=lambda x: x[1]["score"])
    print(f"\n╔═ ACH 对抗场 ═ {cid} ═ {tree['topic']}")
    print(f"║ 证据 {len(valid)} 条 (挂树 {len(seen)} 独立源-EEI 对)")
    print(f"║ [排除法排序: 得分最低=最先排除]")
    for hid, h in ranked:
        print(f"║   {hid} {h['score']:>+6.1f}  {h['text'][:40]}")
    best = ranked[-1]
    worst = ranked[0]
    print(f"║")
    print(f"║ 领先假设: {best[0]} — 但先看反驳 (确认偏误拦截):")
    if best[1]["hurt"]:
        for x in best[1]["hurt"][:3]:
            print(f"║   ↳ 反驳证据 {x}")
    else:
        print(f"║   ⚠ 零反证记录 — 当前领先是未经对抗的单边叙事, "
              f"禁止直接采信 (须补 against 证据后重跑)")
    print(f"║ 最先排除: {worst[0]} — 最伤它的证据 (排除依据, 须可溯源):")
    for x in worst[1]["hurt"][:3]:
        print(f"║   ↳ {x}")
    if conflicts:
        print(f"║ ⚠ 数据矛盾 {len(conflicts)} 条 — 全假设降权, 须人工核:")
        for c in conflicts[:3]:
            print(f"║   ↳ {c['tree_node']} {Path(c['source_path']).name}")
    if detail:
        print(f"║ [逐假设证据账]")
        for hid, h in ranked:
            print(f"║   {hid}: 助证 {len(h['help'])} | 反证 {len(h['hurt'])}")
            for x in (h["help"] + h["hurt"])[:6]:
                print(f"║      {x}")
    gap = [h for h in hyps.values() if not h["help"] and not h["hurt"]]
    if gap or len(valid) < 5:
        print(f"║ ⏳ 证据不足以分辨假设 (挂树 <5 条) — 按 coverage 缺口补采后重跑")
    return 0


# ---------- v1 持久化 (REQ-021 / V-002, 只增不改 v0 逻辑) ---------------------

def _compat_for(stance: str, hyp_ids: list[str]) -> dict[str, float]:
    """stance → 任意 N 假设兼容分: H1-H3 沿 v0 stance_to_compat, 超树假设
    按序号轮转 (v0 docstring 既定口径; Jev Choice 位接线后由其接管)."""
    base = stance_to_compat(stance)
    return {hid: base[f"H{i % 3 + 1}"] for i, hid in enumerate(hyp_ids)}


def _load_hypotheses(pool_dir: Path) -> tuple[list[dict], str]:
    """树 hypotheses 字段优先 (v2 树优先), 缺/坏则 HYPOTHESIS_SEEDS 兜底.
    返回 (假设列表, 来源标记)."""
    for name in TREE_NAMES:
        p = pool_dir / name
        if not p.is_file():
            continue
        try:
            hyps = json.loads(p.read_text(encoding="utf-8")).get("hypotheses")
        except (json.JSONDecodeError, OSError, AttributeError):
            continue
        if (isinstance(hyps, list) and hyps
                and all(isinstance(h, dict) and h.get("id") for h in hyps)):
            return hyps, name
        break
    return list(HYPOTHESIS_SEEDS), "HYPOTHESIS_SEEDS"


def _load_manifest_rows(pool_dir: Path) -> list[dict]:
    p = pool_dir / "manifest.jsonl"
    if not p.is_file():
        return []
    out = []
    for line in p.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            out.append(json.loads(line))
        except json.JSONDecodeError:
            continue
    return out


def run_persistent(campaign_id: str, pool_root=None,
                   out=None) -> list[dict]:
    """ACH v1 持久化排除链 (REQ-021): 挂树反证行 → 逐假设排除打分 →
    追加落盘 ach_exclusions.jsonl, 返回排除链行列表 (供测/供 L6 消费)."""
    root = Path(pool_root) if pool_root else POOL_ROOT
    d = root / campaign_id
    if not d.is_dir():
        raise FileNotFoundError(f"弹药池战役目录不存在: {d}")
    hyps, hyp_src = _load_hypotheses(d)
    hyp_ids = [str(h["id"]) for h in hyps]
    rows = _load_manifest_rows(d)
    # 排除打分只认挂树反证行: valid + tree_node 非空 + stance 含 against/contradict
    elig = [r for r in rows
            if isinstance(r, dict) and r.get("judge") == "valid"
            and r.get("tree_node")
            and any(m in str(r.get("stance") or "").lower()
                    for m in ("against", "contradict"))]
    acc = {hid: {"score": 0.0, "ev": [], "hurt": []} for hid in hyp_ids}
    seen: set[tuple] = set()                       # v0 同款 (host, tree_node) 去重
    for r in elig:
        host = (urlsplit(str(r.get("url_norm") or "")).netloc
                or Path(str(r.get("source_path") or "")).stem)
        kk = (host, r["tree_node"])
        if kk in seen:
            continue
        seen.add(kk)
        w = GRADE_W.get(r.get("grade", "C"), 0.4)
        rid = str(r.get("dedup_key") or "")
        for hid, c in _compat_for(str(r.get("stance") or ""), hyp_ids).items():
            acc[hid]["score"] += c * w
            if rid and rid not in acc[hid]["ev"]:
                acc[hid]["ev"].append(rid)
            if c < 0:
                acc[hid]["hurt"].append(
                    f"{r['tree_node']}({host[:18]},{r.get('grade', 'C')})")
    ts = time.strftime("%Y-%m-%dT%H:%M:%S")
    out_rows: list[dict] = []
    for h in hyps:
        hid, a = str(h["id"]), acc[str(h["id"])]
        if not elig:
            verdict = "inconclusive"
            reason = "无挂树反证行 (stance 含 against/contradict): 无排除依据"
        elif a["score"] <= EXCLUDE_SCORE_MIN:
            verdict = "excluded"
            reason = (f"排除分 {a['score']:+.2f} ≤ {EXCLUDE_SCORE_MIN}; "
                      f"最伤证据: " + "; ".join(a["hurt"][:3] or ["-"]))
        elif a["score"] >= SUPPORT_SCORE_MIN:
            verdict = "supported"
            reason = (f"反证类证据净支持 ({a['score']:+.2f} ≥ "
                      f"{SUPPORT_SCORE_MIN}): 对手假设被同批证据压制")
        else:
            verdict = "inconclusive"
            reason = (f"排除分 {a['score']:+.2f} 落在灰区 ({EXCLUDE_SCORE_MIN},"
                      f" {SUPPORT_SCORE_MIN}): 反证不足以分辨")
        out_rows.append({
            "hypothesis": hid, "hypothesis_text": str(h.get("text") or ""),
            "verdict": verdict,
            "rival_excluded": verdict == "excluded" and bool(a["ev"]),
            "evidence_ids": list(a["ev"]),
            "exclusion_reason": reason,
            "score": round(a["score"], 4),
            "campaign": campaign_id,
            "hypothesis_source": hyp_src, "ts": ts,
        })
    out_path = Path(out) if out else d / "ach_exclusions.jsonl"
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("a", encoding="utf-8", newline="\n") as fh:   # 只增不删
        for row in out_rows:
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
    n_exc = sum(1 for r in out_rows if r["verdict"] == "excluded")
    n_riv = sum(1 for r in out_rows if r["rival_excluded"])
    print(f"[ACHv1] {campaign_id}: 假设 {len(out_rows)} (源 {hyp_src}) | "
          f"挂树反证行 {len(elig)} (独立源-EEI 对 {len(seen)}) | "
          f"excluded {n_exc} / rival_excluded {n_riv}")
    for r in out_rows:
        mark = "✂" if r["rival_excluded"] else ("✔" if r["verdict"] == "supported" else "?")
        print(f"[ACHv1] {mark} {r['hypothesis']} {r['score']:>+6.2f} "
              f"{r['verdict']:<12} ev={len(r['evidence_ids'])}")
    print(f"[ACHv1] 排除链持久化 (追加): {out_path}")
    return out_rows


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="G4 ACH 对抗场")
    ap.add_argument("cid", nargs="?", help="campaign_id (v0 位置参数)")
    ap.add_argument("--detail", action="store_true")
    ap.add_argument("--campaign", default=None,
                    help="campaign_id (persistent 模式, REQ-021)")
    ap.add_argument("--persistent", action="store_true",
                    help="v1 持久化排除链 → ach_exclusions.jsonl")
    ap.add_argument("--out", default=None, help="排除链 jsonl 输出路径覆盖")
    ap.add_argument("--pool-root", default=None, help="ammo_pool 根覆盖")
    ns = ap.parse_args(argv)
    if ns.persistent:
        cid = ns.campaign or ns.cid
        if not cid:
            ap.error("--persistent 需要 --campaign <id> (或位置参数 cid)")
        try:
            run_persistent(cid, pool_root=ns.pool_root, out=ns.out)
        except FileNotFoundError as e:
            print(f"[ACHv1] 错误: {e}", file=sys.stderr)
            return 2
        return 0
    if not ns.cid:
        ap.error("需要位置参数 cid 或 --campaign <id>")
    return run(ns.cid, ns.detail)


if __name__ == "__main__":
    sys.exit(main())
