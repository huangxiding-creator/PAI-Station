#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""PAN-HUNTER MCP 头本地 stdio 自测（W4 · 2026-10-31）

一轮：spawn 子进程 mcp_server.py → initialize → notifications/initialized →
tools/list → tools/call panhunter_doctor（零网络）→ 逐响应验 JSON-RPC 合法性。
不实测 Claude 挂接（留给用户 claude mcp add）；发数=0（doctor 不联网）。

跑法：python scripts/mcp_selftest.py   （退出 0=全绿）
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SERVER = ROOT / "mcp_server.py"


def read_msg(proc: subprocess.Popen, timeout: float = 30.0) -> dict:
    """按行读一条 JSON-RPC（子进程 stdout 单行一响应）。"""
    deadline = time.time() + timeout
    line = ""
    while time.time() < deadline:
        line = proc.stdout.readline()
        if line:
            break
        if proc.poll() is not None:
            raise RuntimeError(f"server exited early rc={proc.returncode}")
    if not line:
        raise TimeoutError("no response within timeout")
    return json.loads(line)


def main() -> int:
    checks: list[tuple[str, bool, str]] = []
    proc = subprocess.Popen(
        [sys.executable, str(SERVER)],
        stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        text=True, encoding="utf-8",
    )
    try:
        # 1) initialize
        proc.stdin.write(json.dumps({"jsonrpc": "2.0", "id": 1, "method": "initialize",
                                     "params": {"protocolVersion": "2024-11-05",
                                                "capabilities": {},
                                                "clientInfo": {"name": "selftest", "version": "0"}}}) + "\n")
        proc.stdin.flush()
        r = read_msg(proc)
        ok = (r.get("id") == 1 and r.get("result", {}).get("serverInfo", {}).get("name") == "pan-hunter"
              and "tools" in r.get("result", {}).get("capabilities", {}))
        checks.append(("initialize→serverInfo+capabilities.tools", ok, json.dumps(r.get("result", {}).get("serverInfo"))))

        # 2) notifications/initialized（无响应=正确）
        proc.stdin.write(json.dumps({"jsonrpc": "2.0", "method": "notifications/initialized"}) + "\n")
        proc.stdin.flush()

        # 3) tools/list
        proc.stdin.write(json.dumps({"jsonrpc": "2.0", "id": 2, "method": "tools/list"}) + "\n")
        proc.stdin.flush()
        r = read_msg(proc)
        names = [t.get("name") for t in r.get("result", {}).get("tools", [])]
        ok = r.get("id") == 2 and names == ["panhunter_search", "panhunter_discover", "panhunter_doctor"]
        checks.append(("tools/list→三工具齐", ok, str(names)))

        # 4) tools/call panhunter_doctor（零网络一发）
        proc.stdin.write(json.dumps({"jsonrpc": "2.0", "id": 3, "method": "tools/call",
                                     "params": {"name": "panhunter_doctor", "arguments": {}}}) + "\n")
        proc.stdin.flush()
        r = read_msg(proc)
        content = r.get("result", {}).get("content", [])
        is_err = r.get("result", {}).get("isError", True)
        payload = json.loads(content[0]["text"]) if content and not is_err else {}
        ok = (r.get("id") == 3 and not is_err and content[0].get("type") == "text"
              and set(payload.get("disk_matrix", {})) >= {"uc", "lanzou", "ecpan"}
              and set(payload.get("discovery", {})) == {"baidu", "aliyun", "quark", "xunlei", "139"}
              and isinstance(payload.get("plugins"), list))
        n_disks = len(payload.get("disk_matrix", {}))
        n_plugins = len(payload.get("plugins", [])) if isinstance(payload.get("plugins"), list) else -1
        checks.append(("tools/call doctor→盘矩阵+发现层+插件态", ok,
                       f"disks={n_disks} discovery=5 plugins={n_plugins} isError={is_err}"))

        # 5) 未知方法 → JSON-RPC error（协议健壮性）
        proc.stdin.write(json.dumps({"jsonrpc": "2.0", "id": 4, "method": "no/such"}) + "\n")
        proc.stdin.flush()
        r = read_msg(proc)
        ok = r.get("id") == 4 and r.get("error", {}).get("code") == -32601
        checks.append(("未知方法→-32601", ok, str(r.get("error", {}).get("code"))))
    finally:
        try:
            proc.stdin.close()
        except Exception:
            pass
        try:
            proc.wait(timeout=10)
        except Exception:
            proc.kill()

    print("== pan-hunter MCP stdio 自测 ==")
    all_ok = True
    for name, ok, detail in checks:
        print(f"  [{'PASS' if ok else 'FAIL'}] {name}  {detail}")
        all_ok &= ok
    print(f"结果：{'全绿' if all_ok else '存在 FAIL'}（子进程退出码={proc.returncode}）")
    return 0 if all_ok else 1


if __name__ == "__main__":
    sys.exit(main())
