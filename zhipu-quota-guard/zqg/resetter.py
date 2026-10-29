# -*- coding: utf-8 -*-
"""T-10 resetter 重置执行器 — reset 协议族 API 腿（FR4/FR5/FR7/FR9）。

契约源 KNOWLEDGE_BASE/reset-protocol.md（zcode-proxy reset.go/oauth.go 只读取证）：
- Base https://zcode.z.ai/api/v1/coding-plan/reset
- GET /status → data.available_five_hour_resets[]/available_week_resets[]
  + latest_five_hour_reset_history/latest_week_reset_history
- POST /use {"idempotency_key": <uuid4 每次新生成>, "reset_type": "five_hour"|"week"}
  业务码 code==0 即成功，data.used bool
- 双凭证头：Authorization: Bearer <ZCodeJWT>（必需，套餐 Key 直调实测 401）
  + X-Bigmodel-Authorization: <套餐 APIKey>（有则带）+ Bigmodel-Target-Type: PERSONAL
- 防风控：动作前后各 3-8s 随机延迟（rng/sleep 可注入）；429 退避；
  网络错误重试 3 次后 RetryableError；同卡 24h 失败 >2 次 RefuseRetry 拒发
- JWT 源 state/zcode_jwt.txt（一次人工登录提取后长效保活）；jwt_provider 可注入
- 冷却持久化 state/reset_cooldown.json（原子写，读时按 24h 窗口剪枝；
  成功一次即清零重新累计；429 限流不计入冷却）
- dry_run / notify_only：零网络零延迟，返回 simulated 结果；账本 reset_exec /
  reset_result 附 simulated=true（与 T-07 决策层 simulated 约定一致；账本 kind
  枚举无 simulated_reset，模拟标记走 payload）
- 账本走 T-02 Ledger（注入实例，kind=reset_exec|reset_result）

UIA 兜底腿（9341 profile 浏览器点使用）按本任务约束不在本文件范围：
zqg/browser/session.py 由浏览器腿任务接续，真浏览器冒烟归 T-15 实弹阶段。
Python 3.11 标准库 only（urllib）；rng/sleep/now/transport 全可注入，测试零真请求。
"""
from __future__ import annotations

import json
import os
import random
import time
import urllib.error
import urllib.request
import uuid
from pathlib import Path
from typing import Any, Callable

__all__ = [
    "RESET_BASE_URL",
    "JITTER_MIN_S",
    "JITTER_MAX_S",
    "COOLDOWN_WINDOW_S",
    "MAX_CARD_FAILURES",
    "ResetterError",
    "ThrottledError",
    "BizError",
    "RetryableError",
    "RefuseRetry",
    "JwtUnavailable",
    "default_jwt_provider",
    "ResetClient",
]

RESET_BASE_URL = "https://zcode.z.ai/api/v1/coding-plan/reset"
JITTER_MIN_S = 3.0          # 动作前后随机延迟下界（KB 防风控节）
JITTER_MAX_S = 8.0          # 上界
COOLDOWN_WINDOW_S = 24 * 3600
MAX_CARD_FAILURES = 2       # 同卡 24h 内失败 > 2 次 → 冷却拒发
COOLDOWN_FILE = "reset_cooldown.json"
JWT_FILE = "zcode_jwt.txt"

# 线上 reset_type 取值（cards.py 的 "weekly" 别名归一为线上 "week"）
_WIRE_TYPES = {"five_hour": "five_hour", "week": "week", "weekly": "week"}

_STATE_DIR = Path(__file__).resolve().parents[1] / "state"


class ResetterError(Exception):
    """resetter 层错误基类。"""


class ThrottledError(ResetterError):
    """HTTP 429 限流 → 上层退避（不计入同卡失败冷却）。"""


class BizError(ResetterError):
    """业务码 code != 0（或非 200 且非 429），携带站方 message。"""

    def __init__(self, message: str, code: Any = None):
        self.code = code
        super().__init__(message)


class RetryableError(ResetterError):
    """网络错误已耗尽重试（默认 3 次）仍失败。"""


class RefuseRetry(ResetterError):
    """同卡 24h 内失败 > 2 次，冷却期拒发（不发任何请求）。"""


class JwtUnavailable(ResetterError):
    """ZCodeJWT 缺失/为空——需人工登录提取后写入 state/zcode_jwt.txt。"""


def default_jwt_provider(state_dir: Path | str | None = None) -> Callable[[], str]:
    """默认 JWT 源：读 state/zcode_jwt.txt（一次人工登录提取，长效保活）。

    返回 callable；缺失/为空抛 JwtUnavailable，错误只带路径不带队列值。
    """
    path = (Path(state_dir) if state_dir is not None else _STATE_DIR) / JWT_FILE

    def provider() -> str:
        try:
            token = path.read_text(encoding="utf-8").strip()
        except FileNotFoundError:
            raise JwtUnavailable(
                f"ZCodeJWT 缺失: {path}（一次人工登录控制台后提取写入，"
                "见 KNOWLEDGE_BASE/reset-protocol.md；套餐 Key 直调 reset/* 实测 401）") from None
        if not token:
            raise JwtUnavailable(f"ZCodeJWT 为空: {path}")
        return token

    return provider


def _urllib_transport(url: str, headers: dict, data: bytes | None = None,
                      timeout: float = 15.0):
    """stdlib urllib 兜底 transport：→ (status, 已解析 JSON 或原文本)。

    HTTPError 不上抛（转为 status 返回，由调用方分类）；网络层异常原样抛出。
    """
    req = urllib.request.Request(
        url, headers=headers, data=data, method="POST" if data is not None else "GET")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            status, raw = resp.status, resp.read()
    except urllib.error.HTTPError as e:
        status, raw = e.code, e.read()
    text = raw.decode("utf-8", "replace")
    try:
        return status, json.loads(text)
    except (ValueError, TypeError):
        return status, text


class ResetClient:
    """reset 协议客户端（fetch_status / execute；transport·rng·sleep·now 可注入）。"""

    def __init__(
        self,
        jwt_provider: Callable[[], str] | None = None,
        plan_key: str = "",
        base_url: str = RESET_BASE_URL,
        *,
        transport: Callable | None = None,
        rng: Callable[[], float] | None = None,
        sleep: Callable[[float], None] = time.sleep,
        now: Callable[[], float] = time.time,
        mode: str = "dry_run",
        ledger: Any = None,
        state_dir: Path | str | None = None,
        retries: int = 3,
        backoff_base: float = 2.0,
        target_type: str = "PERSONAL",
        timeout: float = 15.0,
    ):
        self._state_dir = Path(state_dir) if state_dir is not None else _STATE_DIR
        self._jwt_provider = jwt_provider or default_jwt_provider(self._state_dir)
        self._plan_key = plan_key
        self._base = base_url.rstrip("/")
        self._transport = transport or _urllib_transport
        self._rng = rng or random.Random().random
        self._sleep = sleep
        self._now = now
        self._mode = mode
        self._ledger = ledger                      # T-02 Ledger（鸭子类型 append）
        self._retries = retries
        self._backoff_base = backoff_base
        self._target_type = target_type
        self._timeout = timeout

    # ------------------------------------------------------------ 请求形状
    def _headers(self, jwt: str) -> dict:
        """KB resetHeaders 双凭证 + ZCode UA（团队场景另加 Organization/Project 头）。"""
        headers = {
            "Authorization": f"Bearer {jwt}",
            "Bigmodel-Target-Type": self._target_type,
            "User-Agent": "ZCode/1.0",
            "Accept": "application/json",
            "Content-Type": "application/json",
        }
        if self._plan_key:
            headers["X-Bigmodel-Authorization"] = self._plan_key
        return headers

    def _send(self, url: str, headers: dict, data: bytes | None = None):
        """单请求 + 网络错误退避重试（默认 3 次）→ (status, body)。"""
        last: OSError | None = None
        for attempt in range(1, self._retries + 2):        # 1 次 + retries 次重试
            try:
                return self._transport(url, headers, data)
            except OSError as e:                            # URLError/timeout/Connection 族
                last = e
                if attempt <= self._retries:
                    self._sleep(self._backoff_base * attempt)
        raise RetryableError(
            f"网络错误重试 {self._retries} 次仍失败({url}): {type(last).__name__}: {last}")

    def _jitter(self) -> float:
        """拟人随机延迟 ∈ [JITTER_MIN_S, JITTER_MAX_S]（rng 注入 [0,1) 序列）。"""
        return JITTER_MIN_S + (JITTER_MAX_S - JITTER_MIN_S) * self._rng()

    def _classify(self, status: int, body, where: str):
        """(status, body) → 三分类：429 限流 / 非 200 / code!=0。"""
        if status == 429:
            raise ThrottledError(f"{where}: HTTP 429 限流，退避后再试")
        if status != 200:
            raise BizError(f"{where}: HTTP {status}: {str(body)[:120]}", code=status)
        code = body.get("code") if isinstance(body, dict) else None
        if code != 0:
            msg = (body.get("message") or body.get("msg") or str(body)[:120]) \
                if isinstance(body, dict) else str(body)[:120]
            raise BizError(f"{where}: code={code} {msg}", code=code)
        return body.get("data") if isinstance(body, dict) else None

    # ------------------------------------------------------------ 冷却持久化
    def _load_cooldown(self) -> dict:
        path = self._state_dir / COOLDOWN_FILE
        try:
            mapping = json.loads(path.read_text(encoding="utf-8"))
        except FileNotFoundError:
            return {}
        except ValueError as e:
            raise ResetterError(f"冷却文件损坏(人工排查): {path} ({e})") from None
        return mapping if isinstance(mapping, dict) else {}

    def _save_cooldown(self, mapping: dict) -> None:
        self._state_dir.mkdir(parents=True, exist_ok=True)
        path = self._state_dir / COOLDOWN_FILE
        tmp = path.with_name(COOLDOWN_FILE + ".tmp")
        tmp.write_text(json.dumps(mapping, ensure_ascii=False), encoding="utf-8")
        os.replace(tmp, path)                       # 原子替换，崩溃不留半文件

    def _fresh_failures(self, mapping: dict, wire: str) -> list[dict]:
        cutoff = int(self._now()) - COOLDOWN_WINDOW_S
        return [f for f in mapping.get(wire, []) if f.get("ts", 0) > cutoff]

    def _record_failure(self, wire: str, error: str) -> None:
        mapping = self._load_cooldown()
        kept = self._fresh_failures(mapping, wire)
        kept.append({"ts": int(self._now()), "error": error[:200]})
        mapping[wire] = kept
        self._save_cooldown(mapping)

    def _clear_cooldown(self, wire: str) -> None:
        mapping = self._load_cooldown()
        mapping[wire] = []
        self._save_cooldown(mapping)

    def _ledger_append(self, kind: str, payload: dict) -> None:
        if self._ledger is not None:
            self._ledger.append(kind, payload)      # payload 经账本 redact 落盘

    # ------------------------------------------------------------ GET /status
    def fetch_status(self) -> dict:
        """GET /status → 可用卡槽 + 最近使用历史（解析自 data 节）。"""
        url = self._base + "/status"
        status, body = self._send(url, self._headers(self._jwt_provider()))
        data = self._classify(status, body, "/status") or {}
        if not isinstance(data, dict):
            raise BizError("/status: code=0 但 data 非对象", code=0)
        return {
            "available_five_hour_resets": data.get("available_five_hour_resets", []),
            "available_week_resets": data.get("available_week_resets", []),
            "latest_five_hour_reset_history": data.get("latest_five_hour_reset_history"),
            "latest_week_reset_history": data.get("latest_week_reset_history"),
            "fetched_at": int(self._now()),
        }

    # ------------------------------------------------------------ POST /use
    def execute(self, reset_type: str) -> dict:
        """POST /use 执行一次重置（幂等键每次新生成 uuid4）。

        流程：冷却检查 → 账本 reset_exec →（dry_run/notify_only：simulated 返回）
        → 前抖动 → POST（网络错重试）→ 后抖动 → 分类（429/HTTP/code）→ 账本 reset_result。
        """
        wire = _WIRE_TYPES.get(reset_type)
        if wire is None:
            raise ValueError(
                f"reset_type 非法: {reset_type!r}（允许 {'|'.join(_WIRE_TYPES)}）")

        # 同卡 24h 冷却：>2 次失败拒发（先于任何网络动作与模拟分支）
        failures = self._fresh_failures(self._load_cooldown(), wire)
        if len(failures) > MAX_CARD_FAILURES:
            self._ledger_append("reset_result", {
                "reset_type": wire, "ok": False, "simulated": self._mode != "auto",
                "refused": "cooldown", "failures_24h": len(failures),
            })
            raise RefuseRetry(
                f"同卡 {wire} 24h 内失败 {len(failures)} 次(>2)冷却拒发，"
                f"最近一次: {failures[-1].get('error', '?')}")

        idem = str(uuid.uuid4())                    # 每次新生成（KB 关键事实）
        simulated = self._mode != "auto"
        self._ledger_append("reset_exec", {
            "reset_type": wire, "idempotency_key": idem,
            "mode": self._mode, "simulated": simulated,
        })

        if simulated:                               # dry_run / notify_only：零网络零延迟
            result = {
                "ok": True, "simulated": True, "reset_type": wire,
                "idempotency_key": idem, "http_status": None, "code": 0,
                "used": True, "note": f"mode={self._mode} 未发包", "ts": int(self._now()),
            }
            self._ledger_append("reset_result", result)
            return result

        payload = json.dumps({"idempotency_key": idem, "reset_type": wire}).encode("utf-8")
        url = self._base + "/use"
        headers = self._headers(self._jwt_provider())
        try:
            self._sleep(self._jitter())             # 动作前拟人延迟
            try:
                status, body = self._send(url, headers, payload)
            except RetryableError as e:
                self._record_failure(wire, f"RetryableError: {e}")
                self._ledger_append("reset_result", {
                    "reset_type": wire, "ok": False, "simulated": False,
                    "idempotency_key": idem, "error": f"RetryableError: {e}",
                })
                raise
            self._sleep(self._jitter())             # 动作后拟人延迟（已获响应）
            data = self._classify(status, body, "/use")
        except (ThrottledError, BizError) as e:
            if isinstance(e, BizError):             # 限流不计入同卡失败冷却
                self._record_failure(wire, f"{type(e).__name__}: {e}")
            self._ledger_append("reset_result", {
                "reset_type": wire, "ok": False, "simulated": False,
                "idempotency_key": idem, "error": f"{type(e).__name__}: {e}",
            })
            raise

        used = bool(data.get("used", True)) if isinstance(data, dict) else True
        self._clear_cooldown(wire)                  # 成功即清零（重新累计）
        result = {
            "ok": True, "simulated": False, "reset_type": wire,
            "idempotency_key": idem, "http_status": status, "code": 0,
            "used": used, "ts": int(self._now()),
        }
        self._ledger_append("reset_result", result)
        return result
