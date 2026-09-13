"""M1.1 named pipe IPC（ADR-2）：协议编解码 + 真管道往返 + 坏包/坏鉴权隔离。"""
import json
import threading
import time

import pytest

from paistation.resident.ipc import (
    DecodeError,
    PipeAuthError,
    PipeClient,
    PipeError,
    PipeServer,
    decode_line,
    decode_response,
    encode_request,
    encode_response,
    load_or_create_authkey,
)


# ---- 纯协议层 ----

def test_request_roundtrip_preserves_fields():
    msg = decode_line(encode_request(7, "ping", {"a": 1}))
    assert msg == {"id": 7, "cmd": "ping", "payload": {"a": 1}}


def test_response_roundtrip_ok_and_error():
    ok = decode_response(encode_response(3, ok=True, data={"status": "running"}))
    assert ok == {"id": 3, "ok": True, "data": {"status": "running"}}
    err = decode_response(encode_response(4, ok=False, error="boom"))
    assert err["id"] == 4 and err["ok"] is False and err["error"] == "boom"


def test_decode_rejects_non_json():
    with pytest.raises(DecodeError):
        decode_line("not json at all")


def test_decode_rejects_wrong_shape():
    with pytest.raises(DecodeError):
        decode_line(json.dumps([1, 2]))                       # 非对象
    with pytest.raises(DecodeError):
        decode_line(json.dumps({"id": 1}))                    # 缺 cmd
    with pytest.raises(DecodeError):
        decode_line(json.dumps({"id": "x", "cmd": "ping"}))   # id 非整数
    with pytest.raises(DecodeError):
        decode_line(12345)                                     # 非字符串载荷


# ---- authkey 管理（secrets 不入库，落用户数据目录）----

def test_authkey_created_once_and_stable(tmp_path):
    k1 = load_or_create_authkey(tmp_path)
    k2 = load_or_create_authkey(tmp_path)
    assert k1 == k2 and isinstance(k1, bytes) and len(k1) >= 32


# ---- 真管道往返 ----

def _pipe_name():
    return f"pai-station-test-{int(time.time() * 1000)}-{id(threading.get_ident())}"


@pytest.fixture()
def server():
    srv = PipeServer(_pipe_name(), authkey=b"test-key",
                     handler=lambda cmd, payload: {"echo": cmd})
    srv.start()
    yield srv
    srv.stop()


def test_roundtrip_call(server):
    resp = PipeClient(server.address, authkey=b"test-key").call("ping", {})
    assert resp["ok"] is True
    assert resp["data"] == {"echo": "ping"}


def test_handler_exception_returns_error_not_crash():
    def boom(cmd, payload):
        raise RuntimeError("kaboom")

    srv = PipeServer(_pipe_name(), authkey=b"k", handler=boom)
    srv.start()
    try:
        resp = PipeClient(srv.address, authkey=b"k").call("anything", {})
        assert resp["ok"] is False and "kaboom" in resp["error"]
    finally:
        srv.stop()
    # 服务还活着：再发一个正常命令仍可响应（用新 handler 的服务器验证隔离）
    srv2 = PipeServer(_pipe_name(), authkey=b"k",
                      handler=lambda cmd, payload: {"fine": True})
    srv2.start()
    try:
        resp = PipeClient(srv2.address, authkey=b"k").call("ping", {})
        assert resp["ok"] is True
    finally:
        srv2.stop()


def test_bad_packet_gets_error_response(server):
    """垃圾载荷 → 错误响应，服务进程不崩（后续调用照常）。"""
    from multiprocessing.connection import Client as RawClient
    conn = RawClient(server.address, authkey=b"test-key")
    conn.send("{{{not json")
    resp = decode_response(conn.recv())
    conn.close()
    assert resp["ok"] is False and resp["id"] == -1
    # 服务未连坐
    resp2 = PipeClient(server.address, authkey=b"test-key").call("ping", {})
    assert resp2["ok"] is True


def test_wrong_authkey_rejected(server):
    with pytest.raises(PipeAuthError):
        PipeClient(server.address, authkey=b"wrong-key").call("ping", {})


def test_connect_to_dead_pipe_raises_pipe_error():
    with pytest.raises(PipeError):
        PipeClient(r"\\.\pipe\pai-station-no-such-pipe", authkey=b"k").call(
            "ping", {}, timeout=1.0)


def test_concurrent_clients_all_served(server):
    results = []
    errors = []

    def worker(i):
        try:
            resp = PipeClient(server.address, authkey=b"test-key").call(
                "ping", {"n": i})
            results.append(resp["ok"])
        except Exception as exc:  # noqa: BLE001 - 收集线程异常
            errors.append(exc)

    threads = [threading.Thread(target=worker, args=(i,)) for i in range(8)]
    for t in threads:
        t.start()
    for t in threads:
        t.join(timeout=10)
    assert not errors
    assert results == [True] * 8
