# -*- coding: utf-8 -*-
"""weekly_north_star 单测 (REQ-032, T-018) — 合成订单→周报键节齐/口径对/空数据不炸.

口径: paid_at 落周算收入; refunded 记 0 收入但入退款率分母;
partial_refunded 扣 refunded_fen; 复购只数可识别 contact (auto-pay 匿名除外).
"""
from __future__ import annotations

import sqlite3
import sys
import tempfile
from datetime import date, datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import weekly_north_star as WN   # noqa: E402


def _d() -> Path:
    return Path(tempfile.mkdtemp(prefix="wn_test_"))


def _mk_db(path: Path) -> None:
    con = sqlite3.connect(str(path))
    con.execute("CREATE TABLE orders(id INTEGER PRIMARY KEY, created TEXT, "
                "sku TEXT, order_no TEXT, contact TEXT, note TEXT, "
                "state TEXT DEFAULT 'pending', channel TEXT, txn_id TEXT, "
                "paid_at TEXT, refunded_fen INTEGER DEFAULT 0)")
    con.execute("CREATE TABLE pay_amounts(order_no TEXT PRIMARY KEY, "
                "price INTEGER)")
    # W42 (2026-10-12~18): 2 paid ENT-05 @69800 + 1 refunded TOPIC-01 @49800
    # + 1 partial_refunded PROV-01 @59800 退 10000
    rows = [
        ("ENT-05", "N1", "buyer-a@x.com", "paid", "2026-10-13 09:00:00", 69800, 0),
        ("ENT-05", "N2", "buyer-a@x.com", "paid", "2026-10-14 09:00:00", 69800, 0),
        ("TOPIC-01", "N3", "buyer-b@x.com", "refunded", "2026-10-15 09:00:00",
         49800, 49800),
        ("PROV-01", "N4", "auto-pay", "partial_refunded",
         "2026-10-16 09:00:00", 59800, 10000),
        # W41 单: 不入本周
        ("ENT-06", "N5", "buyer-c@x.com", "paid", "2026-10-06 09:00:00", 69800, 0),
        # 本周创建但未付: 不入任何口径
        ("ENT-07", "N6", "buyer-d@x.com", "pending", "2026-10-13 10:00:00",
         69800, 0),
    ]
    for sku, no, contact, state, paid_at, price, refunded in rows:
        con.execute("INSERT INTO orders(created,sku,order_no,contact,note,"
                    "state,channel,paid_at,refunded_fen) VALUES(?,?,?,?,?,?,"
                    "'wxpay',?,?)",
                    (paid_at[:10], sku, no, contact, "", state, paid_at,
                     refunded))
        con.execute("INSERT INTO pay_amounts(order_no,price) VALUES(?,?)",
                    (no, price))
    con.commit()
    con.close()


def test_week_metrics_math():
    d = _d()
    db = d / "report_platform.db"
    _mk_db(db)
    orders = WN.read_orders(db)
    assert len(orders) == 6
    m = WN.week_metrics(orders, date(2026, 10, 12), date(2026, 10, 18))
    assert m["paid_n"] == 4                     # 2 paid+1 refunded+1 partial
    assert m["revenue_fen"] == 69800 * 2 + 0 + (59800 - 10000)   # = 189400
    assert m["refunded_n"] == 1
    assert m["refund_rate"] == 1 / 4
    # 复购: buyer-a 2 单 (W42 内), buyer-b/c 各 1 → 1/3
    assert m["distinct_buyers"] == 3 and m["repeat_buyers"] == 1
    assert m["repurchase_rate"] == 1 / 3


def test_render_md_key_sections_with_data():
    d = _d()
    db = d / "report_platform.db"
    _mk_db(db)
    import funnel_query as FQ
    funnel = FQ.collect(week="2026-W42", ledger=d / "none.jsonl", db_path=db)
    md = WN.render("2026-W42", WN.read_orders(db), funnel)
    for key in ("# 北极星周报 2026-W42", "（2026-10-12 ~ 2026-10-18）",
                "## 周收入", "## 四级漏斗（全站）", "## 各 SKU 转化率",
                "## 复购率", "## 退款率", "## 对标基准", "## 数据来源说明",
                "6.6%", "Unbounce", "¥1,894.00", "33.3%", "25.0%"):
        assert key in md, f"缺节: {key}"
    assert "无数据" not in md.split("## 复购率")[1].split("## 退款率")[0]


def test_empty_week_renders_no_data_not_crash():
    d = _d()   # 无 db 无账本 → 全站零数据周
    f = WN.build("2026-W42", db_path=d / "no.db", ledger=d / "none.jsonl",
                 out_dir=d / "weekly")
    assert f.exists() and f.name == "2026-W42.md"
    md = f.read_text(encoding="utf-8")
    for key in ("# 北极星周报 2026-W42", "## 周收入", "## 四级漏斗（全站）",
                "## 各 SKU 转化率", "## 复购率", "## 退款率", "## 对标基准",
                "6.6%", "零数据周如实呈现"):
        assert key in md, f"缺节: {key}"
    assert md.count("无数据") >= 4              # 转化/复购/退款/收入如实标


def test_week_window_and_bad_week():
    y, w, mon, sun = WN.week_window("2026-W42")
    assert (y, w) == (2026, 42) and str(mon) == "2026-10-12" \
        and str(sun) == "2026-10-18"
    for bad in ("2026-99", "notaweek", ""):
        try:
            WN.week_window(bad)
            raise AssertionError(f"应拒绝: {bad!r}")
        except ValueError:
            pass


def test_parse_ts_guards():
    assert WN._parse_ts("2026-10-13 09:00:00") == datetime(2026, 10, 13, 9, 0)
    assert WN._parse_ts("") is None and WN._parse_ts("junk") is None
