# -*- coding: utf-8 -*-
"""T-12 单文件状态面板 + 每日汇总文本（FR8 观测）。

数据源仅 T-02 run-ledger 账本 + cards.json 缓存（C10 唯一事实源，不直连 API）：

- render(ledger, cards=None, snapshot=None, decision=None, *,
         out_path=None, now=None) → str
  ledger 可为 Ledger 实例或账本目录路径；cards/snapshot/decision 允许调用方
  （daemon 主循环）直接传内存态覆盖账本最近值（字段名 = SCHEMAS §2
  QuotaSnapshot/CardInventory 与 T-07 Decision），缺省回退最近 poll/decision 条目。
  产出自包含单文件 HTML（内联 CSS/JS，零 CDN 零外链，深色大数字卡片），
  默认写出账本兄弟目录 panel/index.html 并返回 HTML 字符串（运行时产物，
  gitignored）。
- daily_digest(date, ledger) → markdown 汇总文本（水位区间/决策次数/重置次数/
  心跳计数），供 notify daily_digest 事件体。

脱敏复用 T-02：账本落盘前已 redact，本模块只做 html.escape，不引入明文。
时钟可注入（now=epoch 秒），Python 3.11 标准库 only。
"""
from __future__ import annotations

import html as _html
import json
import time
from datetime import date as _date, datetime as _datetime
from pathlib import Path
from typing import Any, Callable

from .cards import budget as _card_budget
from .ledger import Ledger

TEMPLATE_PATH = Path(__file__).resolve().parent / "templates" / "panel_template.html"

_TAIL_N = 20            # 最近动作条数（DoD：账本尾 20 条）
_RESET_WINDOW_S = 7 * 86400  # 七日重置统计窗
_WARN_PCT, _DANGER_PCT = 70.0, 90.0   # 水位配色阈值（config 阈值族一致量级）
_RESERVE_CARDS = 1      # 卡预算预留（CONTEXT：默认留 1 给自媒永动机）


# ------------------------------------------------------------------ 内部工具
def _as_ledger(ledger: Any, now: Callable[[], float] | None) -> Ledger:
    if isinstance(ledger, Ledger):
        return ledger
    return Ledger(ledger, now=now)


def _pick(payload: Any, key: str) -> Any:
    """payload 平铺或嵌套在 payload['snapshot'] 下都能取到（poll 两写法兼容）。"""
    if not isinstance(payload, dict):
        return None
    if key in payload:
        return payload[key]
    snap = payload.get("snapshot")
    if isinstance(snap, dict):
        return snap.get(key)
    return None


def _last_payload(led: Ledger, kind: str) -> dict | None:
    """最近一条该 kind 条目的 payload（账本空则 None）。"""
    rows = led.read(kinds={kind}, limit=1)
    return rows[-1].get("payload") if rows else None


def _fmt(ts: float | int | None, fmt: str = "%m-%d %H:%M") -> str:
    if not ts:
        return "--"
    return time.strftime(fmt, time.localtime(ts))


def _pct(value: Any) -> str:
    """水位数字显示：87.5 / 12.5；非法值回 '--'。"""
    try:
        return f"{float(value):.1f}"
    except (TypeError, ValueError):
        return "--"


def _num(value: Any) -> str:
    """数值显示：123.4 → '123.4'，123.0 → '123'；非法回 '--'。"""
    try:
        f = float(value)
    except (TypeError, ValueError):
        return "--"
    return f"{int(f)}" if f.is_integer() else f"{f:g}"


# ------------------------------------------------------------------ 区块视图
def _water_view(led: Ledger, snapshot: Any, now_ms: int) -> dict:
    src = snapshot if isinstance(snapshot, dict) and snapshot else _last_payload(led, "poll")
    pct_raw = _pick(src, "window_pct") if src else None
    pct = _pct(pct_raw)
    level = "danger" if pct_raw is not None and float(pct_raw) >= _DANGER_PCT \
        else "warn" if pct_raw is not None and float(pct_raw) >= _WARN_PCT else "ok"
    rows = led.read(kinds={"poll"}, limit=1)
    stale_min = "--"
    if rows:
        stale_min = f"{max((now_ms - rows[-1]['ts']) / 60000, 0):.0f}"
    return {
        "provider": str(_pick(src, "provider") or "未知") if src else "未知",
        "window_pct": pct_raw, "window_pct_str": pct, "level": level,
        "bar": pct if pct != "--" else 0,
        "remaining_str": _num(_pick(src, "remaining")) if src else "--",
        "next_reset_at": _pick(src, "next_reset_at") if src else None,
        "stale_min": stale_min,
    }


def _burn_view(led: Ledger, decision: Any, water: dict, now_s: float) -> dict:
    src = decision if isinstance(decision, dict) and decision \
        else _last_payload(led, "decision")
    predicted = _pick(src, "predicted_exhaust_at") if src else None
    next_reset = water["next_reset_at"]
    if predicted and next_reset:
        verdict, level = ("将烧穿", "danger") if predicted < next_reset \
            else ("刷新先到", "ok")
    else:
        verdict, level = ("无预测", "dim")
    countdown = "--"
    if next_reset:
        countdown = f"{max((next_reset - now_s) / 60, 0):.0f}"
    return {
        "action": str(_pick(src, "action") or "无") if src else "无数据",
        "reason": str(_pick(src, "reason") or "账本中尚无 decision") if src
        else "账本中尚无 decision",
        "card_to_use": str(_pick(src, "card_to_use") or "--") if src else "--",
        "predicted_exhaust_at": predicted,
        "verdict": verdict, "level": level, "countdown_min": countdown,
    }


def _cards_view(cards: Any, now_s: float) -> dict:
    if not isinstance(cards, dict):
        cards = {}
    def _total(key):
        try:
            return int(sum(int(g.get("count", 0))
                           for g in (cards.get(key) or []) if isinstance(g, dict)))
        except (TypeError, ValueError):
            return 0
    expiries = [g.get("expire_at") for key in ("five_hour", "weekly")
                for g in (cards.get(key) or [])
                if isinstance(g, dict) and g.get("expire_at")
                and g["expire_at"] > now_s]
    try:
        card_budget = _card_budget(cards, _RESERVE_CARDS, "five_hour",
                                   now=int(now_s))
    except (KeyError, TypeError, ValueError):
        card_budget = max(_total("five_hour") - _RESERVE_CARDS, 0)
    return {
        "five_hour": _total("five_hour"), "weekly": _total("weekly"),
        "budget": card_budget,
        "nearest_expiry": min(expiries) if expiries else None,
    }


def _event_rows(led: Ledger) -> str:
    rows = led.read_tail(_TAIL_N)
    if not rows:
        return ('      <tr><td>--</td><td class="kind">--</td>'
                '<td class="payload">无数据</td></tr>')
    out = []
    for e in reversed(rows):  # 最新在上
        ts = _fmt(e["ts"] / 1000, "%m-%d %H:%M:%S")
        brief = json.dumps(e.get("payload", {}), ensure_ascii=False)
        if len(brief) > 120:
            brief = brief[:120] + "…"
        out.append(
            f'      <tr><td>{_html.escape(ts)}</td>'
            f'<td class="kind">{_html.escape(str(e.get("kind", "?")))}</td>'
            f'<td class="payload">{_html.escape(brief)}</td></tr>')
    return "\n".join(out)


# ------------------------------------------------------------------- render
def render(ledger: Any, cards: Any = None, snapshot: Any = None,
           decision: Any = None, *, out_path: Any = None,
           now: Callable[[], float] | None = None) -> str:
    """读账本渲染单文件 HTML；默认写 panel/index.html 并返回 HTML 字符串。"""
    led = _as_ledger(ledger, now if callable(now) else None)
    now_s = now() if callable(now) else (float(now) if now else time.time())
    now_ms = int(now_s * 1000)
    if cards is None:
        cards = led.load_cards(default={})

    water = _water_view(led, snapshot, now_ms)
    burn = _burn_view(led, decision, water, now_s)
    card = _cards_view(cards, now_s)
    resets_7d = len(led.read(kinds={"reset_exec"},
                             since=now_ms - _RESET_WINDOW_S * 1000))
    events_html = _event_rows(led)

    vm = {
        "generated_at": _fmt(now_s, "%Y-%m-%d %H:%M:%S"),
        "now": now_s,
        "water": {k: water[k] for k in
                  ("provider", "window_pct", "level", "remaining_str",
                   "next_reset_at", "stale_min")},
        "burn": {k: burn[k] for k in
                 ("action", "reason", "card_to_use", "predicted_exhaust_at",
                  "verdict", "countdown_min")},
        "cards": card,
        "resets_7d": resets_7d,
        "events": led.read_tail(_TAIL_N),
    }
    vm_json = json.dumps(vm, ensure_ascii=False,
                         separators=(",", ":")).replace("</", "<\\/")

    values = {
        "__GENERATED_AT__": _html.escape(vm["generated_at"]),
        "__PCT__": water["window_pct_str"], "__PCT_BAR__": water["bar"],
        "__PCT_LEVEL__": water["level"], "__PROVIDER__": water["provider"],
        "__REMAINING__": water["remaining_str"], "__STALE_MIN__": water["stale_min"],
        "__NEXT_RESET__": _fmt(water["next_reset_at"]),
        "__COUNTDOWN_MIN__": burn["countdown_min"],
        "__EXHAUST_AT__": _fmt(burn["predicted_exhaust_at"]),
        "__BURN_VERDICT__": burn["verdict"], "__BURN_LEVEL__": burn["level"],
        "__ACTION__": _html.escape(burn["action"]),
        "__REASON__": _html.escape(burn["reason"]),
        "__CARD_TO_USE__": _html.escape(burn["card_to_use"]),
        "__FIVE_HOUR__": card["five_hour"], "__WEEKLY__": card["weekly"],
        "__BUDGET__": card["budget"],
        "__NEAREST_EXPIRY__": _fmt(card["nearest_expiry"], "%Y-%m-%d"),
        "__RESETS_7D__": resets_7d,
        "__EVENTS_ROWS__": events_html,
        "__VM_JSON__": vm_json,
    }
    page = TEMPLATE_PATH.read_text(encoding="utf-8")
    for key, val in values.items():
        page = page.replace(key, str(val))

    out = Path(out_path) if out_path else led.base_dir.parent / "panel" / "index.html"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(page, encoding="utf-8")
    return page


# -------------------------------------------------------------- daily_digest
def _norm_day(value: Any) -> tuple[int, int, int]:
    """date/datetime/'YYYYMMDD'/'YYYY-MM-DD' → (y, m, d)。"""
    if isinstance(value, _datetime):
        return value.year, value.month, value.day
    if isinstance(value, _date):
        return value.year, value.month, value.day
    s = str(value).strip().replace("-", "")
    if len(s) != 8 or not s.isdigit():
        raise ValueError(f"非法日期: {value!r}; 期望 date/'YYYYMMDD'/'YYYY-MM-DD'")
    return int(s[:4]), int(s[4:6]), int(s[6:8])


def daily_digest(value: Any, ledger: Any) -> str:
    """指定日期的 markdown 汇总：水位区间/决策次数/重置次数/心跳计数。"""
    led = _as_ledger(ledger, None)
    y, m, d = _norm_day(value)
    start = _datetime(y, m, d).timestamp()
    start_ms, end_ms = int(start * 1000), int((start + 86400) * 1000)
    entries = [e for e in led.read(since=start_ms) if e["ts"] < end_ms]

    polls = [e for e in entries if e["kind"] == "poll"]
    pcts = []
    for e in polls:
        try:
            pcts.append(float(_pick(e["payload"], "window_pct")))
        except (TypeError, ValueError):
            pass
    span = f"{_num(min(pcts))}% ~ {_num(max(pcts))}%（{len(polls)} 次轮询）" \
        if pcts else "无数据"

    def _count(kind: str) -> int:
        return sum(1 for e in entries if e["kind"] == kind)

    actions = [str(_pick(e["payload"], "action") or "?")
               for e in entries if e["kind"] == "decision"]
    detail = "（" + " / ".join(f"{a} {actions.count(a)}"
                               for a in dict.fromkeys(actions)) + "）" if actions else ""
    return (
        f"# 每日汇总 {y:04d}-{m:02d}-{d:02d}\n"
        f"- 水位区间: {span}\n"
        f"- 决策次数: {_count('decision')}{detail}\n"
        f"- 重置次数: {_count('reset_exec')}\n"
        f"- 心跳计数: {_count('heartbeat')}\n"
    )
