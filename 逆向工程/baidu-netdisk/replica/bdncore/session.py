# -*- coding: utf-8 -*-
"""BdnSession：凭据加载 / Cookie 头 / UA / 重试退避 / 控制面节流 / 熔断器。

铁律：
- 凭据只从 JSON 字段直读（bduss 含 '-'，绝不正则解析 cookie 串）；
- 任何输出/日志一律掩码（mask()），绝不打印明文 BDUSS/STOKEN/bdstoken；
- 控制面节流：并发 ≤2，物理请求间隔 ≥1.5s；
- 熔断：errno ∈ {31119, 31329, 20012, 31034} 即全局停，后续一律抛 BdnCircuitOpen；
- 重试：3 次尝试，指数退避 1.5s/3s，仅对传输异常与 HTTP ≥500；业务 errno 不重试。
"""
from __future__ import annotations

import json
import os
import threading
import time
from contextlib import contextmanager
from urllib.parse import urlsplit

import requests

from .errors import (
    BdnApiError,
    BdnAuthError,
    BdnCircuitOpen,
    BdnNetworkError,
    CIRCUIT_ERRNOS,
    describe,
)

DEFAULT_CRED_PATH = r"E:\AI-Station\data\secrets\bdn_credentials.json"
DEFAULT_REFERER = "https://pan.baidu.com/disk/main"
HOST = "pan.baidu.com"
BASE_URL = "https://" + HOST

RETRY_TIMES = 3            # 总尝试次数
BACKOFF_BASE = 1.5         # 首次退避秒数，之后 ×2（1.5 → 3.0）
MIN_INTERVAL = 1.5         # 物理请求最小间隔（秒）
MAX_CONCURRENCY = 2        # 控制面并发上限
HTTP_TIMEOUT = (10, 30)    # (connect, read)


def _backoff_sleep(seconds: float):
    """退避睡眠（模块级函数，便于离线单测打桩）。"""
    time.sleep(seconds)


def mask(value) -> str:
    """凭据掩码：只暴露长度，不暴露内容。"""
    if value is None:
        return "<None>"
    s = str(value)
    return f"<masked len={len(s)}>"


class Throttle:
    """控制面节流器：信号量限并发 + 时间轴保间隔。clock/sleeper 可注入以便离线单测。"""

    def __init__(self, min_interval: float = MIN_INTERVAL,
                 max_concurrency: int = MAX_CONCURRENCY,
                 clock=time.monotonic, sleeper=time.sleep):
        self.min_interval = min_interval
        self._sem = threading.Semaphore(max_concurrency)
        self._lock = threading.Lock()
        self._last = float("-inf")
        self._clock = clock
        self._sleep = sleeper

    @contextmanager
    def slot(self):
        """获取一个请求槽：并发许可 + 与上一物理请求的间隔保证。

        注意：不得在 finally 里 return（会吞掉调用方异常——离线单测已抓过此雷）。
        信号量释放由 with self._sem 在异常传播时自动完成。
        """
        with self._sem:
            while True:
                with self._lock:
                    wait = self._last + self.min_interval - self._clock()
                    if wait <= 0:
                        self._last = self._clock()
                        break
                self._sleep(wait)
            yield


class _FakeResponse:
    """离线单测用的极简响应对象。"""

    def __init__(self, payload: dict, status_code: int = 200):
        self._payload = payload
        self.status_code = status_code

    def json(self):
        return self._payload


class BdnSession:
    """带节流/熔断/重试的只读会话。transport 可注入以便离线单测。"""

    def __init__(self, cred_path: str | None = None,
                 creds: dict | None = None,
                 transport=None, throttle: Throttle | None = None):
        self.cred_path = cred_path or os.environ.get("BDN_CREDENTIALS", DEFAULT_CRED_PATH)
        if creds is None:
            creds = self.load_credentials(self.cred_path)
        self.bduss = creds["bduss"]
        self.stoken = creds["stoken"]
        self.ua = creds.get("ua") or creds.get("ua_native") or (
            "netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia")
        self.referer = DEFAULT_REFERER
        self.throttle = throttle or Throttle()
        self._transport = transport or requests.Session()
        # 熔断状态
        self._circuit_reason: str | None = None
        self._circuit_errno = None
        # 请求台账（只记方法+路径+状态+耗时，永不记 Cookie/凭据）
        self.request_log: list[dict] = []
        self.requests_sent = 0

    # ---------- 凭据 ----------

    @staticmethod
    def load_credentials(path: str) -> dict:
        """从 JSON 直读字段。字段缺失/文件不存在 → BdnAuthError（退出码 2）。"""
        try:
            with open(path, "r", encoding="utf-8") as f:
                raw = json.load(f)
        except FileNotFoundError:
            raise BdnAuthError(f"凭据文件不存在: {path}")
        except (OSError, ValueError) as e:
            raise BdnAuthError(f"凭据文件读取/解析失败: {type(e).__name__}: {e}")
        bduss = raw.get("bduss")
        stoken = raw.get("stoken")
        if not bduss or not isinstance(bduss, str):
            raise BdnAuthError("凭据缺字段 bduss（或为空）")
        if not stoken or not isinstance(stoken, str):
            raise BdnAuthError("凭据缺字段 stoken（或为空）")
        return {
            "bduss": bduss,
            "stoken": stoken,
            "ua": raw.get("ua_native") or raw.get("ua"),
        }

    def cookie_header(self) -> str:
        # BDUSS 含 '-' 等 base62 字符，直接拼接，绝不走正则
        return f"BDUSS={self.bduss}; STOKEN={self.stoken}"

    def headers(self) -> dict:
        return {
            "Cookie": self.cookie_header(),
            "User-Agent": self.ua,
            "Referer": self.referer,
        }

    # ---------- 熔断 ----------

    @property
    def circuit_open(self) -> bool:
        return self._circuit_reason is not None

    def _check_circuit(self):
        if self._circuit_reason is not None:
            raise BdnCircuitOpen(
                f"熔断已打开: {self._circuit_reason}；本进程内停止一切请求", self._circuit_errno)

    def _trip(self, errno):
        self._circuit_errno = errno
        self._circuit_reason = f"errno={errno} {describe(errno)}"

    # ---------- 请求 ----------

    def request(self, method: str, path: str, params: dict | None = None,
                data: dict | None = None, cookies: str | None = None) -> dict:
        """发一次受控请求，返回解析后的 JSON dict。

        - path 以 / 开头（pan.baidu.com 域内路径）或完整 https:// URL（跨域端点：
          d.pcs.baidu.com 上传定位等，W4 起支持；台账记 netloc+path）；
        - cookies（W5）：附加 Cookie 段（如转存链 randsk → "BDCLND=…"），拼在
          BDUSS+STOKEN 之后；台账/输出永不记 Cookie 值；
        - 裸 JSON 数组响应（xpan task?method=querytask 形态）→ 包成 {"errno":0,"_list":[...]}；
        - errno==0 或缺省 → 返回 payload；
        - errno 命中 CIRCUIT_ERRNOS → 熔断 + BdnCircuitOpen；
        - errno==-6/111 → BdnAuthError；其余 → BdnApiError；
        - 传输异常/HTTP≥500 → 指数退避重试（共 3 次），耗尽抛 BdnNetworkError。
        """
        self._check_circuit()
        if path.startswith("https://") or path.startswith("http://"):
            url = path
            sp = urlsplit(path)
            log_path = sp.netloc + sp.path       # 跨域端点：台账带 host 区分家族
        else:
            if not path.startswith("/"):
                raise BdnApiError(-7, f"请求路径必须以 / 开头: {path!r}")
            url = BASE_URL + path
            log_path = path
        headers = self.headers()
        if cookies:
            headers["Cookie"] = headers["Cookie"] + "; " + cookies
        last_exc: Exception | None = None
        for attempt in range(RETRY_TIMES):
            with self.throttle.slot():
                t0 = time.perf_counter()
                try:
                    resp = self._transport.request(
                        method, url, params=params, data=data,
                        headers=headers, timeout=HTTP_TIMEOUT)
                    status = resp.status_code
                    if status >= 500:
                        raise requests.HTTPError(f"HTTP {status}")
                except requests.RequestException as e:
                    status = -1
                    self.requests_sent += 1
                    self.request_log.append({
                        "method": method, "path": log_path, "http": status,
                        "errno": None, "ms": round((time.perf_counter() - t0) * 1000, 1),
                        "attempt": attempt + 1})
                    last_exc = e
                    if attempt + 1 < RETRY_TIMES:
                        _backoff_sleep(BACKOFF_BASE * (2 ** attempt))  # 1.5s → 3.0s
                    continue
                self.requests_sent += 1
                try:
                    payload = resp.json()
                except ValueError:
                    self.request_log.append({
                        "method": method, "path": log_path, "http": status,
                        "errno": None, "ms": round((time.perf_counter() - t0) * 1000, 1),
                        "attempt": attempt + 1})
                    raise BdnApiError(-1, f"非 JSON 响应（HTTP {status}, path={log_path}）")
                if isinstance(payload, list):
                    # 裸数组响应（xpan task?method=querytask）：包一层，errno 视 0（W4）
                    self.request_log.append({
                        "method": method, "path": log_path, "http": status,
                        "errno": 0, "ms": round((time.perf_counter() - t0) * 1000, 1),
                        "attempt": attempt + 1})
                    return {"errno": 0, "_list": payload}
                errno = payload.get("errno", 0)
                self.request_log.append({
                    "method": method, "path": log_path, "http": status,
                    "errno": errno, "ms": round((time.perf_counter() - t0) * 1000, 1),
                    "attempt": attempt + 1})
                if errno in CIRCUIT_ERRNOS:
                    self._trip(errno)
                    raise BdnCircuitOpen(
                        f"熔断触发: errno={errno} {describe(errno)}（path={path}）", errno)
                if errno == -6 or errno == 111:
                    raise BdnAuthError(describe(errno), errno=errno)
                if errno != 0:
                    raise BdnApiError(errno, payload=payload)
                return payload
        raise BdnNetworkError(
            f"传输失败重试耗尽（{RETRY_TIMES} 次）: {type(last_exc).__name__}: {last_exc}")

    def get(self, path, **kw) -> dict:
        return self.request("GET", path, **kw)

    def post(self, path, **kw) -> dict:
        return self.request("POST", path, **kw)
