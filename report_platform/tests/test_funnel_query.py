# -*- coding: utf-8 -*-
"""funnel_query 单测 (REQ-032/AC1, T-018) — 账本读写/校验/双源汇聚/周过滤.

合成事件 → 四级漏斗数正确; 坏行不炸; sqlite 双源映射与 pay 级口径可验.
"""
from __future__ import annotations

import json
import sqlite3
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import funnel_query as FQ   # noqa: E402


def _tmp(name: str = "funnel_events.jsonl") -> Path:
    return Path(tempfile.mkdtemp(prefix="fq_test_")) / name


def test_record_writes_full_schema_line():
    p = _tmp()
    ev = FQ.record("BID26-FULL", "gzh-zbzs", "visit", ref="wx_vid_1", path=p)
    assert ev["sku"] == "BID26-FULL" and ev["channel"] == "gzh-zbzs"
    assert ev["level"] == "visit" and ev["ref"] == "wx_vid_1" and ev["ts"]
    line = json.loads(p.read_text(encoding="utf-8").strip())
    assert line == ev


def test_record_rejects_bad_inputs():
    p = _tmp()
    for bad in [("BID26-FULL", "gzh", "order_created"),     # 非四级 level
                ("", "gzh", "visit"),                        # 空 sku
                ("SKU!", "gzh", "visit"),                    # 非法字符 sku
                ("BID26-FULL", "渠道一", "visit"),           # 非 ASCII 渠道
                ("BID26-FULL", "gzh", "pay", "r!")]:         # 非法 ref
        try:
            FQ.record(*bad, path=p)
            raise AssertionError(f"应拒绝: {bad}")
        except ValueError:
            pass
    assert not p.exists() or p.read_text(encoding="utf-8") == ""


def test_load_events_skips_malformed_lines():
    p = _tmp()
    p.write_text('{"sku":"S1","channel":"site","level":"visit","ts":"t"}\n'
                 "not-json\n"
                 "\n"
                 '{"sku":"S1","channel":"site","level":"nope"}\n'
                 '{"sku":"S2","channel":"gzh","level":"pay"}\n',
                 encoding="utf-8")
    evs = FQ.load_events(p)
    assert [e["sku"] for e in evs] == ["S1", "S2"]
    assert evs[0]["source"] == "jsonl" and evs[1]["level"] == "pay"


def test_sku_funnel_four_levels_counts():
    p = _tmp()
    for ch, lv, n in [("gzh-zbzs", "visit", 5), ("gzh-zbzs", "sample_read", 3),
                      ("gzh-zbzs", "click_buy", 2), ("site", "visit", 2),
                      ("site", "pay", 1)]:
        for _ in range(n):
            FQ.record("BID26-FULL", ch, lv, path=p)
    FQ.record("OTHER-SKU", "site", "visit", path=p)   # 别家 SKU 不串
    r = FQ.collect(sku="BID26-FULL", ledger=p, db_path=p.parent / "no.db")
    assert r["levels"] == {"visit": 7, "sample_read": 3, "click_buy": 2,
                           "pay": 1}
    assert r["by_channel"]["site"]["pay"] == 1
    assert r["by_channel"]["gzh-zbzs"]["visit"] == 5


def test_week_filter_and_norm():
    p = _tmp()
    # 显式 ts (不依赖运行当天): 2026-10-13=W42, 2026-10-05=W41
    p.write_text(
        '{"sku":"S1","channel":"site","level":"visit",'
        '"ts":"2026-10-13T10:00:00+08:00"}\n'
        '{"sku":"S1","channel":"site","level":"visit",'
        '"ts":"2026-10-05 10:00:00"}\n'
        '{"sku":"S1","channel":"site","level":"click_buy",'
        '"ts":"bad-ts"}\n', encoding="utf-8")
    assert FQ.event_week({"ts": "2026-10-13T10:00:00+08:00"}) == "2026-W42"
    assert FQ.event_week({"ts": "bad"}) is None        # 解析失败 → 周排除
    r42 = FQ.collect(week="2026-W42", ledger=p, db_path="no.db")
    assert r42["levels"] == {"visit": 1, "sample_read": 0, "click_buy": 0,
                             "pay": 0}
    r41 = FQ.collect(week="2026-W41", ledger=p, db_path="no.db")
    assert r41["levels"]["visit"] == 1
    ev = FQ.record("S1", "site", "visit", path=p)      # record 的 ts 恒可解析
    assert FQ.event_week(ev) is not None
    assert FQ.norm_week("2026W42") == "2026-W42"
    try:
        FQ.norm_week("week-42?")
        raise AssertionError("应拒绝非法周格式")
    except ValueError:
        pass


def _mk_db(path: Path) -> None:
    con = sqlite3.connect(str(path))
    con.execute("CREATE TABLE events(id INTEGER PRIMARY KEY, ts TEXT, "
                "event TEXT, sku TEXT, extra TEXT)")
    con.execute("CREATE TABLE orders(id INTEGER PRIMARY KEY, created TEXT, "
                "sku TEXT, order_no TEXT, contact TEXT, note TEXT, "
                "state TEXT DEFAULT 'pending', channel TEXT, txn_id TEXT, "
                "paid_at TEXT)")
    rows = [("2026-10-13 10:00:00", "visit", "BID26-FULL"),
            ("2026-10-13 10:01:00", "read_sample", "BID26-FULL"),
            ("2026-10-13 10:02:00", "click_buy", "BID26-FULL"),
            ("2026-10-13 10:03:00", "scroll_50", "BID26-FULL"),   # 不入四级
            ("2026-10-13 10:04:00", "order_created", "BID26-FULL"),  # 不冒充 pay
            ("2026-10-13 10:05:00", "visit", "OTHER-SKU")]
    con.executemany("INSERT INTO events(ts,event,sku) VALUES(?,?,?)", rows)
    con.execute("INSERT INTO orders(created,sku,order_no,contact,note,state,"
                "channel,paid_at) VALUES('2026-10-13','BID26-FULL','NO1',"
                "'auto-pay','','paid','wxpay','2026-10-13 10:06:00')")
    con.execute("INSERT INTO orders(created,sku,order_no,contact,note,state,"
                "channel,paid_at) VALUES('2026-10-13','BID26-FULL','NO2',"
                "'auto-pay','','pending','wxpay','')")
    con.commit()
    con.close()


def test_sqlite_dual_source_merge():
    d = Path(tempfile.mkdtemp(prefix="fq_db_"))
    db = d / "report_platform.db"
    _mk_db(db)
    empty_ledger = d / "none.jsonl"
    r = FQ.collect(sku="BID26-FULL", ledger=empty_ledger, db_path=db)
    # events 表三级 + orders 一单 paid (pending 不算); scroll/order_created 不入
    assert r["levels"] == {"visit": 1, "sample_read": 1, "click_buy": 1,
                           "pay": 1}
    assert r["sources"] == {"jsonl": 0, "sqlite_events": 4, "sqlite_paid": 1}
    # sources 口径: events 6 行中可映射四级者 4 (scroll_50/order_created 不映射,
    # OTHER-SKU 的 visit 计入源总量但被 sku 过滤)
    pay_ev = [e for e in r["events"] if e["level"] == "pay"]
    assert pay_ev[0]["channel"] == "wxpay"        # orders.channel 透传
    # 周过滤: 2026-10-13 属 2026-W42
    r42 = FQ.collect(week="2026-W42", ledger=empty_ledger, db_path=db)
    assert r42["levels"]["visit"] == 2 and r42["levels"]["pay"] == 1
    r41 = FQ.collect(week="2026-W41", ledger=empty_ledger, db_path=db)
    assert all(v == 0 for v in r41["levels"].values())


def test_missing_db_and_ledger_are_zero_not_crash():
    d = Path(tempfile.mkdtemp(prefix="fq_empty_"))
    r = FQ.collect(sku="ANY", ledger=d / "none.jsonl", db_path=d / "no.db")
    assert all(v == 0 for v in r["levels"].values())
    assert r["per_sku"] == {}
