# -*- coding: utf-8 -*-
"""charts_gate — 数据表先行门 (断言链 W5-3; P1-3 先图后文产前门升级).

合同2: 「数据表为一等证据单元 — 数字先成表 (表号/口径/时点/来源文档锚),
终稿数字 100% 表锚 (own_calculations 前移到采集期)」.

病理 (RQS r50 复盘): 数字后验拼装=跨格幻影对+口径不可比; 本件把数字
生产顺序倒过来 — 采集期先落 tables.json 登记簿 (每表: 表号/口径/时点/
来源文档锚+行列表), 撰写期只许从表里取数, 终稿机检:

  覆盖判据: 正文句里的数字+单位 token, 须 (a) 命中某登记表单元格
  (去空白包含匹配) 或 (b) 所在句带 [[T:表号]] 行级锚; 未覆盖数字即
  「无表锚数字」→ FAIL 清单 (机检锚: 终稿数字 100% 表锚).

登记簿校验: 每表 caption/口径/时点/source_docs (文档锚, 对
doc_registry.json 短号) /columns/rows 六件齐备 — 缺一即登记不全.

产出 (只增不删, sidecar 落盘原账零改动):
  <pool>/<cid>/tables.json       数据表登记簿 (采集期产物)
  <pool>/<cid>/charts_gate.json  终稿数字表锚机检报告

用法 (reforge_factory 根):
  PYTHONPATH=. python superline/charts_gate.py --campaign-id EPC50-SNEI \
      --draft superline/replay_out_charter/EPC50-SNEI/claim_ledger_replay.md
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from superline.task_ledger import (                # noqa: E402  (W3 同源)
    NUM_UNIT_RE, SENT_SPLIT_RE, _clean_line)

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
COVERAGE_GATE = 1.0                                 # 终稿数字 100% 表锚
ANCHOR_RE = re.compile(r"\[\[T:([A-Za-z0-9_,\-]+)\]\]")


# ---------------------------------------------------------- 登记簿校验

def validate_tables(tables: list[dict],
                    known_doc_ids: set[str] | None = None) -> list[str]:
    """数据表登记簿六件套校验 (caption/口径/时点/来源锚/列/行)."""
    errs: list[str] = []
    if not tables:
        return ["tables 登记簿为空 (数据表先行: 采集期必须先落表)"]
    seen: set[str] = set()
    for i, t in enumerate(tables):
        tid = str(t.get("table_id") or "")
        if not tid:
            errs.append(f"tables[{i}].table_id 缺失")
        elif tid in seen:
            errs.append(f"tables[{i}].table_id 重复: {tid}")
        else:
            seen.add(tid)
        for k in ("caption", "口径", "时点"):
            if not str(t.get(k) or "").strip():
                errs.append(f"tables[{i}({tid})].{k} 缺失")
        srcs = t.get("source_docs")
        if not isinstance(srcs, list) or not srcs:
            errs.append(f"tables[{i}({tid})].source_docs 缺失 (来源文档锚)")
        elif known_doc_ids is not None:
            ghost = [s for s in srcs if s not in known_doc_ids]
            if ghost:
                errs.append(f"tables[{i}({tid})].source_docs 未落账: {ghost}")
        cols, rows = t.get("columns"), t.get("rows")
        if not isinstance(cols, list) or not cols:
            errs.append(f"tables[{i}({tid})].columns 缺失")
        if not isinstance(rows, list) or not rows:
            errs.append(f"tables[{i}({tid})].rows 缺失")
        elif isinstance(cols, list):
            for j, r in enumerate(rows):
                if not isinstance(r, list) or len(r) != len(cols):
                    errs.append(f"tables[{i}({tid})].rows[{j}] 列数 "
                                f"≠ columns ({len(r) if isinstance(r, list) else '?'}/"
                                f"{len(cols)})")
    return errs


# ---------------------------------------------------------- 数字表锚覆盖

def _norm(s: str) -> str:
    return re.sub(r"[\s,，]", "", str(s))


def _cell_blob(tables: list[dict]) -> list[tuple[str, str]]:
    """(表号, 全表单元格规范化拼接) 列表 — 包含匹配底."""
    out = []
    for t in tables:
        blob = _norm("".join(str(c) for r in t.get("rows", [])
                             for c in r))
        out.append((str(t.get("table_id") or "?"), blob))
    return out


def number_coverage(text: str,
                    tables: list[dict]) -> dict:
    """正文数字+单位 token × 登记表 → 覆盖报告 (纯函数).

    (a) token 去空白后包含于某表单元格拼接 → 表锚;
    (b) 所在句带 [[T:表号]] 且该表号已登记 → 行级锚;
    其余 = 无表锚数字 (FAIL 清单).
    """
    blobs = _cell_blob(tables)
    tids = {tid for tid, _ in blobs}
    total = covered = 0
    uncovered: list[dict] = []
    for raw in text.splitlines():
        line = _clean_line(raw)
        if not line:
            continue
        anchors = {a for m in ANCHOR_RE.finditer(line)
                   for a in m.group(1).split(",") if a}
        for sent in SENT_SPLIT_RE.split(line):
            s = sent.strip()
            if not s:
                continue
            for m in NUM_UNIT_RE.finditer(s):
                total += 1
                tok = _norm(m.group(0))
                hit_tbl = any(tok in blob for _, blob in blobs)
                hit_anchor = bool(anchors & tids) and "[[T:" in line
                if hit_tbl or hit_anchor:
                    covered += 1
                else:
                    uncovered.append({"num": m.group(0), "sent": s[:60]})
    pct = round(covered / total, 4) if total else 1.0
    return {"total": total, "covered": covered, "uncovered": uncovered,
            "coverage": pct, "pass": pct >= COVERAGE_GATE
            and not uncovered}


# ---------------------------------------------------------- 战役级

def audit_campaign(draft_path: Path, cid: str,
                   pool_root: Path = POOL_ROOT) -> dict:
    """读 tables.json + doc_registry.json → 表锚机检 → charts_gate.json."""
    d = pool_root / cid
    tables: list[dict] = []
    tp = d / "tables.json"
    if tp.is_file():
        tables = json.loads(tp.read_text(encoding="utf-8")) \
            .get("tables", [])
    known: set[str] = set()
    rp = d / "doc_registry.json"
    if rp.is_file():
        known = {x["id"] for x in json.loads(
            rp.read_text(encoding="utf-8")).get("docs", [])}
    reg_errs = validate_tables(tables, known)
    text = Path(draft_path).read_text(encoding="utf-8")
    cov = number_coverage(text, tables)
    report = {"cid": cid, "draft": str(draft_path),
              "generated": time.strftime("%Y-%m-%d %H:%M"),
              "engine_version": "charts-gate-v1 (W5-3 断言链引擎)",
              "registry_errors": reg_errs, "coverage": cov,
              "overall_pass": not reg_errs and cov["pass"]}
    (d / "charts_gate.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")
    return report


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="数据表先行门 (W5-3)")
    ap.add_argument("--campaign-id", required=True)
    ap.add_argument("--draft", required=True)
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ns = ap.parse_args(argv)
    r = audit_campaign(Path(ns.draft), ns.campaign_id, Path(ns.pool_root))
    c = r["coverage"]
    print(f"[charts] 数字 token {c['total']} | 表锚覆盖 {c['coverage']} "
          f"({'PASS' if c['pass'] else 'FAIL'}) | 无表锚 {len(c['uncovered'])}")
    for u in c["uncovered"][:5]:
        print(f"[charts]   ✗ {u['num']} ← {u['sent']}")
    for e in r["registry_errors"][:5]:
        print(f"[charts]   ✗ 登记簿: {e}")
    print(f"[charts] overall: {'PASS' if r['overall_pass'] else 'FAIL'} → "
          f"charts_gate.json")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
