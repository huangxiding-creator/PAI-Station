# -*- coding: utf-8 -*-
"""manus_outline_adapter — manus_outline_v1 → framework_v1 摄取适配器.

新范式「框架驱动调研」的接线件 (用户 1006 令):
  报告名 → Manus (v3 提示词) → 目录框架 manus_outline_v1
        → 本件转换 → framework_v1 (validate 零错才落盘)
        → S1-1 之后的既有链 (S1-2 scout → 呈审门 → S2 章级分档采集)
替代旧流「报告名 → 关键词 → 检索」—— 词表仍由 S0-2 tier_expander
产出 (T1 实体六槽), 但采集目标与验收标准来自框架章级调研指令。

映射规则 (与 framework_gen 同构, 不另立山头):
  - budget_band: 首尾章 outline_wide / 标题含 对标·竞争·格局 → gap /
    其余 section_narrow (framework_gen._role 同款)
  - channels: outline_wide→[stock_harvest, current_increment, on_demand]
    section_narrow→[current_increment, on_demand] / gap→[on_demand]
    (EPC50 实测框架同款组合)
  - tier_map: T1 = tiers.json T1 轮转切片 ∪ [企业全称, 简称];
    对标章补 T2 = tiers.json T2[:4]; T3 = outline 检索词中含
    EPC/总承包 的行为词 [:3], 无则兜底 ["EPC总承包", "工程总承包"]
  - evidence_density: outline 值; high/medium 而 recon_sources 空 →
    强制降 low (S1-2 纪律: 无侦察据只准 low), 降级绝不静默
    (moa_ledger.jsonl 入账)
  - 透传: question→description / search_terms (S2 派单种子) /
    differentiation / recon_sources→scout_hits
校验失败硬拒不兜底 (坏件回 Manus 重出, 不走 S1-3 降级——降级只对
本地规则件; 外部生成件降级 = 三段默认框架抹掉全部调研指令, 无意义)。

用法:
  python manus_outline_adapter.py --md <manus输出.md> \
      --campaign-id EPC51-HAISUM --report-title 《…》 \
      [--tiers tiers.json] [--out battle/00 研究报告需求/framework.json]
      [--dry-run]
"""
from __future__ import annotations

import ast
import json
import re
import sys
import time
from pathlib import Path

import superline as _sl
from superline import contracts as C

SCHEMA_IN = "manus_outline_v1"
BEHAVIOR_HINTS = ("EPC", "总承包")
T3_FALLBACK = ["EPC总承包", "工程总承包"]
ROLES = ("intro", "core", "benchmark", "outro")
CHANNELS_BY_BAND = {
    "outline_wide": ["stock_harvest", "current_increment", "on_demand"],
    "section_narrow": ["current_increment", "on_demand"],
    "gap": ["on_demand"],
}
BENCH_KEYS = ("对标", "竞争", "格局")

_JSON_RE = re.compile(r"```json\s*(\{.*?\})\s*```", re.DOTALL)


# ---------------------------------------------------------------- 摄取
def extract_outline(md_text: str) -> dict:
    """从 Manus 输出 md 中抽取 manus_outline_v1 JSON 块 (硬拒其他块)."""
    for m in _JSON_RE.finditer(md_text):
        try:
            obj = json.loads(m.group(1))
        except json.JSONDecodeError:
            continue
        if isinstance(obj, dict) and obj.get("schema") == SCHEMA_IN:
            return obj
    raise ValueError(
        f"未找到 {SCHEMA_IN} JSON 块 — Manus 输出不合 v3 契约 (回炉重出, "
        f"不兜底: 外部件降级会抹掉章级调研指令)")


# ---------------------------------------------------------------- 映射 (同构 framework_gen)
def _band(no: int, n: int, title: str, role: str = "") -> str:
    """显式 role 优先 (Manus 声明章职责), 标题关键词只作兜底 —
    『拥挤与空隙』类不带对标字眼的 benchmark 章不靠猜 (1006 冒烟实坑)."""
    if role == "benchmark":
        return "gap"
    if role in ("intro", "outro") or no == 1 or no >= n:
        return "outline_wide"
    if any(k in title for k in BENCH_KEYS):
        return "gap"
    return "section_narrow"


def _t1_slice(t1_pool: list[str], idx: int, n: int) -> list[str]:
    """章级 T1 轮转切片 (framework_gen._tier_map 同款确定性)."""
    if not t1_pool:
        return []
    if idx == 0 or idx >= n - 1:
        return t1_pool[:3]
    pool = t1_pool[3:] or t1_pool
    k = max(2, len(pool) // max(1, n - 2))
    start = (idx - 1) * k % len(pool)
    return pool[start:start + k] or pool[:2]


def _t3_from_terms(terms_zh: list[str]) -> list[str]:
    hit = [w for w in terms_zh if any(h in w for h in BEHAVIOR_HINTS)]
    return (hit or T3_FALLBACK)[:3]


def _dedup(seq: list[str]) -> list[str]:
    seen, out = set(), []
    for x in seq:
        if x and x not in seen:
            seen.add(x)
            out.append(x)
    return out


def convert(outline: dict, campaign_id: str, report_title: str,
            tiers: dict | None = None) -> tuple[dict, list[str]]:
    """manus_outline_v1 → framework_v1 (确定性; 返回 (框架, 降级警示表))."""
    if not isinstance(outline, dict) or outline.get("schema") != SCHEMA_IN:
        raise ValueError(f"schema 非法: {outline.get('schema')!r} (须 {SCHEMA_IN})")
    chs_in = outline.get("chapters")
    if not isinstance(chs_in, list) or not chs_in:
        raise ValueError("chapters 缺失或为空")
    ent = outline.get("enterprise") or {}
    full, short = ent.get("full", ""), ent.get("short", "")
    t1_pool = C.tier_words(tiers or {}, "T1")
    t2_pool = C.tier_words(tiers or {}, "T2")
    n = len(chs_in)
    warnings: list[str] = []
    chapters = []
    for i, cin in enumerate(chs_in):
        no = int(cin.get("no", i + 1))
        title = (cin.get("title") or "").strip()
        role = cin.get("role") or ""
        if role and role not in ROLES:
            warnings.append(f"ch{no:02d} role 非法 {role!r} 忽略 "
                            f"(值域 {ROLES})")
            role = ""
        st = (cin.get("search_terms") or {}).get("zh") or []
        band = _band(no, n, title, role)
        tm: dict[str, list[str]] = {"T1": _dedup(
            _t1_slice(t1_pool, i, n) + [full, short])}
        if band == "gap" and t2_pool:
            tm["T2"] = t2_pool[:4]
        tm["T3"] = _t3_from_terms(st)
        dens = cin.get("evidence_density") or "low"
        hits = [u for u in (cin.get("recon_sources") or [])
                if isinstance(u, str) and u.strip()]
        if dens in ("high", "medium") and not hits:
            warnings.append(
                f"ch{no:02d} 密度 {dens} 无侦察 URL → 强制降 low "
                f"(S1-2 纪律: 无侦察据只准 low)")
            dens = "low"
        chapters.append({
            "id": f"ch{no:02d}", "title": title,
            "description": cin.get("question") or "",
            "tier_map": tm,
            "channels": list(CHANNELS_BY_BAND[band]),
            "budget_band": band,
            "evidence_density": dens,
            "scout_hits": hits,
            "search_terms": {"zh": st,
                             "en": (cin.get("search_terms") or {}).get("en", [])},
            "differentiation": cin.get("differentiation", ""),
            "target_chars": int(cin.get("target_chars") or 0),
        })
    sections = sum(len(c.get("sections") or []) for c in chs_in)
    total = sum(c["target_chars"] for c in chapters)
    fw = {
        "schema": "framework_v1",
        "campaign_id": campaign_id,
        "report_title": report_title,
        "family": "enterprise",
        "version": 1,
        "chapters": chapters,
        "volume_ref": {"chapters": n, "sections": sections,
                       "total_chars": total},
        "generated_by": (f"manus_outline_adapter (manus_outline_v1 → "
                         f"framework_v1) superline {_sl.__version__}"),
    }
    return fw, warnings


def _log_ingest(out_path: Path, event: str, **kw) -> None:
    """变更零静默: 摄取/降级/拒收 全入 battle/_pipeline/moa_ledger.jsonl."""
    pipe = out_path.parent.parent / "_pipeline"
    try:
        pipe.mkdir(parents=True, exist_ok=True)
        with (pipe / "moa_ledger.jsonl").open("a", encoding="utf-8") as f:
            f.write(json.dumps(
                {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "event": event,
                 **kw}, ensure_ascii=False) + "\n")
    except OSError:
        pass                                   # 留痕 best-effort, 拒收仍硬


def ingest(md_path: str, campaign_id: str, report_title: str,
           tiers_path: str | None = None, out_path: str | None = None,
           dry_run: bool = False) -> dict:
    """MD → 框架 (validate 零错才落盘). 返回 {ok, errors, warnings, fw}."""
    text = Path(md_path).read_text(encoding="utf-8")
    outline = extract_outline(text)
    tiers = None
    if tiers_path:
        tiers = json.loads(Path(tiers_path).read_text(encoding="utf-8"))
    fw, warnings = convert(outline, campaign_id, report_title, tiers)
    errs = C.validate_framework(fw)
    done, total_ch = C.route_completeness(fw)
    result = {"ok": not errs, "errors": errs, "warnings": warnings,
              "chapters": total_ch, "routes_done": done, "framework": fw}
    if errs:
        if out_path and not dry_run:
            _log_ingest(Path(out_path), "rejected", campaign_id=campaign_id,
                        errors=errs[:5])
        return result
    if out_path and not dry_run:
        p = Path(out_path)
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(fw, ensure_ascii=False, indent=1),
                     encoding="utf-8")
        _log_ingest(p, "ingested", campaign_id=campaign_id,
                    chapters=total_ch, routes_done=done,
                    density_downgrades=[w.split(" ")[0] for w in warnings],
                    source_md=str(md_path))
    return result


# ---------------------------------------------------------------- CLI
def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(
        description="manus_outline_v1 → framework_v1 摄取适配器")
    ap.add_argument("--md", required=True, help="Manus 输出 md 路径")
    ap.add_argument("--campaign-id", required=True)
    ap.add_argument("--report-title", required=True)
    ap.add_argument("--tiers", default="", help="可选: S0-2 tiers.json")
    ap.add_argument("--out", default="", help="framework.json 落盘位")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args(argv)
    print(f"[moa] superline {_sl.__version__} 目录框架摄取 "
          f"(范式: 框架驱动调研)")
    r = ingest(args.md, args.campaign_id, args.report_title,
               args.tiers or None, args.out or None, args.dry_run)
    for w in r["warnings"]:
        print(f"[moa] ⚠ {w}")
    if not r["ok"]:
        print(f"[moa] ❌ 校验 {len(r['errors'])} 错, 硬拒不落盘 "
              f"(坏件回 Manus 重出):")
        for e in r["errors"][:10]:
            print(f"    - {e}")
        return 1
    vol = r["framework"]["volume_ref"]
    print(f"[moa] ✅ {r['chapters']} 章 / 路由齐备 {r['routes_done']}/"
          f"{r['chapters']} / 字数当量 {vol['total_chars']:,} "
          f"({vol['sections']} 节)")
    if args.out and not args.dry_run:
        print(f"[moa] 落盘 {args.out}")
    return 0


if __name__ == "__main__":
    # ast 零网络机检: 网络根模块禁入 (纯本地转换件)
    _mods = set()
    for _n in ast.walk(ast.parse(Path(__file__).read_text(encoding="utf-8"))):
        if isinstance(_n, ast.Import):
            _mods.update(a.name.split(".")[0] for a in _n.names)
        elif isinstance(_n, ast.ImportFrom) and _n.module:
            _mods.add(_n.module.split(".")[0])
    assert not (_mods & {"urllib", "requests", "httpx", "curl_cffi",
                         "socket"}), f"moa 禁网络根模块: {_mods}"
    sys.exit(main())
