# -*- coding: utf-8 -*-
"""
PAI-Station 通道适配器 PoC 骨架（L2 协议参考实现）
====================================================

依据：ADR-16「借件不借架」L2 级借用 —— 以 OpenClaw feishu 扩展
（research/competitors-src/openclaw-main/extensions/feishu/src/monitor.transport.ts，MIT）
为协议参考实现，用 Python 在自有精简内核中重写其生命周期工程件。

移植清单（源码行号见 RESEARCH_DOCKET/openclaw-channel-protocols.md §4/§5/§8）：
  1. 指数退避重连：min(1000 * 2^(attempt-1), 30000) ms，成功即清零  (:52-53,:127-132)
  2. 终态错误分类：重连耗尽/自动重连关闭 -> blocked，其余 -> recovering (:55-57,:160-166)
  3. 状态三态发布：ready / recovering / blocked + 时间戳，喂健康监控   (:257-273,:304-312)
  4. 入站安全五件套：签名前置(时序安全比较)/challenge/限流/体积+超时守卫/原型污染防护 (:358-568)
  5. 日志脱敏五正则：URL 凭据/Bearer 头/裸 Bearer/敏感键值/控制字符+截断 (:134-158)
  6. durable 纪律：先落账后应答，应答头如实反映接受语义            (:50-51,:498-507)
  7. 归一化事件契约：三身份域 + 会话拓扑(根/父/线程) + 提及列表      (event-types.ts)

本文件是【提案冻结期的接口骨架】，不连任何真实 IM 服务；M0 批准后由
M2 通道子系统按此契约逐通道实现（飞书 = 官方 lark-oapi WSClient 对等委托，
同 OpenClaw client.ts 的 SDK 委托模式——协议零自研）。

运行：python poc/channel_adapter_skeleton.py   （自测：脱敏+退避+终态分类+守卫）
"""

from __future__ import annotations

import hashlib
import hmac
import json
import re
import time
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Optional

# ----------------------------------------------------------------------------
# 常量：与 OpenClaw monitor.transport.ts 同名同值（源码行号注释）
# ----------------------------------------------------------------------------

RECONNECT_INITIAL_DELAY_MS = 1_000        # :52 FEISHU_WS_RECONNECT_INITIAL_DELAY_MS
RECONNECT_MAX_DELAY_MS = 30_000           # :53 FEISHU_WS_RECONNECT_MAX_DELAY_MS
LOG_ERROR_MAX_LENGTH = 500                # :54 截断上限

# :55-57 终态错误的两条契约（SDK 抛出的消息前缀/正则）
TERMINAL_RECONNECT_EXHAUSTED_RE = re.compile(r"^WebSocket reconnect exhausted after \d+ attempts?")
TERMINAL_AUTORECONNECT_DISABLED = "WebSocket connect failed and autoReconnect is disabled"

# :63-68 原型污染防护键黑名单（Python 侧防御 json 载荷的键注入/阴影）
BLOCKED_PAYLOAD_KEYS = frozenset({"__proto__", "prototype", "constructor", "headers"})


# ----------------------------------------------------------------------------
# 件 5：日志脱敏（monitor.transport.ts:134-158 formatFeishuWsErrorForLog 移植）
# ----------------------------------------------------------------------------

_REDACT_URL_CREDS = re.compile(r"://[^:@/\s]+:[^@/\s]+@")
_REDACT_AUTH_HEADER = re.compile(r"\b(authorization\s*[:=]\s*Bearer\s+)[^\s,;]+", re.IGNORECASE)
_REDACT_BARE_BEARER = re.compile(r"\b(Bearer\s+)[A-Za-z0-9._~+/-]+=*")
_REDACT_SECRET_KV = re.compile(
    r"\b((?:app[_-]?secret|tenant[_-]?access[_-]?token|access[_-]?token|refresh[_-]?token"
    r"|token|secret|password)\s*[:=]\s*)[^\s&;,]+",
    re.IGNORECASE,
)


def redact_error_for_log(err: BaseException | str) -> str:
    """异常/文本 -> 可入日志与信任账本的脱敏单行文本（五正则 + 控制字符 + 截断）。"""
    raw = err if isinstance(err, str) else (str(err) or err.__class__.__name__)
    single_line = "".join(" " if (ord(ch) <= 31 or ord(ch) == 127) else ch for ch in raw)
    redacted = _REDACT_URL_CREDS.sub("://[redacted]@", single_line)
    redacted = _REDACT_AUTH_HEADER.sub(r"\1[redacted]", redacted)
    redacted = _REDACT_BARE_BEARER.sub(r"\1[redacted]", redacted)
    redacted = _REDACT_SECRET_KV.sub(r"\1[redacted]", redacted)
    redacted = re.sub(r"\s+", " ", redacted).strip() or "unknown error"
    if len(redacted) <= LOG_ERROR_MAX_LENGTH:
        return redacted
    return redacted[:LOG_ERROR_MAX_LENGTH] + "..."


# ----------------------------------------------------------------------------
# 件 2 + 3：终态分类 + 状态三态发布
# ----------------------------------------------------------------------------

class Lifecycle(str, Enum):
    READY = "ready"
    RECOVERING = "recovering"
    BLOCKED = "blocked"


@dataclass(frozen=True)  # 不可变：所有状态对象一经发布不再修改
class ChannelStatus:
    """statusSink 发布协议（对应 channelReadyPatch / channelBlockedPatch / recovering）。"""
    connected: bool
    lifecycle: Lifecycle
    last_connected_at: Optional[float] = None
    last_event_at: Optional[float] = None
    last_error: Optional[str] = None
    terminal_disconnect: bool = False


def is_terminal_error(err: BaseException) -> bool:
    """OpenClaw 契约：仅 SDK 的两条终态消息视为 blocked，其余一律可恢复重试。"""
    msg = str(err).strip()
    return bool(TERMINAL_RECONNECT_EXHAUSTED_RE.match(msg)) or msg.startswith(
        TERMINAL_AUTORECONNECT_DISABLED
    )


def reconnect_delay_ms(attempt: int) -> int:
    """:127-132 指数退避：min(1000 * 2^(attempt-1), 30000)。attempt 从 1 起。"""
    return min(RECONNECT_INITIAL_DELAY_MS * 2 ** max(0, attempt - 1), RECONNECT_MAX_DELAY_MS)


StatusSink = Callable[[ChannelStatus], None]


def _publish_ready(sink: Optional[StatusSink]) -> ChannelStatus:
    now = time.time()
    status = ChannelStatus(True, Lifecycle.READY, last_connected_at=now, last_event_at=now)
    if sink:
        sink(status)
    return status


def _publish_recovering(sink: Optional[StatusSink]) -> ChannelStatus:
    status = ChannelStatus(False, Lifecycle.RECOVERING, last_event_at=time.time())
    if sink:
        sink(status)
    return status


def _publish_blocked(sink: Optional[StatusSink], redacted_error: str) -> ChannelStatus:
    status = ChannelStatus(
        False, Lifecycle.BLOCKED, last_event_at=time.time(),
        last_error=redacted_error, terminal_disconnect=True,
    )
    if sink:
        sink(status)
    return status


# ----------------------------------------------------------------------------
# 件 7：归一化事件契约（event-types.ts 的语言无关版）
# ----------------------------------------------------------------------------

@dataclass(frozen=True)
class NormalizedEvent:
    """所有通道适配器的统一出站事件：三身份域 + 会话拓扑 + 提及。"""
    platform: str                      # feishu / wecom / dingtalk / ...
    message_id: str
    chat_id: str
    chat_type: str                     # p2p | group | ...
    sender_native_id: str              # 平台原生 ID（open_id / userid / ...）
    sender_union_id: Optional[str]     # 统一 ID（跨通道画像关联键）
    tenant_key: Optional[str]          # 租户键（多企业隔离）
    content: str
    message_type: str = "text"
    root_id: Optional[str] = None      # 会话拓扑：根消息
    parent_id: Optional[str] = None    # 父消息
    thread_id: Optional[str] = None    # 线程
    mentions: tuple[str, ...] = ()     # 被提及者原生 ID
    ts: float = field(default_factory=time.time)


# ----------------------------------------------------------------------------
# 件 1：通道适配器抽象基类（connect/auth/recv/send/reconnect/health 六接口）
# ----------------------------------------------------------------------------

class ChannelAdapter(ABC):
    """通道即插件（第 17 章）的传输层契约。

    实现纪律（全部来自 OpenClaw 源码证据，见 docket）：
    - 协议零自研：优先委托官方 SDK（飞书 lark-oapi / 钉钉 dingtalk-stream）
    - 每账户一个适配器实例；凭据四元组变化才重建底层客户端（client.ts:233-370）
    - 重连退避/终态分类由本基类 run_loop 统一治理，子类只实现瞬时连接语义
    """

    platform: str = "abstract"

    def __init__(self, account_id: str, status_sink: Optional[StatusSink] = None) -> None:
        self.account_id = account_id
        self._status_sink = status_sink
        self._aborted = False
        self._attempt = 0

    # ---- 子类必须实现的六个接口 -------------------------------------------

    @abstractmethod
    async def connect(self) -> Any:
        """建立瞬时连接（WS 握手 / HTTP 回调注册）。失败抛异常，由 run_loop 治理。"""

    @abstractmethod
    async def recv(self) -> NormalizedEvent:
        """阻塞等待下一条归一化事件。连接死亡抛异常。"""

    @abstractmethod
    async def send(self, chat_id: str, content: str, *, root_id: Optional[str] = None) -> str:
        """发送消息，返回 message_id。"""

    @abstractmethod
    async def auth_refresh(self) -> None:
        """凭据/token 刷新（tenant_access_token 等由官方 SDK 托管时可空实现）。"""

    @abstractmethod
    async def close(self) -> None:
        """幂等关闭当前连接（cleanup 契约：close 失败仅记日志，不掩盖主流程）。"""

    @abstractmethod
    async def health(self) -> bool:
        """活性探针：真实请求级探测，进程存活但连接死 must 返回 False。"""

    # ---- 基类统一治理的重连主循环（monitor.transport.ts:223-356 的 Python 版）----

    async def run_loop(self, handler: Callable[[NormalizedEvent], Any]) -> None:
        """while 未中止: 连接 -> (成功) attempt=0 + 发布 ready -> 逐事件回调
        -> (终态) 发布 blocked；否则发布 recovering -> 指数退避 -> 重建。"""
        while not self._aborted:
            conn: Any = None
            try:
                conn = await self.connect()
                self._attempt = 0
                _publish_ready(self._status_sink)
                while not self._aborted:
                    event = await self.recv()
                    await handler(event)
            except BaseException as err:  # noqa: BLE001 —— 循环治理一切非中止异常
                redacted = redact_error_for_log(err)
                await self._safe_close()
                if self._aborted:
                    return
                if is_terminal_error(err):
                    _publish_blocked(self._status_sink, redacted)
                else:
                    _publish_recovering(self._status_sink)
                self._attempt += 1
                delay_s = reconnect_delay_ms(self._attempt) / 1000.0
                if delay_s > 0:
                    time.sleep(delay_s)  # PoC 用同步 sleep；M2 实现换 asyncio.sleep
            finally:
                await self._safe_close()

    async def _safe_close(self) -> None:
        try:
            await self.close()
        except BaseException as err:  # noqa: BLE001 —— cleanup 失败只记不抛（:168-188）
            print(f"[{self.platform}/{self.account_id}] close error: {redact_error_for_log(err)}")

    def abort(self) -> None:
        self._aborted = True


# ----------------------------------------------------------------------------
# 件 4：入站 Webhook 安全五件套（monitor.transport.ts:358-517 的 Python 版）
# ----------------------------------------------------------------------------

@dataclass(frozen=True)
class WebhookGuardVerdict:
    status_code: int          # 0 = 放行
    reason: str = ""


def verify_feishu_style_signature(
    timestamp: str, nonce: str, raw_body: bytes, encrypt_key: str, signature: str
) -> bool:
    """:94-119 sha256(timestamp + nonce + encryptKey + rawBody)，hmac.compare_digest 时序安全。"""
    computed = hashlib.sha256(
        (timestamp + nonce + encrypt_key).encode("utf-8") + raw_body
    ).hexdigest()
    return hmac.compare_digest(computed, signature or "")


def strip_blocked_keys(payload: dict[str, Any]) -> dict[str, Any]:
    """:63-83 原型污染防护：__proto__/prototype/constructor/headers 键不进事件载荷。"""
    return {k: v for k, v in payload.items() if k not in BLOCKED_PAYLOAD_KEYS}


def webhook_admission(
    *,
    method: str,
    content_type: str,
    raw_body: bytes,
    max_body_bytes: int,
    signature_check: Optional[Callable[[], bool]] = None,
) -> WebhookGuardVerdict:
    """五件套的同步前置段：方法白名单 -> Content-Type -> 体积 -> 签名（先于 JSON 解析）。"""
    if method.upper() != "POST":
        return WebhookGuardVerdict(405, "method not allowed")
    if "application/json" not in (content_type or "").lower():
        return WebhookGuardVerdict(415, "content-type must be json")
    if len(raw_body) > max_body_bytes:
        return WebhookGuardVerdict(413, "body too large")
    if signature_check is not None and not signature_check():
        return WebhookGuardVerdict(401, "invalid signature")  # 验签先于 JSON 解析
    return WebhookGuardVerdict(0, "ok")


def parse_webhook_payload(raw_body: bytes) -> Optional[dict[str, Any]]:
    """:85-92 解析失败返回 None（上层回 400），成功载荷先过键黑名单。"""
    try:
        parsed = json.loads(raw_body.decode("utf-8"))
    except (ValueError, UnicodeDecodeError):
        return None
    if not isinstance(parsed, dict):
        return None
    return strip_blocked_keys(parsed)


# ----------------------------------------------------------------------------
# 件 6：durable 纪律 —— 先落账后应答（feishu-ingress + :50-51,:498-507）
# ----------------------------------------------------------------------------

class DurableLedgerStub:
    """PoC 级账本桩：M2 实现为 SQLite 事务（events 表先 INSERT 后 ACK）。

    契约：应答头 x-pai-delivery-accepted: durable 只在事件真正落账后设置；
    challenge 与非持久事件 ACK 不宣称 durable（防假账）。
    """

    def __init__(self) -> None:
        self._entries: list[tuple[str, float]] = []

    def accept(self, event_id: str) -> dict[str, str]:
        self._entries.append((event_id, time.time()))
        return {"x-pai-delivery-accepted": "durable"}

    def ack_only(self) -> dict[str, str]:
        return {}  # 未落账 -> 不加 durable 头


# ----------------------------------------------------------------------------
# PoC 自测（不连任何真实服务；验证移植件的数学与契约）
# ----------------------------------------------------------------------------

def _selftest() -> None:
    ok: list[str] = []

    # 件 5 脱敏
    leak = "connect ws://user:pa55@host failed Bearer abc.def.ghi token=xyz123 password=hunter2"
    red = redact_error_for_log(leak)
    assert "pa55" not in red and "abc.def.ghi" not in red and "xyz123" not in red and "hunter2" not in red
    ok.append(f"redact: {red}")

    # 件 1 退避曲线
    curve = [reconnect_delay_ms(n) for n in range(1, 8)]
    assert curve == [1000, 2000, 4000, 8000, 16000, 30000, 30000], curve
    ok.append(f"backoff: {curve}")

    # 件 2 终态分类
    assert is_terminal_error(RuntimeError("WebSocket reconnect exhausted after 5 attempts"))
    assert is_terminal_error(RuntimeError(TERMINAL_AUTORECONNECT_DISABLED))
    assert not is_terminal_error(RuntimeError("ECONNRESET socket hang up"))
    ok.append("terminal-classification: 2 terminal + 1 recoverable")

    # 件 4 守卫次序
    assert webhook_admission(method="GET", content_type="application/json",
                             raw_body=b"{}", max_body_bytes=1024).status_code == 405
    assert webhook_admission(method="POST", content_type="text/plain",
                             raw_body=b"{}", max_body_bytes=1024).status_code == 415
    assert webhook_admission(method="POST", content_type="application/json",
                             raw_body=b"x" * 11, max_body_bytes=10).status_code == 413
    assert webhook_admission(method="POST", content_type="application/json",
                             raw_body=b"{}", max_body_bytes=10,
                             signature_check=lambda: False).status_code == 401
    ok.append("guards: 405/415/413/401 ordered")

    # 件 4 签名 + 原型污染
    sig = hashlib.sha256(b"1700000000nonce123key/body").hexdigest()
    assert verify_feishu_style_signature("1700000000", "nonce123", b"/body", "key", sig)
    clean = strip_blocked_keys({"__proto__": 1, "headers": 2, "data": 3})
    assert clean == {"data": 3}
    ok.append("signature + proto-pollution")

    # 件 6 durable
    ledger = DurableLedgerStub()
    assert ledger.accept("evt-1") == {"x-pai-delivery-accepted": "durable"}
    assert ledger.ack_only() == {}
    ok.append("durable: accepted/ack-only semantics")

    # 件 3 状态发布
    published: list[ChannelStatus] = []
    _publish_ready(published.append)
    _publish_recovering(published.append)
    _publish_blocked(published.append, "WebSocket reconnect exhausted after 5 attempts")
    assert [s.lifecycle for s in published] == [
        Lifecycle.READY, Lifecycle.RECOVERING, Lifecycle.BLOCKED
    ]
    ok.append("status-sink: ready/recovering/blocked")

    print("channel_adapter_skeleton PoC selftest —— ALL PASS")
    for line in ok:
        print(f"  [ok] {line}")


if __name__ == "__main__":
    _selftest()
