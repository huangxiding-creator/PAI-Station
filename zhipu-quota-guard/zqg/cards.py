# -*- coding: utf-8 -*-
"""T-05 卡库存客户端 — reset/list 转 CardInventory + 卡预算与 FIFO 序（FR2/FR5）

纯函数层（无 IO, 输入输出可 JSON 序列化, 时钟可注入, ADR3 可回放）:
- parse_cards(raw, now): 真身响应 → CardInventory{five_hour, weekly, fetched_at}
  （SCHEMAS §2; 按 expire_at 聚合升序, 剔除已过期/已用卡）
- budget(inventory, reserve_cards, card_type): 可用预算 = max(可用卡数 − 预留, 0)
- fifo_order(inventory, card_type, now): expire_at 升序（快过期先花）
- pick_card(inventory, prefer, ...): FIFO 选卡 + would_expire_wasted 预估
- weekly_eligible(five_hour_exhausted, weekly_quota_will_burn): T-07 注入信号的钩子

网络层（transport 可注入, 测试零真请求）:
- fetch_cards(base_url, api_key, transport): GET /api/biz/customer-package-reset/list
  404/未验证端点 → ConsoleFallback 标记不抛死; 网关 code=1001 → CardsAuthError
- fetch_via_console(page): ConsoleFallback 浏览器兜底预留位, W2(T-09)后接

W0 实测锚点（W0_RECON.md 2026-10-23）: 3 张 5h 卡(recordId 6/7/8)全 available,
expire 2026-12-22 23:59:59, 周卡 0; expire 字面值无时区 → 按 UTC+8 解析。
"""
from __future__ import annotations

import time
from datetime import datetime, timedelta, timezone

__all__ = [
    "CardsContractError",
    "CardsAuthError",
    "DEFAULT_WASTE_HORIZON_DAYS",
    "parse_cards",
    "budget",
    "fifo_order",
    "pick_card",
    "weekly_eligible",
    "fetch_cards",
    "fetch_via_console",
]

DEFAULT_WASTE_HORIZON_DAYS = 3  # would_expire_wasted 预估窗: 距过期 N 天内
_TZ_CN = timezone(timedelta(hours=8))  # 站方控制台本地时区(UTC+8)

CARD_ENDPOINT_PATH = "/api/biz/customer-package-reset/list"

_AVAILABLE_WORDS = ("available", "valid", "unused", "not_used", "init")
_EXPIRE_KEYS = ("expireTime", "expire_time", "expireAt", "expire_at",
                "expiredTime", "expired_at", "expiredAt", "validUntil")
_USED_KEYS = ("usedTime", "used_time", "usedAt", "used_at", "used")
_AGG_EXPIRE_KEYS = ("nearestExpireTime", "nearest_expire_time", "nearestExpireAt")


class CardsContractError(ValueError):
    """卡响应契约漂移: 消息含字段路径(fail loud, 供 T-13 金测试复用)。"""


class CardsAuthError(Exception):
    """网关鉴权失败(code=1001): 由上层续期/唤人(T-11), 本模块不吞。"""


def _now_int(now: int | None) -> int:
    return int(time.time()) if now is None else int(now)


def _to_epoch(value, where: str) -> int:
    """expire 值 → epoch 秒。支持: epoch ms/s(int) / ISO 串(无时区按 UTC+8)。"""
    if isinstance(value, bool):
        raise CardsContractError(f"{where}: expire 为布尔值")
    if isinstance(value, (int, float)):
        v = float(value)
        if v <= 0:
            raise CardsContractError(f"{where}: expire 非正数({value!r})")
        return int(v / 1000) if v > 1e12 else int(v)
    if isinstance(value, str):
        text = value.strip()
        try:
            dt = datetime.fromisoformat(text)  # py3.11 兼容 "2026-12-22 23:59:59"
        except ValueError as e:
            raise CardsContractError(f"{where}: expire 无法解析({value!r})") from e
        if dt.tzinfo is None:
            dt = dt.replace(tzinfo=_TZ_CN)
        return int(dt.timestamp())
    raise CardsContractError(f"{where}: expire 类型不支持({type(value).__name__})")


def _first_key(item: dict, keys, where: str, required: bool = True):
    for k in keys:
        if k in item and item[k] is not None:
            return item[k]
    if required:
        raise CardsContractError(f"{where}: 缺 expire 字段(候选 {list(keys)[:3]}...)")
    return None


def _is_available(item: dict) -> bool:
    for k in _USED_KEYS:
        v = item.get(k)
        if v:  # 已使用时间/标记非空 → 卡已花
            return False
    status = item.get("status", item.get("useState"))
    if status is None:
        return True  # 无状态字段按可用计(默认开放, 契约由 T-13 金测试钉死)
    s = str(status).strip().lower()
    return any(w in s for w in _AVAILABLE_WORDS)


def _pool_from_list(records, now: int, where: str) -> list[dict]:
    """逐卡列表 → 按 expire_at 聚合升序的 [{count, expire_at}]（剔除过期/已用）。"""
    groups: dict[int, int] = {}
    for i, item in enumerate(records):
        path = f"{where}[{i}]"
        if not isinstance(item, dict):
            raise CardsContractError(f"{path}: 卡条目非对象")
        expire_at = _to_epoch(_first_key(item, _EXPIRE_KEYS, path), path)
        if expire_at <= now or not _is_available(item):
            continue
        groups[expire_at] = groups.get(expire_at, 0) + 1
    return [{"count": c, "expire_at": e} for e, c in sorted(groups.items())]


def _pool_from_agg(obj: dict, now: int, where: str) -> list[dict]:
    """预聚合形状 {count, nearestExpireTime} → 同构输出（KB 注记的退化形状）。"""
    count = obj.get("count", obj.get("total", 0))
    if not isinstance(count, int) or count < 0:
        raise CardsContractError(f"{where}: count 非法({count!r})")
    raw_expire = _first_key(obj, _AGG_EXPIRE_KEYS, where, required=False)
    if count == 0 or raw_expire is None:
        return []
    expire_at = _to_epoch(raw_expire, where)
    if expire_at <= now:
        return []
    return [{"count": count, "expire_at": expire_at}]


def _pool(raw_pool, now: int, where: str) -> list[dict]:
    if isinstance(raw_pool, list):
        return _pool_from_list(raw_pool, now, where)
    if isinstance(raw_pool, dict):
        return _pool_from_agg(raw_pool, now, where)
    raise CardsContractError(f"{where}: 既非卡列表亦非聚合对象")


def parse_cards(raw: dict, now: int | None = None) -> dict:
    """真身响应 → CardInventory{five_hour, weekly, fetched_at}（纯函数）。

    raw 形状（KB rules-and-endpoints.md, z.ai 已验证）:
      {code?, data: {customerId?, fiveHourResets: [...], weekResets: [...]}}
    data 包裹层缺省时容忍顶层直挂。空池子段缺失按空计。
    """
    ts = _now_int(now)
    if not isinstance(raw, dict):
        raise CardsContractError("$.data: 响应非对象")
    body = raw.get("data") if isinstance(raw.get("data"), dict) else raw
    if not isinstance(body, dict):
        raise CardsContractError("$.data: 非对象")
    return {
        "five_hour": _pool(body.get("fiveHourResets", []), ts, "$.data.fiveHourResets"),
        "weekly": _pool(body.get("weekResets", []), ts, "$.data.weekResets"),
        "fetched_at": ts,
    }


def fifo_order(inventory: dict, card_type: str = "five_hour",
               now: int | None = None) -> list[dict]:
    """expire_at 升序的可用卡组（快过期先花; 已过期防御性剔除; 同刻稳定）。"""
    if card_type not in ("five_hour", "weekly"):
        raise ValueError(f"card_type 非法: {card_type!r}")
    ts = _now_int(now)
    return [g for g in inventory.get(card_type, []) if g["expire_at"] > ts]


def budget(inventory: dict, reserve_cards: int = 1,
           card_type: str = "five_hour", now: int | None = None) -> int:
    """可用预算 = max(可用卡数 − reserve_cards, 0)（EARS2 决策输入）。

    W0 实测: 3 张 5h 卡 reserve 1 → 2（用户令: 预留 1 张给自媒永动机）。
    reserve_cards 来自 T-03 policy 配置。
    """
    pool = fifo_order(inventory, card_type, now)
    usable = sum(g["count"] for g in pool)
    return max(int(usable) - max(int(reserve_cards), 0), 0)


def weekly_eligible(five_hour_exhausted: bool, weekly_quota_will_burn: bool) -> bool:
    """周卡门槛钩子(T-07 注入布尔信号): 5h 用尽 AND 周额度也预测烧穿。"""
    return bool(five_hour_exhausted) and bool(weekly_quota_will_burn)


def pick_card(inventory: dict, prefer: str = "five_hour", reserve_cards: int = 1,
              weekly_allowed: bool = False, now: int | None = None,
              waste_horizon_days: int = DEFAULT_WASTE_HORIZON_DAYS) -> dict:
    """FIFO 选卡（纯函数, 输出可序列化, 同输入同输出）。

    规则: prefer 池预算>0 → 选其最早过期卡; weekly 仅当 five_hour 用尽
    (预算 0)且 weekly_allowed(T-07 周额度预测烧穿信号)且周卡预算>0 时入选。
    would_expire_wasted: 距过期 < waste_horizon_days 天且本轮不花将作废的卡数
    （本轮花出的那张若在窗内则不计损）。
    返回 {card_type, expire_at, budget_after, would_expire_wasted,
          waste_horizon_days, note}。
    """
    if prefer not in ("five_hour", "weekly"):
        raise ValueError(f"prefer 非法: {prefer!r}")
    ts = _now_int(now)
    pools = {t: fifo_order(inventory, t, ts) for t in ("five_hour", "weekly")}
    bud = {t: budget(inventory, reserve_cards, t, ts) for t in ("five_hour", "weekly")}

    chosen, note = None, ""
    if prefer == "weekly":
        if bud["weekly"] > 0:
            chosen = "weekly"
        else:
            note = "weekly 预算 0(无可用周卡或仅剩预留)"
    else:
        if bud["five_hour"] > 0:
            chosen = "five_hour"
        elif bud["weekly"] > 0 and weekly_allowed:
            chosen = "weekly"
        else:
            note = ("five_hour 预算 0 且周卡门槛未满足(weekly_allowed=False)"
                    if bud["weekly"] > 0 else "five_hour 与 weekly 预算均为 0")

    # would_expire_wasted 预估: 两池全部在窗可用卡 − 本轮花出的 1 张
    horizon = max(int(waste_horizon_days), 0)
    wasted = 0
    if horizon > 0:
        window_end = ts + horizon * 86400
        wasted = sum(g["count"] for groups in pools.values() for g in groups
                     if ts < g["expire_at"] <= window_end)
        if chosen is not None and pools[chosen] and pools[chosen][0]["expire_at"] <= window_end:
            wasted -= 1  # 本轮花出的最早过期卡在窗内, 不计损

    return {
        "card_type": chosen,
        "expire_at": pools[chosen][0]["expire_at"] if chosen else None,
        "budget_after": max(bud[chosen] - 1, 0) if chosen else 0,
        "would_expire_wasted": max(wasted, 0),
        "waste_horizon_days": horizon,
        "note": note,
    }


# ---------------- 网络层（transport 可注入; 测试零真请求） ----------------

def _default_transport(url: str, headers: dict):
    """stdlib urllib 兜底 transport: → (status, 已解析 JSON dict 或原文本)。"""
    import json as _json
    import urllib.error
    import urllib.request

    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            body = resp.read().decode("utf-8", "replace")
            status = resp.status
    except urllib.error.HTTPError as e:
        status = e.code
        body = e.read().decode("utf-8", "replace")
    try:
        return status, _json.loads(body)
    except (ValueError, TypeError):
        return status, body


def _fallback_inventory(now: int, note: str) -> dict:
    """ConsoleFallback 标记的空库存: 不抛死, 注记供面板/企微(T-08/T-12)。"""
    return {"five_hour": [], "weekly": [], "fetched_at": now,
            "console_fallback": True, "note": note}


def fetch_cards(base_url: str, api_key: str = "", transport=None,
                target_type: str = "PERSONAL", now: int | None = None,
                timeout: int = 15) -> dict:
    """GET /api/biz/customer-package-reset/list?targetType=… → CardInventory。

    - 200 且可解析 → parse_cards
    - 404/405/501(bigmodel 端点未验证, 依 T-01 结论) → ConsoleFallback 标记不抛死
    - 网关 code=1001 → CardsAuthError（上层续期, 与 T-04 quota 链路语义一致）
    - 其余非 200/解析失败 → ConsoleFallback 标记不抛死
    """
    ts = _now_int(now)
    url = base_url.rstrip("/") + CARD_ENDPOINT_PATH + "?targetType=" + target_type
    headers = {"Accept": "application/json",
               "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}
    if api_key:
        headers["Authorization"] = f"Bearer {api_key}"
    send = transport or _default_transport
    status, body = send(url, headers)

    if status != 200:
        note = f"卡端点 HTTP {status} 未验证 → ConsoleFallback(API 腿不可用, W2 后接)"
        return _fallback_inventory(ts, note)
    if isinstance(body, dict):
        code = body.get("code")
        if code == 1001:
            raise CardsAuthError("卡库存端点网关鉴权失败 code=1001")
    try:
        return parse_cards(body, now=ts)
    except CardsContractError as e:
        return _fallback_inventory(ts, f"卡响应契约漂移: {e} → ConsoleFallback")


def fetch_via_console(page):
    """ConsoleFallback 预留位: API 不可用时浏览器兜底挂点（W2/T-09 抓包定版后实现）。

    page = DrissionPage ChromiumPage(9341 独立 profile, 见 ARCHITECTURE browser 节)。
    """
    raise NotImplementedError("ConsoleFallback 浏览器腿待 W2 抓包定版后接入(T-09/T-10)")
