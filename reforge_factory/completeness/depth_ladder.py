# -*- coding: utf-8 -*-
"""depth_ladder — P 轴深度阶梯传感器 (T-007D / REQ-023 / KB-COMPLETENESS-SPEC).

以 question_tree 实际 EEI 总数为分母 (REQ-023 铁律: 分母=树实际输出数,
单测对拍), 逐 EEI 由 ammo_pool 挂树证据行 (tree_node/stance/host/text_head/
行源标记) 判其满足的最高深度级:

  L0 零据     无任何有效证据 (单列; 数字零造假 — 零据≠提及, 不计入五级)
  L1 提及     ≥1 条有效证据 (judge==valid 且挂树 tree_node==EEI id)
  L2 数据     证据含数字表格或量词密集 (text_head 检测: 数字×量词 ≥3 处
              或 markdown 表格竖线 ≥3)
  L3 双源     ≥2 独立 host (url_norm 注册域 grade_rules.host_of;
              占位 URL 回退 source_path stem — 与 independence_audit 同口径)
  L4 反证     证据行 stance 含 against/contradict, 或树内反证位
              (EEI stance=against) 已有 ≥1 条有效证据
  L5 own_calc 行源标记含 own_calc/自算 (own_calc 字段 / engine /
              source_path / url_norm / channel)
  L6 rival排除 L5 基础上 + ach_arena v1 排除链留痕 (ach_exclusions.jsonl:
              该 EEI 关联的假设 rival_excluded=true 且 evidence_ids 非空;
              关联 = evidence_ids 经 manifest dedup_key → tree_node 回挂)
              (V-003 / REQ-020: ACH 排除 + rival 显式排除 + 证据 ID 绑定;
               无留痕/ach 缺失 → 保持 L5, 降级路径不炸)

每 EEI 取满足的最高级; l_dist={L0,L1..L6} 且 Σ(l_dist)==eei_total.

key_eei (关键 EEI) 判定链: ①树标记 (key/core/关键/核心 位或 tier∈
{T1,KEY,CORE}) → ②无标记则 tier==T1 的 EEI: 有 ≥1 条 T1 词表标题命中
的有效证据行 (tiers.json 标题级匹配, 与 ammo_pool.tier_report 同口径)
→ ③仍空则全体 EEI 兜底; key_eei_source 字段记录所用依据.

green = key_eei_ge_l3_pct >= KEY_EEI_GE_L3_MIN (比例口径 0-1).
KEY_EEI_GE_L3_MIN 为模块常量 (现值 0.9), 可随 gates.json 调整 —
接线方式: gates 侧加 completeness.P 键后在本件读取处替换常量引用.

输出 (真实池只读, 只增不删; 两文件同容):
  ammo_pool/<cid>/completeness/P_axis.json   (五轴账本位, 父指令)
  ammo_pool/<cid>/depth_ladder.json          (REQ-023.AC1 位)

用法:
  py reforge_factory/completeness/depth_ladder.py --campaign EPC-BID26 [--dry]
  退出码: 0=green 过门 / 2=未过门 (树缺失亦 2, fail-soft 落盘不炸).
"""
from __future__ import annotations

import argparse
import json
import os
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 同级/上级导入纪律: reforge_factory (grade_rules) 与本目录均可解析
_HERE = Path(__file__).resolve().parent
for _p in (str(_HERE.parent), str(_HERE)):
    if _p not in sys.path:
        sys.path.insert(0, _p)
from grade_rules import host_of                      # noqa: E402

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
CID_RE = re.compile(r"[A-Za-z0-9_\-]{3,40}")

# green 阈值: 关键 EEI 中 ≥L3 者占比 (0-1). 模块常量 — 可随 gates 调
# (gates.json completeness.P 键接线后替换此引用; 现 0.9 对齐 V3 总纲).
KEY_EEI_GE_L3_MIN = 0.9

LEVELS = ("L0", "L1", "L2", "L3", "L4", "L5", "L6")
TREE_NAMES = ("question_tree_v2.json", "question_tree.json")   # v2 优先 v1 兜底
#: ach_arena v1 排除链留痕文件 (REQ-021 产物, L6 判据源)
ACH_EXCL_NAME = "ach_exclusions.jsonl"

# 数字×量词 (长词在前防截断) — L2 数据密度检测
_NUM_QUANT_RE = re.compile(
    r"\d+(?:\.\d+)?\s*(?:平方公里|万亿元|千亿元|亿元|万美元|万元|亿|万|美元|元|"
    r"%|％|家|条|个|项|件|人|次|起|例|宗|台|座|亩|倍|年|月|日)")
DATA_DENSE_QUANT_HITS = 3     # 量词密集: 数字×量词 ≥3 处
DATA_DENSE_TABLE_PIPES = 3    # 数字表格: markdown 竖线 ≥3

_KEY_FLAG_FIELDS = ("key", "is_key", "core", "is_core", "关键", "核心")
_OWN_CALC_MARKS = ("own_calc", "自算")
_AGAINST_MARKS = ("against", "contradict")


# ---------- 纯函数 (不改入参) ----------
def is_data_dense(text: str) -> bool:
    """L2 数据密度: 数字表格 (竖线≥3) 或量词密集 (数字×量词≥3 处)."""
    t = str(text or "")
    if not t:
        return False
    if t.count("|") >= DATA_DENSE_TABLE_PIPES:
        return True
    return len(_NUM_QUANT_RE.findall(t)) >= DATA_DENSE_QUANT_HITS


def row_host(row: dict) -> str:
    """行级独立 host: url_norm 注册域优先, 占位/缺失回退 source_path stem."""
    h = host_of(str(row.get("url_norm") or ""))
    if h:
        return h
    sp = str(row.get("source_path") or "")
    return Path(sp).stem if sp else ""


def _has_own_calc(row: dict) -> bool:
    """L5 行源标记: own_calc 字段非空即为标记, 或 own_calc/自算 子串
    出现在 engine/channel/source_path/url_norm 任一标记字段."""
    if row.get("own_calc"):
        return True
    fields = (row.get("engine"), row.get("channel"),
              row.get("source_path"), row.get("url_norm"))
    return any(m in str(f or "") for f in fields for m in _OWN_CALC_MARKS)


def _is_against_row(row: dict) -> bool:
    """L4 行级反证: stance 含 against/contradict."""
    s = str(row.get("stance") or "").lower()
    return any(m in s for m in _AGAINST_MARKS)


def eei_level(eei: dict, rows: list[dict],
              excl_hits: set[str] | None = None) -> str:
    """单 EEI 最高深度级 ("L0".."L6") — 纯函数, 不改入参.

    L6 (V-003 / REQ-020): L5 基础上该 EEI 命中 ACH 排除链留痕
    (excl_hits = _excl_eei_hits 算好的 EEI id 集) → L6;
    无留痕/ach 缺失 (excl_hits 为空) → 保持原 L1-L5 判定不升级."""
    eid = str(eei.get("id") or "")
    ev = [r for r in rows
          if r.get("judge") == "valid" and str(r.get("tree_node") or "") == eid]
    if not ev:
        return "L0"
    ok = {1: True,                                   # L1 提及: ≥1 有效证据
          2: any(is_data_dense(r.get("text_head")) for r in ev),
          3: len({row_host(r) for r in ev} - {""}) >= 2,
          4: any(_is_against_row(r) for r in ev)     # L4 反证: 行级或反证位
          or str(eei.get("stance") or "").lower() in _AGAINST_MARKS,
          5: any(_has_own_calc(r) for r in ev)}
    lv = f"L{max(k for k, hit in ok.items() if hit)}"
    if lv == "L5" and excl_hits and eid in excl_hits:
        return "L6"                                  # rival 显式排除 + 证据绑定
    return lv


def _tree_marked_key(eei: dict) -> bool:
    """关键 EEI 树标记: key/core/关键/核心 位为真, 或 tier∈{T1,KEY,CORE}."""
    for f in _KEY_FLAG_FIELDS:
        v = eei.get(f)
        if isinstance(v, bool):
            if v:
                return True
        elif isinstance(v, (int, float)):
            if v:
                return True
        elif isinstance(v, str) and v.strip().lower() not in ("", "false", "0", "no"):
            return True
    return str(eei.get("tier") or "").strip().upper() in ("T1", "KEY", "CORE")


def _row_title(row: dict) -> str:
    """行标题 (与 tier_report 同口径: source_path/url_norm basename)."""
    return os.path.basename(str(row.get("source_path")
                                or row.get("url_norm") or ""))


def key_eei_set(tree_eeis: list[dict], rows: list[dict],
                t1_keywords: list[str]) -> tuple[list[str], str]:
    """关键 EEI 判定链: 树标记 → T1 挂钩 → 全体兜底. 返回 (ids, source)."""
    marked = [str(e.get("id")) for e in tree_eeis if _tree_marked_key(e)]
    if marked:
        return sorted(marked), "tree_marker"
    if t1_keywords:
        valid = [r for r in rows if r.get("judge") == "valid"
                 and r.get("tree_node")]
        t1_nodes = {str(r["tree_node"]) for r in valid
                    if any(k in _row_title(r) for k in t1_keywords)}
        t1_nodes &= {str(e.get("id")) for e in tree_eeis}   # 只认树内 EEI
        if t1_nodes:
            return sorted(t1_nodes), "t1_linked"
    return [str(e.get("id")) for e in tree_eeis], "all_fallback"


def scan_rows(tree: dict, rows: list[dict], t1_keywords: list[str],
              excl_hits: set[str] | None = None) -> dict:
    """树+池行 → P 轴结果 (纯函数, 不改入参, 无 IO).

    excl_hits: ACH 排除链留痕命中的 EEI id 集 (None/空 → 不判 L6,
    即 L1-L5 原口径, 向后兼容)."""
    eeis = [e for q in tree.get("subquestions", []) for e in q.get("eeis", [])]
    dist = {k: 0 for k in LEVELS}
    levels: dict[str, str] = {}
    for e in eeis:
        lv = eei_level(e, rows, excl_hits)
        levels[str(e.get("id"))] = lv
        dist[lv] += 1
    total = len(eeis)
    key_ids, key_src = key_eei_set(eeis, rows, t1_keywords)
    ge3 = sum(1 for k in key_ids if int(levels.get(k, "L0")[1:]) >= 3)
    pct = round(ge3 / len(key_ids), 4) if key_ids else 0.0
    mean_norm = round(sum(int(lv[1:]) * n for lv, n in dist.items()) / 5
                      / total, 4) if total else 0.0
    return {"eei_total": total, "l_dist": dist, "eei_levels": levels,
            "with_evidence": total - dist["L0"],
            "zero_evidence_eeis": sorted(k for k, v in levels.items()
                                         if v == "L0"),
            "key_eei_source": key_src, "key_eeis": key_ids,
            "key_eei_total": len(key_ids), "key_eei_ge_l3": ge3,
            "key_eei_ge_l3_pct": pct, "mean_depth_norm": mean_norm,
            "green": pct >= KEY_EEI_GE_L3_MIN}


# ---------- 战役 IO (只读池; 输出只增) ----------
def _load_tree(pool_dir: Path) -> tuple[dict, str]:
    """v2 树优先, v1 兜底; 无树 → ({}, "none") fail-soft."""
    for name in TREE_NAMES:
        p = pool_dir / name
        if p.is_file():
            try:
                return json.loads(p.read_text(encoding="utf-8")), name
            except json.JSONDecodeError:
                continue
    return {}, "none"


def _load_rows(pool_dir: Path) -> list[dict]:
    p = pool_dir / "manifest.jsonl"
    if not p.is_file():
        return []
    out = []
    for line in p.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            out.append(json.loads(line))
        except json.JSONDecodeError:
            continue
    return out


def _load_t1_keywords(pool_dir: Path) -> list[str]:
    p = pool_dir / "tiers.json"
    if not p.is_file():
        return []
    try:
        return [str(k) for k in json.loads(
            p.read_text(encoding="utf-8")).get("T1", [])]
    except (json.JSONDecodeError, OSError):
        return []


# ---------- L6 判据: ach_arena v1 排除链留痕 (V-003 / REQ-020, 只增) ----------

def _load_exclusions(pool_dir: Path) -> list[dict]:
    """读 ach_exclusions.jsonl (ach_arena v1 产物, 只读); 缺/坏 → [] fail-soft."""
    p = pool_dir / ACH_EXCL_NAME
    if not p.is_file():
        return []
    out: list[dict] = []
    for line in p.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            x = json.loads(line)
        except json.JSONDecodeError:
            continue
        if isinstance(x, dict):
            out.append(x)
    return out


def _excl_eei_hits(excl_rows: list[dict], rows: list[dict]) -> set[str]:
    """排除链行 → 命中留痕的 EEI id 集 (纯函数).

    判据行 = rival_excluded is True 且 evidence_ids 非空 (REQ-020:
    ACH 排除 + rival 显式排除 + 证据 ID 绑定, 三者齐备才计).
    关联路径: evidence_ids 是 manifest 行 ID (dedup_key) → 经 manifest 行
    tree_node 回挂 EEI; evidence_id 直等于某挂树 tree_node 时亦认 (容错)."""
    ids: set[str] = set()
    for x in excl_rows:
        if x.get("rival_excluded") is not True:
            continue
        ev = x.get("evidence_ids")
        if not isinstance(ev, list) or not ev:
            continue
        ids.update(str(e) for e in ev if e)
    if not ids:
        return set()
    hits: set[str] = set()
    for r in rows:
        tn = str(r.get("tree_node") or "")
        if not tn:
            continue
        dk = str(r.get("dedup_key") or "")
        if (dk and dk in ids) or tn in ids:
            hits.add(tn)
    return hits


def check_l6(campaign: str, eei_id: str,
             pool_root: Path = POOL_ROOT) -> bool:
    """单 EEI 是否满足 L6 判据: 读 ach_exclusions.jsonl, 该 EEI 关联的
    假设有 rival_excluded=true 且 evidence_ids 非空的排除行 → True.
    ach 缺失/无留痕 → False (fail-soft, 不炸)."""
    pool_dir = Path(pool_root) / campaign
    excl = _load_exclusions(pool_dir)
    if not excl:
        return False
    return str(eei_id) in _excl_eei_hits(excl, _load_rows(pool_dir))


def _atomic_write(p: Path, data: dict) -> None:
    p.parent.mkdir(parents=True, exist_ok=True)
    tmp = p.with_suffix(p.suffix + ".tmp")
    tmp.write_text(json.dumps(data, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(p)


def scan(cid: str, pool_root: Path = POOL_ROOT, write: bool = True) -> dict:
    """P 轴扫描: 读树+manifest+tiers (全只读) → 阶梯 → (可选)双落盘."""
    if not CID_RE.fullmatch(cid or ""):
        raise ValueError(f"非法 campaign_id: {cid}")
    pool_dir = Path(pool_root) / cid
    tree, tree_name = _load_tree(pool_dir)
    rows = _load_rows(pool_dir)
    t1k = _load_t1_keywords(pool_dir)
    excl = _load_exclusions(pool_dir)               # L6 判据源 (只读, V-003)
    excl_hits = _excl_eei_hits(excl, rows)
    r = {"axis": "P", "sensor": "depth_ladder", "cid": cid,
         "generated": time.strftime("%Y-%m-%d %H:%M"),
         "engine_version": "depth_ladder-v1.1 (T-007D P轴传感器 + V-003 L6)",
         "tree_source": tree_name, "ach_exclusion_rows": len(excl),
         "threshold": {
             "key_eei_ge_l3_min": KEY_EEI_GE_L3_MIN,
             "note": "模块常量, 可随 gates.json 调"},
         "notes": []}
    r.update(scan_rows(tree, rows, t1k, excl_hits=excl_hits))
    if tree_name == "none":
        r["notes"].append("question_tree 缺失: 分母只认树实际 EEI 数故为 0 "
                          "(fail-soft) — 先 question_tree.py generate " + cid)
    elif r["with_evidence"] == 0:
        r["notes"].append("manifest 无有效挂树证据行 (tree_node 全空): "
                          "P 轴全 L0 — 先挂树再测深度")
    if r["key_eei_source"] == "all_fallback" and r["eei_total"]:
        r["notes"].append("树无关键标记且无 T1 挂钩: key_eei 以全体 EEI 兜底")
    if tree_name != "none" and r["eei_total"] and not excl:
        r["notes"].append(f"{ACH_EXCL_NAME} 缺失: L6 不判 (保持 L5 口径) — "
                          "先 ach_arena.py --campaign " + cid + " --persistent")
    elif r["l_dist"]["L6"]:
        r["notes"].append(f"L6 {r['l_dist']['L6']} 个 EEI (ACH 排除链留痕命中)")
    if write:
        _atomic_write(pool_dir / "completeness" / "P_axis.json", r)
        _atomic_write(pool_dir / "depth_ladder.json", r)
    return r


def _main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="P 轴深度阶梯传感器 (REQ-023)")
    ap.add_argument("--campaign", required=True, help="campaign_id (如 EPC-BID26)")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--dry", action="store_true", help="只算不写")
    ns = ap.parse_args(argv)
    try:
        r = scan(ns.campaign, Path(ns.pool_root), write=not ns.dry)
    except ValueError as e:
        print(f"[P] 错误: {e}", file=sys.stderr)
        return 1
    d = r["l_dist"]
    print(f"[P] {r['cid']}: EEI {r['eei_total']} (树 {r['tree_source']}) | "
          f"阶梯 " + " ".join(f"{k}:{d[k]}" for k in LEVELS) +
          f" | 关键 {r['key_eei_ge_l3']}/{r['key_eei_total']} ≥L3 "
          f"({r['key_eei_ge_l3_pct']:.0%}, 依据 {r['key_eei_source']}) | "
          f"green {'✅' if r['green'] else '❌'}")
    for n in r["notes"]:
        print(f"[P] ⚠ {n}")
    if not ns.dry:
        print(f"[P] sidecar: {Path(ns.pool_root) / ns.campaign / 'completeness' / 'P_axis.json'} "
              f"(+ depth_ladder.json)")
    return 0 if r["green"] else 2


if __name__ == "__main__":
    sys.exit(_main())
