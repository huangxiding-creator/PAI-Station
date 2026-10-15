# -*- coding: utf-8 -*-
"""PRESS 式检索计划独立评议件生成器 (T-016 / REQ-027).

REQ-027: 当战役检索计划生成后开火前, 系统应经独立会话按 PRESS 2015 清单
(PubMed PMID 27005575 同族) 评议检索式(词矩阵/站点清单/时间窗), 评议记录落盘
`06 运行件 work/press_review_<战役>.md`。

本工具只生成「受评议件」——八项清单每项 {item, plan_evidence, status:
needs_review}, 附「评议人意见」空栏; 真正评议由独立会话执行(运行时纪律,
代码不可替代), 评议结论经 `--record <评议.json>` 追加进 md 留痕(只增不覆盖)。

八项清单 ↔ PRESS 2015 要点映射:
  1. 数据库选择            PRESS: database/source selection
  2. 检索式结构-布尔逻辑    PRESS: boolean logic (AND/OR/NOT 组合)
  3. 检索式结构-字段限定    PRESS: field codes / line-by-line search strategy
  4. 同义词与截词-词矩阵    PRESS: synonym use + truncation & wildcards
  5. 时间窗                PRESS: date limits
  6. 限定与排除            PRESS: limits & restrictions (语种/地域/文献类型)
  7. 可复现性              PRESS: reproducible search strategy
  8. 同行第二人评议        PRESS: peer review by a second searcher

数据源 (全部只读):
  - `ammo_pool/<战役>/tiers.json`        T1/T2(/KWS) 词表 → 词矩阵
  - `ammo_pool/<战役>/pool_state.json`   kws 兜底词表 / 收割窗(created→last_judge) /
                                         限定排除账(字符门/拒收/分层门)
  - `ammo_pool/<战役>/timeline.json`     主题时间跨度(founded_year→current_year)
  - `ammo_pool/<战役>/channel_matrix.json` 渠道命中账(缺席则注明)
  - `ResearchFactory-Eng/channel_manifest.json` 在役站点清单(分母)

CLI:
  py reforge_factory/press_review.py <战役> [--ammo-root DIR] [--manifest PATH]
      [--work-dir DIR] [--out PATH] [--record REVIEW.json]
  战役名接受全名(EPC-BID26)或尾名(BID26), 输出文件名用池目录全名。
  退出码: 0=成; 2=战役池/清单缺席; 3=受评议件已在档拒覆盖(只增);
          4=评议记录件引用不存在的清单项(整段不写入)。
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_AMMO_ROOT = REPO_ROOT / "ammo_pool"
DEFAULT_MANIFEST_PATH = REPO_ROOT / "ResearchFactory-Eng" / "channel_manifest.json"
DEFAULT_WORK_DIR = (REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化"
                    / "百倍V3_极致调研变现计划" / "work")

SENSOR = "press_review"
STATUS = "needs_review"

#: 八项清单 (顺序即 PRESS 评议走查顺序)
ITEM_NAMES = [
    "数据库选择",
    "检索式结构-布尔逻辑",
    "检索式结构-字段限定",
    "同义词与截词-词矩阵",
    "时间窗",
    "限定与排除",
    "可复现性",
    "同行第二人评议",
]

EXIT_OK = 0
EXIT_NO_POOL = 2
EXIT_REFUSE_OVERWRITE = 3
EXIT_BAD_RECORD = 4


# ---- 小工具 ---------------------------------------------------------------

def _read_json(path: Path | str) -> dict:
    p = Path(path)
    if not p.exists():
        raise FileNotFoundError(str(p))
    return json.loads(p.read_text(encoding="utf-8"))


def _clip(seq: list, n: int = 40) -> str:
    """列表渲染: 全列(≤n)否则前 n 个 + …(共 N)。"""
    if not seq:
        return "（空）"
    if len(seq) <= n:
        return "、".join(str(x) for x in seq)
    head = "、".join(str(x) for x in seq[:n])
    return f"{head} …(共 {len(seq)} 项)"


def resolve_campaign(name: str, ammo_root: Path | str | None = None) -> str:
    """战役名 → 池目录全名。接受全名(EPC-BID26)或尾名(BID26, 唯一后缀匹配)。"""
    root = Path(ammo_root) if ammo_root else DEFAULT_AMMO_ROOT
    if (root / name / "tiers.json").exists() or (root / name).is_dir():
        return name
    suffix = name.lower()
    hits = [d.name for d in root.iterdir()
            if d.is_dir() and d.name.lower().endswith("-" + suffix)]
    if len(hits) == 1:
        return hits[0]
    if not hits:
        raise FileNotFoundError(f"ammo_pool 下找不到战役: {name} (root={root})")
    raise FileNotFoundError(f"战役尾名歧义: {name} → {hits} (root={root})")


def find_item(checklist: dict, item: str) -> dict:
    for it in checklist["items"]:
        if it["item"] == item:
            return it
    raise KeyError(f"清单项不存在: {item}")


# ---- 清单生成 ---------------------------------------------------------------

def _word_matrix(camp_dir: Path, pool_state: dict) -> list[dict]:
    """词矩阵: T1/T2(/KWS) 三层, KWS 优先 tiers.json, 兜底 pool_state.kws。"""
    tiers = _read_json(camp_dir / "tiers.json")
    kws = tiers.get("KWS") or pool_state.get("kws") or []
    rows = []
    for tier in ("T1", "T2", "KWS"):
        if tier == "KWS":
            words = [str(w) for w in kws]
            src = ("tiers.json:KWS" if tiers.get("KWS")
                   else "pool_state.json:kws")
        else:
            words = [str(w) for w in tiers.get(tier, [])]
            src = f"tiers.json:{tier}"
        rows.append({"tier": tier, "count": len(words),
                     "words": words, "source": src})
    return rows


def make_checklist(campaign: str, *, ammo_root: Path | str | None = None,
                   manifest_path: Path | str | None = None) -> dict:
    """从战役词表+站点清单+时间窗生成 PRESS 八项受评议清单 (只读)。"""
    root = Path(ammo_root) if ammo_root else DEFAULT_AMMO_ROOT
    full = resolve_campaign(campaign, root)
    camp_dir = root / full
    if not (camp_dir / "tiers.json").exists():
        raise FileNotFoundError(f"战役池缺 tiers.json: {camp_dir}")

    pool_state: dict = {}
    pool_missing = False
    try:
        pool_state = _read_json(camp_dir / "pool_state.json")
    except FileNotFoundError:
        pool_missing = True

    manifest: dict = {}
    manifest_missing = False
    try:
        manifest = _read_json(manifest_path or DEFAULT_MANIFEST_PATH)
    except FileNotFoundError:
        manifest_missing = True

    timeline: dict = {}
    timeline_missing = False
    try:
        timeline = _read_json(camp_dir / "timeline.json")
    except FileNotFoundError:
        timeline_missing = True

    chmatrix: dict = {}
    try:
        chmatrix = _read_json(camp_dir / "channel_matrix.json")
    except FileNotFoundError:
        chmatrix = {}

    wm = _word_matrix(camp_dir, pool_state)
    t1, t2, kws = (next(r for r in wm if r["tier"] == k)["words"]
                   for k in ("T1", "T2", "KWS"))
    by_engine = pool_state.get("by_engine") or {}
    totals = manifest.get("totals") or {}
    named = manifest.get("named_channels") or []
    families = manifest.get("families") or []

    items = [
        {   # 1 数据库选择 — PRESS database selection
            "item": ITEM_NAMES[0],
            "status": STATUS,
            "plan_evidence": {
                "站点清单_在役渠道": [c.get("name", c.get("id", "?")) for c in named],
                "named_channel_ids": [c.get("id", "?") for c in named],
                "站点清单_舰队": [f.get("name", f.get("id", "?")) for f in families],
                "site_endpoints_total": totals.get("site_endpoints", 0),
                "战役已命中渠道": [c.get("name", "") for c in chmatrix.get(
                    "hit_channels", [])] or "（channel_matrix.json 缺席）",
                "清单缺席": manifest_missing,
            },
        },
        {   # 2 布尔逻辑 — PRESS boolean
            "item": ITEM_NAMES[1],
            "status": STATUS,
            "plan_evidence": {
                "结构": "(T1 概念行 OR …) AND (T2 概念行 OR …); KWS 短语组独立执行",
                "T1词数": len(t1), "T2词数": len(t2), "KWS短语数": len(kws),
                "样例检索式": f"({' OR '.join(t1[:8])}{' …' if len(t1) > 8 else ''})"
                              f" AND ({' OR '.join(t2[:6])}{' …' if len(t2) > 6 else ''})",
                "NOT 排除项声明": "未显式声明 → 待评议",
            },
        },
        {   # 3 字段限定 — PRESS field codes
            "item": ITEM_NAMES[2],
            "status": STATUS,
            "plan_evidence": {
                "现状": "全文级收割 + head3000 词表归层, 无统一字段限定声明(标题/摘要/正文未分字段)",
                "分层归层规则": pool_state.get("tier_note", "（pool_state 缺席）"),
                "已用引擎标签": sorted(by_engine.keys()),
                "引擎账缺席": pool_missing,
            },
        },
        {   # 4 同义词与截词 — PRESS synonyms & truncation (词矩阵)
            "item": ITEM_NAMES[3],
            "status": STATUS,
            "plan_evidence": {
                "word_matrix": wm,
                "截词与通配符策略": "未显式声明 → 待评议",
            },
        },
        {   # 5 时间窗 — PRESS date limits
            "item": ITEM_NAMES[4],
            "status": STATUS,
            "plan_evidence": {
                "harvest_window": {
                    "available": not pool_missing,
                    "created": pool_state.get("created", "（pool_state 缺席）"),
                    "last_judge": pool_state.get("last_judge", "（pool_state 缺席）"),
                },
                "subject_span": {
                    "available": not timeline_missing,
                    "founded_year": timeline.get("founded_year", "（timeline.json 缺席）"),
                    "current_year": timeline.get("current_year", "（timeline.json 缺席）"),
                },
                "date_limit_declared": False,
                "声明状态": "收割窗≠检索日期限定; 显式日期限定未声明 → 待评议",
            },
        },
        {   # 6 限定与排除 — PRESS limits & restrictions
            "item": ITEM_NAMES[5],
            "status": STATUS,
            "plan_evidence": {
                "字符门 gate_chars": pool_state.get("gate_chars", "（pool_state 缺席）"),
                "拒收账": {"rejected_items": pool_state.get("rejected_items", 0),
                            "rejected_chars": pool_state.get("rejected_chars", 0)},
                "分层门规则": (pool_state.get("tier_gate_v3") or {}).get(
                    "rule", "（pool_state 缺席）"),
                "语种限定": "未显式声明", "地域限定": "未显式声明",
                "文献类型限定": "未显式声明 → 三项待评议",
            },
        },
        {   # 7 可复现性 — PRESS reproducibility
            "item": ITEM_NAMES[6],
            "status": STATUS,
            "plan_evidence": {
                "词表源": str(camp_dir / "tiers.json"),
                "池账源": str(camp_dir / "pool_state.json"),
                "站点清单源": str(manifest_path or DEFAULT_MANIFEST_PATH),
                "检索式独立落盘": "否(散见于渠道 runner/词表) → 待评议",
                "复跑入口": "各渠道 runner 见 channel_manifest named_channels[].runner",
            },
        },
        {   # 8 同行第二人评议 — PRESS peer review
            "item": ITEM_NAMES[7],
            "status": STATUS,
            "plan_evidence": {
                "评议协议": "独立会话按本清单逐项走查后填写评议人意见与结论; "
                            "生成器会话不得自评(运行时纪律)",
                "留痕命令": f"py reforge_factory/press_review.py {full} --record 评议.json",
                "本件状态": "受评议件(生成即待评议, 非评议结论)",
            },
        },
    ]

    return {
        "sensor": SENSOR,
        "campaign": full,
        "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
        "press_basis": "PRESS 2015 (PubMed PMID 27005575 同族)",
        "items": items,
    }


# ---- 渲染 -------------------------------------------------------------------

def _ev_lines(ev: dict, indent: str = "") -> list[str]:
    """plan_evidence → markdown 行; word_matrix 出表格, 嵌套 dict 出子弹。"""
    lines = []
    for k, v in ev.items():
        if k == "word_matrix":
            lines.append(f"{indent}- **{k}**:")
            lines.append("")
            lines.append(f"{indent}| 层 | 词数 | 词表 | 词表源 |")
            lines.append(f"{indent}|----|------|------|--------|")
            for row in v:
                words = "、".join(row["words"][:80]) + (
                    f" …(共 {row['count']} 词)" if row["count"] > 80 else "")
                lines.append(f"{indent}| {row['tier']} | {row['count']} "
                             f"| {words or '（空）'} | {row['source']} |")
            lines.append("")
        elif isinstance(v, dict):
            lines.append(f"{indent}- **{k}**:")
            for k2, v2 in v.items():
                lines.append(f"{indent}  - {k2}: {_clip(v2) if isinstance(v2, list) else v2}")
        elif isinstance(v, list):
            lines.append(f"{indent}- {k}: {_clip(v)}")
        else:
            lines.append(f"{indent}- {k}: {v}")
    return lines


def render_md(checklist: dict) -> str:
    """八项清单 → press_review_<战役>.md 受评议件模板 (逐项带评议人意见空栏)。"""
    out: list[str] = [
        f"# PRESS 式检索计划独立评议件 — {checklist['campaign']}",
        "",
        f"- 生成时间: {checklist['generated_at']}",
        f"- 评议基准: {checklist['press_basis']}",
        "- 件性: 本件由工具生成, 是**受评议件**; 评议由**独立会话**执行"
        "(生成器会话不得自评), 结论经 `--record` 追加留痕。",
        "",
        "## 清单概览",
        "",
        "| # | 清单项 | PRESS 要点 | 状态 |",
        "|---|--------|-----------|------|",
        "| 1 | 数据库选择 | database/source selection | needs_review |",
        "| 2 | 检索式结构-布尔逻辑 | boolean logic | needs_review |",
        "| 3 | 检索式结构-字段限定 | field codes | needs_review |",
        "| 4 | 同义词与截词-词矩阵 | synonym + truncation | needs_review |",
        "| 5 | 时间窗 | date limits | needs_review |",
        "| 6 | 限定与排除 | limits & restrictions | needs_review |",
        "| 7 | 可复现性 | reproducible strategy | needs_review |",
        "| 8 | 同行第二人评议 | peer review (2nd searcher) | needs_review |",
        "",
        "---",
        "",
    ]
    for i, it in enumerate(checklist["items"], 1):
        out += [
            f"## {i}. {it['item']}",
            "",
            "**当前检索计划证据 (plan_evidence)**:",
            "",
        ]
        out += _ev_lines(it["plan_evidence"])
        out += [
            "",
            f"- 状态: {it['status']}",
            "",
            "**评议人意见**: ______________________",
            "",
            "**结论**: （空 — 通过 / 修改后通过 / 不通过）",
            "",
            "---",
            "",
        ]
    out += [
        "## 总评议结论",
        "",
        "（空 — 由独立会话评议后经 --record 追加）",
        "",
    ]
    return "\n".join(out)


# ---- 评议记录追加 (只增不覆盖) --------------------------------------------------

def record_review(md_path: Path, checklist: dict, record: dict) -> str:
    """把独立会话的评议意见追加进 md (原文保留)。引用不存在的清单项 → 整段拒写。"""
    name_to_idx = {it["item"]: i for i, it in enumerate(checklist["items"], 1)}
    rows = []
    problems = []
    for rec in record.get("items", []):
        if rec.get("item"):
            key, idx = rec["item"], name_to_idx.get(rec["item"])
        elif rec.get("index"):
            idx = int(rec["index"])
            key = checklist["items"][idx - 1]["item"] if 1 <= idx <= 8 else None
        else:
            problems.append(f"（既无 item 也无 index）: {rec}")
            continue
        if idx is None:
            problems.append(f"清单项不存在: {rec.get('item') or rec.get('index')}")
            continue
        comment = str(rec.get("comment", "")).replace("\n", " ").replace("|", "\\|")
        rows.append((idx, key, str(rec.get("verdict", "（未填）")), comment))
    if problems:
        raise ValueError("评议记录引用无效: " + "; ".join(problems))

    ts = datetime.now().astimezone().isoformat(timespec="seconds")
    section = [
        "",
        "---",
        "",
        f"## 评议记录 {ts}",
        "",
        f"- 评议人: {record.get('reviewer', '（未署名）')}",
        "- 评议会话: 独立会话 (非生成器会话)",
        "",
        "| # | 清单项 | 结论 | 评议意见 |",
        "|---|--------|------|----------|",
    ]
    section += [f"| {i} | {name} | {v} | {c} |" for i, name, v, c in rows]
    section += ["", f"（共 {len(rows)} 项已评议, 追加只增不覆盖原文）", ""]

    text = md_path.read_text(encoding="utf-8")
    if not text.endswith("\n"):
        text += "\n"
    md_path.write_text(text + "\n".join(section), encoding="utf-8", newline="\n")
    return "\n".join(section)


# ---- CLI ---------------------------------------------------------------------

def main(argv: list[str] | None = None) -> int:
    try:
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass
    ap = argparse.ArgumentParser(
        description="PRESS 式检索计划独立评议件生成器 (REQ-027; 只读战役池, 输出只增)")
    ap.add_argument("campaign", help="战役名, 全名(EPC-BID26)或尾名(BID26)")
    ap.add_argument("--ammo-root", default=None, help="ammo_pool 根 (默认仓库默认)")
    ap.add_argument("--manifest", default=None, help="channel_manifest.json 路径覆盖")
    ap.add_argument("--work-dir", default=None,
                    help="受评议件输出目录 (默认 V3 计划 work/)")
    ap.add_argument("--out", default=None, help="输出 md 全路径覆盖")
    ap.add_argument("--record", default=None,
                    help="评议.json {reviewer, items:[{item|index, verdict, comment}]}"
                         " — 追加进已在档 md, 不覆盖原文")
    args = ap.parse_args(argv)

    try:
        checklist = make_checklist(args.campaign, ammo_root=args.ammo_root,
                                   manifest_path=args.manifest)
    except FileNotFoundError as e:
        print(f"[PRESS] FAIL {e}", file=sys.stderr)
        return EXIT_NO_POOL

    out_path = (Path(args.out) if args.out else
                Path(args.work_dir) / f"press_review_{checklist['campaign']}.md"
                if args.work_dir else
                DEFAULT_WORK_DIR / f"press_review_{checklist['campaign']}.md")

    if args.record:
        if not out_path.exists():
            print(f"[PRESS] FAIL 受评议件不在档, 先生成再评议: {out_path}",
                  file=sys.stderr)
            return EXIT_BAD_RECORD
        try:
            record = _read_json(args.record)
        except FileNotFoundError as e:
            print(f"[PRESS] FAIL 评议记录读不到 {e}", file=sys.stderr)
            return EXIT_BAD_RECORD
        try:
            record_review(out_path, checklist, record)
        except ValueError as e:
            print(f"[PRESS] FAIL {e}", file=sys.stderr)
            return EXIT_BAD_RECORD
        print(f"[PRESS] 评议记录已追加(只增): {out_path}")
        return EXIT_OK

    if out_path.exists():                       # 只增纪律: 已在档拒覆盖
        print(f"[PRESS] FAIL 受评议件已在档, 拒覆盖(只增; 评议走 --record): {out_path}",
              file=sys.stderr)
        return EXIT_REFUSE_OVERWRITE

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(render_md(checklist), encoding="utf-8", newline="\n")
    print(f"[PRESS] 受评议件落盘: {out_path} ({len(checklist['items'])} 项待独立评议)")
    return EXIT_OK


if __name__ == "__main__":
    raise SystemExit(main())
