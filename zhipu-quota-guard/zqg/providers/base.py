# -*- coding: utf-8 -*-
"""providers 基座：stdlib urllib HTTP + 双站同构客户端 + 契约漂移检测（T-04, ADR2）。

契约依据 KNOWLEDGE_BASE/rules-and-endpoints.md 端点节 + W0_RECON.md 实测样本：
- GET /api/monitor/usage/quota/limit（Bearer 套餐Key）
  TOKENS_LIMIT=5h窗已用%（实测响应无 usage/remaining，仅 percentage），nextResetTime=毫秒epoch
- GET /api/biz/customer-package-reset/list?targetType=PERSONAL
  fiveHourResets[]/weekResets[] 含 recordId/expireTime/available
数据模型依据 SCHEMAS §2（QuotaSnapshot/CardInventory）。
零第三方依赖；sleep/now/timeout/retries 均可注入供离线测试。
"""
from __future__ import annotations

import json
import time
import urllib.error
import urllib.request
from dataclasses import dataclass, field
from datetime import datetime, timedelta, timezone
from typing import Any, Callable

QUOTA_PATH = "/api/monitor/usage/quota/limit"
CARDS_PATH = "/api/biz/customer-package-reset/list?targetType=PERSONAL"

CN_TZ = timezone(timedelta(hours=8))  # 控制台时间(实测 2026-12-22 23:59:59 为北京时间)

_NUMBER = "number"
_ARRAY = "array"
_OBJECT = "object"


class ProviderError(Exception):
    """provider 层错误基类。"""


class AuthError(ProviderError):
    """鉴权失败（HTTP 401 或网关 code=1001）——不重试，交上层续期/唤人。"""


class RetryableError(ProviderError):
    """超时/5xx——已耗尽退避重试(默认3次)仍失败。"""


class ContractDriftError(ProviderError):
    """响应契约漂移（缺键/类型变），携带字段路径 diff 摘要；monitor 捕获后降级+告警(EARS3)。"""

    def __init__(self, diffs: list[str]):
        self.diffs = list(diffs)
        super().__init__("contract drift: " + "; ".join(self.diffs))


@dataclass
class QuotaSnapshot:  # SCHEMAS §2
    ts: int                    # epoch 秒
    provider: str              # "zai"|"bigmodel"
    window_pct: float          # 5h窗已用%
    remaining: float           # 响应有 remaining 用之；实测无 → 100-已用%
    next_reset_at: int         # epoch 秒（调度权威字段，毫秒→秒）
    raw: dict = field(default_factory=dict)  # 原始响应（契约漂移检测用，含 TIME_LIMIT）


@dataclass
class Card:
    count: int
    expire_at: int  # epoch 秒


@dataclass
class CardInventory:  # SCHEMAS §2
    five_hour: list[Card] = field(default_factory=list)
    weekly: list[Card] = field(default_factory=list)
    fetched_at: int = 0


def _json_type(v: Any) -> str:
    if isinstance(v, bool):
        return "boolean"
    if isinstance(v, (int, float)):
        return _NUMBER
    if isinstance(v, str):
        return "string"
    if isinstance(v, list):
        return _ARRAY
    if isinstance(v, dict):
        return _OBJECT
    return type(v).__name__


def _is_number(v: Any) -> bool:
    return isinstance(v, (int, float)) and not isinstance(v, bool)


def _quota_diffs(raw: Any) -> list[str]:
    """quota/limit 契约断言：缺键/类型变→字段路径 diff（额外新键不视为漂移）。"""
    diffs: list[str] = []
    if not isinstance(raw, dict):
        return [f"type mismatch limits: expected {_OBJECT}, got {_json_type(raw)}"]
    limits = raw.get("limits")
    if "limits" not in raw:
        diffs.append("missing key limits")
    elif not isinstance(limits, list):
        diffs.append(f"type mismatch limits: expected {_ARRAY}, got {_json_type(limits)}")
        return diffs
    else:
        tok = next((e for e in limits if isinstance(e, dict) and e.get("type") == "TOKENS_LIMIT"), None)
        if tok is None:
            diffs.append("missing key limits[TOKENS_LIMIT]")
        else:
            for key in ("type", "percentage", "nextResetTime"):
                if key not in tok:
                    diffs.append(f"missing key limits[TOKENS_LIMIT].{key}")
                elif key != "type" and not _is_number(tok[key]):
                    diffs.append(
                        f"type mismatch limits[TOKENS_LIMIT].{key}: expected {_NUMBER}, got {_json_type(tok[key])}")
                elif key == "type" and not isinstance(tok[key], str):
                    diffs.append(
                        f"type mismatch limits[TOKENS_LIMIT].{key}: expected string, got {_json_type(tok[key])}")
    return diffs


def _parse_expire(v: Any) -> int:
    """expireTime→epoch秒。支持 毫秒epoch(>1e11)/秒epoch/「YYYY-MM-DD HH:MM:SS」(北京时间)。"""
    if _is_number(v):
        return int(v // 1000) if v > 1e11 else int(v)
    if isinstance(v, str):
        dt = datetime.strptime(v.strip().replace("T", " ")[:19], "%Y-%m-%d %H:%M:%S")
        return int(dt.replace(tzinfo=CN_TZ).timestamp())
    raise ValueError(f"unparseable expireTime: {v!r}")


def _cards_diffs(raw: Any) -> list[str]:
    diffs: list[str] = []
    if not isinstance(raw, dict):
        return [f"type mismatch fiveHourResets: expected {_ARRAY}, got {_json_type(raw)}"]
    for key in ("fiveHourResets", "weekResets"):
        entries = raw.get(key)
        if key not in raw:
            diffs.append(f"missing key {key}")
        elif not isinstance(entries, list):
            diffs.append(f"type mismatch {key}: expected {_ARRAY}, got {_json_type(entries)}")
        else:
            for i, e in enumerate(entries):
                if "expireTime" not in e:
                    diffs.append(f"missing key {key}[{i}].expireTime")
                else:
                    try:
                        _parse_expire(e["expireTime"])
                    except ValueError:
                        diffs.append(f"type mismatch {key}[{i}].expireTime: expected datetime/epoch, "
                                     f"got {e['expireTime']!r}")
    return diffs


def _unwrap(raw: Any) -> Any:
    """兼容 {"code","data":{...}} 信封（W0 实测真身）与顶层直挂两种形状。"""
    if isinstance(raw, dict):
        data = raw.get("data")
        if isinstance(data, dict):
            return data
    return raw


class BaseProvider:
    """双站同构客户端（ADR2）：zai/bigmodel 子类仅差 name+base_url，全部逻辑在此。"""

    name: str = "base"
    base_url: str = ""

    def __init__(
        self,
        api_key: str,
        base_url: str | None = None,
        timeout: float = 15.0,
        retries: int = 3,
        backoff_base: float = 0.5,
        sleep: Callable[[float], None] = time.sleep,
        now: Callable[[], float] = time.time,
    ):
        if not api_key:
            raise AuthError(f"{self.name}: plan api_key is empty")
        self._api_key = api_key
        self._base_url = (base_url or self.base_url).rstrip("/")
        self._timeout = timeout
        self._retries = retries
        self._backoff_base = backoff_base
        self._sleep = sleep
        self._now = now

    # -- HTTP（stdlib urllib；超时/5xx 退避重试3次；401→AuthError；网关1001→AuthError）--

    def _get_json(self, path: str) -> Any:
        url = self._base_url + path
        attempt = 0
        while True:
            retryable = ""
            try:
                req = urllib.request.Request(url, headers={
                    "Authorization": f"Bearer {self._api_key}",
                    "Accept": "application/json",
                    "User-Agent": "zqg-quota-guard/0.1",
                })
                with urllib.request.urlopen(req, timeout=self._timeout) as resp:
                    status, body = resp.status, resp.read()
            except urllib.error.HTTPError as e:
                status, body = e.code, e.read()
                if status == 401:
                    raise AuthError(f"{self.name}: HTTP 401 unauthorized ({path})") from None
                if not 500 <= status < 600:
                    raise ProviderError(f"{self.name}: HTTP {status} from {path}: {body[:200]!r}") from None
                retryable = f"HTTP {status}"
            except (urllib.error.URLError, TimeoutError, OSError) as e:
                retryable = f"{type(e).__name__}: {e}"
            else:
                text = body.decode("utf-8", "replace")
                try:
                    parsed = json.loads(text)
                except ValueError:
                    raise ContractDriftError([f"{path}: expected JSON object, got non-JSON body"]) from None
                if isinstance(parsed, dict) and parsed.get("code") == 1001:
                    # 网关无鉴权一律 {"code":1001}（鉴权先于路由, KB端点节）→ 优先于契约漂移
                    raise AuthError(f"{self.name}: gateway code=1001 unauthorized ({path})")
                return parsed
            attempt += 1
            if attempt > self._retries:
                raise RetryableError(
                    f"{self.name}: {path} failed after {attempt} attempts ({self._retries} retries): {retryable}")
            self._sleep(self._backoff_base * (2 ** (attempt - 1)))

    # -- FR1: 额度查询 → QuotaSnapshot --

    def fetch_quota(self) -> QuotaSnapshot:
        raw = self._get_json(QUOTA_PATH)
        body = _unwrap(raw)
        diffs = _quota_diffs(body)
        if diffs:
            raise ContractDriftError(diffs)
        tok = next(e for e in body["limits"] if e["type"] == "TOKENS_LIMIT")
        window_pct = float(tok["percentage"])
        remaining = float(tok["remaining"]) if _is_number(tok.get("remaining")) else 100.0 - window_pct
        return QuotaSnapshot(
            ts=int(self._now()),
            provider=self.name,
            window_pct=window_pct,
            remaining=remaining,
            next_reset_at=int(tok["nextResetTime"]) // 1000,
            raw=raw,
        )

    # -- FR2: 重置卡库存 → CardInventory（仅计 available 卡，按最近过期聚合）--

    def fetch_cards(self) -> CardInventory:
        raw = self._get_json(CARDS_PATH)
        body = _unwrap(raw)
        diffs = _cards_diffs(body)
        if diffs:
            raise ContractDriftError(diffs)

        def aggregate(entries: list[dict]) -> list[Card]:
            groups: dict[int, int] = {}
            for e in entries:
                if not e.get("available", True):
                    continue
                exp = _parse_expire(e["expireTime"])
                groups[exp] = groups.get(exp, 0) + 1
            return [Card(count=n, expire_at=exp) for exp, n in sorted(groups.items())]

        return CardInventory(
            five_hour=aggregate(body["fiveHourResets"]),
            weekly=aggregate(body["weekResets"]),
            fetched_at=int(self._now()),
        )
