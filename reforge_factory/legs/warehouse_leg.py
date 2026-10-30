# -*- coding: utf-8 -*-
"""warehouse 腿 — P1-4 ETL 数仓查询入池 (1026 世界顶级差距#3修复).

查询本地规范化数仓 data/warehouse/price_finance.db (akshare 免费 ETL 落库,
跨截面可比序列), 把查询结果写散文式 md 入弹药池 (engine=warehouse,
cred=research), 挂树 EEI。数字全部来自 SQLite 实测行, 零手填零伪造。

查询路由 (中文自然语句 → SQL, 不命中如实报告):
  公司序列: 「中国建筑近5年营收序列/净利/毛利率/海外收入」 (八大建筑央企)
  商品价格: 「螺纹钢2024年均价 vs 2023」「沥青主力日线」(均价=AVG实测)
  宏观序列: 「建筑业总产值近5年」「PPI近5年」「固投/建安工程投资」

用法:
  py reforge_factory/legs/warehouse_leg.py --campaign EPC-JIAGE
      --queries "中国建筑近5年营收序列" [--tree Q23-E1] [--no-ingest]
"""
from __future__ import annotations

import argparse
import json
import re
import sqlite3
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb                     # noqa: E402 (台账只增)

REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
DB = REPO / "data" / "warehouse" / "price_finance.db"
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"

ENGINE = "warehouse"
SOURCE = "P1-4 ETL 数仓 price_finance.db (akshare 免费源)"

METRIC_KEYS = [
    ("海外", "海外收入(元)"), ("境外", "海外收入(元)"),
    ("营收", "营业总收入"), ("营业收入", "营业总收入"),
    ("净利", "归母净利润"), ("毛利率", "毛利率"),
]
COMMODITY_KEYS = [("螺纹钢", "螺纹钢"), ("沥青", "石油沥青"), ("水泥", "水泥(建材指数)")]
MACRO_KEYS = [
    ("建筑业总产值", "建筑业总产值_累计值(亿元)"),
    ("建安", "建筑安装工程固定资产投资额累计增长(%)"),
    ("固投", "固定资产投资自年初累计(亿元)"),
    ("固定资产投资", "固定资产投资自年初累计(亿元)"),
    ("PPI", None), ("ppi", None),  # PPI 双指标
]


def _years(q: str, default: int = 5) -> int:
    m = re.search(r"近(\d+)年", q)
    return int(m.group(1)) if m else default


def _yrs_expr(n: int) -> str:
    y = datetime.now().year - n + 1
    return "%d-01-01" % y


def find_company(conn: sqlite3.Connection, q: str) -> tuple[str, str] | None:
    """公司在册表里名字被查询句包含 (最长名优先, 防止「中国建筑」吞「中国建设」误配)."""
    rows = conn.execute("SELECT name, code FROM company_registry").fetchall()
    for name, code in sorted(rows, key=lambda r: -len(r[0])):
        if name in q:
            return name, code
    return None


def query_company_series(conn, q: str) -> tuple[str, str, list]:
    hit = find_company(conn, q)
    if not hit:
        return "", "", []
    name, code = hit
    metric = next((m for k, m in METRIC_KEYS if k in q), "营业总收入")
    n = _years(q)
    rows = conn.execute(
        "SELECT report_date, value FROM stock_financials "
        "WHERE code=? AND metric=? AND report_date>=? ORDER BY report_date",
        (code, metric, _yrs_expr(n))).fetchall()
    sql = "stock_financials code=%s metric=%s since %s -> %d行" % (
        code, metric, _yrs_expr(n), len(rows))
    return "%s · %s · 近%d年" % (name, metric, n), sql, rows


def query_commodity(conn, q: str) -> tuple[str, str, list]:
    prod = next((p for k, p in COMMODITY_KEYS if k in q), "")
    if not prod:
        return "", "", []
    if "均价" in q or "平均" in q:
        rows = conn.execute(
            "SELECT substr(date,1,4)||'年' y, market, COUNT(*) n, "
            "ROUND(AVG(price),2) v FROM commodity_prices WHERE product=? "
            "GROUP BY y, market ORDER BY market, y", (prod,)).fetchall()
        sql = "commodity_prices product=%s 年均AVG -> %d行" % (prod, len(rows))
        return "%s 各年均价 (分市场)" % prod, sql, rows
    rows = conn.execute(
        "SELECT date, market, price FROM commodity_prices WHERE product=? "
        "ORDER BY date DESC LIMIT 12", (prod,)).fetchall()
    sql = "commodity_prices product=%s 最近12行" % prod
    return "%s 最新价格序列" % prod, sql, rows


def query_macro(conn, q: str) -> tuple[str, str, list]:
    key = next((k for k, q2 in MACRO_KEYS if k in q), "")
    if not key:
        return "", "", []
    n = _years(q)
    if key.upper() == "PPI":
        rows = conn.execute(
            "SELECT date, indicator, value FROM macro_series "
            "WHERE indicator LIKE 'PPI%' AND date>=? ORDER BY date, indicator",
            (_yrs_expr(n),)).fetchall()
        sql = "macro_series PPI* since %s -> %d行" % (_yrs_expr(n), len(rows))
        return "PPI 序列 (指数+同比)", sql, rows
    ind = dict((k, v) for k, v in MACRO_KEYS)[key]
    rows = conn.execute(
        "SELECT date, value FROM macro_series WHERE indicator=? AND date>=? "
        "ORDER BY date", (ind, _yrs_expr(n))).fetchall()
    sql = "macro_series indicator=%s since %s -> %d行" % (ind, _yrs_expr(n), len(rows))
    return ind, sql, rows


def fmt_val(v) -> str:
    if v is None:
        return "—"
    av = abs(float(v))
    if av >= 1e8:
        return "%.2f亿元" % (float(v) / 1e8)
    if av >= 1e4:
        return "%.2f万元" % (float(v) / 1e4)
    return "%g" % float(v)


def build_md(query: str, title: str, sql: str, rows: list) -> str:
    lines = [
        "# 数仓序列简报 | " + (title or query),
        "",
        "本件为 P1-4 ETL 数仓 (data/warehouse/price_finance.db) 一次真实查询的实测结果面。"
        "数仓由 akshare 免费接口 ETL 落库 (央企财务/工程材料价格/宏观序列), "
        "本件数字全部为 SQLite 实测行 (零手填); 序列可跨公司、跨截面直接对比, "
        "用作工程计价依据研究的造价与市场价基准证据底座。",
        "",
        "- 查询: " + query,
        "- 引擎: 数仓查询 (engine=warehouse) | 采集: " + time.strftime("%Y-%m-%d %H:%M"),
        "- 实测 SQL: " + sql,
        "",
        "---",
        "",
    ]
    if not rows:
        lines.append("如实: 该查询在数仓零行 (路由未命中或缺口在案), 不伪造数字。")
    for r in rows:
        cells = [str(x) for x in r]
        lines.append("- " + " · ".join(
            [cells[0]] + [fmt_val(float(c)) if _is_num(c) else c for c in cells[1:]]))
    lines += ["", "---", "", "合计 %d 行实测 (源与口径见数仓 source 列; 数字零造假)。" % len(rows)]
    return "\n".join(lines)


def _is_num(s: str) -> bool:
    try:
        float(s)
        return True
    except (TypeError, ValueError):
        return False


def pool_ingest(campaign: str, md: Path, tree: str) -> tuple[int, int]:
    cmd = [sys.executable, "-X", "utf8", str(AMMO_POOL_PY), "ingest", campaign,
           "--file", str(md), "--engine", ENGINE, "--cred", "research"]
    if tree:
        cmd += ["--tree", tree]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=180)
    out = (r.stdout or "") + (r.stderr or "")
    m = re.search(r"\+待审\s+([\d,]+)字", out)
    chars = int(m.group(1).replace(",", "")) if m else 0
    tail = out.strip().splitlines()[-1] if out.strip() else "(无输出)"
    print("    " + tail)
    return r.returncode, chars


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="数仓查询腿 (warehouse→弹药池)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--tree", default="", help="挂树 EEI id (如 Q23-E1)")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    if not DB.exists():
        print("[warehouse] 数仓不存在: %s (先跑 data/warehouse/etl.py run all)" % DB)
        return 2
    conn = sqlite3.connect(DB)
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    stage.mkdir(parents=True, exist_ok=True)
    tot_chars = tot_items = 0
    per_q = []
    for q in ns.queries:
        print("[warehouse] 查询: " + q)
        title, sql, rows = query_company_series(conn, q)
        if not sql:
            title, sql, rows = query_commodity(conn, q)
        if not sql:
            title, sql, rows = query_macro(conn, q)
        if not sql:
            print("    如实: 路由未命中 (不伪造)")
            per_q.append({"query": q, "rows": 0, "ingested": 0})
            continue
        md = build_md(q, title, sql, rows)
        slug = re.sub(r"[^0-9A-Za-z\u4e00-\u9fff]+", "-", q).strip("-")[:48] or "query"
        md_path = stage / (slug + ".md")
        md_path.write_text(md, encoding="utf-8")
        print("    实测 %d 行 -> %s (%d字面)" % (len(rows), md_path.name, len(md)))
        if not ns.no_ingest and len(md) >= 300:
            rc, ch = pool_ingest(ns.campaign, md_path, ns.tree)
            if rc == 0 and ch > 0:
                tot_items += 1
                tot_chars += ch
        per_q.append({"query": q, "rows": len(rows),
                      "ingested": 1 if (not ns.no_ingest and len(md) >= 300) else 0})
    conn.close()
    if not ns.no_ingest:
        yld = "%d查询/%d件%s字入池" % (len(ns.queries), tot_items, format(tot_chars, ","))
        arb.append_invocation(
            ENGINE, "warehouse_leg:本地数仓SQLite查询 (akshare免费ETL落库, 零浏览器)",
            "; ".join(ns.queries), yld,
            note="P1-4 ETL数仓渠道接线 (1026世界顶级差距#3修复); "
                 "db=data/warehouse/price_finance.db; tree=%s" % (ns.tree or "-"),
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "ingested": tot_items, "chars": tot_chars,
                      "staging": str(stage), "per_query": per_q},
                     ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
