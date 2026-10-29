# -*- coding: utf-8 -*-
"""T-05 卡库存+预算 FIFO — tests（先测后实现, FR2/FR5）

W0 实测场景锚点（W0_RECON.md 2026-10-23, API 腿实测）:
- 3 张 5h 卡 recordId 6/7/8, GLOBAL, 全部 available, expire 2026-12-22 23:59:59, 从未使用
- 周卡 0 张
- 用户令: 预留 1 张给自媒永动机 → 3-1=2 可动用
- expire 字符串为无时区字面值, 按 UTC+8 解析: 2026-12-22 23:59:59+08:00 = epoch 1797955199

运行: e:/AI-Station/.venv/Scripts/python.exe -m pytest zhipu-quota-guard/tests/test_cards.py -q
(在 T-02 conftest.py 就位前, 本文件自举注入项目根到 sys.path; conftest 就位后二者兼容)
"""
import json
import sys
from pathlib import Path

import pytest

_ROOT = str(Path(__file__).resolve().parents[1])  # zhipu-quota-guard/
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from zqg import cards  # noqa: E402  (自举后导入)

NOW = 1792838400  # 固定时钟(2026-10-24 前后), 早于一切未来过期时刻, 保证断言确定性

# W0 真身响应形状(KB rules-and-endpoints.md: fiveHourResets/weekResets + customerId)
W0_RAW = {
    "code": 200,
    "data": {
        "customerId": "26081768204143049",
        "fiveHourResets": [
            {"recordId": 6, "scope": "GLOBAL", "status": "AVAILABLE",
             "expireTime": "2026-12-22 23:59:59"},
            {"recordId": 7, "scope": "GLOBAL", "status": "AVAILABLE",
             "expireTime": "2026-12-22 23:59:59"},
            {"recordId": 8, "scope": "GLOBAL", "status": "AVAILABLE",
             "expireTime": "2026-12-22 23:59:59"},
        ],
        "weekResets": [],
    },
}

EXP_1222 = 1797955199  # 2026-12-22 23:59:59 UTC+8
EXP_1130 = 1796054399  # 2026-11-30 23:59:59 UTC+8
EXP_1210 = 1796918399  # 2026-12-10 23:59:59 UTC+8


def _inv_five_hour(records, weekly=()):
    return cards.parse_cards(
        {"data": {"fiveHourResets": list(records), "weekResets": list(weekly)}},
        now=NOW,
    )


# ---------- FR2: reset/list 转 CardInventory ----------

def test_t05_fr2_parse_w0_real_shape():
    """W0 真身回放: 3 卡聚合一组, 最近过期时间按 UTC+8 精确解析, 周卡空。"""
    inv = cards.parse_cards(W0_RAW, now=NOW)
    assert inv["five_hour"] == [{"count": 3, "expire_at": EXP_1222}]
    assert inv["weekly"] == []
    assert inv["fetched_at"] == NOW


def test_t05_fr2_parse_dedup_by_expiry_and_order():
    """按最近过期聚合: 不同过期时刻分组且 expire_at 升序。"""
    inv = _inv_five_hour([
        {"recordId": 1, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 2, "status": "AVAILABLE", "expireTime": "2026-11-30 23:59:59"},
        {"recordId": 3, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 4, "status": "AVAILABLE", "expireTime": "2026-12-10 23:59:59"},
    ])
    assert inv["five_hour"] == [
        {"count": 1, "expire_at": EXP_1130},
        {"count": 1, "expire_at": EXP_1210},
        {"count": 2, "expire_at": EXP_1222},
    ]


def test_t05_fr2_parse_excludes_expired_cards():
    """含过期卡剔除: expire_at <= now 的卡不进库存(测试要求逐字)。"""
    inv = _inv_five_hour([
        {"recordId": 1, "status": "AVAILABLE", "expireTime": "2026-10-01 00:00:00"},
        {"recordId": 2, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
    ])
    assert inv["five_hour"] == [{"count": 1, "expire_at": EXP_1222}]


def test_t05_fr2_parse_excludes_used_cards():
    """已用/不可用状态的卡剔除(status 非可用 或 usedTime 已置)。"""
    inv = _inv_five_hour([
        {"recordId": 1, "status": "USED", "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 2, "status": "AVAILABLE", "usedTime": "2026-10-23 10:00:00",
         "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 3, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
    ])
    assert inv["five_hour"] == [{"count": 1, "expire_at": EXP_1222}]


def test_t05_fr2_parse_contract_error_names_field():
    """缺 expire 字段的卡: 抛 CardsContractError 且消息含字段路径(fail loud, 纯函数层)。"""
    with pytest.raises(cards.CardsContractError) as ei:
        cards.parse_cards(
            {"data": {"fiveHourResets": [{"recordId": 9, "status": "AVAILABLE"}],
                      "weekResets": []}},
            now=NOW,
        )
    assert "expire" in str(ei.value)


def test_t05_fr2_fetch_cards_fake_transport_replay():
    """fake transport 回放真身 fixture, 不发真请求(DoD 实测要求)。"""
    calls = []

    def fake_transport(url, headers):
        calls.append((url, headers))
        return 200, W0_RAW

    inv = cards.fetch_cards(
        "https://api.z.ai", api_key="sk-test-1234", transport=fake_transport, now=NOW)
    assert inv["five_hour"] == [{"count": 3, "expire_at": EXP_1222}]
    assert inv["weekly"] == []
    assert len(calls) == 1
    url, headers = calls[0]
    assert "/api/biz/customer-package-reset/list?targetType=PERSONAL" in url
    assert headers["Authorization"] == "Bearer sk-test-1234"


def test_t05_fr2_fetch_404_console_fallback_not_fatal():
    """端点未验证/404: 打 ConsoleFallback 标记+注记, 不抛死(DoD)。"""
    inv = cards.fetch_cards(
        "https://open.bigmodel.cn", api_key="sk-test-1234",
        transport=lambda url, headers: (404, {"code": 404}), now=NOW)
    assert inv["five_hour"] == [] and inv["weekly"] == []
    assert inv.get("console_fallback") is True
    assert inv.get("note")


def test_t05_fr2_fetch_auth_1001_raises_typed():
    """网关鉴权 1001: 抛类型化 CardsAuthError 供上层续期(与 T-04 语义一致)。"""
    with pytest.raises(cards.CardsAuthError):
        cards.fetch_cards(
            "https://api.z.ai", api_key="sk-wrong",
            transport=lambda url, headers: (200, {"code": 1001, "msg": "no auth"}), now=NOW)


def test_t05_fr2_fetch_via_console_stub_reserved():
    """ConsoleFallback 预留位: W2 后接, 当前显式 NotImplementedError。"""
    with pytest.raises(NotImplementedError):
        cards.fetch_via_console(page=object())


# ---------- FR5: 卡预算 + FIFO + 周卡门槛 ----------

def test_t05_fr5_budget_w0_three_cards_reserve_one():
    """W0 实测场景: 3 卡预留 1 → 预算 2(用户令默认规则)。"""
    inv = cards.parse_cards(W0_RAW, now=NOW)
    assert cards.budget(inv, reserve_cards=1) == 2


def test_t05_fr5_budget_floor_zero():
    """0 卡得 0; 预留超库存下限 0(EARS2 决策输入)。"""
    empty = cards.parse_cards({"data": {"fiveHourResets": [], "weekResets": []}}, now=NOW)
    assert cards.budget(empty, reserve_cards=1) == 0
    inv = cards.parse_cards(W0_RAW, now=NOW)
    assert cards.budget(inv, reserve_cards=5) == 0


def test_t05_fr5_budget_excludes_expired_and_weekly_type():
    """预算只数可用卡; card_type='weekly' 按周卡池计。"""
    inv = _inv_five_hour(
        [{"recordId": 1, "status": "AVAILABLE", "expireTime": "2026-10-01 00:00:00"},
         {"recordId": 2, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"}],
        weekly=[{"recordId": 11, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"}],
    )
    assert cards.budget(inv, reserve_cards=1, card_type="five_hour") == 0  # 1可用-1预留
    assert cards.budget(inv, reserve_cards=1, card_type="weekly") == 0
    assert cards.budget(inv, reserve_cards=0, card_type="weekly") == 1


def test_t05_fr5_fifo_earliest_expiry_first():
    """FIFO: 快过期先花 — expire_at 早者排先。"""
    inv = _inv_five_hour([
        {"recordId": 1, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 2, "status": "AVAILABLE", "expireTime": "2026-11-30 23:59:59"},
        {"recordId": 3, "status": "AVAILABLE", "expireTime": "2026-12-10 23:59:59"},
    ])
    order = cards.fifo_order(inv, card_type="five_hour", now=NOW)
    assert [g["expire_at"] for g in order] == [EXP_1130, EXP_1210, EXP_1222]
    picked = cards.pick_card(inv, reserve_cards=0, now=NOW)
    assert picked["card_type"] == "five_hour"
    assert picked["expire_at"] == EXP_1130


def test_t05_fr5_fifo_same_expiry_stable_and_replayable():
    """全同 expiry(W0 现状): FIFO 退化为预算约束, 选择确定且两次逐字节一致。"""
    inv = cards.parse_cards(W0_RAW, now=NOW)
    a = cards.pick_card(inv, reserve_cards=1, now=NOW)
    b = cards.pick_card(inv, reserve_cards=1, now=NOW)
    assert a["card_type"] == "five_hour" and a["expire_at"] == EXP_1222
    assert json.dumps(a, sort_keys=True) == json.dumps(b, sort_keys=True)


def test_t05_fr5_reserve_blocks_last_card():
    """预算 0(只剩预留)时 pick 不到卡: card_to_use=None。"""
    one = _inv_five_hour([{"recordId": 6, "status": "AVAILABLE",
                           "expireTime": "2026-12-22 23:59:59"}])
    picked = cards.pick_card(one, reserve_cards=1, now=NOW)
    assert picked["card_type"] is None
    assert picked["budget_after"] == 0


def test_t05_fr5_weekly_never_when_five_hour_available():
    """周卡不抢 5h 卡: five_hour 预算>0 时永远选 five_hour。"""
    inv = _inv_five_hour(
        [{"recordId": 1, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"}],
        weekly=[{"recordId": 11, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"}],
    )
    picked = cards.pick_card(inv, reserve_cards=0, weekly_allowed=True, now=NOW)
    assert picked["card_type"] == "five_hour"


def test_t05_fr5_weekly_only_when_exhausted_and_allowed():
    """weekly 仅当 five_hour 用尽且周额度也将烧穿(weekly_allowed=True)才选。"""
    weekly_only = cards.parse_cards(
        {"data": {"fiveHourResets": [],
                  "weekResets": [{"recordId": 11, "status": "AVAILABLE",
                                  "expireTime": "2026-12-22 23:59:59"}]}},
        now=NOW)
    yes = cards.pick_card(weekly_only, reserve_cards=0, weekly_allowed=True, now=NOW)
    assert yes["card_type"] == "weekly" and yes["expire_at"] == EXP_1222
    no = cards.pick_card(weekly_only, reserve_cards=0, weekly_allowed=False, now=NOW)
    assert no["card_type"] is None


def test_t05_fr5_weekly_eligible_hook():
    """T-07 注入信号的钩子: 5h 用尽 AND 周额度预测烧穿 → 才可用周卡。"""
    assert cards.weekly_eligible(five_hour_exhausted=True, weekly_quota_will_burn=True)
    assert not cards.weekly_eligible(five_hour_exhausted=False, weekly_quota_will_burn=True)
    assert not cards.weekly_eligible(five_hour_exhausted=True, weekly_quota_will_burn=False)


def test_t05_fr5_would_expire_wasted_estimate():
    """would_expire_wasted: 距过期<N天且本轮不花将作废的卡数(本轮花 1 张扣除)。"""
    near = EXP_1222 - 2 * 86400  # 两天后过期
    inv = _inv_five_hour([
        {"recordId": 1, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 2, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
        {"recordId": 3, "status": "AVAILABLE", "expireTime": "2026-12-22 23:59:59"},
    ])
    picked = cards.pick_card(inv, reserve_cards=0, now=near, waste_horizon_days=3)
    assert picked["card_type"] == "five_hour"
    assert picked["would_expire_wasted"] == 2  # 3 张在窗内, 本轮花 1
    # W0 现状(距过期约 2 个月)不误报
    far = cards.pick_card(cards.parse_cards(W0_RAW, now=NOW),
                          reserve_cards=0, now=NOW, waste_horizon_days=3)
    assert far["would_expire_wasted"] == 0
    # horizon<=0 关闭预估
    off = cards.pick_card(inv, reserve_cards=0, now=near, waste_horizon_days=0)
    assert off["would_expire_wasted"] == 0


# ---------- 纯函数/可序列化 ----------

def test_t05_pure_serializable_roundtrip():
    """纯函数无 IO: 输入输出可 json 序列化, 同输入同输出(ADR3 可回放)。"""
    inv = cards.parse_cards(W0_RAW, now=NOW)
    outs = [cards.budget(inv, reserve_cards=1),
            cards.fifo_order(inv, now=NOW),
            cards.pick_card(inv, reserve_cards=1, now=NOW),
            inv]
    blob = json.dumps(outs, sort_keys=True)  # 不抛即通过
    assert blob
    again = json.loads(blob)
    assert again[2]["card_type"] == "five_hour"
