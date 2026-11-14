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
CIRCUIT_TTL = 30 * 60      # 熔断标记跨进程 TTL（秒）——W7 B8：30 分钟
CIRCUIT_MARKER = ".bdn_circuit.json"   # 标记文件名（放凭据同目录）

# W7 A7：STOKEN 失效（蓝本 issue #546）自愈编排的中文指引
AUTH_REGUIDE = (
    "登录凭据失效（errno={errno}），且从凭据文件重读后仍无新值——不再盲目复用旧 token。\n"
    "请手动重收凭据：按 README「凭据重收 runbook」重新抓取 BDUSS/STOKEN 写入 "
    f"{DEFAULT_CRED_PATH}，或以 --cred 指定新凭据文件后重试；"
    "重收后可先跑 bdn doctor 验活（若此前熔断，用 bdn doctor --reset 清标记）。")


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
        self._creds_from_file = creds is None      # 生产 CLI 路径（凭据重读自愈的前提）
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
        # W7 B8：跨进程熔断标记预装载（仅生产路径；creds= 注入的测试会话不受影响）
        if self._creds_from_file:
            m = self._read_circuit_marker()
            if m is not None:
                self._circuit_errno = m.get("errno")
                self._circuit_reason = (
                    f"跨进程持久化: errno={m.get('errno')} "
                    f"{describe(m.get('errno'))}（标记于 {m.get('time')}，"
                    f"TTL {CIRCUIT_TTL // 60} 分钟内）")
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
                f"熔断已打开: {self._circuit_reason}；本进程内停止一切请求"
                "（bdn doctor --reset 可清标记）", self._circuit_errno)

    def _trip(self, errno):
        self._circuit_errno = errno
        self._circuit_reason = f"errno={errno} {describe(errno)}"
        if self._creds_from_file:               # 仅生产路径落标记（离线注入态不写盘）
            self._write_circuit_marker(errno)

    # ---- W7 B8：熔断标记跨进程持久化（凭据同目录 .bdn_circuit.json，TTL 30 分钟） ----

    def circuit_marker_path(self) -> str:
        d = os.path.dirname(os.path.abspath(self.cred_path)) or "."
        return os.path.join(d, CIRCUIT_MARKER)

    def _write_circuit_marker(self, errno):
        """落标记（errno+时间戳）。写失败不掩盖原熔断异常——静默容忍。"""
        try:
            with open(self.circuit_marker_path(), "w", encoding="utf-8") as f:
                json.dump({"errno": errno,
                           "ts": time.time(),
                           "time": time.strftime("%Y-%m-%d %H:%M:%S")}, f)
        except OSError:
            pass

    def _read_circuit_marker(self) -> dict | None:
        """读未过期标记；无标记/过期/坏文件 → None（过期顺手清掉）。"""
        try:
            with open(self.circuit_marker_path(), "r", encoding="utf-8") as f:
                m = json.load(f)
        except (OSError, ValueError):
            return None
        if not isinstance(m, dict) or "errno" not in m:
            return None
        try:
            fresh = time.time() - float(m.get("ts", 0)) < CIRCUIT_TTL
        except (TypeError, ValueError):
            return None
        if not fresh:
            self.clear_circuit_marker()
            return None
        return m

    def clear_circuit_marker(self) -> bool:
        """清标记文件（bdn doctor --reset 调用）。返回是否确实删了文件。"""
        try:
            os.remove(self.circuit_marker_path())
            return True
        except OSError:
            return False

    def reset_circuit(self) -> dict:
        """熔断复位（内存+标记双清）。doctor --reset 用。"""
        removed = self.clear_circuit_marker()
        reason, errno = self._circuit_reason, self._circuit_errno
        self._circuit_reason = None
        self._circuit_errno = None
        return {"reset": True, "marker_removed": removed,
                "previous_reason": reason, "previous_errno": errno}

    # ---------- 请求 ----------

    def request(self, method: str, path: str, params: dict | None = None,
                data: dict | None = None, cookies: str | None = None,
                files: dict | None = None) -> dict:
        """受控请求编排壳（W7 A7：STOKEN 失效自愈）。

        errno -6/111（蓝本 issue #546 stoken 族失效）→ 从凭据文件重读一次：
        拿到**不同**的 BDUSS/STOKEN 才退避 1.5s 重试一次；重读无新值或重试仍败
        → BdnAuthError 附中文重收指引（绝不盲目复用旧 token 重试）。
        files（W7）：multipart 表单（recycle restore 的 param 字段形态）。
        """
        for cred_round in range(2):
            try:
                return self._request_once(method, path, params, data, cookies,
                                          files)
            except BdnAuthError as e:
                if e.errno not in (-6, 111) or cred_round > 0:
                    raise
                if self._reload_credentials():
                    continue                    # 拿到新凭据 → 退避后重试一次
                raise BdnAuthError(
                    AUTH_REGUIDE.format(errno=e.errno), errno=e.errno) from e
        raise BdnAuthError("unreachable", errno=-6)   # pragma: no cover

    def _reload_credentials(self) -> bool:
        """凭据文件重读（仅 _creds_from_file 生产路径）。有新值→更新+退避→True。"""
        if not self._creds_from_file:
            return False
        try:
            fresh = self.load_credentials(self.cred_path)
        except BdnAuthError:
            return False
        if fresh["bduss"] == self.bduss and fresh["stoken"] == self.stoken:
            return False                         # 文件无新值（没换 token 白试）
        self.bduss, self.stoken = fresh["bduss"], fresh["stoken"]
        if fresh.get("ua"):
            self.ua = fresh["ua"]
        _backoff_sleep(BACKOFF_BASE)             # 退避 1.5s 再重试（W7 A7）
        return True

    def _request_once(self, method: str, path: str, params: dict | None = None,
                      data: dict | None = None, cookies: str | None = None,
                      files: dict | None = None) -> dict:
        """单轮受控请求（原 request() 主体，重试/熔断/台账语义不变；
        -6/111 的凭据自愈由外层 request() 编排）。"""
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
                    if files is not None:
                        resp = self._transport.request(
                            method, url, params=params, data=data, files=files,
                            headers=headers, timeout=HTTP_TIMEOUT)
                    else:
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
