"""微信纯视觉只读通道（提案红线：不注入、不 Hook、不模拟点击）。

- send() 永远拒绝：微信零外发（config wechat_mode=vision_readonly 防篡改已锁）
- digest()：消费最新截图 → 视觉快照 → 本地感知摘要（delivered 恒 False）
"""
from paistation.sense import vision as _vision


class WechatVisionChannel:
    """只读视觉通道：digest(image_path) -> 本地摘要；send() 抛 PermissionError。"""

    def __init__(self, snapshot_fn=_vision.wechat_snapshot):
        self._snapshot = snapshot_fn

    def digest(self, image_path: str) -> dict:
        """截图 → 微信窗口概要（纯本地，绝不投递）。"""
        snap = self._snapshot(image_path)
        if not isinstance(snap, dict):
            snap = {"is_wechat": False, "messages_summary": ""}
        return {"is_wechat": bool(snap.get("is_wechat", False)),
                "messages_summary": str(snap.get("messages_summary", "")),
                "delivered": False}

    def send(self, title: str, body: str) -> dict:
        raise PermissionError(
            "微信通道为纯视觉只读（vision_readonly 红线）：只感知不外发，"
            "请使用企微/飞书/钉钉通道投递")
