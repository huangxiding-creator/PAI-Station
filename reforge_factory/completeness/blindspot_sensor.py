# -*- coding: utf-8 -*-
"""BSP 盲区传感器 — 树外造问, 第六轴候选 (V-004 / REQ-022 / KB-V4-SPEC).

KB-V4-SPEC 盲区传感器口径: 跨学科域包词 × 对象名组合扫描 + 做空反问
「如果对方在撒谎」→ 产「未问之问」新 EEI 候选, 须过五轴门才入报告
(不过门不入正文 — VISION 铁律: 域包产出须过五轴门, 同质化即下架重铸).

三域包词表 (v1 内置, 词即规格; V-006 方法卡入伍后由域包侧扩表, 勿删词):
  做空  做空审计: 关联方/利益输送/资金流向/审计意见/内控/红旗/隐瞒/伪造
  法务  法务穿透: 股权穿透/实控人/代持/抽逃/担保链/诉讼风险/行政处罚
  调查  调查叙事: 时间线交叉/信源动机/利益冲突/选择性披露/内幕

扫描 (全只读: question_tree.json + manifest.jsonl):
  已知 EEI 语料 = 树内全部子问题文本 + EEI need 文本;
  对象名 = topic / region / subject(topic 剥地域前缀);
  候选 = (域, 词) 有 manifest 命中 且 词不在已知语料 (未问之问),
         候选句 = 域问式模板 × 对象名 × 词 (做空反问内建).

五轴门过滤 (每候选逐门 bool, 全过才 passed; 不过门不入报告):
  T 时间锚   命中行 ts 跨 >=2 个年份 (时间线可交叉锚定)
  B 十面挂靠 域默认面在 B 轴十面表内 (结构防漂移; 与 coverage_facets 同源)
  D 九维归属 域可归入在役维度 (V-006 三域包注册后域即维; 否则默认维兜底)
  P 深度可达 命中行 max chars >= 2000 (有实质材料可下钻, 非碎片提及)
  C 渠道在场 命中行跨 >=2 个 engine (多渠道可采, 单渠道孤证不过)

green = passed 候选 >= 3 条 (BSP_GREEN_MIN, 模块常量可随 gates 调).

输出 (真实池只读, 只增不删):
  ammo_pool/<cid>/completeness/BSP_axis.json  (六轴账本位 BSP, 父指令 schema:
    {axis:"BSP", sensor:"blindspot", candidates:[...], green} 同容超集)

用法:
  py reforge_factory/completeness/blindspot_sensor.py --campaign EPC-BID26 [--ammo-root DIR] [--dry]
  退出码: 0=全候选过五轴门(且 green) / 2=有未过门或 green 未达 (树缺失亦 2, fail-soft 落盘不炸).
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 同级/上级导入纪律 (脚本模式与包模式均可解析)
_HERE = Path(__file__).resolve().parent
for _p in (str(_HERE.parent), str(_HERE)):
    if _p not in sys.path:
        sys.path.insert(0, _p)
try:  # B/D 轴表与 V-006 可扩展维度 (缺件退化不阻断, 见 _active_dims)
    from completeness.coverage_facets import TEN_FACETS
    from completeness import dimension_matrix as _dm
except Exception:  # pragma: no cover - 环境缺件兜底
    TEN_FACETS = None
    _dm = None

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
CID_RE = re.compile(r"[A-Za-z0-9_\-]{3,40}")

SENSOR = "blindspot"
AXIS = "BSP"

# ---------- 三域包 (词即规格; source_domain 短键 = 做空/法务/调查) ----------

DOMAIN_PACKS: dict[str, dict] = {
    "做空": {
        "full": "做空审计",
        "words": ["关联方", "利益输送", "资金流向", "审计意见", "内控",
                  "红旗", "隐瞒", "伪造"],
        "facet": "财务经营",          # B 轴十面默认挂靠面
        "dim": "财务",               # D 轴默认归属维 (域包维注册前兜底)
        "template": "做空审计之问: {obj}的「{w}」证据链 — 若对方在撒谎, "
                    "账面与{w}何处先破",
    },
    "法务": {
        "full": "法务穿透",
        "words": ["股权穿透", "实控人", "代持", "抽逃", "担保链",
                  "诉讼风险", "行政处罚"],
        "facet": "风险纠纷",
        "dim": "司法风险",
        "template": "法务穿透之问: {obj}的「{w}」穿透链 — 名义结构与"
                    "实际权益在哪里断裂",
    },
    "调查": {
        "full": "调查叙事",
        "words": ["时间线交叉", "信源动机", "利益冲突", "选择性披露", "内幕"],
        "facet": "案例实践",
        "dim": "行业",
        "template": "调查叙事之问: {obj}的「{w}」核验链 — 单一信源的"
                    "叙事经得起交叉验证吗",
    },
}
DOMAINS = tuple(DOMAIN_PACKS)

#: B 轴十面兜底表 (coverage_facets 缺件时用于 B 门结构校验; 与其 TEN_FACETS 同源)
TEN_FACETS_FALLBACK = [
    "政策法规", "市场行情", "竞争格局", "案例实践", "风险纠纷", "财务经营",
    "技术方案", "组织人事", "国际对标", "渠道生态",
]

# 五轴门参数 (模块常量, 可随 gates.json 调)
BSP_GREEN_MIN = 3          # green 门槛: passed 候选 >= 3
T_GATE_YEARS = 2           # T 门: 命中行 ts 跨 >=2 年份
P_MIN_CHARS = 2000         # P 门: 命中行 max chars 下限 (有料可下钻)
C_GATE_ENGINES = 2         # C 门: 命中行跨 >=2 engine

_YEAR_RE = re.compile(r"^\d{4}")


# ---------- 内部小件 ----------

def _atomic_write(p: Path, data: dict) -> None:
    p.parent.mkdir(parents=True, exist_ok=True)
    tmp = p.with_suffix(p.suffix + ".tmp")
    tmp.write_text(json.dumps(data, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(p)


def _ten_facets() -> list[str]:
    return list(TEN_FACETS) if TEN_FACETS else list(TEN_FACETS_FALLBACK)


def _active_dims() -> set[str]:
    """在役维度集 (V-006 三域包注册后含域包维; 缺件回退九维基线)."""
    if _dm is not None:
        try:
            return set(_dm._active_dimensions())
        except Exception:
            pass
        try:
            return set(_dm.DIMENSION_PACKS)
        except Exception:
            pass
    return {"行业", "政策", "财务", "技术", "组织人事", "司法风险",
            "招投标", "市场客户", "ESG国际"}


def _load_tree(pool_dir: Path) -> tuple[dict | None, str]:
    p = pool_dir / "question_tree.json"
    if not p.is_file():
        return None, "none"
    try:
        t = json.loads(p.read_text(encoding="utf-8"))
        return t, "question_tree.json" if isinstance(t, dict) else "bad"
    except Exception:
        return None, "bad"


def _known_corpus(tree: dict) -> tuple[str, int]:
    """树内已知 EEI 语料 (子问题文本 + EEI need 文本) 与 EEI 计数."""
    parts, n_eei = [], 0
    for q in tree.get("subquestions") or []:
        if not isinstance(q, dict):
            continue
        parts.append(str(q.get("text") or ""))
        for e in q.get("eeis") or []:
            if isinstance(e, dict):
                parts.append(str(e.get("need") or ""))
                n_eei += 1
    return "\n".join(parts), n_eei


def _objects(tree: dict) -> list[str]:
    """对象名: topic / region / subject(topic 剥地域前缀), 去空去重保序."""
    topic = str(tree.get("topic") or "").strip()
    region = str(tree.get("region") or "").strip()
    subject = topic[len(region):].strip() \
        if region and topic.startswith(region) else topic
    out, seen = [], set()
    for o in (topic, region, subject):
        if o and o not in seen:
            seen.add(o)
            out.append(o)
    return out or ["本战役课题"]


def _iter_rows(pool_dir: Path):
    """流式读 manifest.jsonl (只读); 坏行跳过计数."""
    p = pool_dir / "manifest.jsonl"
    if not p.is_file():
        return [], 0
    rows, skipped = [], 0
    with p.open(encoding="utf-8", errors="replace") as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                rows.append(json.loads(line))
            except Exception:
                skipped += 1
    return rows, skipped


def _row_text(r: dict) -> str:
    """行可搜文本: text_head + source_path + url_norm (三字段皆证据载体)."""
    return " ".join(str(r.get(k) or "") for k in ("text_head", "source_path",
                                                  "url_norm"))


def _row_year(r: dict) -> str | None:
    m = _YEAR_RE.match(str(r.get("ts") or ""))
    return m.group(0) if m else None


# ---------- 五轴门 ----------

def gate_candidate(domain: str, hit_rows: list[dict]) -> dict:
    """单候选五轴门: 逐门 bool + passed = 全过 (不过门不入报告)."""
    pack = DOMAIN_PACKS[domain]
    years = {y for y in (_row_year(r) for r in hit_rows) if y}
    max_chars = max((int(r.get("chars") or 0) for r in hit_rows), default=0)
    engines = {str(r.get("engine") or "?") for r in hit_rows}

    dims = _active_dims()
    dim = pack["full"] if pack["full"] in dims else None  # V-006: 域包维即维
    if dim is None and pack["dim"] in dims:
        dim = pack["dim"]                                  # 注册前默认维兜底

    g = {
        "T": len(years) >= T_GATE_YEARS,                   # 时间锚: 跨年份
        "B": pack["facet"] in _ten_facets(),               # 十面挂靠
        "D": dim is not None,                              # 九维(在役维)归属
        "P": max_chars >= P_MIN_CHARS,                     # 深度可达
        "C": len(engines) >= C_GATE_ENGINES,               # 渠道在场
    }
    g["passed"] = all(g[k] for k in ("T", "B", "D", "P", "C"))
    g["detail"] = {"distinct_years": sorted(years), "max_chars": max_chars,
                   "engines": sorted(engines), "facet": pack["facet"],
                   "dim": dim}
    return g


# ---------- 主扫描 ----------

def scan(cid: str, pool_root: Path | str = POOL_ROOT,
         write: bool = True) -> dict:
    """BSP 扫描: 读树+manifest (全只读) → 未问之问候选 → 五轴门 → 落盘."""
    if not CID_RE.fullmatch(cid or ""):
        raise ValueError(f"非法 campaign_id: {cid}")
    pool_dir = Path(pool_root) / cid
    tree, tree_name = _load_tree(pool_dir)

    r = {"axis": AXIS, "sensor": SENSOR, "cid": cid,
         "generated": time.strftime("%Y-%m-%d %H:%M"),
         "engine_version": "blindspot-v1 (V-004 盲区传感器)",
         "tree_source": tree_name, "candidates": [],
         "passed_count": 0, "failed_count": 0, "green": False,
         "notes": []}

    if tree is None:
        r["notes"].append(
            f"question_tree {tree_name}: 无法取树内已知 EEI, 未问之问无基准 — "
            f"fail-soft 不炸 (先 question_tree.py generate {cid})")
        if write:
            _atomic_write(pool_dir / "completeness" / f"{AXIS}_axis.json", r)
        return r

    corpus, n_eei = _known_corpus(tree)
    objects = _objects(tree)
    r["objects"] = objects
    r["tree_eei_total"] = n_eei

    rows, skipped = _iter_rows(pool_dir)
    if skipped:
        r["notes"].append(f"manifest 坏行跳过 {skipped} 行 (fail-soft)")
    if not rows:
        r["notes"].append("manifest 无行可扫: 候选为空 (如实报, 不猜)")
        if write:
            _atomic_write(pool_dir / "completeness" / f"{AXIS}_axis.json", r)
        return r

    # (域, 词) → 命中行累积
    hits: dict[tuple[str, str], list[dict]] = {}
    for row in rows:
        if not isinstance(row, dict):
            continue
        text = _row_text(row)
        if not text:
            continue
        for d in DOMAINS:
            for w in DOMAIN_PACKS[d]["words"]:
                if w in text:
                    hits.setdefault((d, w), []).append(row)

    suppressed: list[str] = []
    for (d, w), hit_rows in sorted(hits.items()):
        if w in corpus:                       # 树内已问 → 非未问之问, 显式压下
            suppressed.append(w)
            continue
        pack = DOMAIN_PACKS[d]
        gate = gate_candidate(d, hit_rows)
        why = (f"树内 {n_eei} 条 EEI/子问题文本无一含「{w}」; "
               f"现有树维度无{pack['full']}域包位, 该跨学科反问在树内"
               f"无出生通道")
        r["candidates"].append({
            "candidate_eei": pack["template"].format(obj=objects[0], w=w),
            "source_domain": d,               # 做空/法务/调查 (规格短键)
            "source_domain_full": pack["full"],
            "objects": objects,
            "why_unasked": why,
            "evidence_hits": len(hit_rows),
            "gate": gate,
        })

    passed = [c for c in r["candidates"] if c["gate"]["passed"]]
    r["passed_count"] = len(passed)
    r["failed_count"] = len(r["candidates"]) - len(passed)
    r["green"] = len(passed) >= BSP_GREEN_MIN
    r["suppressed_asked_words"] = sorted(set(suppressed))
    if suppressed:
        r["notes"].append(
            f"树内已问之词显式压下 {len(set(suppressed))} 个: "
            f"{','.join(sorted(set(suppressed)))}")
    if not r["candidates"]:
        r["notes"].append("域包词在 manifest 零命中: 无未问之问候选 (如实报)")

    if write:
        _atomic_write(pool_dir / "completeness" / f"{AXIS}_axis.json", r)
    return r


def _main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="BSP 盲区传感器: 树外造问 → 五轴门过滤 (REQ-022)")
    ap.add_argument("--campaign", required=True, help="campaign_id (如 EPC-BID26)")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--dry", action="store_true", help="只算不写")
    ns = ap.parse_args(argv)
    try:
        r = scan(ns.campaign, Path(ns.pool_root), write=not ns.dry)
    except ValueError as e:
        print(f"[BSP] 错误: {e}", file=sys.stderr)
        return 1
    print(f"[BSP] {r['cid']}: 候选 {len(r['candidates'])} "
          f"(过门 {r['passed_count']} / 未过 {r['failed_count']}) | "
          f"green {'✅' if r['green'] else '❌'} (门槛 ≥{BSP_GREEN_MIN})")
    for c in r["candidates"]:
        mark = "✅" if c["gate"]["passed"] else "❌"
        g = c["gate"]
        print(f"[BSP] {mark} [{c['source_domain']}] hits={c['evidence_hits']} "
              f"门T{int(g['T'])}B{int(g['B'])}D{int(g['D'])}"
              f"P{int(g['P'])}C{int(g['C'])} {c['candidate_eei'][:52]}")
    for n in r["notes"]:
        print(f"[BSP] ⚠ {n}")
    if not ns.dry:
        print(f"[BSP] 落盘: {Path(ns.pool_root) / ns.campaign / 'completeness' / 'BSP_axis.json'}")
    # 退出码: 0=全候选过五轴门且 green / 2=有未过门或 green 未达 (树缺失亦 2)
    ok = r["green"] and r["failed_count"] == 0
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(_main())
