# -*- coding: utf-8 -*-
"""chapter_matrix — S3-1 章节×证据双向对账器 (P0 主链: 判级→契约→分母可信→对账锁定).

行=章节, 列=T1/T2/T3 字数当量+四权得分+权威度分布+独立源数; 每格可对回
manifest 明细 (dedup_key 锚, 抽样零漂移). 三态 (饱和/贫血/缺口) → 处置
(扩写/合并/降级/补扫); 缺口章可出一笔真实补扫单 (conductor add_job 路径,
CONDUCTOR_STATE 测试态闸同源隔离).

评分层复用 epc-deep-research 阶段5 在役四权口径 (同阈值, 纯函数重实现 —
skill 脚本在包外不 import):
  数量30% (≥10件30/≥5件20/≥3件12/余 件数×4) + 深度30% (均字≥3000→30/
  ≥1500→20/≥500→10/余 均/50) + 多样性20% (引擎≥3→20/2→14/余7) +
  时效20% (当年20/近一年15/更早8/无ts15 — 在役口径默认中位15的桶化版).
判定源=盘上账本 (manifest valid 行, dedup 后, 与 ammo_pool.tier_report
同语义); 不信模型自评.

用法:
  python chapter_matrix.py --battle-dir D [--cid EPC50-SNEI] [--sample 10]
                           [--rescan ch03] [--rescan-chars 200000]
环境变量: CONDUCTOR_STATE / CHANNELS_V2 / ROUTER_STATE (补扫单测试隔离).
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import time
from pathlib import Path

_SL = Path(__file__).resolve().parent.parent
if str(_SL) not in sys.path:
    sys.path.insert(0, str(_SL))
from superline import framework_gen as FG            # noqa: E402
import ammo_pool as AP                                # noqa: E402

if sys.stdout:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 三态门限 (v1 校准参数 — 改动须留快照对照)
SAT_SCORE = 75          # ≥75 饱和
GAP_SCORE = 40          # <40 或零证据 = 缺口
MERGE_OVERLAP = 0.5     # 章间证据 Jaccard >0.5 → 合并候选
RESCAN_DEFAULT_CHARS = 200_000                        # 补扫单默认弹药量
TIERS = ("T1", "T2", "T3")


# ---------------------------------------------------------------- 行装载
def _row_title(r: dict) -> str:
    """匹配面 = 标题级下界 (与 tier_report 同源: source_path 基名兜 url)."""
    return os.path.basename(r.get("source_path") or r.get("url_norm") or "")


def load_rows(cid: str) -> list[dict]:
    """manifest valid 行 × dedup (dedup_key/url_norm/source_path 三级键 —
    与 tier_report 完全同语义, 对账两账本零漂移的根基)."""
    mp = AP._camp_dir(cid) / "manifest.jsonl"
    if not mp.is_file():
        return []
    out: list[dict] = []
    seen: set[str] = set()
    for ln in mp.read_text(encoding="utf-8").splitlines():
        ln = ln.strip()
        if not ln:
            continue
        try:
            r = json.loads(ln)
        except json.JSONDecodeError:
            continue
        if r.get("judge") != "valid":
            continue
        key = r.get("dedup_key") or r.get("url_norm") \
            or r.get("source_path") or ""
        if key:
            if key in seen:
                continue
            seen.add(key)
        out.append(r)
    return out


# ---------------------------------------------------------------- 四权 (同源口径)
def _score(count: int, avg_chars: float, engines: int, newest_year: int,
           cur_year: int) -> dict:
    """四权得分 (阈值与 epc-deep-research 阶段5 在役口径一致)."""
    s_cnt = 30 if count >= 10 else 20 if count >= 5 \
        else 12 if count >= 3 else count * 4
    s_dep = 30 if avg_chars >= 3000 else 20 if avg_chars >= 1500 \
        else 10 if avg_chars >= 500 else avg_chars / 50
    s_div = 20 if engines >= 3 else 14 if engines == 2 else 7
    if not newest_year:
        s_rec = 15                                   # 在役口径: 无日期中位分
    elif newest_year >= cur_year:
        s_rec = 20
    elif newest_year >= cur_year - 1:
        s_rec = 15
    else:
        s_rec = 8
    tot = round(min(100.0, s_cnt + s_dep + s_div + s_rec), 1)
    return {"count": s_cnt, "depth": round(s_dep, 1), "diversity": s_div,
            "recency": s_rec, "total": tot}


def _cell(rows: list[dict], cur_year: int) -> dict:
    """行集 → 一格 (字数当量+四权+权威度分布+独立源; keys=对账锚)."""
    chars = sum(r.get("chars") or 0 for r in rows)
    engines = {r.get("engine", "?") for r in rows}
    from urllib.parse import urlsplit
    domains = {(urlsplit(r["url_norm"]).netloc or Path(r["source_path"]).stem)
               for r in rows if r.get("url_norm") or r.get("source_path")}
    years = [int((r.get("ts") or "")[:4]) for r in rows
             if (r.get("ts") or "")[:4].isdigit()]
    auth = {"A": 0, "B": 0, "C": 0, "未分级": 0}
    for r in rows:
        g = r.get("authority_grade")
        auth[g if g in ("A", "B", "C") else "未分级"] += 1
    return {"chars": chars, "items": len(rows),
            "score": _score(len(rows), chars / max(1, len(rows)),
                            len(engines), max(years) if years else 0,
                            cur_year),
            "authority": auth, "engines": len(engines),
            "domains": len(domains),
            "keys": [r.get("dedup_key") or r.get("url_norm")
                     or r.get("source_path") for r in rows]}


def _match(rows: list[dict], words: list[str]) -> list[dict]:
    """章词 × 标题匹配 (标题级下界, 同 tier_report 判据)."""
    ws = [w for w in words if w]
    if not ws:
        return []
    return [r for r in rows
            if any(w in _row_title(r) for w in ws)]


# ---------------------------------------------------------------- 矩阵构建
def build(framework: dict, rows: list[dict],
          cur_year: int | None = None) -> dict:
    """framework.json × manifest valid 行 → 章节×证据矩阵 (纯函数)."""
    cur_year = cur_year if cur_year is not None \
        else int(time.strftime("%Y"))
    chapters = []
    keysets: list[set] = []
    for ch in framework.get("chapters", []):
        cells = {}
        union: dict[str, dict] = {}
        for tier in TIERS:
            words = (ch.get("tier_map") or {}).get(tier) or []
            matched = _match(rows, words)
            if not words:
                continue
            cells[tier] = {"words": words, **_cell(matched, cur_year)}
            for r in matched:                    # 章级并集 (同证据不双计)
                k = r.get("dedup_key") or r.get("url_norm") \
                    or r.get("source_path")
                union[k] = r
        u_rows = list(union.values())
        u = _cell(u_rows, cur_year)
        chapters.append({"id": ch.get("id"), "title": ch.get("title"),
                         "budget_band": ch.get("budget_band"),
                         "evidence_density": ch.get("evidence_density"),
                         "cells": cells, "union": u})
        keysets.append(set(union))
    # 二次遍历: 三态+处置 (合并判据要跨章重叠, 须全集先就位)
    for i, c in enumerate(chapters):
        u = c["union"]
        has_t12 = any(t in c["cells"] for t in ("T1", "T2"))
        if u["items"] == 0 or u["score"]["total"] < GAP_SCORE:
            c["state"], c["action"] = "缺口", "补扫"
        else:
            ks = keysets[i]
            ov = max((len(ks & keysets[j]) / max(1, len(ks | keysets[j]))
                      for j in range(len(chapters))
                      if j != i and keysets[j]), default=0.0)
            if u["score"]["total"] >= SAT_SCORE:
                c["state"], c["action"] = "饱和", "锁定"
            else:
                c["state"] = "贫血"
                if ov > MERGE_OVERLAP:
                    c["action"] = "合并"
                elif not has_t12:
                    c["action"] = "降级"
                else:
                    c["action"] = "扩写"
            c["max_overlap"] = round(ov, 3)
    dist = {s: sum(1 for c in chapters if c["state"] == s)
            for s in ("饱和", "贫血", "缺口")}
    return {"schema": "chapter_matrix_v1",
            "campaign_id": framework.get("campaign_id"),
            "framework_mode": framework.get("generated_by", ""),
            "rows_total": len(rows), "chapters": chapters,
            "state_dist": dist,
            "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S")}


# ---------------------------------------------------------------- 对账 (抽样零漂移)
def audit_sample(matrix: dict, rows: list[dict], n: int = 10) -> dict:
    """抽样 n 格对回 manifest 明细: 按 keys 重算 chars/items 必须逐格相等.

    确定性抽样 (前 n 个非空格, 章序×tier 序) — 可复跑可追责."""
    by_key: dict[str, list[dict]] = {}
    for r in rows:
        k = r.get("dedup_key") or r.get("url_norm") or r.get("source_path")
        by_key.setdefault(k, []).append(r)
    details, drift, sampled = [], 0, 0
    for c in matrix.get("chapters", []):
        for tier in TIERS:
            cell = c["cells"].get(tier)
            if not cell or cell["items"] == 0:
                continue
            if sampled >= n:
                break
            sampled += 1
            back = [r for k in cell["keys"] for r in by_key.get(k, [])]
            b_chars = sum(r.get("chars") or 0 for r in back)
            ok = (b_chars == cell["chars"] and len(back) == cell["items"])
            drift += 0 if ok else 1
            details.append({"chapter": c["id"], "tier": tier,
                            "matrix": {"chars": cell["chars"],
                                       "items": cell["items"]},
                            "manifest": {"chars": b_chars,
                                         "items": len(back)},
                            "drift": 0 if ok else 1})
        if sampled >= n:
            break
    return {"sampled": sampled, "drift_cells": drift, "ok": drift == 0,
            "details": details}


# ---------------------------------------------------------------- 补扫单 (真实出队留痕)
_RF_ENG = _SL.parent / "ResearchFactory-Eng" / "EPC100" / "conductor"


def dispatch_rescan(battle_dir: str, cid: str, chapter_id: str,
                    planned_chars: int = RESCAN_DEFAULT_CHARS,
                    tier_override: str = "") -> dict:
    """缺口章补扫单: tier_router 选腿+_mk_cmd → channel_conductor.add_job
    真实入队 + rescan_ledger.jsonl 留痕. 补弹档恒 gap (S2-2 词表).

    tier_override: 操作员显式指定层 (如当期仅 T3 有可机器派腿); 缺省=
    自动选最弱层 (零证据层优先, 平手 T1>T2>T3). 无可派腿 → plan-only
    留痕待渠道扩容 (绝不静默).
    测试隔离: 调用前设 CONDUCTOR_STATE/CHANNELS_V2/ROUTER_STATE 环境变量
    (cc.STATE 在 import 时读 env — 本函数 import 在调用时, env 先到先得)."""
    fw, meta = FG.load_framework(battle_dir)
    if fw is None:
        raise FileNotFoundError("framework.json 缺席 — 先跑 S1-1")
    ch = next((c for c in fw["chapters"] if c["id"] == chapter_id), None)
    if ch is None:
        raise KeyError(f"章不存在: {chapter_id}")
    matrix = build(fw, load_rows(cid))
    mc = next(c for c in matrix["chapters"] if c["id"] == chapter_id)
    if tier_override:
        if tier_override not in TIERS \
                or not (ch.get("tier_map") or {}).get(tier_override):
            raise ValueError(f"{chapter_id} 无 {tier_override} 词表")
        tier = tier_override
    else:
        # 缺哪层补哪层: 零证据层优先, 否则 T1 (主体层不缺不扫)
        tier = next((t for t in TIERS
                     if (mc["cells"].get(t) or {}).get("items", 0) == 0
                     and (ch.get("tier_map") or {}).get(t)), "T1")
    words = (ch.get("tier_map") or {}).get(tier) or []
    if not words:
        raise ValueError(f"{chapter_id} 无可用 tier 词表")
    company = (fw.get("report_title") or "").split("怎么干")[0].strip("《 ")
    v2 = _RF_ENG / "v2"
    for p in (str(v2), str(v2.parent)):
        if p not in sys.path:
            sys.path.insert(0, p)
    import tier_router as TR                     # noqa: E404 (调用时装载)
    import channel_conductor as cc
    chosen = None
    for c in TR.select_channels(tier, None, battle=cid):
        cmd = TR._mk_cmd(c, words[:3], str(battle_dir), company)
        if cmd:
            chosen = (c, cmd)
            break
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "battle": cid,
           "chapter": chapter_id, "chapter_title": ch.get("title"),
           "state": mc["state"], "tier": tier, "words": words[:3],
           "planned_chars": planned_chars,
           "framework_mode": meta.get("mode"),
           "queued": False, "channel": "", "cmd": "", "note": ""}
    if chosen:
        c, cmd = chosen
        job_note = (f"S3-1 补扫单 {chapter_id}[{ch.get('title', '')[:12]}] "
                    f"{tier}[gap] 证据 {mc['union']['items']}件/"
                    f"{mc['union']['chars']:,}字 → 补 {planned_chars:,}字")
        cc.add_job({"jobs": []}, c["id"], cmd, resource=None,
                   window="heavy" if tier == "T3" else (c.get("windows")
                                                       or "any"),
                   battle=cid, note=job_note, priority=TR._TIER_PRIO[tier])
        rec.update(queued=True, channel=c["id"], cmd=cmd, note=job_note)
    else:
        rec["note"] = "无可机器派腿 (plan-only) — 留痕待渠道扩容"
    led = Path(battle_dir) / "_pipeline" / "rescan_ledger.jsonl"
    led.parent.mkdir(parents=True, exist_ok=True)
    with led.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    return rec


# ---------------------------------------------------------------- 落盘
def render_md(matrix: dict, audit: dict) -> str:
    md = ["# S3-1 章节×证据矩阵", "",
          f"- campaign {matrix['campaign_id']} | 账本行 {matrix['rows_total']:,}"
          f" (valid×dedup) | 三态 {matrix['state_dist']['饱和']}饱和/"
          f"{matrix['state_dist']['贫血']}贫血/{matrix['state_dist']['缺口']}缺口",
          f"- 抽样对账 {audit['sampled']} 格, 漂移 {audit['drift_cells']} 格"
          f" ({'零漂移 ✅' if audit['ok'] else '漂移在案 ❌'})", "",
          "| 章 | 题目 | 三态 | 处置 | T1字 | T2字 | T3字 | 四权 | A/B/C/未 | 独立源 |",
          "|---|---|---|---|---|---|---|---|---|---|"]
    for c in matrix["chapters"]:
        t = {x: f"{c['cells'][x]['chars']:,}"
             if x in c["cells"] else "—" for x in TIERS}
        a = c["union"]["authority"]
        md.append(
            f"| {c['id']} | {c['title'][:14]} | {c['state']} | {c['action']} "
            f"| {t['T1']} | {t['T2']} | {t['T3']} "
            f"| {c['union']['score']['total']} "
            f"| {a['A']}/{a['B']}/{a['C']}/{a['未分级']} "
            f"| {c['union']['domains']} |")
    return "\n".join(md) + "\n"


def main() -> int:
    ap = argparse.ArgumentParser(description="S3-1 章节×证据双向对账器")
    ap.add_argument("--battle-dir", required=True)
    ap.add_argument("--cid", default="", help="campaign_id (缺省取框架)")
    ap.add_argument("--sample", type=int, default=10)
    ap.add_argument("--rescan", default="", help="缺口章 id (如 ch03)")
    ap.add_argument("--rescan-chars", type=int, default=RESCAN_DEFAULT_CHARS)
    ap.add_argument("--rescan-tier", default="",
                    help="显式补扫层 (缺省自动选最弱层)")
    args = ap.parse_args()
    fw, meta = FG.load_framework(args.battle_dir)
    if fw is None:
        print("[s3-1] framework.json 缺席 — 先跑 S1-1", file=sys.stderr)
        return 2
    cid = args.cid or fw.get("campaign_id") or ""
    if not cid:
        print("[s3-1] 缺 campaign_id (--cid)", file=sys.stderr)
        return 2
    rows = load_rows(cid)
    matrix = build(fw, rows)
    audit = audit_sample(matrix, rows, n=max(1, args.sample))
    out = FG.CG._out_dir(args.battle_dir)
    (out / "chapter_matrix.json").write_text(
        json.dumps({**matrix, "audit": audit}, ensure_ascii=False, indent=1),
        encoding="utf-8")
    (out / "chapter_matrix.md").write_text(render_md(matrix, audit),
                                           encoding="utf-8")
    print(f"[s3-1] {cid}: {len(matrix['chapters'])} 章 × 账本 "
          f"{len(rows):,} 行 | 三态 {matrix['state_dist']} | "
          f"抽样 {audit['sampled']} 格漂移 {audit['drift_cells']} "
          f"({'零漂移' if audit['ok'] else '漂移!'}) | framework={meta['mode']}")
    print(f"[s3-1] 矩阵落 {out / 'chapter_matrix.md'}")
    rc = 0 if audit["ok"] else 1
    if args.rescan:
        rec = dispatch_rescan(args.battle_dir, cid, args.rescan,
                              args.rescan_chars, args.rescan_tier)
        print(f"[s3-1] 补扫单 {rec['chapter']}/{rec['tier']} "
              f"{'已入队 ' + rec['channel'] if rec['queued'] else 'plan-only'} "
              f"→ {rec['note']}")
    return rc


if __name__ == "__main__":
    sys.exit(main())
