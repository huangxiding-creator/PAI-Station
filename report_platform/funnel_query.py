# -*- coding: utf-8 -*-
"""REQ-032 漏斗事件账本 + 查询器 (百倍V3 T-018) — 只增件, 不改既有服务.

四级漏斗: visit → sample_read → click_buy → pay
  (per-SKU × 渠道 × 漏斗级; REQ-032 schema: sku/channel/level/ts[+ref])

数据源 (双源, 全部只读):
  1. report_platform/funnel_events.jsonl  — 本件定义的追加式事件账本 (唯一带
     channel 维度的源; 现有 server events 表无 channel 列, 形态不足故立此账本)
  2. report_platform.db (server.py 既有埋点+订单库, 只读 URI 打开)
       events 表映射: visit→visit, read_sample→sample_read, click_buy→click_buy
                     (scroll_*/show_qr 为更细粒度, 不入四级; order_created=下单
                      未必付, 不冒充 pay)
       pay 级取 orders 表 state IN (paid/partial_refunded/refunded) — 真实到达
       过支付的订单 (refunded 也曾付费, 漏斗照计; 退款在周报里另算退款率)

接线位 (README_FUNNEL.md 详述, 此处摘要):
  server.py do_POST /api/track 成功 INSERT 后追加
      funnel_query.record(sku, channel, level, ref=extra)
  pay 级官方落点: /api/pay/notify/{wx,ali} SUCCESS 分支 (PAY.mark_paid 之后).

用法:
  py funnel_query.py --sku BID26-FULL          # 单 SKU 四级漏斗数
  py funnel_query.py --week 2026-W42           # 全站周汇总 (per-SKU)
  py funnel_query.py --record R50-SNEI gzh-zbzs visit ref123   # 手工/接线写入
  (可加 --json 出机器可读; --ledger/--db 覆盖默认路径)
"""
from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
import threading
import time
from datetime import date, datetime
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parent
LEDGER = ROOT / "funnel_events.jsonl"
DB = ROOT / "report_platform.db"

LEVELS = ("visit", "sample_read", "click_buy", "pay")

# server.py FUNNEL_EVENTS → 四级漏斗映射 (pay 不映射, 见模块 docstring)
SQLITE_EVENT_MAP = {"visit": "visit", "read_sample": "sample_read",
                    "click_buy": "click_buy"}
_PAY_STATES = ("paid", "partial_refunded", "refunded")

# 渠道/sku/ref 均为 ASCII 代码位 (渠道命名规范见 README_FUNNEL.md)
_SAFE_SKU = re.compile(r"^[A-Za-z0-9_\-]{1,32}$")
_SAFE_CHANNEL = re.compile(r"^[A-Za-z0-9_\-]{1,24}$")
_SAFE_REF = re.compile(r"^[A-Za-z0-9_\-.,@;]{0,64}$")

_W_LOCK = threading.Lock()


# ------------------------------------------------------------- 账本写入
def record(sku: str, channel: str, level: str, ref: str = "",
           path: Path | str = LEDGER) -> dict:
    """追加一条漏斗事件到 JSONL 账本 → 写入的完整事件 dict.

    校验失败抛 ValueError (不静默丢弃: 埋点接线处应显式决定吞或记错).
    """
    sku = str(sku or "").strip()
    channel = str(channel or "").strip()
    level = str(level or "").strip()
    ref = str(ref or "").strip()
    if not _SAFE_SKU.match(sku):
        raise ValueError(f"sku 非法: {sku!r} (须 ASCII [A-Za-z0-9_-] 1-32 位)")
    if not _SAFE_CHANNEL.match(channel):
        raise ValueError(f"channel 非法: {channel!r} (须 ASCII [A-Za-z0-9_-] "
                         f"1-24 位)")
    if level not in LEVELS:
        raise ValueError(f"level 非法: {level!r} (须四选一 {LEVELS})")
    if not _SAFE_REF.match(ref):
        raise ValueError(f"ref 非法: {ref!r}")
    ev = {"sku": sku, "channel": channel, "level": level,
          "ts": datetime.now().astimezone().isoformat(timespec="seconds"),
          "ref": ref}
    p = Path(path)
    p.parent.mkdir(parents=True, exist_ok=True)
    with _W_LOCK:
        with open(p, "a", encoding="utf-8") as f:
            f.write(json.dumps(ev, ensure_ascii=False) + "\n")
    return ev


# ------------------------------------------------------------- 账本/库读取
def load_events(path: Path | str = LEDGER) -> list[dict]:
    """读 JSONL 账本 → 合法事件列表 (坏行跳过不炸: 账本要抗手工编辑)."""
    p = Path(path)
    if not p.exists():
        return []
    out: list[dict] = []
    for line in p.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            ev = json.loads(line)
        except json.JSONDecodeError:
            continue
        if (isinstance(ev, dict) and ev.get("sku") and ev.get("channel")
                and ev.get("level") in LEVELS):
            out.append({"sku": str(ev["sku"]), "channel": str(ev["channel"]),
                        "level": ev["level"], "ts": str(ev.get("ts") or ""),
                        "ref": str(ev.get("ref") or ""), "source": "jsonl"})
    return out


def _week_str(d: date) -> str:
    iso = d.isocalendar()
    return f"{iso.year}-W{iso.week:02d}"


def norm_week(week: str) -> str:
    """宽容归一: '2026W42'/'2026-W42' → '2026-W42'; 非法抛 ValueError."""
    m = re.match(r"^(\d{4})-?W(\d{1,2})$", str(week or "").strip(), re.I)
    if not m:
        raise ValueError(f"周格式非法: {week!r} (须 YYYY-WW, 如 2026-W42)")
    y, w = int(m.group(1)), int(m.group(2))
    if not 1 <= w <= 53:
        raise ValueError(f"周数越界: {w}")
    return f"{y}-W{w:02d}"


def event_week(ev: dict) -> str | None:
    """事件 ts → 'YYYY-WW'; 解析不出返回 None (该事件周过滤时被排除)."""
    ts = ev.get("ts") or ""
    for fmt in ("%Y-%m-%dT%H:%M:%S%z", "%Y-%m-%d %H:%M:%S", "%Y-%m-%d"):
        try:
            return _week_str(datetime.strptime(ts[:26] if fmt.endswith("z")
                                               else ts, fmt).date())
        except ValueError:
            continue
    return None


def _sqlite_ro(db_path: Path | str) -> sqlite3.Connection | None:
    """只读连接 (红线: 订单数据只读); 库不存在/打不开 → None."""
    p = Path(db_path)
    if not p.exists():
        return None
    try:
        return sqlite3.connect(f"file:{p.as_posix()}?mode=ro", uri=True)
    except sqlite3.Error:
        return None


def _table_cols(con: sqlite3.Connection, table: str) -> set[str]:
    return {r[1] for r in con.execute(f"PRAGMA table_info({table})")}


def sqlite_events(db_path: Path | str = DB) -> list[dict]:
    """server events 表 → 四级事件 (channel 无列, 统一记 'site')."""
    con = _sqlite_ro(db_path)
    if con is None:
        return []
    try:
        if not _table_cols(con, "events"):
            return []
        out = []
        for ts, ev, sku in con.execute(
                "SELECT ts, event, sku FROM events"):
            lvl = SQLITE_EVENT_MAP.get(str(ev or ""))
            if not lvl or not sku:
                continue
            out.append({"sku": str(sku), "channel": "site", "level": lvl,
                        "ts": str(ts or ""), "ref": "", "source": "sqlite"})
        return out
    except sqlite3.Error:
        return []
    finally:
        con.close()


def sqlite_paid_orders(db_path: Path | str = DB) -> list[dict]:
    """orders 表到达过支付的订单 → pay 级事件 (channel 列缺省记 'site')."""
    con = _sqlite_ro(db_path)
    if con is None:
        return []
    try:
        cols = _table_cols(con, "orders")
        if not cols:
            return []
        ch_sql = ("channel" if "channel" in cols else "'' AS channel")
        at_sql = ("paid_at" if "paid_at" in cols else "'' AS paid_at")
        st = ",".join("?" * len(_PAY_STATES))
        out = []
        for sku, ch, at in con.execute(
                f"SELECT sku, {ch_sql}, {at_sql} FROM orders "
                f"WHERE state IN ({st})", _PAY_STATES):
            if not sku:
                continue
            out.append({"sku": str(sku),
                        "channel": str(ch) if ch else "site",
                        "level": "pay", "ts": str(at or ""), "ref": "",
                        "source": "sqlite_orders"})
        return out
    except sqlite3.Error:
        return []
    finally:
        con.close()


# ------------------------------------------------------------- 汇聚
def collect(sku: str | None = None, week: str | None = None,
            ledger: Path | str = LEDGER, db_path: Path | str = DB) -> dict:
    """双源汇聚 → {events, levels, per_sku, by_channel, sources}.

    sku 过滤精确匹配; week 过滤按事件 ts 的 ISO 周 (解析失败的旧事件排除).
    """
    wk = norm_week(week) if week else None
    evs: list[dict] = []
    evs += load_events(ledger)
    src_desc = {"jsonl": len(evs)}
    se = sqlite_events(db_path)
    so = sqlite_paid_orders(db_path)
    evs += se + so
    src_desc["sqlite_events"] = len(se)
    src_desc["sqlite_paid"] = len(so)

    kept: list[dict] = []
    for ev in evs:
        if sku and ev["sku"] != sku:
            continue
        if wk and event_week(ev) != wk:
            continue
        kept.append(ev)

    levels = {lv: 0 for lv in LEVELS}
    per_sku: dict[str, dict] = {}
    by_channel: dict[str, dict] = {}
    for ev in kept:
        levels[ev["level"]] += 1
        per_sku.setdefault(ev["sku"], {lv: 0 for lv in LEVELS})[ev["level"]] += 1
        # 渠道维度仅 jsonl 账本可信 (sqlite 无 channel 列, 'site' 为兜底标)
        by_channel.setdefault(ev["channel"], {lv: 0 for lv in LEVELS})
        by_channel[ev["channel"]][ev["level"]] += 1
    return {"events": kept, "levels": levels, "per_sku": per_sku,
            "by_channel": by_channel, "sources": src_desc}


def _pct(num: int, den: int) -> str:
    return f"{num / den * 100:.1f}%" if den else "—"


# ------------------------------------------------------------- CLI
def _fmt_sku_report(r: dict, sku: str) -> str:
    lv = r["levels"]
    rows = [("visit", "—"), ("sample_read", _pct(lv["sample_read"], lv["visit"])),
            ("click_buy", _pct(lv["click_buy"], lv["sample_read"])),
            ("pay", _pct(lv["pay"], lv["click_buy"]))]
    lines = [f"SKU {sku} 四级漏斗 (visit → sample_read → click_buy → pay)"]
    for name, conv in rows:
        lines.append(f"  {name:<12} {lv[name]:>6}   上级转化率 {conv}")
    lines.append(f"  总转化率 visit→pay: {_pct(lv['pay'], lv['visit'])}"
                 f"   (对标全行业中位 6.6%, Unbounce 5,700 万数据集/N2 卷宗)")
    ch = [f"{c}: " + " ".join(f"{k}={v[k]}" for k in LEVELS if v[k])
          for c, v in sorted(r["by_channel"].items())]
    lines.append("  渠道明细: " + ("; ".join(ch) if ch else "无数据"))
    s = r["sources"]
    lines.append(f"  数据源: funnel_events.jsonl={s['jsonl']} 条"
                 f" + db events={s['sqlite_events']} 条"
                 f" + db 已支付订单={s['sqlite_paid']} 单"
                 f" (库不存在则计 0)")
    return "\n".join(lines)


def _fmt_week_report(r: dict, wk: str) -> str:
    lv = r["levels"]
    mon = date.fromisocalendar(int(wk[:4]), int(wk[6:]), 1)
    sun = date.fromisocalendar(int(wk[:4]), int(wk[6:]), 7)
    lines = [f"全站周汇总 {wk} ({mon} ~ {sun})",
             "  总计: " + " ".join(f"{k}={lv[k]}" for k in LEVELS)
             + f"   visit→pay {_pct(lv['pay'], lv['visit'])}"]
    if not r["per_sku"]:
        lines.append("  per-SKU: 无数据 (本周零事件)")
        return "\n".join(lines)
    lines.append(f"  {'SKU':<18}{'visit':>7}{'sample':>8}{'click':>7}"
                 f"{'pay':>5}  转化")
    for s in sorted(r["per_sku"], key=lambda x: -r["per_sku"][x]["visit"]):
        v = r["per_sku"][s]
        lines.append(f"  {s:<18}{v['visit']:>7}{v['sample_read']:>8}"
                     f"{v['click_buy']:>7}{v['pay']:>5}"
                     f"  {_pct(v['pay'], v['visit'])}")
    return "\n".join(lines)


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="REQ-032 漏斗账本查询器")
    ap.add_argument("--sku", help="单 SKU 四级漏斗数")
    ap.add_argument("--week", help="全站周汇总 (YYYY-WW, 如 2026-W42)")
    ap.add_argument("--record", nargs=3, metavar=("SKU", "CHANNEL", "LEVEL"),
                    help="追加事件 (可选第 4 参 ref 经 --ref)")
    ap.add_argument("--ref", default="", help="--record 的 ref 参数")
    ap.add_argument("--ledger", default=str(LEDGER))
    ap.add_argument("--db", default=str(DB))
    ap.add_argument("--json", action="store_true", help="机器可读输出")
    ns = ap.parse_args(argv)

    if ns.record:
        ev = record(ns.record[0], ns.record[1], ns.record[2], ref=ns.ref,
                    path=ns.ledger)
        print(json.dumps(ev, ensure_ascii=False))
        return 0
    if not ns.sku and not ns.week:
        ap.error("须给 --sku 或 --week 之一 (或 --record 写入)")
    r = collect(sku=ns.sku, week=ns.week, ledger=ns.ledger, db_path=ns.db)
    if ns.json:
        slim = {"levels": r["levels"], "per_sku": r["per_sku"],
                "by_channel": r["by_channel"], "sources": r["sources"]}
        slim.update({"sku": ns.sku} if ns.sku else {"week": ns.week})
        print(json.dumps(slim, ensure_ascii=False))
        return 0
    if ns.sku:
        print(_fmt_sku_report(r, ns.sku))
    else:
        print(_fmt_week_report(r, norm_week(ns.week)))
    return 0


if __name__ == "__main__":
    raise SystemExit(_main(sys.argv[1:]))
