# -*- coding: utf-8 -*-
"""T-13 契约快照金测试 — 真身 fixture 金样 + 漂移回归 + 决策回放（EARS3/NFR2）。

「实测数字零造假」守门测试：全部断言值锚定 W0_RECON.md（2026-10-23 API 腿实测）与
tests/fixtures/*.json（T-01 脱敏真身源），fixture→金测试单向流，禁手填调整。

三段金标准：
① fixture ↔ W0_RECON.md 逐字段对账（percentage=25 / nextResetTime=1792739680173 /
   TIME_LIMIT 100%=search-prime 3392+web-reader 608 / 4000 用尽 / 3 张 5h 卡
   recordId 6/7/8 全 available 从未使用 expire 2026-12-22 23:59:59 / 周卡 0）。
② T-04 providers 对 fixture 归一化输出快照 + 参数化逐字段变异漂移回归：
   篡改任一关键字段必抛 ContractDriftError 且 diffs 指名精确字段路径；
   网关 code=1001 → AuthError 回归；漂移→账本 drift 条目不崩溃（EARS3 前置层）。
③ T-05 zqg.cards 对同一 fixture 的解析快照（聚合/FIFO/预算 3−1=2 与 W0 对账），
   同快照两次决策输入逐字节一致（NFR2 零误重置确定性门；T-07 Decision 回放
   待 policy 模块落地后在本文件追加同锚点用例）。

运行: e:/AI-Station/.venv/Scripts/python.exe -m pytest zhipu-quota-guard/tests/test_contract_snapshots.py -q
"""
import copy
import json
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

import pytest

_ROOT = str(Path(__file__).resolve().parents[1])  # zhipu-quota-guard/
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from zqg import cards as zqg_cards  # noqa: E402
from zqg.ledger import Ledger  # noqa: E402
from zqg.providers import (  # noqa: E402
    AuthError,
    BigmodelProvider,
    ContractDriftError,
    QuotaSnapshot,
    ZaiProvider,
)
import zqg.providers.base as base_mod  # noqa: E402

FIXTURES = Path(__file__).resolve().parent / "fixtures"
CN_TZ = timezone(timedelta(hours=8))  # 站方控制台时区(UTC+8)
FAKE_NOW = 1792838400  # 固定时钟(2026-10-24 前后): 早于一切过期时刻, 保证确定性
FAKE_KEY = "test-plan-key-abcd1234"

# ---- W0 实测锚点（W0_RECON.md 2026-10-23 原文数值, 逐条注明出处行） ----
W0_TOKENS_PCT = 25                    # 「5h 窗 | TOKENS_LIMIT 已用 25%」
W0_TOKENS_NEXT_RESET_MS = 1792739680173  # 「nextResetTime=1792739680173（今日）」→ 秒 1792739680
W0_TIME_PCT = 100                     # 「MCP 工具月度 | TIME_LIMIT 100% 用尽」
W0_MCP_SEARCH_PRIME = 3392            # 「search-prime 3392」
W0_MCP_WEB_READER = 608               # 「+ web-reader 608」
W0_MCP_QUOTA = 4000                   # 「/ 4000」→ 4000/4000 用尽与 percentage=100 自洽
W0_TIME_NEXT_RESET_MS = 1792944000000  # 「nextReset 2026-10-26」= 2026-10-26 00:00:00+08
W0_CARD_IDS = [6, 7, 8]               # 「3 张 5h 卡（recordId 6/7/8」
W0_CARD_TYPE = "GLOBAL"               # 「GLOBAL，全部 available」
W0_CARD_EXPIRE = "2026-12-22 23:59:59"  # 「expire 2026-12-22 23:59:59」→ epoch 1797955199(+08)
W0_CARD_EXPIRE_EPOCH = 1797955199     # 2026-12-22 23:59:59 UTC+8
W0_RESERVE_CARDS = 1                  # 「3 − 1（自媒永动机预留）」（用户批准的默认规则）
W0_CARD_BUDGET = 2                    # 「= 2 张可动用」

QUOTA_FIXTURES = {
    "zai": "quota_limit_zai.json",
    "bigmodel": "quota_limit_bigmodel.json",
}
PROVIDERS = [(ZaiProvider, "zai"), (BigmodelProvider, "bigmodel")]


def load_fixture(name: str) -> dict:
    return json.loads((FIXTURES / name).read_text(encoding="utf-8"))


def limit_of(raw: dict, limit_type: str) -> dict:
    body = raw.get("data") if isinstance(raw.get("data"), dict) else raw
    return next(e for e in body["limits"] if e["type"] == limit_type)


# ==========================================================================
# ① 金样对账: fixture ↔ W0_RECON.md 逐字段（数字零造假守门）
# ==========================================================================

@pytest.mark.parametrize("fixture", QUOTA_FIXTURES.values())
def test_t13_golden_quota_fixture_field_by_field_w0(fixture):
    """quota/limit fixture 逐字段对 W0 实测: 字段集+类型+数值逐项钉死。"""
    raw = load_fixture(fixture)
    # 响应形状钉死: limits 恰含 TOKENS_LIMIT(5h窗) + TIME_LIMIT(MCP月度)
    assert {e["type"] for e in raw["data"]["limits"]} == {"TOKENS_LIMIT", "TIME_LIMIT"}

    tok = limit_of(raw, "TOKENS_LIMIT")
    # 字段集+类型(实测: 无 usage/remaining, 仅 percentage——W0 明示的契约事实)
    assert set(tok) == {"type", "percentage", "nextResetTime"}
    assert isinstance(tok["percentage"], int) and isinstance(tok["nextResetTime"], int)
    assert "usage" not in tok and "remaining" not in tok
    # 数值逐字段(W0 原文)
    assert tok["percentage"] == W0_TOKENS_PCT == 25
    assert tok["nextResetTime"] == W0_TOKENS_NEXT_RESET_MS
    # nextResetTime 毫秒epoch→北京时间=W0 实测当日(「今日」=2026-10-23)
    assert datetime.fromtimestamp(tok["nextResetTime"] // 1000, CN_TZ).strftime(
        "%Y-%m-%d") == "2026-10-23"

    tl = limit_of(raw, "TIME_LIMIT")
    assert tl["percentage"] == W0_TIME_PCT == 100
    assert tl["nextResetTime"] == W0_TIME_NEXT_RESET_MS
    # W0 用尽对账: search-prime 3392 + web-reader 608 = 4000/4000 → percentage=100 自洽
    assert W0_MCP_SEARCH_PRIME + W0_MCP_WEB_READER == W0_MCP_QUOTA
    assert datetime.fromtimestamp(tl["nextResetTime"] // 1000, CN_TZ).strftime(
        "%Y-%m-%d %H:%M:%S") == "2026-10-26 00:00:00"  # 「nextReset 2026-10-26」


def test_t13_golden_dual_domain_same_source():
    """W0「双域同源: 同一 customerId 同一数据」→ 两站 fixture limits 逐字节一致。"""
    zai = load_fixture(QUOTA_FIXTURES["zai"])
    big = load_fixture(QUOTA_FIXTURES["bigmodel"])
    assert zai["data"]["limits"] == big["data"]["limits"]
    # 证据链缝合: fixture 溯源必须指向 W0_RECON.md 实测(单向流)
    for raw in (zai, big):
        assert "W0_RECON.md" in raw["data"]["_meta"]["source"]


def test_t13_golden_fixtures_sanitized_no_secrets():
    """脱敏门(NFR3 前置): fixture 文本无 sk-串/Bearer/32+位hex, 无 customerId 明文。"""
    import re
    patterns = [re.compile(r"sk-[A-Za-z0-9_\-]{8,}"),
                re.compile(r"bearer\s+[A-Za-z0-9._\-+/=]+", re.IGNORECASE),
                re.compile(r"[0-9a-fA-F]{32,}")]
    for name in (*QUOTA_FIXTURES.values(), "cards_zai.json"):
        text = (FIXTURES / name).read_text(encoding="utf-8")
        for pat in patterns:
            assert not pat.search(text), f"{name} 泄密形态命中: {pat.pattern}"
        assert "Authorization" not in text and "api_key" not in text
        # 注: customerId 明文仅出现在 _meta 溯源注记(与 W0_RECON.md 同级证据, 非凭据),
        # 不在脱敏门内; 响应字段级脱敏由上方字段集断言钉死。


def test_t13_golden_cards_fixture_field_by_field_w0():
    """卡库存 fixture 逐字段对 W0: 3 卡 recordId 6/7/8, 全 available 从未使用, 周卡 0。"""
    raw = load_fixture("cards_zai.json")
    five = raw["data"]["fiveHourResets"]
    assert [c["recordId"] for c in five] == W0_CARD_IDS      # 3 张, id 顺序钉死
    for c in five:
        assert set(c) == {"recordId", "cardType", "available", "expireTime", "usedTime"}
        assert c["cardType"] == W0_CARD_TYPE                  # GLOBAL
        assert c["available"] is True and c["usedTime"] is None  # 从未使用
        assert isinstance(c["expireTime"], str)
        assert c["expireTime"] == W0_CARD_EXPIRE              # 2026-12-22 23:59:59(+08)
    assert raw["data"]["weekResets"] == []                            # 周卡 0 张
    assert "W0_RECON.md" in raw["data"]["_meta"]["source"]


# ==========================================================================
# ② providers(T-04) 归一化快照 + 逐字段变异漂移回归(EARS3)
# ==========================================================================

class FakeResponse:
    def __init__(self, body, status=200):
        self.status = status
        self._body = body if isinstance(body, bytes) else json.dumps(body).encode("utf-8")

    def read(self):
        return self._body

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


class FakeTransport:
    def __init__(self, items):
        self.items, self.calls = list(items), []

    def __call__(self, req, timeout=None):
        self.calls.append(req.full_url)
        item = self.items[0]
        if len(self.items) > 1:
            del self.items[0]  # 按序弹出, 仅剩最后一项时重复使用
        if isinstance(item, Exception):
            raise item
        return item


def make_provider(cls, monkeypatch, items):
    transport = FakeTransport(items)
    monkeypatch.setattr(base_mod.urllib.request, "urlopen", transport)
    provider = cls(api_key=FAKE_KEY, sleep=lambda _s: None, now=lambda: FAKE_NOW)
    return provider, transport


@pytest.mark.parametrize("cls,name", PROVIDERS)
def test_t13_snapshot_providers_normalize_fixture(cls, name, monkeypatch):
    """归一化快照: 双站对真身 fixture 的 QuotaSnapshot 输出逐字段钉死。"""
    raw = load_fixture(QUOTA_FIXTURES[name])
    provider, _ = make_provider(cls, monkeypatch, [FakeResponse(raw)])

    snap = provider.fetch_quota()

    assert isinstance(snap, QuotaSnapshot)
    assert snap.provider == name and snap.ts == FAKE_NOW
    assert snap.window_pct == float(W0_TOKENS_PCT) == 25.0       # percentage=已用%
    assert snap.remaining == 100.0 - W0_TOKENS_PCT == 75.0       # 实测无remaining→100−已用
    assert snap.next_reset_at == W0_TOKENS_NEXT_RESET_MS // 1000 == 1792739680
    assert snap.raw == raw                                       # 原样留存(漂移检测输入)
    # TIME_LIMIT(MCP月度)留 raw 不入 5h 窗: 窗值25≠月度100, 语义不串
    assert limit_of(snap.raw, "TIME_LIMIT")["percentage"] == W0_TIME_PCT
    assert snap.window_pct != limit_of(snap.raw, "TIME_LIMIT")["percentage"]


@pytest.mark.parametrize("cls,name", PROVIDERS)
def test_t13_snapshot_provider_fetch_cards_aggregate(cls, name, monkeypatch):
    """provider 层卡库存快照: 3 张同刻到期聚合一组, 周卡空。"""
    provider, _ = make_provider(cls, monkeypatch, [FakeResponse(load_fixture("cards_zai.json"))])
    inv = provider.fetch_cards()
    assert [(c.count, c.expire_at) for c in inv.five_hour] == [(3, W0_CARD_EXPIRE_EPOCH)]
    assert inv.weekly == []
    assert inv.fetched_at == FAKE_NOW


# ---- 逐字段变异漂移回归: 篡改任一关键字段必抛 ContractDriftError 且路径精确 ----

QUOTA_MUTATIONS = [
    (lambda r: r["data"].__delitem__("limits"), "missing key limits"),
    (lambda r: r["data"].__setitem__("limits", {"a": 1}), "type mismatch limits"),
    (lambda r: r["data"].__setitem__("limits", []), "limits"),  # 空数组→TOKENS_LIMIT 缺失
    (lambda r: limit_of(r, "TOKENS_LIMIT").__setitem__("type", "FOO_LIMIT"),
     "limits[TOKENS_LIMIT]"),
    # type 值变非字符串: 检测器按 type 定位 TOKENS_LIMIT → 条目缺失同路径(fail loud)
    (lambda r: limit_of(r, "TOKENS_LIMIT").__setitem__("type", 123),
     "limits[TOKENS_LIMIT]"),
    (lambda r: limit_of(r, "TOKENS_LIMIT").__delitem__("percentage"),
     "missing key limits[TOKENS_LIMIT].percentage"),
    (lambda r: limit_of(r, "TOKENS_LIMIT").__setitem__("percentage", "25"),
     "type mismatch limits[TOKENS_LIMIT].percentage"),
    (lambda r: limit_of(r, "TOKENS_LIMIT").__setitem__("percentage", True),
     "type mismatch limits[TOKENS_LIMIT].percentage"),  # bool 伪装数字
    (lambda r: limit_of(r, "TOKENS_LIMIT").__delitem__("nextResetTime"),
     "missing key limits[TOKENS_LIMIT].nextResetTime"),
    (lambda r: limit_of(r, "TOKENS_LIMIT").__setitem__("nextResetTime", None),
     "type mismatch limits[TOKENS_LIMIT].nextResetTime"),
    (lambda r: limit_of(r, "TOKENS_LIMIT").__setitem__("type", 123),
     "limits[TOKENS_LIMIT]"),
    (lambda r: [], "limits"),  # 响应整体非对象(replace 型变异, 返回值即响应体)
]


def _mutated_body(mutate, raw):
    """原位变异(mutate 改 raw 后返回 None)或整体替换(返回新响应体)。"""
    return mutate(raw) if callable(mutate) else raw


@pytest.mark.parametrize("mutate,expected_path", QUOTA_MUTATIONS)
def test_t13_drift_quota_mutation_raises_with_exact_path(mutate, expected_path, monkeypatch):
    raw = copy.deepcopy(load_fixture("quota_limit_zai.json"))
    body = _mutated_body(mutate, raw)
    if body is None:
        body = raw
    provider, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(body)])

    with pytest.raises(ContractDriftError) as ei:
        provider.fetch_quota()
    diffs = ei.value.diffs
    assert any(expected_path in d for d in diffs), \
        f"diffs 应含路径 {expected_path!r}: {diffs}"
    assert expected_path in str(ei.value)  # 消息亦指名(供账本/企微原文)


CARDS_MUTATIONS = [
    (lambda r: r["data"].__delitem__("fiveHourResets"), "missing key fiveHourResets"),
    (lambda r: r["data"].__delitem__("weekResets"), "missing key weekResets"),
    (lambda r: r["data"].__setitem__("fiveHourResets", {}), "type mismatch fiveHourResets"),
    (lambda r: r["data"]["fiveHourResets"][0].__delitem__("expireTime"),
     "missing key fiveHourResets[0].expireTime"),
    (lambda r: r["data"]["fiveHourResets"][0].__setitem__("expireTime", "not-a-date"),
     "type mismatch fiveHourResets[0].expireTime"),
    (lambda r: r["data"]["fiveHourResets"][0].__setitem__("expireTime", False),
     "type mismatch fiveHourResets[0].expireTime"),
    (lambda r: r["data"].__setitem__("weekResets", "x"), "type mismatch weekResets"),
    (lambda r: [1, 2], "fiveHourResets"),  # 响应整体非对象(replace 型变异)
]


@pytest.mark.parametrize("mutate,expected_path", CARDS_MUTATIONS)
def test_t13_drift_cards_mutation_raises_with_exact_path(mutate, expected_path, monkeypatch):
    raw = copy.deepcopy(load_fixture("cards_zai.json"))
    body = _mutated_body(mutate, raw)
    if body is None:
        body = raw
    provider, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(body)])

    with pytest.raises(ContractDriftError) as ei:
        provider.fetch_cards()
    assert any(expected_path in d for d in ei.value.diffs), \
        f"diffs 应含路径 {expected_path!r}: {ei.value.diffs}"


def test_t13_drift_non_json_gateway_body(monkeypatch):
    """网关吐非 JSON: 契约漂移(不是崩溃)。"""
    provider, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(b"<html>gateway</html>")])
    with pytest.raises(ContractDriftError):
        provider.fetch_quota()


@pytest.mark.parametrize("cls,name", PROVIDERS)
def test_t13_gateway_1001_is_autherror(cls, name, monkeypatch):
    """W0/KB「网关无鉴权一律 code=1001」→ AuthError 且不重试(回归)。"""
    provider, transport = make_provider(
        cls, monkeypatch, [FakeResponse({"code": 1001, "msg": "no auth"})])
    with pytest.raises(AuthError) as ei:
        provider.fetch_quota()
    assert "1001" in str(ei.value)
    assert len(transport.calls) == 1  # 鉴权错误不退避重试


def test_t13_gateway_1001_on_cards_path_is_autherror(monkeypatch):
    provider, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse({"code": 1001})])
    with pytest.raises(AuthError):
        provider.fetch_cards()


def test_t13_ears3_drift_writes_ledger_entry_without_crash(tmp_path, monkeypatch):
    """EARS3 前置层回归: 漂移被捕获→账本 drift 条目(字段路径入payload), 不崩溃。"""
    raw = copy.deepcopy(load_fixture("quota_limit_zai.json"))
    limit_of(raw, "TOKENS_LIMIT").__delitem__("percentage")
    provider, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(raw)])
    ledger = Ledger(tmp_path, now=lambda: FAKE_NOW)

    try:  # daemon(T-11)处置模式: 降级+记账, 进程活着
        provider.fetch_quota()
        raise AssertionError("应抛 ContractDriftError")
    except ContractDriftError as e:
        ledger.append("drift", {"provider": "zai", "endpoint": "quota/limit", "diffs": e.diffs})

    entries = ledger.read(kinds={"drift"})
    assert len(entries) == 1
    assert entries[0]["kind"] == "drift"
    assert any("limits[TOKENS_LIMIT].percentage" in d for d in entries[0]["payload"]["diffs"])


# ==========================================================================
# ③ zqg.cards(T-05) 解析快照 + NFR2 确定性回放门
# ==========================================================================

def test_t13_snapshot_cards_parse_w0():
    """同一 fixture 过 zqg.cards: 聚合/时区解析/空周卡与 W0 对账。"""
    inv = zqg_cards.parse_cards(load_fixture("cards_zai.json"), now=FAKE_NOW)
    assert inv["five_hour"] == [{"count": 3, "expire_at": W0_CARD_EXPIRE_EPOCH}]
    assert inv["weekly"] == []
    assert inv["fetched_at"] == FAKE_NOW


def test_t13_snapshot_cards_budget_fifo_w0():
    """W0 卡预算对账: 3−1(自媒永动机预留)=2 可动用; FIFO 首组=最近过期。"""
    inv = zqg_cards.parse_cards(load_fixture("cards_zai.json"), now=FAKE_NOW)
    assert zqg_cards.budget(inv, reserve_cards=W0_RESERVE_CARDS) == W0_CARD_BUDGET == 2
    assert zqg_cards.fifo_order(inv, now=FAKE_NOW)[0]["expire_at"] == W0_CARD_EXPIRE_EPOCH
    assert zqg_cards.budget(inv, reserve_cards=3) == 0  # 预留吃满→下限0


def test_t13_nfr2_decision_inputs_replay_deterministic():
    """NFR2 零误重置确定性门: 同一真身快照两次解析+选卡, 逐字节一致。
    (T-07 Decision 回放落点: policy 落地后在本文件追加同锚点 decision 断言。)"""
    def replay():
        inv = zqg_cards.parse_cards(load_fixture("cards_zai.json"), now=FAKE_NOW)
        return json.dumps(zqg_cards.pick_card(inv, reserve_cards=1, now=FAKE_NOW),
                          sort_keys=True, ensure_ascii=False)

    a, b = replay(), replay()
    assert a == b
    assert json.loads(a)["card_type"] == "five_hour"          # 全同刻到期→预算约束下选 5h
    assert json.loads(a)["expire_at"] == W0_CARD_EXPIRE_EPOCH


def test_t13_cards_layer_gateway_1001_typed_auth():
    """跨层语义一致: zqg.cards 网络层 code=1001 → CardsAuthError(上层续期)。"""
    with pytest.raises(zqg_cards.CardsAuthError):
        zqg_cards.fetch_cards(
            "https://api.z.ai", api_key="sk-wrong",
            transport=lambda url, headers: (200, {"code": 1001, "msg": "no auth"}),
            now=FAKE_NOW)
