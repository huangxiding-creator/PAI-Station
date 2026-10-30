#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""PAN-HUNTER MCP 头（W4 · 2026-10-31）— stdio 最小实现，零第三方依赖

三工具（包 ph.py 同源件 engine/sourcehub）：
  panhunter_search(kw)            聚合 9 活源全网网盘检索 → 红绿灯标注命中（JSON 文本）
  panhunter_discover(url, pwd?)   五盘黄盘免登发现层：列表+探活，不下载
  panhunter_doctor()              盘矩阵+发现层+插件态体检（零网络）

协议：MCP over stdio（newline-delimited JSON-RPC 2.0）。只实现 initialize /
notifications/initialized / tools/list / tools/call / ping——最小可用面。
频控/预算铁律与 ph.py 同源（searchagg 单源≥2s 并发≤4；discovery ≤150 发熔断）。

挂接（Claude Code 命令行，用户自执）：
  claude mcp add pan-hunter -- python E:\\AI-Station\\逆向工程\\pan-hunter\\mcp_server.py
（或加 -s user 全局挂）。详见 README.md「MCP 挂接」节。

铁律：零凭据；不读任何账号文件；plugins 只显态不执行。
"""
from __future__ import annotations

import json
import sys
import traceback
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))

SERVER_INFO = {"name": "pan-hunter", "version": "1.0.0", "title": "PAN-HUNTER 网盘资源检索"}
PROTOCOL_VERSION = "2024-11-05"

TOOLS = [
    {
        "name": "panhunter_search",
        "description": ("聚合 9 实测活源检索全网网盘分享链（夸克/百度/阿里/迅雷/UC/蓝奏等 21 盘红绿灯标注，"
                        "发现/交付两栏口径）。返回 JSON 命中数组：url/disk/light/source/deliverable。"
                        "耗时约 20-40s（频控在身：单源≥2s、并发≤4）。"),
        "inputSchema": {
            "type": "object",
            "properties": {"kw": {"type": "string", "description": "搜索关键词"}},
            "required": ["kw"],
        },
    },
    {
        "name": "panhunter_discover",
        "description": ("黄盘五盘（baidu/aliyun/quark/xunlei/139）免登发现层：列表+探活，零下载零凭据。"
                        "返回 state/alive/shots/title/file_count/entries。绿盘链请走 CLI download。"),
        "inputSchema": {
            "type": "object",
            "properties": {
                "url": {"type": "string", "description": "分享链接"},
                "pwd": {"type": "string", "description": "提取码（可省，URL 内嵌码自动剥）"},
            },
            "required": ["url"],
        },
    },
    {
        "name": "panhunter_doctor",
        "description": "PAN-HUNTER 体检（零网络）：十盘 adapter 矩阵+红绿灯、五盘发现层、本地凭据插件态（默认全关）。",
        "inputSchema": {"type": "object", "properties": {}},
    },
]


# ---------------- 工具实现（与 ph.py 同源件） ----------------

def _tool_search(kw: str) -> dict:
    from searchagg import SearchLedger, search_all
    led = SearchLedger(jsonl_path=str(ROOT / "analysis" / "search_ledger.jsonl"),
                       hits_path=str(ROOT / "analysis" / "search_hits.jsonl"))
    hits = search_all(kw, ledger=led)
    deliver = [h for h in hits if h.light == "绿"]
    return {
        "kw": kw, "total": len(hits), "deliverable": len(deliver),
        "shots": led.shots,
        "hits": [dict(url=h.url, disk=h.disk, light=h.light, source=h.source,
                      deliverable=(h.light == "绿")) for h in hits[:100]],
        "note": "黄盘=可发现可列表，交付走本地凭据插件（默认关）；绿?=链路就绪未过门，勿当绿承诺。",
    }


def _tool_discover(url: str, pwd: str = "") -> dict:
    from discovery import DISK_TIER, discover_url, discovery_of_url
    disk = discovery_of_url(url)
    if not disk:
        return {"error": "非五盘发现层链接（baidu/aliyun/quark/xunlei/139）", "url": url,
                "hint": "绿盘链请走 CLI: python -I ph.py download <url>"}
    r = discover_url(url, pwd=pwd)
    return {
        "url": url, "disk": disk, "tier": DISK_TIER.get(disk, "?"),
        "state": r.state, "ok": r.ok, "alive": r.alive, "shots": r.shots,
        "title": r.title, "file_count": r.file_count, "message": r.message,
        "entries": [dict(name=e.name, size=e.size, is_dir=e.is_dir) for e in r.entries[:50]],
        "note": "发现层只列清单+探活不下载；黄盘交付=本地凭据插件（默认关，凭据零托管）。",
    }


def _tool_doctor() -> dict:
    from adapters import ADAPTERS, light_of
    from discovery import DISCOVERY, DISK_TIER
    out = {
        "disk_matrix": {n: {"light": light_of(n), "domains": list(a.domains[:3])}
                        for n, a in ADAPTERS.items()},
        "discovery": {n: {"tier": DISK_TIER.get(n), "domains": list(d.domains[:2])}
                      for n, d in DISCOVERY.items()},
    }
    try:
        from plugins import plugin_states
        out["plugins"] = [{k: v for k, v in st.items() if k != "note"} | {"enabled": st["enabled"]}
                          for st in plugin_states()]
        out["plugin_note"] = "法务#3 凭据零托管：默认全关，此处只显态不执行。"
    except Exception as e:  # pragma: no cover
        out["plugins"] = f"插件态读取异常: {type(e).__name__}"
    return out


def _call(name: str, args: dict):
    if name == "panhunter_search":
        return _tool_search(str(args["kw"]))
    if name == "panhunter_discover":
        return _tool_discover(str(args["url"]), str(args.get("pwd", "")))
    if name == "panhunter_doctor":
        return _tool_doctor()
    raise ValueError(f"unknown tool: {name}")


# ---------------- stdio JSON-RPC 主循环 ----------------

def _send(obj: dict) -> None:
    sys.stdout.write(json.dumps(obj, ensure_ascii=False) + "\n")
    sys.stdout.flush()


def _handle(msg: dict) -> None:
    method = msg.get("method", "")
    mid = msg.get("id")
    params = msg.get("params") or {}
    if method == "initialize":
        pv = params.get("protocolVersion", PROTOCOL_VERSION)
        _send({"jsonrpc": "2.0", "id": mid, "result": {
            "protocolVersion": pv,
            "capabilities": {"tools": {"listChanged": False}},
            "serverInfo": SERVER_INFO,
        }})
    elif method in ("notifications/initialized", "notifications/cancelled"):
        pass  # 通知无响应
    elif method == "ping":
        _send({"jsonrpc": "2.0", "id": mid, "result": {}})
    elif method == "tools/list":
        _send({"jsonrpc": "2.0", "id": mid, "result": {"tools": TOOLS}})
    elif method == "tools/call":
        name = params.get("name", "")
        args = params.get("arguments") or {}
        try:
            data = _call(name, args)
            _send({"jsonrpc": "2.0", "id": mid, "result": {
                "content": [{"type": "text",
                             "text": json.dumps(data, ensure_ascii=False, indent=1)}],
                "isError": False}})
        except Exception as e:
            _send({"jsonrpc": "2.0", "id": mid, "result": {
                "content": [{"type": "text",
                             "text": f"{type(e).__name__}: {e}\n{traceback.format_exc()[-400:]}"}],
                "isError": True}})
    elif mid is not None:
        _send({"jsonrpc": "2.0", "id": mid,
               "error": {"code": -32601, "message": f"method not found: {method}"}})


def main() -> int:
    try:
        sys.stdin.reconfigure(encoding="utf-8")
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            _handle(json.loads(line))
        except json.JSONDecodeError:
            continue  # 坏行丢弃（MCP 客户端不会发；防呆）
    return 0


if __name__ == "__main__":
    sys.exit(main())
