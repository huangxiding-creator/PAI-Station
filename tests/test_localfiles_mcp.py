"""MCP 暴露层（L4 出口）：只读 JSON-RPC stdio 服务器。

手写协议层（零依赖，MCP newline-delimited JSON-RPC 2.0）：
- 三个只读工具：localfiles_search（内容混检）/ localfiles_find（路径秒查）
  / localfiles_status（索引统计）——scan/extract 长活不进门（CLI/schtasks 侧）
- 红线继承：secret 行 find 默认过滤（路径也不喂给 agent 会话）；
  内容索引本就无 secret 文本
- WAL 并行：夜间提取与 MCP 查询互不阻塞（store/inventory 均已 WAL）
"""
from __future__ import annotations

import io
import json
from datetime import datetime

import pytest

from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.mcp_server import (
    SERVER_NAME,
    LocalFilesMcpService,
    handle_message,
    serve,
)
from paistation.sense.localfiles.store import ChunkIndex

NOW = 1_700_000_000.0
PDF = r"C:\Docs\数字孪生方案.pdf"
DOCX = r"C:\Docs\会议纪要.docx"
KEY = r"C:\Keys\id_rsa"


@pytest.fixture()
def svc(tmp_path):
    inv = Inventory(tmp_path / "inventory.db")
    chunks = ChunkIndex(tmp_path / "index.db")
    inv.apply_scan([
        {"path": PDF, "size": 100, "mtime": int(NOW), "secret": 0},
        {"path": DOCX, "size": 50, "mtime": int(NOW), "secret": 0},
        {"path": KEY, "size": 10, "mtime": int(NOW), "secret": 1},
    ], now=NOW)
    inv.mark_extracted(PDF, "pdf", "1.0", "h1", "pdf", now=NOW)
    inv.mark_extracted(DOCX, "docx", "1.0", "h2", "docx", now=NOW)
    chunks.upsert_file(PDF, ["黄河设计院数字孪生平台建设方案"], "cv1")
    chunks.upsert_file(DOCX, ["关于云河平台的评审会议纪要"], "cv1")
    service = LocalFilesMcpService(inv=inv, chunks=chunks)
    yield service
    service.close()


def _req(msg_id, method, params=None):
    m = {"jsonrpc": "2.0", "id": msg_id, "method": method}
    if params is not None:
        m["params"] = params
    return m


def _call(msg_id, name, args):
    return _req(msg_id, "tools/call", {"name": name, "arguments": args})


def _payload(resp) -> dict:
    assert resp["jsonrpc"] == "2.0"
    return resp


def _text_payload(resp) -> dict:
    body = _payload(resp)["result"]["content"]
    assert body[0]["type"] == "text"
    return json.loads(body[0]["text"])


# ---------- 握手与工具清单 ----------

def test_initialize_handshake(svc):
    resp = handle_message(
        _req(1, "initialize", {"protocolVersion": "2024-11-05"}), svc)
    result = _payload(resp)["result"]
    assert result["protocolVersion"] == "2024-11-05"
    assert "tools" in result["capabilities"]
    assert result["serverInfo"]["name"] == SERVER_NAME


def test_ping(svc):
    assert _payload(handle_message(_req(1, "ping"), svc))["result"] == {}


def test_tools_list_three(svc):
    tools = _payload(
        handle_message(_req(1, "tools/list"), svc))["result"]["tools"]
    names = {t["name"] for t in tools}
    assert names == {"localfiles_search", "localfiles_find",
                     "localfiles_status"}
    for t in tools:  # 每个工具必须有 inputSchema（JSON Schema）
        assert isinstance(t["inputSchema"].get("type"), str)
        assert t.get("description")


# ---------- 三工具语义 ----------

def test_search_hits_content(svc):
    hits = _text_payload(handle_message(
        _call(2, "localfiles_search", {"query": "数字孪生"}), svc))
    assert hits and hits[0]["path"] == PDF
    assert "数字孪生" in hits[0]["snippet"]
    assert hits[0]["source"]  # fts 或 like 路由标注


def test_find_paths_and_secret_filter(svc):
    hits = _text_payload(handle_message(
        _call(3, "localfiles_find", {"pattern": "Docs"}), svc))
    paths = [h["path"] for h in hits]
    assert PDF in paths and DOCX in paths
    # 红线：secret 文件的路径也不喂给 agent 会话
    assert _text_payload(handle_message(
        _call(4, "localfiles_find", {"pattern": "id_rsa"}), svc)) == []
    assert all("id_rsa" not in p for p in paths)
    # mtime 可读化须与本地时区无关地对照（不硬编码日期，防时区耦合）
    expect = datetime.fromtimestamp(int(NOW)).isoformat(timespec="seconds")
    assert any(h["path"] == PDF and h["mtime_iso"] == expect for h in hits)


def test_status_mixes_inventory_and_chunks(svc):
    out = _text_payload(handle_message(_call(5, "localfiles_status", {}), svc))
    assert out["inventory"]["total_alive"] == 3
    assert out["chunks"]["chunks"] == 2


# ---------- 协议错误面 ----------

def test_unknown_method(svc):
    resp = _payload(handle_message(_req(9, "no/such"), svc))
    assert resp["error"]["code"] == -32601


def test_unknown_tool(svc):
    resp = _payload(handle_message(
        _call(9, "localfiles_delete", {"path": "x"}), svc))
    assert resp["error"]["code"] == -32602


def test_bad_arguments_type(svc):
    resp = _payload(handle_message(
        _call(9, "localfiles_search", {"query": 123}), svc))
    assert resp["error"]["code"] == -32602


def test_notification_no_response(svc):
    assert handle_message(
        {"jsonrpc": "2.0", "method": "notifications/initialized"}, svc) is None


def test_surrogate_text_sanitized_not_fatal(svc, monkeypatch):
    r"""真机回归（09-16 实锤）：chunk 文本混入孤立代理对时 json.dumps
    整查询炸——egress 必须清洗，单条坏行只脏自己。"""
    from paistation.sense.localfiles.store import ChunkHit
    monkeypatch.setattr(
        svc._chunks, "search",
        lambda q, k=8: [ChunkHit("C:\\坏\udcaa.txt", 0, "坏\udcaa字节")])
    hits = _text_payload(handle_message(
        _call(7, "localfiles_search", {"query": "x"}), svc))
    # encode 侧 errors="replace" 产出 '?'（U+FFFD 是解码侧行为）
    assert hits[0]["snippet"] == "坏?字节"


def test_non_object_message(svc):
    resp = _payload(handle_message([1, 2], svc))
    assert resp["error"]["code"] == -32600


# ---------- stdio 循环 ----------

def test_serve_end_to_end(svc):
    inbox = io.StringIO("\n".join([
        json.dumps(_req(1, "initialize", {"protocolVersion": "2024-11-05"})),
        json.dumps({"jsonrpc": "2.0", "method": "notifications/initialized"}),
        json.dumps(_call(2, "localfiles_find", {"pattern": "数字孪生"})),
    ]) + "\n")
    outbox = io.StringIO()
    serve(inbox, outbox, svc)
    lines = [json.loads(x) for x in outbox.getvalue().splitlines()]
    assert len(lines) == 2  # 通知不回包
    assert lines[0]["id"] == 1 and lines[1]["id"] == 2
    assert json.loads(lines[1]["result"]["content"][0]["text"])


def test_serve_malformed_line_continues(svc):
    inbox = io.StringIO("not-json\n" + json.dumps(_req(1, "ping")) + "\n")
    outbox = io.StringIO()
    serve(inbox, outbox, svc)
    lines = [json.loads(x) for x in outbox.getvalue().splitlines()]
    assert lines[0]["error"]["code"] == -32700
    assert lines[0]["id"] is None
    assert lines[1]["result"] == {}
