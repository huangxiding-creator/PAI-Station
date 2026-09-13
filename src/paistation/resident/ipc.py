"""M1.1 named pipe IPC（ADR-2）：stdlib multiprocessing.connection + authkey。

协议：单连接单请求-响应；外层帧走 stdlib（HMAC 鉴权握手），载荷是
JSON 字符串（不 pickle 任意对象，坏包回错误响应、连接不连坐服务进程）。
authkey 落用户数据目录（secrets 不入库），首次自动生成。
"""
from __future__ import annotations

import json
import logging
import os
import secrets
import threading

from multiprocessing.connection import AuthenticationError, Client, Listener

_log = logging.getLogger("paistation.resident.ipc")

AUTHKEY_FILE = "pipe.authkey"
_MAX_ID = 1 << 30


class DecodeError(ValueError):
    """载荷不是合法请求/响应 JSON 行。"""


class PipeError(RuntimeError):
    """管道层故障（连不上/超时/中断）。"""


class PipeAuthError(PipeError):
    """authkey 握手失败。"""


# ---- 纯协议层（可单测，不碰管道）----

def encode_request(id_: int, cmd: str, payload: dict) -> str:
    return json.dumps({"id": id_, "cmd": cmd, "payload": payload},
                      ensure_ascii=False)


def encode_response(id_: int, *, ok: bool, data: dict | None = None,
                    error: str | None = None) -> str:
    resp: dict = {"id": id_, "ok": ok}
    if ok:
        resp["data"] = data or {}
    else:
        resp["error"] = error or "unknown"
    return json.dumps(resp, ensure_ascii=False)


def decode_line(line) -> dict:
    if not isinstance(line, str):
        raise DecodeError(f"载荷非字符串: {type(line).__name__}")
    try:
        msg = json.loads(line)
    except (json.JSONDecodeError, ValueError) as exc:
        raise DecodeError(f"JSON 解析失败: {exc}") from exc
    if not isinstance(msg, dict):
        raise DecodeError("载荷非对象")
    if "id" not in msg or not isinstance(msg["id"], int) or msg["id"] < 0:
        raise DecodeError("id 缺失或非非负整数")
    if "cmd" not in msg or not isinstance(msg["cmd"], str):
        raise DecodeError("cmd 缺失或非字符串")
    return msg


def decode_response(line) -> dict:
    """响应行：{id, ok, data|error}；id 允许 -1（坏包兜底响应）。"""
    if not isinstance(line, str):
        raise DecodeError(f"载荷非字符串: {type(line).__name__}")
    try:
        msg = json.loads(line)
    except (json.JSONDecodeError, ValueError) as exc:
        raise DecodeError(f"JSON 解析失败: {exc}") from exc
    if not isinstance(msg, dict):
        raise DecodeError("载荷非对象")
    if not isinstance(msg.get("id"), int):
        raise DecodeError("id 缺失或非整数")
    if not isinstance(msg.get("ok"), bool):
        raise DecodeError("ok 缺失或非布尔")
    if msg["ok"] and "data" not in msg:
        raise DecodeError("成功响应缺 data")
    if not msg["ok"] and not isinstance(msg.get("error"), str):
        raise DecodeError("错误响应缺 error")
    return msg


def load_or_create_authkey(data_dir) -> bytes:
    """authkey 一次生成、落盘复用；调用方负责传入用户数据目录。"""
    path = os.path.join(str(data_dir), AUTHKEY_FILE)
    if os.path.exists(path):
        raw = open(path, "rb").read()
        if len(raw) >= 32:
            return raw
    key = secrets.token_bytes(32)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "wb") as fh:
        fh.write(key)
    return key


# ---- 服务端薄壳 ----

class PipeServer:
    """accept 循环后台线程；每连接单请求-响应后关闭。"""

    def __init__(self, name: str, authkey: bytes, handler, address: str | None = None):
        self.address = address or rf"\\.\pipe\{name}"
        self._authkey = authkey
        self._handler = handler  # (cmd, payload) -> data；异常由本层转错误响应
        self._listener: Listener | None = None
        self._stopping = threading.Event()
        self._thread: threading.Thread | None = None

    def start(self) -> None:
        self._listener = Listener(self.address, authkey=self._authkey)
        self._thread = threading.Thread(target=self._accept_loop,
                                        name="pai-ipc-accept", daemon=True)
        self._thread.start()
        _log.info("PipeServer 启动: %s", self.address)

    def _accept_loop(self) -> None:
        while not self._stopping.is_set():
            try:
                conn = self._listener.accept()
            except OSError:
                break  # listener 已关闭（stop 路径）
            except AuthenticationError:
                continue  # 坏 digest 握手：弃连接，accept 环不连坐
            try:
                self._serve_conn(conn)
            except Exception as exc:  # noqa: BLE001 - 单连接故障不杀 accept 环
                _log.warning("IPC 连接处理异常（忽略）: %s", exc)

    def _serve_conn(self, conn) -> None:
        try:
            raw = conn.recv()
            try:
                req = decode_line(raw)
            except DecodeError as exc:
                conn.send(encode_response(-1, ok=False, error=f"坏包: {exc}"))
                return
            try:
                data = self._handler(req["cmd"], req.get("payload") or {})
            except Exception as exc:  # noqa: BLE001 - handler 异常转错误响应
                _log.warning("IPC handler 异常 cmd=%s: %s", req["cmd"], exc)
                conn.send(encode_response(req["id"], ok=False, error=str(exc)))
                return
            conn.send(encode_response(req["id"], ok=True, data=data or {}))
        finally:
            conn.close()

    def stop(self) -> None:
        self._stopping.set()
        if self._listener:
            try:
                self._listener.close()
            except OSError:
                pass
        if self._thread:
            self._thread.join(timeout=5)


# ---- 客户端薄壳 ----

class PipeClient:
    """一次 call = 一条连接（简单且免连接池陈旧问题）。"""

    def __init__(self, address: str, authkey: bytes):
        self._address = address
        self._authkey = authkey
        self._next_id = 0
        self._id_lock = threading.Lock()

    def _take_id(self) -> int:
        with self._id_lock:
            self._next_id = (self._next_id + 1) % _MAX_ID
            return self._next_id

    def call(self, cmd: str, payload: dict | None = None,
             timeout: float = 5.0) -> dict:
        payload = payload or {}
        try:
            conn = Client(self._address, authkey=self._authkey)
        except AuthenticationError as exc:
            raise PipeAuthError(f"authkey 鉴权失败: {exc}") from exc
        except OSError as exc:
            raise PipeError(f"管道连接失败: {exc}") from exc
        try:
            conn.send(encode_request(self._take_id(), cmd, payload))
            if not conn.poll(timeout):
                raise PipeError(f"响应超时({timeout}s): cmd={cmd}")
            return decode_response(conn.recv())
        finally:
            conn.close()
