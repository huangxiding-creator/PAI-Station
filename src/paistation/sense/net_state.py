"""M7a 网络状态流（场景上下文：SSID/在线）。

netsh wlan 输出解析为纯逻辑（中英文系统输出都兼容：字段名 SSID 不本地
化，状态值「已连接/connected」双判）；薄壳 CREATE_NO_WINDOW + 节流。
有线网/无网卡 → 解析不出 → 零产出（缺席不崩）。
"""
from __future__ import annotations

import subprocess
from datetime import datetime

_CREATE_NO_WINDOW = 0x08000000


def parse_wlan(output: str) -> dict:
    """netsh wlan show interfaces 输出 → {"ssid", "connected"}。

    解析不出（有线/无无线网卡）→ {"ssid": None, "connected": None}。
    """
    ssid = None
    connected = None
    for line in (output or "").splitlines():
        if ":" not in line:
            continue
        key, _, value = line.partition(":")
        key_s = key.strip()
        value_s = value.strip()
        if not value_s:
            continue
        if "BSSID" in key_s:
            continue
        if key_s.upper().startswith("SSID") and ssid is None:
            ssid = value_s
        elif ("state" in key_s.lower() or "状态" in key_s) and connected is None:
            v = value_s.lower()
            connected = ("connected" in v or "已连接" in v or "连接" in v
                         ) and "断开" not in value_s and "disconnect" not in v
    return {"ssid": ssid, "connected": connected}


def run_netsh() -> str:
    """薄壳：netsh wlan show interfaces 只读查询（隐藏窗口）。"""
    try:
        out = subprocess.run(
            ["netsh", "wlan", "show", "interfaces"], capture_output=True,
            timeout=10, creationflags=_CREATE_NO_WINDOW)
        return out.stdout.decode(errors="replace")
    except Exception:  # noqa: BLE001 - 缺席不崩
        return ""


def net_event(state: dict, now_fn=None) -> dict:
    now = now_fn or datetime.now
    return {
        "ts": now().isoformat(timespec="milliseconds"),
        "type": "net.state",
        "source": "netsh",
        "text": state.get("ssid") or "",
        "evidence": {"connected": state.get("connected")},
        "meta": {"ssid": state.get("ssid"),
                 "online": state.get("connected")},
    }
