# -*- coding: utf-8 -*-
"""T-07 policy 决策引擎 — 烧穿比对+卡预算FIFO+lead_time+mode 全分支（FR4/FR5, EARS1/2/5）。

纯函数、确定性、可回放（ADR3：决策全由规则算出，LLM 不进决策链；同输入同输出）。
输入鸭子类型，本模块不 import predictor/cards/config，按 SCHEMAS §2/§3 字段名取值，
dict 与 dataclass 皆可（属性/键双通道）：
- snapshot: {window_pct, remaining, next_reset_at, ts?}
- burn:     {tokens_per_min, peak_now?}        # 速率 0/缺省 → 无烧穿预测
- cards:    {five_hour: [{count, expire_at}], weekly: [...], fetched_at}
- config:   poll.threshold_pct + policy.{reserve_cards, lead_time_min,
             fifo_by_expiry, mode: auto|dry_run|notify_only}（T-03 dataclass 或 dict）
- recent_ledger: 可迭代的账本条目 {ts, kind, payload}（T-02 口径，ts 为 epoch 毫秒，
             秒值亦容忍）

决策序（固定，规则确定可回放）：
 1) 幂等门：同刷新窗（payload.next_reset_at 与本窗相同）已有非模拟 reset ——
    kind=reset_exec，或 kind=decision 且 payload.action="reset" —— → wait。
    simulated=true 的 dry_run 条目不计（模拟不占卡，不得阻塞后续 auto 实弹）。
 2) 速率 0 → wait（无烧穿预测，自然刷新兜底，NFR2 零误重置）。
 3) 自然刷新可覆盖（提前量 < lead_time_min）→ wait。
 4) 水位 < threshold_pct → wait（EARS1 双门槛）。
 5) 卡预算（可用 − reserve_cards，下限 0）：5h 预算 0 且周卡双门槛（5h 用尽 ∧
    weekly_quota_will_burn 注入信号）未满足或周预算 0 → notify_only 卡不足建议（EARS2）。
 6) 候选卡 24h 内失败 > 2 次（reset_result 条目，按 (card_type, expire_at) 识别同卡，
    失败=ok/success 为 False 或 result ∈ fail|failed|false）→ notify_only 冷却。
 7) mode：auto → reset；dry_run → 同规则 reset 且 simulated=true（EARS5）；
    notify_only → 永不 reset，降级为仅通知。

烧穿折算（④）：minutes_left = remaining / tokens_per_min（积分速率）；
predicted_exhaust_at = now + minutes_left*60。选卡：fifo_by_expiry=true 时快过期先花
（would_expire_wasted 规避——自然刷新前将过期的卡优先标损），false 时取最晚过期。

reason 为一句人读中文、含关键数字（提前X分钟/卡余Y张），即企微推送原文（T-08/T-12 直接用）。
时钟可注入（now=epoch 秒或 callable），供测试与 T-11 注入复用。Python 标准库 only。
"""
from __future__ import annotations

import time
from dataclasses import asdict, dataclass

__all__ = ["Decision", "PolicyError", "decide"]

_H24 = 86400
_VALID_ACTIONS = ("reset", "wait", "notify_only")
_VALID_MODES = ("auto", "dry_run", "notify_only")


class PolicyError(ValueError):
    """决策输入非法（如 policy.mode 拼错）；fail loud，不静默猜测。"""


@dataclass(frozen=True)
class Decision:
    """SCHEMAS §2 Decision：决策引擎产出，字段可 JSON 序列化（账本/面板/企微消费）。"""
    action: str                       # "reset" | "wait" | "notify_only"
    reason: str                       # 人读理由（企微推送原文，含数字）
    predicted_exhaust_at: int | None  # epoch 秒；速率 0 时 None
    card_to_use: str | None           # "five_hour" | "weekly" | None
    simulated: bool = False           # mode=dry_run 时 true（EARS5），其余 false

    def to_dict(self) -> dict:
        return asdict(self)


# ---------------- 鸭子类型取值（dict 键 / dataclass 属性双通道） ----------------

def _get(obj, name, default=None):
    if obj is None:
        return default
    if isinstance(obj, dict):
        return obj.get(name, default)
    return getattr(obj, name, default)


def _norm_ts(ts) -> int:
    """账本条目 ts → epoch 秒（T-02 落盘为毫秒；容忍秒值/缺省 0）。"""
    try:
        v = int(ts or 0)
    except (TypeError, ValueError):
        return 0
    return v // 1000 if v > 1_000_000_000_000 else v


def _now(now) -> int:
    if callable(now):
        return int(now())
    if now is not None:
        return int(now)
    return int(time.time())


def _usable_pool(inventory, card_type: str, now: int) -> list[tuple[int, int]]:
    """[(expire_at, count)] 升序（同刻稳定）；剔除已过期/零张组。"""
    pool = _get(inventory, card_type) or []
    groups = []
    for g in pool:
        if not isinstance(g, dict):
            g = {"count": _get(g, "count", 0), "expire_at": _get(g, "expire_at")}
        cnt = _get(g, "count", 0) or 0
        exp = _get(g, "expire_at")
        if isinstance(exp, (int, float)) and not isinstance(exp, bool) and exp > now \
                and isinstance(cnt, (int, float)) and cnt > 0:
            groups.append((int(exp), int(cnt)))
    return sorted(groups)


def _already_reset_this_window(recent_ledger, next_reset_at: int) -> bool:
    for e in recent_ledger or ():
        kind = _get(e, "kind")
        payload = _get(e, "payload") or {}
        if _get(payload, "simulated") is True:  # dry_run 模拟不占卡不阻塞
            continue
        if kind == "reset_exec":
            if _get(payload, "next_reset_at") == next_reset_at:
                return True
        elif kind == "decision":
            if _get(payload, "action") == "reset" and \
                    _get(payload, "next_reset_at") == next_reset_at:
                return True
    return False


def _failures_on_card(recent_ledger, card_type: str, expire_at: int, now: int) -> int:
    """24h 内同一张卡（card_type+expire_at 二元组识别）的重置失败次数。"""
    key = (card_type, expire_at)
    fails = 0
    for e in recent_ledger or ():
        if _get(e, "kind") != "reset_result":
            continue
        if now - _norm_ts(_get(e, "ts")) > _H24:
            continue
        p = _get(e, "payload") or {}
        ok = _get(p, "ok", _get(p, "success", True))
        result = str(_get(p, "result", "")).lower()
        failed = ok is False or result in ("fail", "failed", "false")
        if failed and (_get(p, "card_type"), _get(p, "expire_at")) == key:
            fails += 1
    return fails


# ---------------- 决策入口 ----------------

def decide(snapshot, burn, cards, config, recent_ledger=(), *, now=None,
           weekly_quota_will_burn: bool = False) -> Decision:
    """按固定规则序产出 Decision（纯函数，同输入同输出，可回放）。

    weekly_quota_will_burn：周额度也预测烧穿的注入信号（cards.weekly_eligible 钩子的
    T-07 侧布尔输入；默认 False——周卡双门槛保守关闭）。
    """
    ts_now = _now(now)
    window_pct = float(_get(snapshot, "window_pct", 0.0) or 0.0)
    remaining = float(_get(snapshot, "remaining", 0.0) or 0.0)
    next_reset_at = int(_get(snapshot, "next_reset_at", 0) or 0)

    policy = _get(config, "policy") or {}
    mode = _get(policy, "mode", "dry_run")
    if mode not in _VALID_MODES:
        raise PolicyError(
            f"policy.mode 非法 {mode!r}（允许 {'|'.join(_VALID_MODES)}）")
    reserve = int(_get(policy, "reserve_cards", 1) or 0)
    lead_min = int(_get(policy, "lead_time_min", 30) or 30)
    fifo = _get(policy, "fifo_by_expiry", True)
    fifo = bool(fifo) if fifo is not None else True
    threshold = int(_get(_get(config, "poll") or {}, "threshold_pct", 90) or 90)

    simulated = mode == "dry_run"

    # ④ 剩余额度按积分速率折算分钟数（速率<=0 → 无预测）
    minutes_left = (remaining / rate) if (rate := float(
        _get(burn, "tokens_per_min", 0.0) or 0.0)) > 0 else None
    exhaust_at = int(ts_now + minutes_left * 60) if minutes_left is not None else None
    margin_min = ((next_reset_at - exhaust_at) / 60.0
                  if exhaust_at is not None else None)

    pools = {t: _usable_pool(cards, t, ts_now) for t in ("five_hour", "weekly")}
    usable = {t: sum(c for _, c in pools[t]) for t in pools}
    budget = {t: max(usable[t] - max(reserve, 0), 0) for t in pools}

    def wait(reason: str) -> Decision:
        return Decision("wait", reason, exhaust_at, None, simulated)

    # 1) 幂等门：同刷新窗已 reset 过（非模拟）→ wait
    if _already_reset_this_window(recent_ledger, next_reset_at):
        extra = (f"，距自然刷新仍提前{margin_min:.0f}分钟"
                 if margin_min is not None else "")
        return wait(f"本刷新窗已重置过（幂等去重）{extra}，不再重复花卡")

    # 2) 无速率 → 无烧穿风险
    if exhaust_at is None:
        return wait(f"本地遥测速率0，无烧穿风险（水位{window_pct:.0f}%），等待自然刷新")

    # 2.5) CC 空闲门（1023 用户令）：无任务在跑就不花卡，等自然刷新
    last_at = _get(burn, "last_record_at", None)
    idle_grace = int(_get(policy, "idle_grace_min", 10) or 10)
    if last_at and (ts_now - float(last_at)) > idle_grace * 60:
        idle_min = (ts_now - float(last_at)) / 60.0
        return wait(f"CC 已空闲{idle_min:.0f}分钟（>宽限{idle_grace}分），不花卡——"
                    f"尾速预测的烧穿不会兑现，等自然刷新或任务恢复")

    # 3) 自然刷新可覆盖 → 零误重置（NFR2）
    if margin_min < lead_min:
        return wait(f"自然刷新可覆盖：预测{minutes_left:.0f}分钟后烧穿，距刷新仅提前"
                    f"{margin_min:.0f}分钟（<门槛{lead_min}分钟），不花卡")

    # 4) EARS1 双门槛：水位未达阈值
    if window_pct < threshold:
        return wait(f"烧穿提前量{margin_min:.0f}分钟达标，但水位{window_pct:.0f}%"
                    f"<阈值{threshold}%，继续等待")

    # 5) 选卡：5h FIFO 优先；5h 预算 0 且周卡双门槛开且周预算>0 才用周卡
    card_type, chosen = None, None
    if budget["five_hour"] > 0:
        card_type = "five_hour"
        chosen = pools["five_hour"][0 if fifo else -1]
    elif budget["weekly"] > 0 and weekly_quota_will_burn:
        card_type = "weekly"
        chosen = pools["weekly"][0 if fifo else -1]
    if card_type is None:
        if usable["weekly"] > 0 and not weekly_quota_will_burn:
            reason = (f"已到重置条件（提前{margin_min:.0f}分钟，水位{window_pct:.0f}%）"
                      f"但5h卡预算0（可用{usable['five_hour']}张-预留{reserve}张），"
                      f"周卡双门槛未满足（周额度未预测烧穿）；建议补充5h卡")
        else:
            reason = (f"已到重置条件（提前{margin_min:.0f}分钟，水位{window_pct:.0f}%）"
                      f"但卡预算0（5h可用{usable['five_hour']}张-预留{reserve}张）；"
                      f"建议尽快补充重置卡或降低消耗")
        return Decision("notify_only", reason, exhaust_at, None, simulated)

    # 6) 同卡 24h 内失败 > 2 次 → 冷却
    fails = _failures_on_card(recent_ledger, card_type, chosen[0], ts_now)
    if fails > 2:
        return Decision(
            "notify_only",
            f"已到重置条件但候选{card_type}卡24小时内已失败{fails}次进入冷却，"
            f"暂停自动重用；建议人工排查重置链路",
            exhaust_at, None, simulated)

    # 7) mode 分支：notify_only 永不 reset；dry_run 同规则附 simulated
    if mode == "notify_only":
        return Decision(
            "notify_only",
            f"已到重置条件（提前{margin_min:.0f}分钟，卡预算{budget[card_type]}张）"
            f"但mode=notify_only仅通知不执行；确认后可切auto",
            exhaust_at, None, False)

    days = (chosen[0] - ts_now) // 86400
    reason = (f"预测{minutes_left:.0f}分钟后烧穿，较自然刷新提前{margin_min:.0f}分钟"
              f"（≥门槛{lead_min}），水位{window_pct:.0f}%≥{threshold}%，"
              f"花费{card_type}卡（该卡{days}天后过期，"
              f"用后卡余{budget[card_type] - 1}张）")
    if simulated:
        reason += "；dry_run模拟，不实际执行"
    return Decision("reset", reason, exhaust_at, card_type, simulated)
