# -*- coding: utf-8 -*-
"""ws_api_client — Manus WebSocket API 客户端 (逆向协议直连).

协议要素(从JS逆向):
  URL: wss://api.manus.im
  Auth: Bearer JWT + x-client-id (from data/tokens/)
  Transport: ConnectRPC over WebSocket (protobuf JSON)
  Session: session.v1.AgentSession message

用法: py ws_api_client.py test
"""
import json
import ssl
import sys
import time
import uuid

sys.path.insert(0, ".")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import websocket  # websocket-client

from manus_api import load_token

WS_URL = "wss://api.manus.im"


def connect_ws(tok: dict) -> websocket.WebSocket:
    """建立带认证的WebSocket连接."""
    headers = [
        f"Authorization: {tok['authorization']}",
        f"x-client-id: {tok.get('client_id', '')}",
        "x-client-type: web",
        "Origin: https://manus.im",
    ]
    ws = websocket.WebSocket(sslopt={"cert_reqs": ssl.CERT_NONE})
    ws.connect(WS_URL, header=headers, timeout=15)
    return ws


def test_connection():
    """测试WebSocket连接+监听初始消息."""
    tok = load_token("5l8urxjdkd@cam.ac.cn")
    if not tok:
        print("无令牌")
        return

    print(f"连接 {WS_URL}...")
    try:
        ws = connect_ws(tok)
        print("✅ WebSocket连接成功!")

        # 监听初始消息(服务器可能发送欢迎/配置)
        ws.settimeout(5)
        try:
            for i in range(3):
                msg = ws.recv()
                if isinstance(msg, bytes):
                    print(f"  [{i}] 二进制 {len(msg)}B: {msg[:100].hex()}")
                else:
                    print(f"  [{i}] 文本: {msg[:200]}")
        except websocket.WebSocketTimeoutException:
            print("  (5秒内无消息)")

        # 尝试发送JSON格式的createSession
        session_msg = {
            "$typeName": "session.v1.AgentSession",
            "uid": uuid.uuid4().hex[:12],
            "title": "API Direct Test",
            "status": "SESSION_STATUS_UNSPECIFIED",
            "isShared": False,
            "initialQualityMode": "standard",
        }
        ws.send(json.dumps(session_msg))
        print("\n✅ createSession消息已发送")
        time.sleep(3)

        # 读取响应
        ws.settimeout(5)
        try:
            resp = ws.recv()
            if isinstance(resp, bytes):
                print(f"响应(二进制): {resp[:200].hex()}")
            else:
                print(f"响应: {resp[:300]}")
        except websocket.WebSocketTimeoutException:
            print("(无响应)")

        ws.close()
    except Exception as e:
        print(f"❌ 连接失败: {type(e).__name__}: {str(e)[:150]}")


if __name__ == "__main__":
    test_connection()
