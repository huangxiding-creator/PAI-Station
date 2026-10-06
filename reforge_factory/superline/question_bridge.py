# -*- coding: utf-8 -*-
"""question_bridge — manus_outline_v1 → question_tree_v2 问题桥 (断言链 W2-1).

背景 (PROPOSAL.md §一 缺口③): 树 v1 由 SUBQ_TEMPLATES 模板生成 (60 问/维),
Manus v3 的企业特定 question/sub_questions 被 manus_outline_adapter 丢弃
(sub_questions 只进 volume_ref 计数) — 两套半焊系统的断点.

本件把企业特定问题直接接进树世界:
  - 每章 question → 章 dim; 每条 sub_question → 子问题 (可证伪性审查);
  - 每子问题 → 三腿 EEI (正/反/权威, 复用 G1.eei_for — M1 四维查询词同源);
  - ACH 假设层强制点火: ≥3 假设非空 + Heuer 规则随树落盘 (只数 I 排序/
    仅正面反证判死/全假设相对可能性呈报) — ach_arena 可直接吃;
  - 只增不删: 落 question_tree_v2.json sidecar, 绝不触碰 v1 树.

输入二选一: --md (Manus 输出 md, 走 MOA.extract_outline — sub_questions
保真) / --framework (framework.json, sub_questions 已丢 → 章问题自身降级
为唯一子问题, 警示留痕).

用法 (reforge_factory 根, PYTHONPATH=.):
  python superline/question_bridge.py --md <manus输出.md> \
      --campaign-id EPC51-HAISUM --report-title 《…》 [--dry-run]
  python superline/question_bridge.py --framework <framework.json> \
      --campaign-id EPC51-HAISUM
"""
from __future__ import annotations

import ast
import json
import sys
import time
from pathlib import Path

import superline as _sl
from superline import manus_outline_adapter as MOA

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import question_tree as G1                     # noqa: E402  (三腿 EEI 同源)

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# Heuer ACH 规则随树落盘 (ach_arena 升级位 W4 接管; 树先带规则不动原件)
ACH_RULES = {
    "ranking": "count-I-only",                 # 排序只数不一致项, 禁止加号计分
    "death": "positive-counter-evidence-only",  # 仅正面反证判死, 无证据≠证伪
    "report": "all-hypotheses-relative-likelihood",  # 终稿须呈报全部假设相对可能性
    "source": "Heuer Psychology of Intelligence Analysis ch.8 (1999)",
}


def _subq_rows(chs: list[dict], full: str, short: str
               ) -> tuple[list[dict], list[str]]:
    """章×sub_question → 子问题行 (每行自带三腿 EEI). 返回 (行, 警示)."""
    rows: list[dict] = []
    warns: list[str] = []
    sid = 0
    for ch in chs:
        no = int(ch.get("no") or 0)
        title = (ch.get("title") or "").strip() or f"ch{no:02d}"
        subs = [s.strip() for s in (ch.get("sub_questions") or [])
                if isinstance(s, str) and s.strip()]
        if not subs:
            q = (ch.get("question") or ch.get("description") or "").strip()
            if q:
                subs = [q]
                warns.append(f"ch{no:02d} 无 sub_questions → 章问题自身降级 "
                             f"为唯一子问题 (framework 输入形态)")
        for sub in subs:
            sid += 1
            ok, note = G1.falsifiable_check(sub)
            sid_str = f"M{no:02d}-{sid:03d}"
            eeis = G1.eei_for(sub, short, full)
            for i, e in enumerate(eeis, 1):
                e["id"] = f"{sid_str}E{i}"
                e["status"] = "zero"           # 运行时由 coverage 更新
            rows.append({"id": sid_str, "dim": title, "chapter_no": no,
                         "text": sub, "falsifiable": ok,
                         "falsify_note": note, "eeis": eeis})
    return rows, warns


def _hypotheses(topic: str) -> list[dict]:
    """ACH 假设层点火: G1 种子 (扩张/恶化/分化) × Heuer 规则字段."""
    out = []
    for h in G1.HYPOTHESIS_SEEDS:
        out.append({"id": h["id"], "text": h["text"].format(s=topic),
                    "prior": h["prior"], "status": "alive"})
    return out


def bridge(outline: dict, campaign_id: str, report_title: str
           ) -> tuple[dict, list[str]]:
    """manus_outline_v1 → question_tree_v2 (确定性; 返回 (树, 警示))."""
    if not isinstance(outline, dict) or outline.get("schema") != MOA.SCHEMA_IN:
        raise ValueError(f"schema 非法: {outline.get('schema')!r} "
                         f"(须 {MOA.SCHEMA_IN}, 回炉重出不兜底)")
    chs = outline.get("chapters")
    if not isinstance(chs, list) or not chs:
        raise ValueError("chapters 缺失或为空")
    ent = outline.get("enterprise") or {}
    full = ent.get("full", "")
    short = ent.get("short", "") or full
    topic = report_title.strip("《》 ").strip() or f"{full} 研究报告"
    rows, warns = _subq_rows(chs, full, short)
    if not rows:
        raise ValueError("章问题与 sub_questions 全空 — 坏件回 Manus 重出")
    tree = {
        "campaign": campaign_id, "topic": topic, "region": short,
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "engine": f"question_bridge v1 (superline {_sl.__version__})",
        "provenance": {"schema_in": MOA.SCHEMA_IN,
                       "chapters": len(chs),
                       "note": "企业特定问题入树, 替代 SUBQ_TEMPLATES 模板位"},
        "loop_policy": "M3 增量生长: 小批采→即时判挂树→按 coverage 缺口补下批",
        "ach_rules": dict(ACH_RULES),
        "hypotheses": _hypotheses(topic),
        "subquestions": rows,
        "stats": {"subquestions": len(rows),
                  "unfalsifiable": sum(0 if r["falsifiable"] else 1
                                       for r in rows),
                  "eeis": sum(len(r["eeis"]) for r in rows),
                  "queries": sum(len(e["queries"]) for r in rows
                                 for e in r["eeis"]),
                  "chapters": len(chs)},
    }
    return tree, warns


def from_framework(fw: dict) -> dict:
    """framework_v1 → manus_outline_v1 形态 (sub_questions 已丢, 章问题降级)."""
    if fw.get("schema") != "framework_v1":
        raise ValueError(f"schema 非法: {fw.get('schema')!r}")
    ent_full = ent_short = ""
    for c in fw.get("chapters", []):
        for w in (c.get("tier_map") or {}).get("T1", []):
            if w and not ent_full:
                ent_full = w
            elif w and w != ent_full and not ent_short:
                ent_short = w
    return {"schema": MOA.SCHEMA_IN,
            "report_title": fw.get("report_title", ""),
            "enterprise": {"full": ent_full, "short": ent_short,
                           "industry": "", "group": ""},
            "chapters": [{"no": i + 1,
                          "title": c.get("title", ""),
                          "question": c.get("description", ""),
                          "sub_questions": [],
                          "search_terms": c.get("search_terms", {})}
                         for i, c in enumerate(fw.get("chapters", []))]}


def build(md_path: str = "", framework_path: str = "", campaign_id: str = "",
          report_title: str = "", pool_root: Path = POOL_ROOT,
          dry_run: bool = False) -> dict:
    """输入二选一 → 树 v2 sidecar 落盘 (只增不删, 绝不写 v1)."""
    if bool(md_path) == bool(framework_path):
        raise ValueError("--md 与 --framework 恰好给一个")
    if md_path:
        outline = MOA.extract_outline(
            Path(md_path).read_text(encoding="utf-8"))
        src = md_path
    else:
        fw = json.loads(Path(framework_path).read_text(encoding="utf-8"))
        outline = from_framework(fw)
        src = framework_path
    title = report_title or outline.get("report_title", "")
    tree, warns = bridge(outline, campaign_id, title)
    out = pool_root / campaign_id / "question_tree_v2.json"
    if not dry_run:
        out.parent.mkdir(parents=True, exist_ok=True)
        tree["provenance"]["source"] = str(src)
        out.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                       encoding="utf-8")
    return {"tree": tree, "warnings": warns, "out": str(out),
            "dry_run": dry_run}


def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(
        description="manus_outline_v1/framework_v1 → question_tree_v2 问题桥")
    ap.add_argument("--md", default="", help="Manus 输出 md (sub_questions 保真)")
    ap.add_argument("--framework", default="",
                    help="framework.json (sub_questions 已丢, 章问题降级)")
    ap.add_argument("--campaign-id", required=True)
    ap.add_argument("--report-title", default="")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args(argv)
    r = build(args.md, args.framework, args.campaign_id,
              args.report_title, Path(args.pool_root), args.dry_run)
    t = r["tree"]
    print(f"[qb] superline {_sl.__version__} 问题桥 (断言链 W2-1: "
          f"企业问题入树 + ACH 点火)")
    for w in r["warnings"]:
        print(f"[qb] ⚠ {w}")
    print(f"[qb] {t['stats']['chapters']} 章 → {t['stats']['subquestions']} "
          f"子问题 / {t['stats']['eeis']} EEI (三腿) / "
          f"{t['stats']['queries']} 查询词 | 不可证伪 "
          f"{t['stats']['unfalsifiable']} (标记待改写, 不删)")
    print(f"[qb] ACH 假设 {len(t['hypotheses'])} 条 alive | 规则 "
          f"{t['ach_rules']['ranking']}/{t['ach_rules']['death']}")
    print(f"[qb] {'dry-run' if r['dry_run'] else '落盘 ' + r['out']} "
          f"(v1 树零触碰)")
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
                         "socket"}), f"qb 禁网络根模块: {_mods}"
    sys.exit(main())
