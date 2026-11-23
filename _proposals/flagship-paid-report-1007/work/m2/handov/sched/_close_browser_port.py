# -*- coding: utf-8 -*-
"""_close_browser_port — 优雅关闭指定调试端口上的浏览器 (CDP Browser.close), 用于关闭
我自己启动后遗留在临时目录上的浏览器. 连不上就什么都不做 (绝不因此新开浏览器).
用法: py -X utf8 _close_browser_port.py 9351
"""
import json
import sys
import urllib.request

port = int(sys.argv[1])
try:
    with urllib.request.urlopen(f"http://127.0.0.1:{port}/json/version", timeout=5) as r:
        info = json.loads(r.read().decode())
except Exception as e:
    print(f"端口 {port} 无浏览器: {str(e)[:60]}")
    raise SystemExit(0)
ws = info.get("webSocketDebuggerUrl", "")
print("已连接:", ws[-48:])

import websocket  # noqa: E402

ws_obj = websocket.create_connection(ws, timeout=8)
ws_obj.send(json.dumps({"id": 1, "method": "Browser.close"}))
try:
    print("回应:", str(ws_obj.recv())[:80])
except Exception as e:
    print("关闭中(连接已断, 属正常):", str(e)[:60])
ws_obj.close()
print("已发送 Browser.close")
