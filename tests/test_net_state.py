"""M7a 网络状态：netsh wlan 中英文输出解析。"""
from datetime import datetime

from paistation.sense.net_state import net_event, parse_wlan
from paistation.sense.voice_events import validate_event

_NOW = datetime(2026, 9, 15, 8, 0, 0)

_ZH_CONNECTED = """
系统上有 1 个接口

    名称                   : WLAN
    描述                   : Intel(R) Wi-Fi 6 AX201
    SSID                   : MyHomeWiFi
    BSSID                  : aa:bb:cc:dd:ee:ff
    状态                   : 已连接
    接收速率(Mbps)         : 866.7
"""

_ZH_DISCONNECTED = """
    SSID                   : Office5G
    BSSID                  : aa:bb:cc:dd:ee:ff
    状态                   : 已断开连接
"""

_EN = """
There is 1 interface on the system:

    Name                   : WLAN
    SSID                   : Cafe Guest
    BSSID                  : 11:22:33:44:55:66
    State                  : connected
"""


def test_parse_zh_connected():
    state = parse_wlan(_ZH_CONNECTED)
    assert state["ssid"] == "MyHomeWiFi"
    assert state["connected"] is True


def test_parse_zh_disconnected():
    state = parse_wlan(_ZH_DISCONNECTED)
    assert state["ssid"] == "Office5G"
    assert state["connected"] is False


def test_parse_english():
    state = parse_wlan(_EN)
    assert state["ssid"] == "Cafe Guest"
    assert state["connected"] is True


def test_parse_no_wlan_absent():
    """有线网/无无线网卡 → 全 None（缺席不产出）。"""
    state = parse_wlan("系统找不到指定的文件。")
    assert state == {"ssid": None, "connected": None}
    assert parse_wlan("")["ssid"] is None


def test_net_event_validates():
    ev = net_event({"ssid": "MyHomeWiFi", "connected": True},
                   now_fn=lambda: _NOW)
    assert ev["type"] == "net.state"
    assert ev["text"] == "MyHomeWiFi"
    assert ev["meta"]["online"] is True
    assert validate_event(ev)
