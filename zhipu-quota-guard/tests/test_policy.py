# -*- coding: utf-8 -*-
"""T-07 policy 决策引擎测试 — EARS1/EARS2/EARS5 + 零误重置(NFR2) + 边界/幂等/冷却/回放。

覆盖 tasks.json T-07 验收标准：
- EARS1 reset 双门槛（水位≥threshold_pct 且 提前量≥lead_time_min）与 29/30min 边界
- EARS2 卡预算=0 → notify_only + 卡不足建议；未达重置条件时不误报（不刷屏企微）
- EARS5 dry_run 同规则 + simulated=true；notify_only 模式永不 reset
- NFR2 零误重置：自然刷新可覆盖 → wait；速率 0 → wait
- 周卡双门槛、FIFO 快过期先花、同窗幂等、同卡 24h 失败>2 冷却、同输入逐字节回放
- 鸭子类型输入：dict 与 dataclass(T-03 Config)/SimpleNamespace 皆可

基准数字（离线可回放）：now=NOW, remaining=600, rate=20积分/min → 30min 烧穿
exhaust=NOW+1800；自然刷新 NOW+4500 → 提前量 45min。
"""
from dataclasses import asdict
from types import SimpleNamespace

import json

import pytest

from zqg.policy import Decision, PolicyError, decide

NOW = 1700000000
FIVE_EXPIRE_AT = NOW + 60 * 86400  # 基准 5h 卡过期时刻(60 天后)


# ---------- 固定输入工厂（全部显式注入 now，决策确定性可回放） ----------

def snap(window_pct=95.0, remaining=600.0, next_reset_at=NOW + 4500, ts=NOW):
    """QuotaSnapshot(SCHEMAS §2) dict 形态：window_pct/remaining/next_reset_at/ts。"""
    return {"ts": ts, "provider": "zai", "window_pct": window_pct,
            "remaining": remaining, "next_reset_at": next_reset_at, "raw": {}}


def burn(rate=20.0, peak=True):
    """BurnRate(SCHEMAS §2) dict 形态：tokens_per_min/peak_now。"""
    return {"tokens_per_min": rate, "peak_now": peak}


def cards(five_hour=3, weekly=0, five_expire_days=60):
    """CardInventory(SCHEMAS §2) dict 形态：five_hour/weekly 按 expire_at 聚合。"""
    inv = {"five_hour": [], "weekly": [], "fetched_at": NOW}
    if five_hour:
        inv["five_hour"] = [{"count": five_hour,
                             "expire_at": NOW + five_expire_days * 86400}]
    if weekly:
        inv["weekly"] = [{"count": weekly, "expire_at": NOW + 200 * 86400}]
    return inv


def conf(mode="auto", reserve=1, lead=30, fifo=True, threshold=90):
    """config(SCHEMAS §3) dict 形态：poll.threshold_pct + policy 四字段。"""
    return {"poll": {"threshold_pct": threshold},
            "policy": {"reserve_cards": reserve, "lead_time_min": lead,
                       "fifo_by_expiry": fifo, "mode": mode}}


def entry(kind, payload, ts=NOW - 3600):
    """RunLedgerEntry(SCHEMAS §2)：ts 为 epoch 毫秒（T-02 账本口径）。"""
    return {"ts": ts * 1000, "kind": kind, "payload": payload}


# ---------- EARS1：水位≥阈值 且 提前量≥lead → reset ----------

class TestEars1Reset:
    def test_reset_when_threshold_and_margin_met(self):
        d = decide(snap(), burn(), cards(3), conf(), [], now=NOW)
        assert d.action == "reset"
        assert d.card_to_use == "five_hour"
        assert d.simulated is False
        assert d.predicted_exhaust_at == NOW + 1800
        # reason=企微推送原文：含提前X分钟/卡余Y张数字
        assert "提前45分钟" in d.reason
        assert "用后卡余1张" in d.reason  # 预算 3-预留1=2，花 1 张后余 1

    def test_boundary_margin_30_reset_29_wait(self):
        # exhaust=NOW+1800：next_reset=NOW+3600 → 提前恰 30min(>=) → reset
        d30 = decide(snap(next_reset_at=NOW + 3600), burn(), cards(3), conf(), [], now=NOW)
        assert d30.action == "reset"
        # next_reset=NOW+3540 → 提前恰 29min(<) → wait
        d29 = decide(snap(next_reset_at=NOW + 3540), burn(), cards(3), conf(), [], now=NOW)
        assert d29.action == "wait"
        assert "提前29分钟" in d29.reason

    def test_wait_when_pct_below_threshold(self):
        d = decide(snap(window_pct=80.0), burn(), cards(3), conf(), [], now=NOW)
        assert d.action == "wait"
        assert d.card_to_use is None
        assert "水位80%" in d.reason


# ---------- EARS2：卡预算=0 → 不重置 + 卡不足建议 + notify_only ----------

class TestEars2CardShortage:
    def test_notify_only_when_budget_zero(self):
        d = decide(snap(), burn(), cards(five_hour=1), conf(), [], now=NOW)  # 1张-预留1=0
        assert d.action == "notify_only"
        assert d.card_to_use is None
        assert d.simulated is False
        assert "卡预算0" in d.reason and "建议" in d.reason

    def test_no_shortage_spam_when_not_reset_worthy(self):
        # 未达重置条件(自然刷新可覆盖)时即便 0 卡也 wait——不给企微刷屏
        d = decide(snap(remaining=2400.0), burn(), cards(five_hour=0), conf(), [], now=NOW)
        assert d.action == "wait"


# ---------- EARS5：dry_run 同规则 simulated=true；notify_only 永不 reset ----------

class TestEars5Mode:
    def test_dry_run_simulated_reset(self):
        d = decide(snap(), burn(), cards(3), conf(mode="dry_run"), [], now=NOW)
        assert d.action == "reset"           # action 照算
        assert d.simulated is True           # 附 simulated=true
        assert d.card_to_use == "five_hour"
        assert "dry_run" in d.reason

    def test_notify_only_mode_never_resets(self):
        d = decide(snap(), burn(), cards(3), conf(mode="notify_only"), [], now=NOW)
        assert d.action == "notify_only"
        assert d.card_to_use is None
        assert d.simulated is False
        assert "仅通知" in d.reason

    def test_dry_run_marks_simulated_on_wait_too(self):
        d = decide(snap(remaining=2400.0), burn(), cards(3), conf(mode="dry_run"),
                   [], now=NOW)
        assert d.action == "wait" and d.simulated is True


# ---------- NFR2 零误重置：自然刷新能覆盖 → wait，不花卡 ----------

class TestNfr2ZeroFalseReset:
    def test_wait_when_natural_refresh_covers(self):
        # remaining=2400/rate20 → 120min 烧穿，晚于 NOW+4500 刷新 → 自然刷新覆盖
        d = decide(snap(remaining=2400.0), burn(), cards(3), conf(), [], now=NOW)
        assert d.action == "wait"
        assert d.card_to_use is None
        assert d.predicted_exhaust_at == NOW + 7200
        assert "自然刷新可覆盖" in d.reason

    def test_wait_when_rate_zero(self):
        d = decide(snap(), burn(rate=0.0), cards(3), conf(), [], now=NOW)
        assert d.action == "wait"
        assert d.predicted_exhaust_at is None
        assert "无烧穿风险" in d.reason


# ---------- FR5 周卡双门槛：5h 用尽 且 周额度也预测烧穿 才可用周卡 ----------

class TestWeeklyDoubleGate:
    def test_weekly_used_only_when_gate_open(self):
        inv = cards(five_hour=1, weekly=2)  # 5h 预算 0；周卡 2-预留1=1
        d_closed = decide(snap(), burn(), inv, conf(), [], now=NOW,
                          weekly_quota_will_burn=False)
        assert d_closed.action == "notify_only"
        assert d_closed.card_to_use is None
        assert "周卡" in d_closed.reason
        d_open = decide(snap(), burn(), inv, conf(), [], now=NOW,
                        weekly_quota_will_burn=True)
        assert d_open.action == "reset"
        assert d_open.card_to_use == "weekly"

    def test_five_hour_preferred_over_weekly(self):
        d = decide(snap(), burn(), cards(five_hour=3, weekly=2), conf(), [], now=NOW,
                   weekly_quota_will_burn=True)
        assert d.card_to_use == "five_hour"


# ---------- FR5 FIFO：快过期先花（would_expire_wasted 规避）；过期卡不算预算 ----------

class TestFifoEarliestExpiry:
    @staticmethod
    def _two_groups():
        return {"five_hour": [{"count": 1, "expire_at": NOW + 10 * 86400},
                              {"count": 1, "expire_at": NOW + 60 * 86400}],
                "weekly": [], "fetched_at": NOW}

    def test_earliest_expiry_spent_first(self):
        d = decide(snap(), burn(), self._two_groups(), conf(reserve=0), [], now=NOW)
        assert d.action == "reset"
        assert "该卡10天后过期" in d.reason

    def test_fifo_flag_off_picks_latest(self):
        d = decide(snap(), burn(), self._two_groups(), conf(reserve=0, fifo=False),
                   [], now=NOW)
        assert d.action == "reset"
        assert "该卡60天后过期" in d.reason

    def test_expired_cards_excluded_from_budget(self):
        inv = {"five_hour": [{"count": 5, "expire_at": NOW - 60}],
               "weekly": [], "fetched_at": NOW}
        d = decide(snap(), burn(), inv, conf(), [], now=NOW)
        assert d.action == "notify_only"  # 全过期 → 预算 0 → 卡不足


# ---------- 幂等：同窗口(同 next_reset_at)已 reset 过 → wait；模拟不占卡 ----------

class TestIdempotency:
    def test_same_window_reset_exec_blocks_second(self):
        led = [entry("reset_exec", {"next_reset_at": NOW + 4500})]
        d = decide(snap(), burn(), cards(3), conf(), led, now=NOW)
        assert d.action == "wait"
        assert "已重置过" in d.reason

    def test_decision_entry_counts_and_other_window_does_not(self):
        led = [entry("decision", {"action": "reset", "next_reset_at": NOW + 4500})]
        assert decide(snap(), burn(), cards(3), conf(), led, now=NOW).action == "wait"
        led_next = [entry("reset_exec", {"next_reset_at": NOW + 8100})]  # 下一窗
        assert decide(snap(), burn(), cards(3), conf(), led_next, now=NOW).action == "reset"

    def test_simulated_dry_run_does_not_block_auto(self):
        led = [entry("decision", {"action": "reset", "next_reset_at": NOW + 4500,
                                  "simulated": True})]
        assert decide(snap(), burn(), cards(3), conf(), led, now=NOW).action == "reset"


# ---------- 冷却：同卡(同 card_type+expire_at) 24h 内失败>2 次 → notify_only ----------

class TestCooldown:
    KEY = {"card_type": "five_hour", "expire_at": FIVE_EXPIRE_AT}

    def test_three_failures_within_24h_cool_down(self):
        led = [entry("reset_result", dict(self.KEY, ok=False), ts=NOW - i * 600)
               for i in range(3)]
        d = decide(snap(), burn(), cards(3), conf(), led, now=NOW)
        assert d.action == "notify_only"
        assert d.card_to_use is None
        assert "冷却" in d.reason

    def test_two_failures_still_reset(self):
        led = [entry("reset_result", dict(self.KEY, ok=False), ts=NOW - 600),
               entry("reset_result", dict(self.KEY, ok=False), ts=NOW - 1200)]
        assert decide(snap(), burn(), cards(3), conf(), led, now=NOW).action == "reset"

    def test_old_success_other_card_failures_ignored(self):
        led = [
            entry("reset_result", dict(self.KEY, ok=False), ts=NOW - 90000),  # >24h
            entry("reset_result", dict(self.KEY, ok=True), ts=NOW - 600),     # 成功
            entry("reset_result", {"card_type": "five_hour",
                                   "expire_at": NOW + 7 * 86400,
                                   "ok": False}, ts=NOW - 600),               # 他卡
        ]
        assert decide(snap(), burn(), cards(3), conf(), led, now=NOW).action == "reset"


# ---------- ADR3 可回放：同输入两次调用逐字节一致 ----------

class TestReplay:
    def test_same_input_byte_identical(self):
        args = (snap(), burn(), cards(3), conf(), [entry("poll", {"seq": 1})])
        d1 = decide(*args, now=NOW)
        d2 = decide(*args, now=NOW)
        assert d1 == d2
        assert json.dumps(asdict(d1)) == json.dumps(asdict(d2))


# ---------- 鸭子类型：dict/dataclass/SimpleNamespace 混吃；Decision 形状 ----------

class TestDuckTyping:
    def test_accepts_dataclass_config_and_attr_snapshot(self):
        from zqg.config import Config, PolicyCfg, PollCfg  # T-03 产物(dataclass)
        cfg = Config(poll=PollCfg(threshold_pct=90), policy=PolicyCfg(mode="dry_run"))
        s = SimpleNamespace(window_pct=95.0, remaining=600.0, next_reset_at=NOW + 4500)
        d = decide(s, burn(), cards(3), cfg, [], now=NOW)
        assert d.action == "reset"
        assert d.simulated is True

    def test_decision_shape_matches_schemas(self):
        d = decide(snap(), burn(rate=0.0), cards(3), conf(), [], now=NOW)
        assert isinstance(d, Decision)
        assert set(d.to_dict()) == {"action", "reason", "predicted_exhaust_at",
                                    "card_to_use", "simulated"}
        assert d.action in ("reset", "wait", "notify_only")

    def test_invalid_mode_raises(self):
        with pytest.raises(PolicyError):
            decide(snap(), burn(), cards(3), conf(mode="yolo"), [], now=NOW)
