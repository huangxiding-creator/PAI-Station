"""MCP stdio 出口（L4 收官）：把本地文件宇宙检索暴露给任意 agent 会话。

设计裁决（2026-09-16）：
- **手写 JSON-RPC 2.0，零依赖**——MCP stdio 即 newline-delimited
  JSON-RPC，协议面只有 initialize/ping/tools/list/tools/call 四个方法，
  引入 SDK 换不来什么（干净房纪律：离线可装优先）。
- **只读三工具**：search（内容混检）/ find（路径秒查）/ status（统计）。
  scan/extract 是长活，留在 CLI + schtasks 侧（重活晚间跑既有惯例），
  绝不进门——agent 会话的工具调用必须有界。
- **红线继承**：find 默认过滤 secret 行（密钥文件的路径也不喂给
  LLM 会话，纵深防御）；内容索引本就无 secret 文本。
- **WAL 并行**：inventory/index 两库均 WAL，夜间提取写入与 MCP
  只读查询互不阻塞。
- 协议健壮性：坏 JSON 行回 -32700 继续服务；通知不回包；
  工具内部异常回 -32603 不杀服务器（单请求失败不连坐）。
"""
from __future__ import annotations

import json
import logging
from datetime import datetime
from pathlib import Path

from paistation import __version__
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.store import ChunkIndex

_log = logging.getLogger("paistation.sense.localfiles.mcp_server")

SERVER_NAME = "paistation-localfiles"
PROTOCOL_VERSION = "2024-11-05"
SNIPPET_CHARS = 200

_TOOLS = [
    {
        "name": "localfiles_search",
        "description": "本地文件宇宙内容混检（FTS5 trigram，中文短词 LIKE "
                       "兜底）。回答「哪份文档讲过 X」——返回 chunk 片段与"
                       "所属文件路径。只读。",
        "inputSchema": {
            "type": "object",
            "properties": {
                "query": {"type": "string", "description": "检索词"},
                "k": {"type": "integer", "default": 8,
                      "minimum": 1, "maximum": 50},
            },
            "required": ["query"],
        },
    },
    {
        "name": "localfiles_find",
        "description": "按路径子串秒查文件（ASCII 大小写不敏感；红线 secret "
                       "行已过滤）。回答「某文件在哪」。只读。",
        "inputSchema": {
            "type": "object",
            "properties": {
                "pattern": {"type": "string", "description": "路径子串"},
                "limit": {"type": "integer", "default": 20,
                          "minimum": 1, "maximum": 100},
            },
            "required": ["pattern"],
        },
    },
    {
        "name": "localfiles_status",
        "description": "索引统计：清单代际/各状态行数/类型分布/chunk 库。只读。",
        "inputSchema": {"type": "object", "properties": {}},
    },
]


class _RpcError(Exception):
    """协议层可预期错误（回 JSON-RPC error，不带堆栈）。"""

    def __init__(self, code: int, message: str):
        super().__init__(message)
        self.code, self.message = code, message


def _clean(s: str) -> str:
    r"""清洗孤立代理对（\udcXX）等不可编码字符。

    真机实证（09-16）：提取侧内容链路会把个别坏字节以代理对形式
    落进 chunk 文本，json.dumps 序列化时整查询炸——egress 一律
    utf-8/replace 重编码，单条坏行只脏自己不脏整包。
    """
    return str(s).encode("utf-8", "replace").decode("utf-8")


class LocalFilesMcpService:
    """只读检索门面：Inventory + ChunkIndex 的 agent 出口。"""

    def __init__(self, inv: Inventory, chunks: ChunkIndex):
        self._inv = inv
        self._chunks = chunks

    @classmethod
    def open(cls, db_dir) -> LocalFilesMcpService:
        """从索引目录开门（无嵌入器 = keyword-only，查询侧零外部依赖）。"""
        d = Path(db_dir)
        return cls(Inventory(d / "inventory.db"),
                   ChunkIndex(d / "index.db"))

    # ---------- 三工具实现 ----------

    def search(self, query: str, k: int = 8) -> list[dict]:
        hits = self._chunks.search(query, k=k)
        return [{"path": _clean(h.path), "seq": h.seq,
                 "source": _clean(h.source), "score": h.score,
                 "snippet": _clean(h.text[:SNIPPET_CHARS])}
                for h in hits]

    def find(self, pattern: str, limit: int = 20) -> list[dict]:
        rows = self._inv.search_paths(pattern, limit=limit,
                                      include_secret=False)
        return [{"path": _clean(r["path"]), "size": r["size"],
                 "kind": _clean(r["kind"]), "status": _clean(r["status"]),
                 "mtime_iso": datetime.fromtimestamp(int(r["mtime"]))
                 .isoformat(timespec="seconds")}
                for r in rows]

    def status(self) -> dict:
        return {"inventory": self._inv.stats(),
                "chunks": self._chunks.stats()}

    def close(self) -> None:
        self._inv.close()
        self._chunks.close()


def _clamp(value, default: int, lo: int, hi: int) -> int:
    """参数防御：非整数/越界一律收进界内，绝不因怪参数 500。"""
    try:
        v = int(value)
    except (TypeError, ValueError):
        return default
    return max(lo, min(hi, v))


def _require_str(args: dict, key: str) -> str:
    v = args.get(key)
    if not isinstance(v, str) or not v.strip():
        raise _RpcError(-32602, f"{key} 必须是非空字符串")
    return v


def _call_tool(svc: LocalFilesMcpService, name, args) -> object:
    if not isinstance(args, dict):
        raise _RpcError(-32602, "arguments 必须是对象")
    if name == "localfiles_search":
        return svc.search(_require_str(args, "query"),
                          k=_clamp(args.get("k", 8), 8, 1, 50))
    if name == "localfiles_find":
        return svc.find(_require_str(args, "pattern"),
                        limit=_clamp(args.get("limit", 20), 20, 1, 100))
    if name == "localfiles_status":
        return svc.status()
    raise _RpcError(-32602, f"未知工具 {name}（本服务只读，无写入口）")


def _ok(msg_id, result) -> dict:
    return {"jsonrpc": "2.0", "id": msg_id, "result": result}


def _err(msg_id, code: int, message: str) -> dict:
    return {"jsonrpc": "2.0", "id": msg_id,
            "error": {"code": code, "message": message}}


def handle_message(msg, svc: LocalFilesMcpService) -> dict | None:
    """单消息分发；通知（无 id）返回 None 不回包。"""
    if not isinstance(msg, dict):
        return _err(None, -32600, "请求必须是 JSON 对象")
    msg_id = msg.get("id")
    if msg_id is None and "id" not in msg:  # 通知：不回包
        return None
    method = msg.get("method")
    try:
        if method == "initialize":
            ver = (msg.get("params") or {}).get(
                "protocolVersion", PROTOCOL_VERSION)
            return _ok(msg_id, {
                "protocolVersion": ver,
                "capabilities": {"tools": {}},
                "serverInfo": {"name": SERVER_NAME, "version": __version__}})
        if method == "ping":
            return _ok(msg_id, {})
        if method == "tools/list":
            return _ok(msg_id, {"tools": _TOOLS})
        if method == "tools/call":
            params = msg.get("params") or {}
            data = _call_tool(svc, params.get("name"),
                              params.get("arguments", {}))
            return _ok(msg_id, {"content": [
                {"type": "text",
                 "text": json.dumps(data, ensure_ascii=False, indent=2)}]})
        return _err(msg_id, -32601, f"未知方法 {method}")
    except _RpcError as exc:
        return _err(msg_id, exc.code, exc.message)
    except Exception as exc:  # 工具内部故障不杀服务器（坏包不连坐）
        _log.warning("工具执行失败: %s", exc)
        return _err(msg_id, -32603, f"内部错误: {exc}")


def force_utf8_stdio() -> None:
    """Windows 中文机 stdout 重定向默认 cp936——MCP 规范要求 UTF-8。

    GBK 显示层假象家族病（同 wechat-cli）：不重配则协议流写出 GBK
    字节，客户端按 UTF-8 解码即炸（09-16 真机冒烟实锤）。
    """
    import sys
    for stream in (sys.stdin, sys.stdout):
        if stream is not None and hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8")
            except (OSError, ValueError):  # 管道已关/不可重配：尽力而为
                pass


def serve(reader, writer, svc: LocalFilesMcpService) -> None:
    """newline-delimited JSON-RPC 主循环；EOF 即退（客户端关管道）。"""
    while True:
        line = reader.readline()
        if not line:
            break
        stripped = line.strip()
        if not stripped:
            continue
        try:
            msg = json.loads(stripped)
        except ValueError:
            resp = _err(None, -32700, "解析失败：非 JSON 行")
        else:
            resp = handle_message(msg, svc)
        if resp is not None:
            writer.write(json.dumps(resp, ensure_ascii=False) + "\n")
            writer.flush()


def main(argv=None) -> int:
    """CLI 形态：python -m paistation.sense.localfiles.mcp_server [--db-dir]。

    stdout 是协议通道，任何日志只走 stderr——banner 一行都会毁协议。
    """
    import argparse
    import sys

    ap = argparse.ArgumentParser(
        prog="paistation.sense.localfiles.mcp_server")
    ap.add_argument("--db-dir", type=Path, default=Path("data/local_index"))
    args = ap.parse_args(argv)
    force_utf8_stdio()
    svc = LocalFilesMcpService.open(args.db_dir)
    try:
        serve(sys.stdin, sys.stdout, svc)
    finally:
        svc.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
