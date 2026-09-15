"""M7a 剪贴板流（银甲虫信号源 + 项目脱敏红线加强）。

红线：密码形状内容连元数据都不留（长度/哈希也不产出）；
文本正文永不入事件流——只留类型+长度+签名指纹。
缺席不崩：剪贴板打不开/格式不可用 → kind="unknown" 零产出。
"""
from __future__ import annotations

import ctypes
import hashlib
from datetime import datetime

from .browser_url import looks_like_url

_CF_UNICODETEXT = 13
_CF_BITMAP = 2
_CF_HDROP = 15


def password_shape(text: str) -> bool:
    """密码/密钥形状判定（宁误杀勿泄漏）。

    单行无空格且满足其一：常见密钥前缀；≥20 字符且≥2 类字符
    （字母/数字/符号混合的高熵单串）。URL 豁免（常见剪贴板内容，
    且为意图识别重要信号）——注意前缀判定在前，eyJ*JWT 不会被豁免。
    """
    t = (text or "").strip()
    if not t or "\n" in t or " " in t:
        return False  # 多行/带空格=普通文本
    if any(t.startswith(p) for p in
           ("sk-", "ak-", "ghp_", "gho_", "xoxb-", "xoxp-", "AIza",
            "eyJ")):  # sk-apikey / GitHub / Slack / Google / JWT
        return True
    if looks_like_url(t):
        return False
    if len(t) >= 20:
        classes = sum((any(c.isalpha() for c in t),
                       any(c.isdigit() for c in t),
                       any(not c.isalnum() for c in t)))
        if classes >= 2:
            return True
    return False


def read_clipboard() -> dict:
    """当前剪贴板 {"kind", "text"}；kind=text/image/file/empty/unknown。"""
    try:
        user32 = ctypes.windll.user32
        kernel32 = ctypes.windll.kernel32
        if not user32.OpenClipboard(0):
            return {"kind": "unknown", "text": ""}
        try:
            if user32.IsClipboardFormatAvailable(_CF_UNICODETEXT):
                handle = user32.GetClipboardData(_CF_UNICODETEXT)
                if not handle:
                    return {"kind": "empty", "text": ""}
                locked = kernel32.GlobalLock(handle)
                if not locked:
                    return {"kind": "empty", "text": ""}
                try:
                    return {"kind": "text",
                            "text": ctypes.wstring_at(locked)[:8000]}
                finally:
                    kernel32.GlobalUnlock(handle)
            if user32.IsClipboardFormatAvailable(_CF_HDROP):
                return {"kind": "file", "text": ""}
            if user32.IsClipboardFormatAvailable(_CF_BITMAP):
                return {"kind": "image", "text": ""}
            return {"kind": "empty", "text": ""}
        finally:
            user32.CloseClipboard()
    except Exception:  # noqa: BLE001 - 非 Windows / API 失败
        return {"kind": "unknown", "text": ""}


class ClipboardTracker:
    """剪贴板采样 → clipboard.change 事件（签名去重 + 密码形状丢弃）。"""

    def __init__(self, now_fn=None):
        self._now = now_fn or datetime.now
        self._last_sig = None

    def feed(self, sample: dict) -> dict | None:
        kind = sample.get("kind", "unknown")
        text = sample.get("text") or ""
        if kind in ("empty", "unknown"):
            return None
        if kind == "text":
            if password_shape(text):
                return None  # 密码形状：零痕迹丢弃
            sig = hashlib.sha1(text.encode("utf-8")).hexdigest()[:12]
            meta = {"kind": kind, "length": len(text)}
        else:
            sig = kind
            meta = {"kind": kind}
        if sig == self._last_sig:
            return None
        self._last_sig = sig
        return {
            "ts": self._now().isoformat(timespec="milliseconds"),
            "type": "clipboard.change",
            "source": "clipboard",
            "text": "",
            "evidence": {"sig": sig},
            "meta": meta,
        }
