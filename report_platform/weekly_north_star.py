# -*- coding: utf-8 -*-
"""REQ-032 周报北极星 (百倍V3 T-018) — 只增件, 订单库实读, 缺数据如实标「无数据」.

生成 report_platform/weekly/<YYYY-WW>.md:
  周收入 / 四级漏斗 / 各 SKU 转化率 / 复购率 / 退款率
  对标行: 全行业转化率中位 6.6% (Unbounce 5,700 万落地页数据集, N2 卷宗)

数据源 (全只读):
  - report_platform.db orders + pay_amounts (paid_at 落周的订单算收入;
    refunded 全额退扣除, partial_refunded 扣 refunded_fen)
  - funnel_query.collect() 双源漏斗 (funnel_events.jsonl + events 表 + 已付订单)

零数据周如实呈现 0/无数据 (REQ-034 首周 0 的呼应: 不造数).

用法:
  py weekly_north_star.py --week 2026-W42          # 默认出 report_platform/weekly/
  py weekly_north_star.py --week 2026-W42 --json   # 顺带 stdout 出指标 json
"""
from __future__ import annotations

import argparse
import json
import sqlite3
import sys
from datetime import date, datetime, timedelta
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import funnel_query as FQ   # noqa: E402

ROOT = Path(__file__).resolve().parent
DB = ROOT / "report_platform.db"
OUT_DIR = ROOT / "weekly"

BENCH = "全行业转化率中位 6.6%（Unbounce 5,700 万落地页数据集，N2 卷宗）"
_ANON_CONTACTS = ("", "auto-pay")     # 匿名渠道单: 无法识别买家, 不入复购分母


# ------------------------------------------------------------- 周窗口
def week_window(week: str) -> tuple[int, int, date, date]:
    """'2026-W42' → (year, week, 周一, 周日); 非法抛 ValueError."""
    wk = FQ.norm_week(week)
    y, w = int(wk[:4]), int(wk[6:])
    mon = date.fromisocalendar(y, w, 1)
    return y, w, mon, mon + timedelta(days=6)


def _parse_ts(s: str) -> datetime | None:
    s = str(s or "").strip()
    for fmt in ("%Y-%m-%d %H:%M:%S", "%Y-%m-%dT%H:%M:%S"):
        try:
            return datetime.strptime(s, fmt)
        except ValueError:
            continue
    return None


# ------------------------------------------------------------- 订单实读
def read_orders(db_path: Path | str = DB) -> list[dict]:
    """orders+pay_amounts 只读 → 规范订单列表; 无库/无表 → [] (如实无数据)."""
    con = FQ._sqlite_ro(db_path)
    if con is None:
        return []
    try:
        cols = FQ._table_cols(con, "orders")
        if not cols:
            return []
        prices = {}
        if FQ._table_cols(con, "pay_amounts"):
            try:
                prices = {no: fen for no, fen in con.execute(
                    "SELECT order_no, price FROM pay_amounts")}
            except sqlite3.Error:
                prices = {}
        has = lambda c: c if c in cols else "''"   # noqa: E731
        out = []
        for no, sku, contact, state, paid_at, ch, rf in con.execute(
                f"SELECT order_no, sku, contact, state, {has('paid_at')}, "
                f"{has('channel')}, {has('refunded_fen')} FROM orders"):
            out.append({
                "order_no": str(no or ""), "sku": str(sku or ""),
                "contact": str(contact or ""), "state": str(state or ""),
                "paid_at": _parse_ts(paid_at),
                "channel": str(ch) if ch else "",
                "price_fen": prices.get(str(no or "")),
                "refunded_fen": int(rf) if str(rf or "").isdigit() else 0})
        return out
    except sqlite3.Error:
        return []
    finally:
        con.close()


def week_metrics(orders: list[dict], mon: date, sun: date) -> dict:
    """周窗口指标 (paid_at∈[mon,sun] 到达过支付的单; refunded 也曾付费)."""
    lo, hi = datetime.combine(mon, datetime.min.time()), \
        datetime.combine(sun, datetime.max.time())
    in_week = [o for o in orders
               if o["paid_at"] and lo <= o["paid_at"] <= hi]
    paid = [o for o in in_week if o["state"] in ("paid", "partial_refunded",
                                                 "refunded")]
    revenue_fen = 0
    no_price = 0
    for o in paid:
        if o["price_fen"] is None:
            no_price += 1
            continue
        if o["state"] == "refunded":          # 全额退: 收入记 0
            continue
        give_back = o["refunded_fen"] if o["state"] == "partial_refunded" else 0
        revenue_fen += max(0, o["price_fen"] - give_back)
    refunded = [o for o in paid if o["state"] == "refunded"]

    # 复购: 可识别买家 (contact 非匿名) 的历史 (≤周尾) 已付单 ≥2 占比
    hist = [o for o in orders if o["paid_at"] and o["paid_at"] <= hi
            and o["state"] in ("paid", "partial_refunded", "refunded")
            and o["contact"] not in _ANON_CONTACTS]
    buyers: dict[str, int] = {}
    for o in hist:
        buyers[o["contact"]] = buyers.get(o["contact"], 0) + 1
    repeat = sum(1 for n in buyers.values() if n >= 2)
    return {"paid_n": len(paid), "refunded_n": len(refunded),
            "revenue_fen": revenue_fen, "no_price_n": no_price,
            "refund_rate": (len(refunded) / len(paid)) if paid else None,
            "distinct_buyers": len(buyers), "repeat_buyers": repeat,
            "repurchase_rate": (repeat / len(buyers)) if buyers else None}


# ------------------------------------------------------------- 渲染
def _pct(x: float | None) -> str:
    return "无数据" if x is None else f"{x * 100:.1f}%"


def render(week: str, orders: list[dict], funnel: dict) -> str:
    y, w, mon, sun = week_window(week)
    m = week_metrics(orders, mon, sun)
    lv = funnel["levels"]
    conv = lv["pay"] / lv["visit"] if lv["visit"] else None
    gen_ts = datetime.now().astimezone().isoformat(timespec="seconds")

    L: list[str] = []
    L.append(f"# 北极星周报 {y}-W{w:02d}（{mon} ~ {sun}）")
    L.append("")
    L.append(f"> 生成 {gen_ts} · weekly_north_star.py (REQ-032/REQ-034) · "
             f"订单实读 report_platform.db · 漏斗双源 funnel_events.jsonl+events 表")
    L.append("")
    L.append("## 周收入")
    if m["paid_n"]:
        L.append(f"- 本周入账: ¥{m['revenue_fen'] / 100:,.2f}"
                 f"（支付到达 {m['paid_n']} 单）"
                 + (f"，其中 {m['no_price_n']} 单缺 pay_amounts 单价未计入"
                    if m["no_price_n"] else ""))
    else:
        L.append("- 本周入账: 无数据（本周 0 单支付到达——零数据周如实呈现）")
    L.append(f"- ¥100k 冲刺对账（REQ-034）: 本周 "
             f"¥{m['revenue_fen'] / 100:,.2f}")
    L.append("")
    L.append("## 四级漏斗（全站）")
    L.append("")
    L.append("| level | 数 |")
    L.append("|---|---|")
    for k in FQ.LEVELS:
        L.append(f"| {k} | {lv[k]} |")
    L.append("")
    if conv is None:
        L.append("visit=0，visit→pay 转化: 无数据")
    L.append("")
    L.append("## 各 SKU 转化率")
    if funnel["per_sku"]:
        L.append("")
        L.append("| SKU | visit | sample_read | click_buy | pay | visit→pay |")
        L.append("|---|---|---|---|---|---|")
        for s in sorted(funnel["per_sku"],
                        key=lambda x: -funnel["per_sku"][x]["visit"]):
            v = funnel["per_sku"][s]
            c = f"{v['pay'] / v['visit'] * 100:.1f}%" if v["visit"] else "无数据"
            L.append(f"| {s} | {v['visit']} | {v['sample_read']} | "
                     f"{v['click_buy']} | {v['pay']} | {c} |")
    else:
        L.append("")
        L.append("无数据（本周零漏斗事件）")
    L.append("")
    L.append("## 复购率")
    if m["repurchase_rate"] is None:
        L.append("无数据（无可识别买家: 本周无已付订单或均为匿名渠道单 "
                 "contact=auto-pay）")
    else:
        L.append(f"- {_pct(m['repurchase_rate'])}"
                 f"（复购买家 {m['repeat_buyers']}/可识别买家 "
                 f"{m['distinct_buyers']}，历史口径≤本周日）")
    L.append("")
    L.append("## 退款率")
    if m["refund_rate"] is None:
        L.append("无数据（本周 0 单支付到达，无退款分母）")
    else:
        L.append(f"- {_pct(m['refund_rate'])}"
                 f"（本周退款 {m['refunded_n']}/{m['paid_n']} 单）")
    L.append("")
    L.append("## 对标基准")
    L.append(f"- {BENCH}")
    L.append(f"- 本站本周 visit→pay: "
             + (_pct(conv) if conv is not None else "无数据（visit=0）"))
    L.append("")
    L.append("## 数据来源说明")
    L.append("- 订单: report_platform.db orders/pay_amounts 只读实读；"
             "本机无库文件时各指标如实标无数据（不造数）")
    L.append("- 漏斗: funnel_events.jsonl（带渠道）+ server events 表映射"
             "（visit/read_sample/click_buy）+ orders 已支付订单（pay 级）")
    L.append("- 周窗口: ISO 周 周一~周日；收入口径=paid_at 落周，"
             "refunded 扣全款、partial_refunded 扣 refunded_fen")
    return "\n".join(L) + "\n"


def build(week: str, db_path: Path | str = DB,
          ledger: Path | str = FQ.LEDGER, out_dir: Path | str = OUT_DIR) -> Path:
    """实读→渲染→落盘 weekly/<YYYY-WW>.md → 文件路径 (只增: 不覆盖语义见下)."""
    wk = FQ.norm_week(week)
    funnel = FQ.collect(week=wk, ledger=ledger, db_path=db_path)
    orders = read_orders(db_path)
    md = render(wk, orders, funnel)
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    f = out / f"{wk}.md"
    f.write_text(md, encoding="utf-8")
    return f


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="REQ-032 周报北极星")
    ap.add_argument("--week", required=True, help="YYYY-WW, 如 2026-W42")
    ap.add_argument("--db", default=str(DB))
    ap.add_argument("--ledger", default=str(FQ.LEDGER))
    ap.add_argument("--out", default=str(OUT_DIR))
    ap.add_argument("--json", action="store_true", help="顺带 stdout 出指标 json")
    ns = ap.parse_args(argv)
    f = build(ns.week, db_path=ns.db, ledger=ns.ledger, out_dir=ns.out)
    print(f"[weekly] {f}")
    if ns.json:
        y, w, mon, sun = week_window(ns.week)
        m = week_metrics(read_orders(ns.db), mon, sun)
        print(json.dumps({"week": FQ.norm_week(ns.week), **m},
                         ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(_main(sys.argv[1:]))
