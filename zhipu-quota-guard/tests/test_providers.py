# -*- coding: utf-8 -*-
"""T-04 providers 双站额度客户端+契约漂移检测 — 测试（先写测试后实现, TDD red→green）。

覆盖: FR1(quota归一化)/FR2(fetch_cards)/EARS3(ContractDrift不崩溃且指名字段)/ADR2(双站同构)
数据源: tests/fixtures/*.json = W0_RECON.md 实测响应(脱敏), 全程零真网(monkeypatch urlopen)。
"""
import copy
import io
import json
import sys
import urllib.error
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]  # zhipu-quota-guard/
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from zqg.providers import (  # noqa: E402
    AuthError,
    BaseProvider,
    BigmodelProvider,
    CardInventory,
    ContractDriftError,
    ProviderError,
    QuotaSnapshot,
    RetryableError,
    ZaiProvider,
)
import zqg.providers.base as base_mod  # noqa: E402

FIXTURES = Path(__file__).resolve().parent / "fixtures"
FAKE_KEY = "test-plan-key-abcd1234"
FAKE_NOW = 1761182400  # 2025-10-23 00:00:00 UTC

PROVIDERS = [
    (ZaiProvider, "zai", "https://api.z.ai", "quota_limit_zai.json"),
    (BigmodelProvider, "bigmodel", "https://open.bigmodel.cn", "quota_limit_bigmodel.json"),
]


def load_fixture(name):
    return json.loads((FIXTURES / name).read_text(encoding="utf-8"))


def tokens_limit(raw):
    body = raw.get("data") if isinstance(raw.get("data"), dict) else raw
    return next(e for e in body["limits"] if e["type"] == "TOKENS_LIMIT")


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
    """urlopen 替身: 按序弹出响应(最后一项重复), 记录每次调用的 url/头/timeout。"""

    def __init__(self, items):
        self.items = list(items)
        self.calls = []

    def __call__(self, req, timeout=None):
        self.calls.append({
            "url": req.full_url,
            "auth": req.get_header("Authorization"),
            "timeout": timeout,
        })
        item = self.items.pop(0) if len(self.items) > 1 else self.items[0]
        if isinstance(item, Exception):
            raise item
        return item


def http_error(code, body=b""):
    return urllib.error.HTTPError("u", code, "err", {}, io.BytesIO(body))


def make_provider(cls, monkeypatch, items, **kw):
    """建 provider + 挂 fake transport + 注入 sleep/now, 返回 (provider, transport, sleeps)。"""
    transport = FakeTransport(items)
    monkeypatch.setattr(base_mod.urllib.request, "urlopen", transport)
    sleeps = []
    kw.setdefault("sleep", sleeps.append)
    kw.setdefault("now", lambda: FAKE_NOW)
    provider = cls(api_key=FAKE_KEY, **kw)
    return provider, transport, sleeps


# ---------- FR1: quota/limit 归一化(双站共用一条参数化路径, ADR2) ----------

@pytest.mark.parametrize("cls,name,base_url,fixture", PROVIDERS)
def test_t04_fr1_fetch_quota_normalizes_real_fixture(cls, name, base_url, fixture, monkeypatch):
    raw = load_fixture(fixture)
    provider, transport, _ = make_provider(cls, monkeypatch, [FakeResponse(raw)])

    snap = provider.fetch_quota()

    assert isinstance(snap, QuotaSnapshot)
    assert snap.provider == name
    assert snap.ts == FAKE_NOW
    tok = tokens_limit(raw)
    assert snap.window_pct == float(tok["percentage"])          # percentage=5h窗已用%
    assert snap.remaining == float(tok.get("remaining", 100 - tok["percentage"]))  # 实测无remaining→100-已用%
    assert snap.next_reset_at == tok["nextResetTime"] // 1000   # 毫秒→秒epoch(调度权威字段)
    assert snap.raw == raw                                       # TIME_LIMIT 留 raw 不入窗
    # 请求契约: Bearer 套餐Key + 精确端点
    assert transport.calls[0]["url"] == base_url + "/api/monitor/usage/quota/limit"
    assert transport.calls[0]["auth"] == "Bearer " + FAKE_KEY
    assert transport.calls[0]["timeout"] == 15


@pytest.mark.parametrize("cls,name,base_url,fixture", PROVIDERS)
def test_t04_fr1_uses_explicit_remaining_when_present(cls, name, base_url, fixture, monkeypatch):
    raw = copy.deepcopy(load_fixture(fixture))
    tokens_limit(raw)["remaining"] = 62.5
    provider, _, _ = make_provider(cls, monkeypatch, [FakeResponse(raw)])

    snap = provider.fetch_quota()
    assert snap.remaining == 62.5


# ---------- EARS3: 契约漂移检测(缺键/类型变→ContractDriftError 带字段路径) ----------

@pytest.mark.parametrize("mutate,paths", [
    (lambda r: tokens_limit(r).pop("nextResetTime"), ["limits[TOKENS_LIMIT].nextResetTime"]),
    (lambda r: tokens_limit(r).__setitem__("percentage", "25"), ["limits[TOKENS_LIMIT].percentage"]),
    (lambda r: r["data"].pop("limits"), ["limits"]),
    (lambda r: r["data"].__setitem__("limits", {"a": 1}), ["limits"]),
    (lambda r: tokens_limit(r).__setitem__("type", "FOO_LIMIT"), ["limits[TOKENS_LIMIT]"]),
])
def test_t04_ears3_quota_drift_names_the_field(mutate, paths, monkeypatch):
    raw = copy.deepcopy(load_fixture("quota_limit_zai.json"))
    mutate(raw)  # 原位变异
    provider, _, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(raw)])

    with pytest.raises(ContractDriftError) as ei:
        provider.fetch_quota()
    msg = str(ei.value)
    for p in paths:
        assert p in msg, f"drift 消息应指名 {p}: {msg}"
    assert any(p in d for d in ei.value.diffs for p in paths)


@pytest.mark.parametrize("mutate,paths", [
    (lambda r: r["data"].pop("fiveHourResets"), ["fiveHourResets"]),
    (lambda r: r["data"].__setitem__("weekResets", {}), ["weekResets"]),
    (lambda r: r["data"]["fiveHourResets"][0].pop("expireTime"), ["fiveHourResets[0].expireTime"]),
    (lambda r: r["data"]["fiveHourResets"][0].__setitem__("expireTime", "not-a-date"), ["fiveHourResets[0].expireTime"]),
])
def test_t04_ears3_cards_drift_names_the_field(mutate, paths, monkeypatch):
    raw = copy.deepcopy(load_fixture("cards_zai.json"))
    mutate(raw)  # 原位变异
    provider, _, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(raw)])

    with pytest.raises(ContractDriftError) as ei:
        provider.fetch_cards()
    for p in paths:
        assert p in str(ei.value)


def test_t04_ears3_non_json_body_is_drift(monkeypatch):
    provider, _, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(b"<html>gateway</html>")])
    with pytest.raises(ContractDriftError):
        provider.fetch_quota()


# ---------- 401 / 网关1001 → AuthError(不重试) ----------

@pytest.mark.parametrize("cls,name,base_url,fixture", PROVIDERS)
def test_t04_auth_http401_raises_autherror_immediately(cls, name, base_url, fixture, monkeypatch):
    provider, transport, sleeps = make_provider(cls, monkeypatch, [http_error(401, b'{"code":1001}')])

    with pytest.raises(AuthError):
        provider.fetch_quota()
    assert len(transport.calls) == 1  # 鉴权错误不退避
    assert sleeps == []


@pytest.mark.parametrize("cls,name,base_url,fixture", PROVIDERS)
def test_t04_auth_gateway_code1001_raises_autherror(cls, name, base_url, fixture, monkeypatch):
    provider, _, _ = make_provider(cls, monkeypatch, [FakeResponse({"code": 1001, "msg": "not auth"})])

    with pytest.raises(AuthError) as ei:
        provider.fetch_quota()
    assert "1001" in str(ei.value)


# ---------- 超时/5xx → RetryableError, 退避重试3次 ----------

def test_t04_retry_timeout_exhausts_with_backoff(monkeypatch):
    provider, transport, sleeps = make_provider(
        ZaiProvider, monkeypatch, [urllib.error.URLError(TimeoutError("timed out"))])

    with pytest.raises(RetryableError):
        provider.fetch_quota()
    assert len(transport.calls) == 4          # 1次初始 + 3次重试
    assert sleeps == [0.5, 1.0, 2.0]          # 指数退避(可注入sleep断言)


def test_t04_retry_5xx_then_success(monkeypatch):
    raw = load_fixture("quota_limit_bigmodel.json")
    provider, transport, sleeps = make_provider(
        BigmodelProvider, monkeypatch,
        [http_error(502, b"bad gw"), http_error(503, b"down"), FakeResponse(raw)])

    snap = provider.fetch_quota()
    assert snap.window_pct == float(tokens_limit(raw)["percentage"])
    assert len(transport.calls) == 3
    assert sleeps == [0.5, 1.0]


def test_t04_nonretryable_http_error_is_provider_error(monkeypatch):
    provider, transport, sleeps = make_provider(ZaiProvider, monkeypatch, [http_error(404, b"nope")])
    with pytest.raises(ProviderError):
        provider.fetch_quota()
    assert len(transport.calls) == 1
    assert sleeps == []


# ---------- FR2: fetch_cards → CardInventory(按最近过期聚合) ----------

def test_t04_fr2_fetch_cards_aggregates_by_nearest_expiry(monkeypatch):
    raw = load_fixture("cards_zai.json")
    provider, transport, _ = make_provider(ZaiProvider, monkeypatch, [FakeResponse(raw)])

    inv = provider.fetch_cards()

    assert isinstance(inv, CardInventory)
    assert inv.fetched_at == FAKE_NOW
    # 3张同刻到期卡聚合为1组{count:3}; 2026-12-22 23:59:59+08:00 → epoch 1797955199
    assert [(c.count, c.expire_at) for c in inv.five_hour] == [(3, 1797955199)]
    assert inv.weekly == []
    assert transport.calls[0]["url"] == \
        "https://api.z.ai/api/biz/customer-package-reset/list?targetType=PERSONAL"


def test_t04_fr2_cards_groups_sort_by_expiry_and_skip_used(monkeypatch):
    raw = load_fixture("cards_zai.json")
    raw["data"]["fiveHourResets"] = [
        {"recordId": 9, "available": True, "expireTime": 1798300800000},   # 12-26 ms epoch
        {"recordId": 10, "available": False, "expireTime": 1797955199},    # 已用→不计
        {"recordId": 11, "available": True, "expireTime": "2026-12-22 23:59:59"},
    ]
    raw["data"]["weekResets"] = [{"recordId": 20, "available": True, "expireTime": 1798300800}]
    provider, _, _ = make_provider(BigmodelProvider, monkeypatch, [FakeResponse(raw)])

    inv = provider.fetch_cards()
    assert [(c.count, c.expire_at) for c in inv.five_hour] == [(1, 1797955199), (1, 1798300800)]
    assert [(c.count, c.expire_at) for c in inv.weekly] == [(1, 1798300800)]


# ---------- ADR2: 双站同构, 仅差 base_url/provider 名 ----------

def test_t04_adr2_providers_share_base_differ_only_in_site():
    assert issubclass(ZaiProvider, BaseProvider) and issubclass(BigmodelProvider, BaseProvider)
    assert ZaiProvider.name == "zai" and ZaiProvider.base_url == "https://api.z.ai"
    assert BigmodelProvider.name == "bigmodel" and BigmodelProvider.base_url == "https://open.bigmodel.cn"
    # 子类自身不引入新行为方法(ADR2 抽象实证: 全部逻辑在 BaseProvider)
    for cls in (ZaiProvider, BigmodelProvider):
        own = {k for k, v in vars(cls).items() if callable(v) and not k.startswith("__")}
        assert own == set(), f"{cls.__name__} 不应自定义方法(ADR2 仅差站点常量): {own}"
